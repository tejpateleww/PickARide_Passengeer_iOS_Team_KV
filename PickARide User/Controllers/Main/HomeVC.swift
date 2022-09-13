//
//  HomeViewController.swift
//  PickARide User
//
//  Created by Apple on 17/12/20.
//  Copyright © 2020` `EWW071. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation
import SwiftyJSON

class HomeVC: BaseViewController, GMSMapViewDelegate {

    //MARK:- ======= Outlets =======
    @IBOutlet weak var mainVW: UIView!
    @IBOutlet weak var mapVw: GMSMapView!
    @IBOutlet weak var txtFieldWhereAreYouGoing: leftSideImageTextField!
    @IBOutlet weak var btnShare: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var bottomVWWhereAreYouGoing: UIView!
    @IBOutlet weak var selectTexiVCContainerVW: UIView!
    @IBOutlet weak var currentRideDetailContainerVW: UIView!
    @IBOutlet weak var currentRideDriverInfoContainerVW: UIView!
    @IBOutlet weak var conHeightOfCurrentDriverDetail: NSLayoutConstraint!
    @IBOutlet weak var conHeightOfTaxi: NSLayoutConstraint!
    @IBOutlet weak var conHeightOfCurrentRideDriverInfo: NSLayoutConstraint!
    @IBOutlet weak var botomContentView: UIView!
    @IBOutlet weak var conBottomOfContainerView: NSLayoutConstraint!
    @IBOutlet weak var containerTopView: UIView!{
        didSet {
            let directions: [UISwipeGestureRecognizer.Direction] = [.up, .down]
            for direction in directions {
                let gesture = UISwipeGestureRecognizer(target: self, action: #selector(panAction(_:)))
                gesture.direction = direction
                containerTopView.addGestureRecognizer(gesture)
            }
            containerTopView.isUserInteractionEnabled = true
            containerTopView.layoutIfNeeded()
        }
    }
    
    
    //MARK:- ======== Variables ========
    var SelectedLocationString : (String,String) = ("Pick Up","Destination")
    var locationManager:CLLocationManager!
    let decoder = JSONDecoder()
    var bookingReqModel = BookingReqModel()
    var arrPickupPlace : [placePickerData] = [placePickerData]()
    var arrDestinationPlace : [placePickerData] = [placePickerData]()
    var isFirtLocation = Bool()
    var timer : Timer?
    var nearByDrivers = [Driver]()
    var arrTaxiData = [EstimateFare]()
    var arrAllTaxiData = [EstimateFare]()
    var Driverplacemarker : GMSMarker!
    var CurrentPlaceMarker : GMSMarker!
    var isStartTrip = false
    var moveMent: ARCarMovement?
    var oldCoordinate: CLLocationCoordinate2D!
    var arrMarkers = [GMSMarker]()
    var isFirstTimeLoadView = true
    var arrTaxiTypes = [String]()
    var isCameraAnimation = false
    lazy var taxiTypeView : SelectTaxiTypes = SelectTaxiTypes.fromNib()
    lazy var currentRideDetailView : CurrentRideDetail = CurrentRideDetail.fromNib()
    lazy var currentRideInfoView : CurrrentRideDriverInfo = CurrrentRideDriverInfo.fromNib()

    
    //MARK:- ===== View Controller LifeCycle ====
    override func viewDidLoad() {
        super.viewDidLoad()
    
         getFirstView()
         self.mapVw.settings.consumesGesturesInView = false
         let panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.panHandler(_:)))
         self.mapVw.addGestureRecognizer(panGesture)
         socketManageSetup()
         self.addObserver()
         WebserviceCallCurrentBooking()
    }
    
    deinit {
        print("Remove object")
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationBarSetup()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startTimer()
    }
    
    @objc func updateProfilePic(){
        navigationBarSetup()
    }
    
    
    @objc func panAction(_ sender: UISwipeGestureRecognizer){
        switch sender.direction {
        case .down:
            hideBottomView(true)
        case .up:
            hideBottomView(false)
        default:
            break
        }
    }
    
    @objc func hideBottomView(_ hide: Bool){
        conBottomOfContainerView.constant = hide ? -botomContentView.bounds.height : 0
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [.curveEaseInOut, .allowUserInteraction, .beginFromCurrentState], animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    public func getFirstView() {
        self.txtFieldWhereAreYouGoing.delegate = self
        self.locationManager = CLLocationManager()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestAlwaysAuthorization()

        if CLLocationManager.locationServicesEnabled(){
            self.locationManager.startUpdatingLocation()
        }
        self.setLocalization()
        self.navigationBarSetup()
        containerTopView.isHidden = true
        botomContentView.removeAllSubviews()
        conBottomOfContainerView.constant = 0
        self.bottomVWWhereAreYouGoing.isHidden = false
    }
    
    @objc private func panHandler(_ pan : UIPanGestureRecognizer){
            if pan.state == .ended && isCameraAnimation == true{
                isCameraAnimation = false
                let mapSize = self.mapVw.frame.size
                let point = CGPoint(x: mapSize.width/2, y: mapSize.height/2)
                let newCoordinate = self.mapVw.projection.coordinate(for: point)
                print(newCoordinate)
                 //do task here
            }
        }
    
    @IBAction func btnActionshare(_ sender: UIButton) {
    }
    
    

    //MARK:- ==== NavigationBar Setup =====
    func navigationBarSetup(){
        self.navigationController?.navigationBar.isHidden = false
        if self.containerTopView.isHidden == false{
         let  arrselctTaxitype = self.botomContentView.subviews.compactMap({$0 as? SelectTaxiTypes })
            if arrselctTaxitype.count != 0 {
                self.setNavigationBarInViewController(controller: self, naviColor: colors.submitButtonColor.value, naviTitle: NavTitles.CommonView.value, leftImage: NavItemsLeft.none.value, rightImages: [NavItemsRight.none.value], isTranslucent: true, CommonViewTitles: [SelectedLocationString.0,SelectedLocationString.1], isTwoLabels: false)
                }
            else {
                self.setNavigationBarInViewController(controller: self, naviColor: colors.appColor.value, naviTitle: NavTitles.chatSupport.value, leftImage: NavItemsLeft.menu.value, rightImages: [NavItemsRight.userProfile.value], isTranslucent: true, CommonViewTitles: [], isTwoLabels: false)
                self.setProfilePicture()
            }
        }
        else{
            self.setNavigationBarInViewController(controller: self, naviColor: colors.appColor.value, naviTitle: NavTitles.chatSupport.value, leftImage: NavItemsLeft.menu.value, rightImages: [NavItemsRight.userProfile.value], isTranslucent: true, CommonViewTitles: [], isTwoLabels: false)
            self.setProfilePicture()

        }
    }
    
    //MARK:- ===== socket setup Methods ==
    func socketManageSetup(){
        SocketIOManager.shared.establishConnection()
        self.SocketOnMethods()
    }
    
    
    @IBAction func btnCancel(_ sender: Any) {
        if self.containerTopView.isHidden == false {
        
         let arrSubView : [UIView] = self.botomContentView.subviews.compactMap({$0})
            if arrSubView.count != 0 {
                switch arrSubView[0] {
                case is SelectTaxiTypes:
                    guard let taxitypeVC : SelectTaxiTypes =  arrSubView[0] as? SelectTaxiTypes else {
                           return
                     }
                     taxitypeVC.removeSelection()
                     
                default:
                    break
                }
                self.botomContentView.removeAllSubviews()
                self.containerTopView.isHidden = true
                self.bottomVWWhereAreYouGoing.isHidden = false
                self.currentLocationSetup()
            }
         
      }
    }
    
    //MARK:- ==== Btn Action Current location ==
    @IBAction func btnActionCurrentLocation(_ sender: UIButton) {
       setCurrentLocationClicked()
    }
    
}

//MARK:- Methods
extension HomeVC{
    func setLocalization() {
        txtFieldWhereAreYouGoing.placeholder = "home_Whereareyougoing_place".Localized()
    }
    
    func setProfilePicture(){
        let authUser = Singleton.sharedInstance.UserProfilData
        self.navBtnProfile.loadSDImage(imgUrl: authUser?.profileImage ?? "")
        self.navBtnProfile.addTarget(self, action: #selector(EditUserProfile(_:)), for: .touchUpInside)
    }
    
    func addObserver(){
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("UpdateProfile"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateProfilePic), name: NSNotification.Name("UpdateProfile"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.openCurrentRideDriverInfoVC), name: .OpenCurrentRideDriverInfoVC, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.openCurrentRideDetailsVC), name: .OpenCurrentRideDetailsVC, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.openLocationSelection), name: .OpenLocationSelectionVC, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.CancelCompleteTrip), name: .CancelCompleteTRip, object: nil)
    }
    
    @objc func CancelCompleteTrip(){
        self.currentLocationSetup()
    }
    
    @objc func openCurrentRideDriverInfoVC(){
            btnCancel.isHidden = true
            btnShare.isHidden = false
            self.botomContentView.removeAllSubviews()
            self.containerTopView.isHidden = false
            self.bottomVWWhereAreYouGoing.isHidden = true
            self.botomContentView.customAddSubview(self.currentRideInfoView)
    
//        self.bottomVWWhereAreYouGoing.isHidden = true
//        self.selectTexiVCContainerVW.isHidden = true
//        self.currentRideDriverInfoContainerVW.isHidden = false
    }
    
    
    //MARK:- ====== On socket Accept driver request =====
    func onSocketAcceptDriverRequest(){
        SocketIOManager.shared.socketCall(for: socketApikeys.KAcceptBookingRequest) { json in
            print(json)
            let objDictJson = json[0]
            print(objDictJson)
            
            self.presentedViewController?.dismiss(animated: true, completion: nil)
            let controller = PaymentSucessFullyVC.instantiate(fromAppStoryboard: .Main)
            controller.dismissedClosour = {
                let obj = RootBookingRequestAccept(fromJson: objDictJson)
                print(obj)
                self.DriverRequestAccept(obj: obj)
            }
            controller.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
            let navigationController = UINavigationController(rootViewController: controller)
            navigationController.modalPresentationStyle = .overCurrentContext
            navigationController.modalTransitionStyle = .crossDissolve
            navigationController.navigationBar.isHidden = true
            self.present(navigationController, animated: true, completion: nil)
        }
    }
    
    //MARK:- ======= Driver request accest Setup =====
    func DriverRequestAccept(obj:RootBookingRequestAccept){
        NotificationCenter.default.post(name: .OpenCurrentRideDriverInfoVC, object: nil)
        print((appDel.window?.rootViewController as! UINavigationController).children)
        print((appDel.window?.rootViewController as! UINavigationController).children[0].children)
        guard let NavVc = appDel.window?.rootViewController as? UINavigationController else {return}
        print(NavVc.children[0].children)
        guard let objhomeVC = NavVc.children[0].children[0] as? UINavigationController else {
            return
        }
        guard let homeVC = objhomeVC.children[0] as? HomeVC else {
            return
        }
        
        if self.containerTopView.isHidden == false {
        
         let  arrdriverInfoView  = self.botomContentView.subviews.compactMap({$0 as? CurrrentRideDriverInfo })
            guard let driverInfoVC : CurrrentRideDriverInfo = arrdriverInfoView[0] as? CurrrentRideDriverInfo else { return }
        
//        guard let driverInfoVC = homeVC.children[0] as? CurrentRideDriverInformationVC else {
//            return
//        }
        driverInfoVC.objBookingInfo = obj.bookingInfo
        driverInfoVC.setUpUI(isFromArrived: false, isFromApi: false)
        driverInfoVC.heightGet = { (height , isExpand) in
            self.conHeightOfCurrentRideDriverInfo.constant = height
         }
        }
    }
    
    //MARK:- ======= Driver request accest Setup =====
    func WebServiceDriverRequestAccept(obj:RootCurrentBooking){
        NotificationCenter.default.post(name: .OpenCurrentRideDriverInfoVC, object: nil)
        print((appDel.window?.rootViewController as! UINavigationController).children)
        print((appDel.window?.rootViewController as! UINavigationController).children[0].children)
        guard let NavVc = appDel.window?.rootViewController as? UINavigationController else {return}
        print(NavVc.children[0].children)
        guard let objhomeVC = NavVc.children[0].children[0] as? UINavigationController else {
            return
        }
        guard let homeVC = objhomeVC.children[0] as? HomeVC else {
            return
        }
        
//       guard let driverInfoVC = homeVC.children[0] as? CurrentRideDriverInformationVC else {
//            return
//        }
        
        if self.containerTopView.isHidden == false {
        
         let  arrdriverInfoView  = self.botomContentView.subviews.compactMap({$0 as? CurrrentRideDriverInfo})
         guard let driverInfoVC : CurrrentRideDriverInfo = arrdriverInfoView[0] as? CurrrentRideDriverInfo else { return }
        
//        guard let driverInfoVC = homeVC.children[0] as? CurrentRideDriverInformationVC else {
//            return
//        }
            driverInfoVC.objCurrentBooking = obj.data
            driverInfoVC.setUpUI(isFromArrived: false, isFromApi: true)
            driverInfoVC.heightGet = { (height , isExpand) in
                self.conHeightOfCurrentRideDriverInfo.constant = height
            }
        }
    }
    
    
    //MARK:- ====== On socket Cancell by system  =======
    func onSocketCancellBySysteem(){
        SocketIOManager.shared.socketCall(for: socketApikeys.KCancelBookingRequestBySystem) { json in
            print(json)
            let objDict = json[0]
            
            self.presentedViewController?.dismiss(animated: true, completion: {
                Toast.show(message: objDict["message"].stringValue, state: .failure)
                
                self.isFirstTimeLoadView = true
                self.mapVw.clear()
                self.getFirstView()
//                self.bottomVWWhereAreYouGoing.isHidden = false
//                self.selectTexiVCContainerVW.isHidden = true
//                self.currentRideDriverInfoContainerVW.isHidden = true
//                self.currentRideDetailContainerVW.isHidden = true
            })
        }
    }
    
    //MARK:- ====On socket driver arrived =====
    func OnSocketArrivedLocation(){
        SocketIOManager.shared.socketCall(for: socketApikeys.KdriverArrived) { json in
            print(json)
            let objDictjson = json[0]
            let obj = RootBookingRequestAccept(fromJson: objDictjson)
            print(obj)
            self.ArrivedDriverSetup(obj: obj)
        }
    }
    
    
    //MARK:- ========= Arrived Driver Setup ========
    func ArrivedDriverSetup(obj : RootBookingRequestAccept) {
        NotificationCenter.default.post(name: .OpenCurrentRideDriverInfoVC, object: nil)
    
        print((appDel.window?.rootViewController as! UINavigationController).children)
        print((appDel.window?.rootViewController as! UINavigationController).children[0].children)
        guard let NavVc = appDel.window?.rootViewController as? UINavigationController else {return}
        print(NavVc.children[0].children)
        guard let objhomeVC = NavVc.children[0].children[0] as? UINavigationController else {
            return
        }
        guard let homeVC = objhomeVC.children[0] as? HomeVC else {
            return
        }
    
        if self.containerTopView.isHidden == false {
        
         let  arrdriverInfoView  = self.botomContentView.subviews.compactMap({$0 as? CurrrentRideDriverInfo})
         guard let driverInfoVC : CurrrentRideDriverInfo = arrdriverInfoView[0] as? CurrrentRideDriverInfo else { return }
        
        driverInfoVC.objBookingInfo = obj.bookingInfo
        driverInfoVC.setUpUI(isFromArrived: true, isFromApi: false)
        driverInfoVC.heightGet = { (height , isExpand) in
            self.conHeightOfCurrentDriverDetail.constant = height
        }
       }
    }
    
    //MARK:- ========= Arrived Driver Setup ========
    func WebserviceArrivedDriverSetup(obj : RootCurrentBooking) {
        NotificationCenter.default.post(name: .OpenCurrentRideDriverInfoVC, object: nil)
        print((appDel.window?.rootViewController as! UINavigationController).children)
        print((appDel.window?.rootViewController as! UINavigationController).children[0].children)
        guard let NavVc = appDel.window?.rootViewController as? UINavigationController else {return}
        print(NavVc.children[0].children)
        guard let objhomeVC = NavVc.children[0].children[0] as? UINavigationController else {
            return
        }
        guard let homeVC = objhomeVC.children[0] as? HomeVC else {
            return
        }
//        guard let driverInfoVC = homeVC.children[0] as? CurrentRideDriverInformationVC else {
//            return
//        }
        if self.containerTopView.isHidden == false {
        
         let  arrdriverInfoView  = self.botomContentView.subviews.compactMap({$0 as? CurrrentRideDriverInfo })
            guard let driverInfoVC : CurrrentRideDriverInfo = arrdriverInfoView[0] as? CurrrentRideDriverInfo else { return }
        
        
        driverInfoVC.objCurrentBooking = obj.data
        driverInfoVC.setUpUI(isFromArrived: true, isFromApi: true)
        driverInfoVC.heightGet = { (height , isExpand) in
            self.conHeightOfCurrentDriverDetail.constant = height
         }
        }
    }
    
    //MARK:- ======= Cancel Trip Socket Implementation =====
    func onSocketCancelTrip(){
        SocketIOManager.shared.socketCall(for: socketApikeys.KCancelTrip) { json in
            print(json)
            let objDict = json[0]
           
            Toast.show(message: objDict["message"].stringValue, state: .success)
            self.currentLocationSetup()
        }
    }
    
    //MARK:- ======= Emit Socket Call Near by Driver=========
    func emitSocketNearByDriver(){
        let param = [
            socketApikeys.KCustomerID : Singleton.sharedInstance.UserId,
            socketApikeys.KCurrentLat : Singleton.sharedInstance.latitute,
            socketApikeys.KCurrentLng : Singleton.sharedInstance.longtitute,
        ] as [String:Any]
        SocketIOManager.shared.socketEmit(for: socketApikeys.KNearByDriver, with: param)
    }
    
    //MARK: ===== start timer for update location =======
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    func startTimer() {
        stopTimer()
//        if(timer == nil){
        timer = Timer.scheduledTimer(withTimeInterval: 10, repeats: true, block: { (timer) in
             print(timer)
            if  SocketIOManager.shared.socket.status == .connected {
                    self.emitSocketNearByDriver()
                print("lat \(Singleton.sharedInstance.latitute) , long : \(Singleton.sharedInstance.longtitute)")
            }
         })
//        }
      }

    //MARK:- ========= On Socket Call Near By Driver ======
    func onSocketNearByDriver(){
        SocketIOManager.shared.socketCall(for: socketApikeys.KNearByDriver) { json in
            print("ATDebug :: \(#function) \n \(json)" )
          
            let objDict = json[0]
            let objDriver = RootNearByDrivers(fromJson: objDict)
            print(objDriver.drivers.count)
            if objDriver.drivers.count != 0 {
                self.nearByDrivers = objDriver.drivers
              //  self.NearByDriversSetup(Drivers: self.nearByDrivers)
            }
            else {
                self.nearByDrivers.removeAll()
            }
            //if self.selectTexiVCContainerVW.isHidden == false {
            let arrselctTaxitype = self.botomContentView.subviews.compactMap{ $0 as? SelectTaxiTypes }
              if  arrselctTaxitype.count != 0 {
                guard let NavVc = appDel.window?.rootViewController as? UINavigationController else {return}
                print(NavVc.children[0].children)
                guard let objhomeVC = NavVc.children[0].children[0] as? UINavigationController else {
                    return
                }
                guard let homeVC = objhomeVC.children[0] as? HomeVC else {
                    return
                }
//                guard let taxitypeVC = homeVC.children[2] as? SelectTaxiTypeVC else {
//                    return
//                }
                
               // if taxitypeVC.selectedTaxi == NSNotFound {
                if SocketIOManager.shared.socket.status == .connected     {                    self.emitSocketEstimateFare(PickupLat:self.arrPickupPlace[0].lat, PickupLng:self.arrPickupPlace[0].lng, DropOfLat: self.arrDestinationPlace[0].lat, DropOfLng:self.arrDestinationPlace[0].lng, CityName: self.arrDestinationPlace[0].cityName)
                    }
                }
            }
         }
    
    //MARK:- ===== Near By Drivers Display ========
    func NearByDriversSetup(Drivers: [Driver]){
        mapVw.clear()
        for obj in Drivers {
            let currentMarker1 = GMSMarker()
            currentMarker1.position = CLLocationCoordinate2D(latitude:Double(obj.location[1]) ?? 0.0, longitude:Double(obj.location[0]) ?? 0.0)
            let CurrentmarkerView1 = MarkerView()
            CurrentmarkerView1.markerImage = UIImage(named: "car")
            CurrentmarkerView1.layoutSubviews()
            currentMarker1.iconView = CurrentmarkerView1
            currentMarker1.map = self.mapVw

                let mapInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 300.0, right: 0.0)
                self.mapVw.padding = mapInsets
                self.arrMarkers.removeAll()
                self.arrMarkers.append(currentMarker1)
                var bounds = GMSCoordinateBounds()
                for marker in self.arrMarkers
                {
                    bounds = bounds.includingCoordinate(marker.position)
                }
                let update = GMSCameraUpdate.fit(bounds, withPadding: 17)
                self.mapVw.animate(with: update)
        }
    }
    
    //MARK:- ======= On Socket Live Tracking =====
    func OnSocketLiveTracking(){
        SocketIOManager.shared.socketCall(for: socketApikeys.KLiveTracking) { json in
            print(json)
            let objdict = json[0]
            print(objdict)
            let objdriverLocation = objdict["current_location"]
            let lat = objdriverLocation[1].rawValue as! Double
            let lng = objdriverLocation[0].rawValue as! Double
            
            if self.isFirtLocation == true || self.isStartTrip == true{
                self.updateMarker(lat: lat, lng: lng)
            }
            else if self.isFirtLocation == false{
                self.isFirtLocation = true
                self.mapVw.clear()
                
                let currentMarker = GMSMarker()
                currentMarker.position = CLLocationCoordinate2D(latitude:Singleton.sharedInstance.latitute, longitude: Singleton.sharedInstance.longtitute)
                let CurrentmarkerView = MarkerView()
                CurrentmarkerView.markerImage = UIImage(named: "ic_DropOff")
                CurrentmarkerView.layoutSubviews()
                currentMarker.iconView = CurrentmarkerView
                currentMarker.map = self.mapVw
                
            
                let currentMarker1 = GMSMarker()
                currentMarker1.position = CLLocationCoordinate2D(latitude:lat, longitude:lng)
                let CurrentmarkerView1 = MarkerView()
                CurrentmarkerView1.markerImage = UIImage(named: "car")
                CurrentmarkerView1.layoutSubviews()
                currentMarker1.iconView = CurrentmarkerView1
                currentMarker1.map = self.mapVw
                
                    let mapInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 300.0, right: 0.0)
                    self.mapVw.padding = mapInsets
                    self.arrMarkers.removeAll()
                    self.arrMarkers.append(currentMarker)
                    self.arrMarkers.append(currentMarker1)
                    var bounds = GMSCoordinateBounds()
                    for marker in self.arrMarkers
                    {
                        bounds = bounds.includingCoordinate(marker.position)
                    }
                    let update = GMSCameraUpdate.fit(bounds, withPadding: 17)
                    self.mapVw.animate(with: update)
            
                 self.getPolylineRoute(from: CLLocationCoordinate2D(latitude:Singleton.sharedInstance.latitute, longitude:Singleton.sharedInstance.longtitute), to: CLLocationCoordinate2D(latitude:lat, longitude:lng))
            }
        }
    }
    
    //MARK:- ===== Update placemark ======
    func updateMarker(lat:Double , lng : Double){
        DispatchQueue.main.async {
            
            if(self.oldCoordinate == nil){
                self.oldCoordinate = CLLocationCoordinate2DMake(lat, lng)
            }
            if(self.Driverplacemarker == nil){
                self.Driverplacemarker = GMSMarker(position: self.oldCoordinate)
                self.Driverplacemarker?.icon = UIImage(named: "car")
                self.Driverplacemarker?.map = self.mapVw
            }
            let newCoordinate: CLLocationCoordinate2D = CLLocationCoordinate2DMake(CLLocationDegrees(lat), CLLocationDegrees(lng))
            self.moveMent?.arCarMovement(marker: self.Driverplacemarker!, oldCoordinate: self.oldCoordinate, newCoordinate: newCoordinate, mapView: self.mapVw, bearing: Float(0))
            self.oldCoordinate = newCoordinate
            
            if self.isCameraAnimation == true {
                let camera = GMSCameraPosition.camera(withLatitude: newCoordinate.latitude, longitude: newCoordinate.longitude, zoom: 17)
                self.mapVw.animate(to: camera)
            }
        }
    }
    
    //MARK:- ====== On Socket Complete Trip =====
    func OnSocketCompleteTrip(){
        SocketIOManager.shared.socketCall(for: socketApikeys.KCompleteTrip) { json in
              print(json)
             let objDict = json[0]
             print(objDict)
            
            self.presentedViewController?.dismiss(animated: true, completion: nil)
            Toast.show(message: objDict["message"].stringValue, state: .success)

//            self.bottomVWWhereAreYouGoing.isHidden = true
//            self.selectTexiVCContainerVW.isHidden = true
//            self.currentRideDriverInfoContainerVW.isHidden = true
//            self.currentRideDetailContainerVW.isHidden = true
//
            self.containerTopView.isHidden = true
            self.botomContentView.removeAllSubviews()
            self.botomContentView.isHidden = true
            let obj = RootBookingRequestAccept(fromJson: objDict)
            let ratingReviewVC :RatingYourTripVC  = RatingYourTripVC.instantiate(fromAppStoryboard: .Main)
            ratingReviewVC.objBookingInfo = obj.bookingInfo
            ratingReviewVC.skipBtnClicked = {
                self.dismiss(animated: true) {
                    self.currentLocationSetup()
                }
            }
            ratingReviewVC.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
//            let navigationController = UINavigationController(rootViewController: ratingReviewVC)
//            navigationController.modalPresentationStyle = .overCurrentContext
//            navigationController.modalTransitionStyle = .crossDissolve
           // self.navigationController.isHidden = true
            self.present(ratingReviewVC, animated: true, completion: nil)
        }
    }
    
    
    
    //MARK:- === On Socket Start Trip =======
    func OnSocketStartTrip(){
        SocketIOManager.shared.socketCall(for: socketApikeys.KStartTrip) { json in
            print(json)
            let objDict = json[0]
            print(objDict)
            let obj = RootBookingRequestAccept(fromJson: objDict)
            print(obj)

            self.StartRideSetup(obj: obj)
        }
    }
    
    //MARK:- ====== Start Ride Setup ======
    func WebserviceStartRideSetup(obj : RootCurrentBooking){
        NotificationCenter.default.post(name: .OpenCurrentRideDetailsVC, object: nil)
        print((appDel.window?.rootViewController as! UINavigationController).children)
        print((appDel.window?.rootViewController as! UINavigationController).children[0].children)
        guard let NavVc = appDel.window?.rootViewController as? UINavigationController else {return}
        print(NavVc.children[0].children)
        guard let objhomeVC = NavVc.children[0].children[0] as? UINavigationController else {
            return
        }
        guard let homeVC = objhomeVC.children[0] as? HomeVC else {
            return
        }
    
        if self.containerTopView.isHidden == false {
        
         let  arrdriverInfoView  = self.botomContentView.subviews.compactMap({$0 as? CurrentRideDetail})
         guard let driverInfoVC : CurrentRideDetail = arrdriverInfoView[0] as? CurrentRideDetail else { return }
        
//        guard let driverInfoVC = homeVC.children[1] as? CurrentRideDetailsVC else {
//            return
//        }
        self.isStartTrip = true
        isFirtLocation = true
        self.mapVw.clear()
        self.Driverplacemarker = GMSMarker()
        self.Driverplacemarker.position = CLLocationCoordinate2D(latitude:Double(obj.data?.pickupLat ?? "") ?? 0.0, longitude: Double(obj.data?.pickupLng ?? "") ?? 0.0)
        let DrivermarkerView = MarkerView()
        DrivermarkerView.markerImage = UIImage(named: "car")
        self.Driverplacemarker.title = ""
        self.Driverplacemarker.snippet = ""
        DrivermarkerView.layoutSubviews()
        self.Driverplacemarker.iconView = DrivermarkerView
        self.Driverplacemarker.map = self.mapVw
        
    
        let currentMarker = GMSMarker()
        currentMarker.position = CLLocationCoordinate2D(latitude:Double(obj.data?.dropoffLat ?? "") ?? 0.0, longitude: Double(obj.data?.dropoffLng ?? "") ?? 0.0)
        let CurrentmarkerView = MarkerView()
        CurrentmarkerView.markerImage = UIImage(named: "ic_DropOff")
        CurrentmarkerView.layoutSubviews()
        currentMarker.iconView = CurrentmarkerView
        currentMarker.map = self.mapVw
        
        self.getPolylineRoute(from: CLLocationCoordinate2D(latitude: Double(obj.data?.pickupLat ?? "") ?? 0.0, longitude: Double(obj.data?.pickupLng ?? "") ?? 0.0), to: CLLocationCoordinate2D(latitude: Double(obj.data?.dropoffLat ?? "") ?? 0.0, longitude: Double(obj.data?.dropoffLng ?? "") ?? 0.0))
        
        driverInfoVC.objCurrentBooking = obj.data
        driverInfoVC.setUpUI(isFromApi: true)
        }
    }
    
    
    //MARK:- ====== Start Ride Setup ======
    func StartRideSetup(obj : RootBookingRequestAccept){
        NotificationCenter.default.post(name: .OpenCurrentRideDetailsVC, object: nil)
        print((appDel.window?.rootViewController as! UINavigationController).children)
        print((appDel.window?.rootViewController as! UINavigationController).children[0].children)
        guard let NavVc = appDel.window?.rootViewController as? UINavigationController else {return}
        print(NavVc.children[0].children)
        guard let objhomeVC = NavVc.children[0].children[0] as? UINavigationController else {
            return
        }
        guard let homeVC = objhomeVC.children[0] as? HomeVC else {
            return
        }
        
        if self.containerTopView.isHidden == false {
        
         let  arrdriverInfoView  = self.botomContentView.subviews.compactMap({$0 as? CurrentRideDetail })
            guard let driverInfoVC : CurrentRideDetail = arrdriverInfoView[0] as? CurrentRideDetail else { return }
        
    
//        guard let driverInfoVC = homeVC.children[1] as? CurrentRideDetailsVC else {
//            return
//        }
        self.isStartTrip = true
        isFirtLocation = true
        self.mapVw.clear()
        self.Driverplacemarker = GMSMarker()
        self.Driverplacemarker.position = CLLocationCoordinate2D(latitude:Double(obj.bookingInfo.pickupLat) ?? 0.0, longitude: Double(obj.bookingInfo.pickupLng) ?? 0.0)
        let DrivermarkerView = MarkerView()
        DrivermarkerView.markerImage = UIImage(named: "car")
        self.Driverplacemarker.title = ""
        self.Driverplacemarker.snippet = ""
        DrivermarkerView.layoutSubviews()
        self.Driverplacemarker.iconView = DrivermarkerView
        self.Driverplacemarker.map = self.mapVw
        
        let currentMarker = GMSMarker()
        currentMarker.position = CLLocationCoordinate2D(latitude:Double(obj.bookingInfo.dropoffLat) ?? 0.0, longitude: Double(obj.bookingInfo.dropoffLng) ?? 0.0)
        let CurrentmarkerView = MarkerView()
        CurrentmarkerView.markerImage = UIImage(named: "ic_DropOff")
        CurrentmarkerView.layoutSubviews()
        currentMarker.iconView = CurrentmarkerView
        currentMarker.map = self.mapVw
        
        
        self.getPolylineRoute(from: CLLocationCoordinate2D(latitude: Double(obj.bookingInfo.pickupLat) ?? 0.0, longitude: Double(obj.bookingInfo.pickupLng) ?? 0.0), to: CLLocationCoordinate2D(latitude: Double(obj.bookingInfo.dropoffLat) ?? 0.0, longitude: Double(obj.bookingInfo.dropoffLng) ?? 0.0))
        
        driverInfoVC.objBookingInfo = obj.bookingInfo
        driverInfoVC.setUpUI(isFromApi: false)
        }
    }
    
    
    //MARK:- ===== On Socket Verify Customer ====
    func onsocketVerifyCustomer(){
        SocketIOManager.shared.socketCall(for: socketApikeys.KVerifyCustomer) { json in
             print(json)
             let dictjson = json[0]
             print(dictjson)
            Toast.show(message: dictjson["message"].stringValue + dictjson["otp"].stringValue, state: .info)
        }
    }

    
    //MARK:- ==== Open Current Ride Detail ======
    @objc func openCurrentRideDetailsVC(){
        btnCancel.isHidden = true
        btnShare.isHidden = false
        self.botomContentView.removeAllSubviews()
        self.containerTopView.isHidden = false
        self.bottomVWWhereAreYouGoing.isHidden = true
        self.botomContentView.customAddSubview(self.currentRideDetailView)
//        self.bottomVWWhereAreYouGoing.isHidden = true
//        self.selectTexiVCContainerVW.isHidden = true
//        self.currentRideDriverInfoContainerVW.isHidden = true
//        self.currentRideDetailContainerVW.isHidden = false
    }
}


//MARK:- UITextFiled Delegate
extension HomeVC: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
        
        let controller = ChooseDestinationVC.instantiate(fromAppStoryboard: .Main)
        controller.openSelectTexiVC = { (pickup,dropoff) in
            
            self.CurrenDestinationRouteSetup(pickup: pickup, dropoff: dropoff)
            
//            self.arrPickupPlace.removeAll()
//            self.arrDestinationPlace.removeAll()
//            self.arrPickupPlace.append(pickup)
//            self.arrDestinationPlace.append(dropoff)
//
//
//            self.bookingReqModel.pickupAddress = pickup.location
//            self.bookingReqModel.dropoffAddress = dropoff.location
//            self.bookingReqModel.pickupLatitude = "\(pickup.lat)"
//            self.bookingReqModel.pickupLongitude = "\(pickup.lng)"
//            self.bookingReqModel.dropoffLatitude = "\(dropoff.lat)"
//            self.bookingReqModel.dropoffLongitude = "\(dropoff.lng)"
//
//            self.mapVw.clear()
//            self.isFirtLocation = true
//            self.selectTexiVCContainerVW.isHidden = false
//            self.navigationBarSetup()
//
//            let currentMarker = GMSMarker()
//            currentMarker.position = CLLocationCoordinate2D(latitude: pickup.lat, longitude: pickup.lng)
//            let markerView = MarkerView()
//            markerView.markerImage = UIImage(named: "iconCurrentLocPin")
//            markerView.layoutSubviews()
//            currentMarker.iconView = markerView
//            currentMarker.map = self.mapVw
//
//
//            let destinationMarker = GMSMarker()
//            destinationMarker.position = CLLocationCoordinate2D(latitude: dropoff.lat, longitude: dropoff.lng)
//            let markerView1 = MarkerView()
//            markerView1.markerImage = UIImage(named: "ic_DropOff")
//            markerView1.layoutSubviews()
//            destinationMarker.iconView = markerView1
//            destinationMarker.map = self.mapVw
//
//            let mapInsets = UIEdgeInsets(top: 20, left: 0.0, bottom: self.conHeightOfTaxi.constant, right: 0.0)
//                self.mapVw.padding = mapInsets
//
//                 self.arrMarkers.append(currentMarker)
//                self.arrMarkers.append(destinationMarker)
//                var bounds = GMSCoordinateBounds()
//                for marker in self.arrMarkers
//                {
//                    bounds = bounds.includingCoordinate(marker.position)
//                }
//                let update = GMSCameraUpdate.fit(bounds, withPadding: 80)
//                self.mapVw.animate(with: update)
//
//
//            self.getPolylineRoute(from: CLLocationCoordinate2D(latitude: pickup.lat, longitude: pickup.lng), to: CLLocationCoordinate2D(latitude: dropoff.lat, longitude: dropoff.lng))
//
//            self.SelectedLocationString = (pickup.location,dropoff.location)
//            if SocketIOManager.shared.socket.status == .connected {
//                self.emitSocketEstimateFare(PickupLat: pickup.lat, PickupLng: pickup.lng, DropOfLat: dropoff.lat, DropOfLng: dropoff.lng)
//            }
        }
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    
    //MARK:- ===== Current destination Route =====
    func CurrenDestinationRouteSetup(pickup:placePickerData,dropoff:placePickerData){
        self.arrPickupPlace.removeAll()
        self.arrDestinationPlace.removeAll()
        self.arrPickupPlace.append(pickup)
        self.arrDestinationPlace.append(dropoff)
        
        self.bookingReqModel.pickupAddress = pickup.location
        self.bookingReqModel.dropoffAddress = dropoff.location
        self.bookingReqModel.pickupLatitude = "\(pickup.lat)"
        self.bookingReqModel.pickupLongitude = "\(pickup.lng)"
        self.bookingReqModel.dropoffLatitude = "\(dropoff.lat)"
        self.bookingReqModel.dropoffLongitude = "\(dropoff.lng)"
        self.bookingReqModel.cityName = arrDestinationPlace.first?.cityName ?? ""
        
        self.mapVw.clear()
        self.isFirstTimeLoadView = true
        self.selectTexiVCContainerVW.isHidden = false
        self.navigationBarSetup()
        
        self.SelectedLocationString = (pickup.location,dropoff.location)
        if SocketIOManager.shared.socket.status == .connected {
            self.emitSocketEstimateFare(PickupLat: pickup.lat, PickupLng: pickup.lng, DropOfLat: dropoff.lat, DropOfLng: dropoff.lng, CityName: dropoff.cityName )
        }
        startTimer()
        let currentMarker = GMSMarker()
        currentMarker.position = CLLocationCoordinate2D(latitude: pickup.lat, longitude: pickup.lng)
        let markerView = MarkerView()
        markerView.markerImage = UIImage(named: "iconCurrentLocPin")
        markerView.layoutSubviews()
        currentMarker.userData = "currentMarker"
        currentMarker.iconView = markerView
        currentMarker.map = self.mapVw
        self.mapVw.delegate = self
        
        let destinationMarker = GMSMarker()
        destinationMarker.position = CLLocationCoordinate2D(latitude: dropoff.lat, longitude: dropoff.lng)
        let markerView1 = MarkerView()
        markerView1.markerImage = UIImage(named: "ic_DropOff")
        markerView1.layoutSubviews()
        destinationMarker.userData = "destinationMarker"
        destinationMarker.iconView = markerView1
        destinationMarker.map = self.mapVw

         let mapInsets = UIEdgeInsets(top: 50, left: 15, bottom: self.selectTexiVCContainerVW.frame.height, right: 15)
            self.mapVw.padding = mapInsets
            self.arrMarkers.removeAll()
            self.arrMarkers.append(currentMarker)
            self.arrMarkers.append(destinationMarker)
            var bounds = GMSCoordinateBounds()
            for marker in self.arrMarkers
            {
                bounds = bounds.includingCoordinate(marker.position)
            }
    
            let update = GMSCameraUpdate.fit(bounds, withPadding: 17)
            self.mapVw.animate(with: update)
        
           delay(seconds: 5) {
            
            let camera = GMSCameraPosition.camera(withLatitude: pickup.lat, longitude: pickup.lng, zoom: 20);
                self.mapVw.camera = camera
          }

          self.getPolylineRoute(from: CLLocationCoordinate2D(latitude: pickup.lat, longitude: pickup.lng), to: CLLocationCoordinate2D(latitude: dropoff.lat, longitude: dropoff.lng))
       }
    
    //MARK:- ====== Tap On Marker =====
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool
    {
        if marker.userData as? String ?? "" == "currentMarker" {
            let controller = PickupViewController.instantiate(fromAppStoryboard: .Main)
            controller.pinnedLocation = marker.position
           
            controller.dropOffData = arrDestinationPlace
            controller.openSelectTexiVC = { (pickup,dropoff) in
                self.CurrenDestinationRouteSetup(pickup: pickup, dropoff: dropoff)
                
                guard let NavVc = appDel.window?.rootViewController as? UINavigationController else {return}
                print(NavVc.children[0].children)
                guard let objhomeVC = NavVc.children[0].children[0] as? UINavigationController else {
                    return
                }
                guard let homeVC = objhomeVC.children[0] as? HomeVC else {
                    return
                }
//                guard let taxitypeVC = homeVC.children[2] as? SelectTaxiTypeVC else {
//                    return
//                }
//
                let arrselctTaxitype = self.botomContentView.subviews.compactMap{ $0 as? SelectTaxiTypes }
                if  arrselctTaxitype.count != 0 {
                     arrselctTaxitype[0].selectedTaxi = NSNotFound
                }
               
            }
            self.navigationController?.pushViewController(controller, animated: true)
            print("ATDebug :: currentMarker tappend ")
           } else if marker.userData as? String ?? "" == "destinationMarker" {
            print("ATDebug :: destinationMarker tappend ")
           }
           return true
       }
    
    
    //MARK:- ====== Open Location Selection =======
    @objc func openLocationSelection(){
        let controller = ChooseDestinationVC.instantiate(fromAppStoryboard: .Main)
        controller.isFromSelectedLocation = true
        controller.arrPickupPlace = arrPickupPlace
        controller.arrDestinationPlace = arrDestinationPlace
        
        controller.openSelectTexiVC = { (pickup,dropoff) in
            self.CurrenDestinationRouteSetup(pickup: pickup, dropoff: dropoff)
            guard let NavVc = appDel.window?.rootViewController as? UINavigationController else {return}
            print(NavVc.children[0].children)
            guard let objhomeVC = NavVc.children[0].children[0] as? UINavigationController else {
                return
            }
            guard let homeVC = objhomeVC.children[0] as? HomeVC else {
                return
            }
        
//            guard let taxitypeVC = homeVC.children[2] as? SelectTaxiTypeVC else {
//                return
//            }
            
            let arrselctTaxitype = self.botomContentView.subviews.compactMap{ $0 as? SelectTaxiTypes }
            if  arrselctTaxitype.count != 0 {
                arrselctTaxitype[0].selectedTaxi = NSNotFound
            }
           
            
        }
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
//    "customer_id
//    pickup_lat
//    pickup_lng
//    dropoff_lat
//    dropoff_lng"
    //MARK:- ===== Emit socket EstimateFare =====
    func emitSocketEstimateFare(PickupLat : Double , PickupLng : Double , DropOfLat : Double , DropOfLng : Double, CityName: String){
        
        let param = [
            socketApikeys.KCustomerID : Singleton.sharedInstance.UserId,
            socketApikeys.KPickupLat : PickupLat,
            socketApikeys.KPickupLng : PickupLng,
            socketApikeys.KDropOffLat : DropOfLat,
            socketApikeys.KDropOffLng : DropOfLng,
            socketApikeys.KCityName: CityName
        ] as [String:Any]
        print("param \(param)")
        SocketIOManager.shared.socketEmit(for: socketApikeys.KGetEstimateFare, with: param)
    }
    
    //MARK:- ===== On Socket Estimate Fare =====
    func onSocketGetEstimateFare(){
        SocketIOManager.shared.socketCall(for: socketApikeys.KGetEstimateFare) { (json) in
            print("ATDebug :: \(#function)")
            print(json)
            let objDictJson = json[0]
            print(objDictJson)
            
            let objjson = RootDrivers(fromJson: objDictJson)
            
            DispatchQueue.main.async {
                self.btnCancel.isHidden = false
                self.btnShare.isHidden = true
               // self.selectTexiVCContainerVW.isHidden = false
                self.containerTopView.isHidden = false
                self.bottomVWWhereAreYouGoing.isHidden = true
                self.botomContentView.customAddSubview(self.taxiTypeView)
                
            }
            print(objjson)
            print((appDel.window?.rootViewController as! UINavigationController).children)
            print((appDel.window?.rootViewController as! UINavigationController).children[0].children)
            guard let NavVc = appDel.window?.rootViewController as? UINavigationController else {return}
            print(NavVc.children[0].children)
            guard let objhomeVC = NavVc.children[0].children[0] as? UINavigationController else {
                return
            }
            guard let homeVC = objhomeVC.children[0] as? HomeVC else {
                return
            }
        
//            guard let taxitypeVC = homeVC.children[2] as? SelectTaxiTypeVC else {
//                return
//            }
            
            if self.containerTopView.isHidden == false {
            
             let  arrselctTaxitype  = self.botomContentView.subviews.compactMap({$0 as? SelectTaxiTypes })
            guard let taxitypeVC : SelectTaxiTypes = arrselctTaxitype[0] as? SelectTaxiTypes else {
                    return
            }
            
            taxitypeVC.bookingSucess = {
                self.bottomVWWhereAreYouGoing.isHidden = true
                self.containerTopView.isHidden = true
                self.navigationBarSetup()
                
                let popupVc : ProgressPopupVC = ProgressPopupVC.instantiate(fromAppStoryboard: .Main)
                popupVc.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
                let navigationController = UINavigationController(rootViewController: popupVc)
                navigationController.modalPresentationStyle = .overCurrentContext
                navigationController.modalTransitionStyle = .crossDissolve
                navigationController.navigationBar.isHidden = true
                self.present(navigationController, animated: true, completion: nil)
                
            }
            
            self.navigationBarSetup()
            taxitypeVC.bookingReqModel = self.bookingReqModel

            if self.nearByDrivers.count != 0 {
                
                self.arrTaxiData.removeAll()
                
                self.arrTaxiTypes.removeAll()
                
                let taxitypes = self.nearByDrivers.map{$0.vehicleTypeId}
               
                print(taxitypes.compactMap{$0})
        
                for obj in taxitypes {
                    for j in obj!{
                        self.arrTaxiTypes.append(j)
                    }
                }
                
                let arrunique = Array(Set(self.arrTaxiTypes))

                for i in arrunique {
                    for j in objjson.estimateFare {
                        if i == j.vehicleTypeId {
                            self.arrTaxiData.append(j)
                        }
                    }
                }
                
                // Tej's Code
                self.arrAllTaxiData.removeAll()
                for j in objjson.estimateFare {
                    self.arrAllTaxiData.append(j)
                }
                // Tej's Code Comp
                
                print(self.isFirstTimeLoadView)
                taxitypeVC.taxiData = self.arrTaxiData
                taxitypeVC.availableTaxi = self.arrTaxiData
                taxitypeVC.allTaxiData = self.arrAllTaxiData
                taxitypeVC.setUPUI(isExpand: self.isFirstTimeLoadView)
            
                taxitypeVC.heightGet = { (height , isExpand) in
                    self.isFirstTimeLoadView = isExpand
                    self.conHeightOfTaxi.constant = height
                }
            }
            
            else {
                
                self.arrTaxiTypes.removeAll()
                self.arrTaxiData.removeAll()
                self.nearByDrivers.removeAll()
                // Tej's Code
                self.arrAllTaxiData.removeAll()
                for j in objjson.estimateFare {
                    self.arrAllTaxiData.append(j)
                }
                taxitypeVC.allTaxiData = self.arrAllTaxiData
                taxitypeVC.taxiData = self.arrTaxiData
                taxitypeVC.availableTaxi = self.arrTaxiData
                // Tej's Code Comp
                
                taxitypeVC.setUPUI(isExpand: self.isFirstTimeLoadView)
                
                //Toast.show(message: "No drivers available", state: .failure)
                taxitypeVC.heightGet = { (height , isExpand) in
                    self.isFirstTimeLoadView = isExpand
                    self.conHeightOfTaxi.constant = height
                }
               // taxitypeVC.taxiData = objjson.estimateFare
            }
           // taxitypeVC.tblSuggestedRides.reloadData()
         }
        }
    }
    
    //MARK:- ====== Current Booking =======
    func WebserviceCallCurrentBooking(){
        
        WebServiceSubClass.CurrentBookingHistory(CustomerId: Singleton.sharedInstance.UserId) { status, msg, response, error in

            if status {
                print(response ?? Data())
            
                if response?.data != nil {
                   
                    let obj = response?.data
                    if obj?.pickupTime != nil && obj?.pickupTime != "" {
                        
                        self.WebserviceStartRideSetup(obj: response!)
                    }
                     else if obj?.arrivedTime != nil && obj?.arrivedTime != "" {
                        self.WebserviceArrivedDriverSetup(obj: response!)
                    }
                    else if obj?.acceptTime != nil && obj?.acceptTime != ""{
                        self.WebServiceDriverRequestAccept(obj: response!)
                    }
                }
            }
        }
    }
    
    //MARK:- ===== Current locationSetup =====
    func currentLocationSetup(){
        startTimer()
        isFirstTimeLoadView = true
        self.mapVw.clear()
        CurrentPlaceMarker = nil
        Driverplacemarker = nil
        self.Driverplacemarker = nil
        self.isFirtLocation = false
        self.isStartTrip = false
        getFirstView()
        
        
//        self.selectTexiVCContainerVW.isHidden = true
//        self.currentRideDriverInfoContainerVW.isHidden = true
//        self.currentRideDetailContainerVW.isHidden = true
       
    }
    
    
    //MARK:- ====== Draw Route  =======
    func getPolylineRoute(from source: CLLocationCoordinate2D, to destination: CLLocationCoordinate2D){

            let config = URLSessionConfiguration.default
            let session = URLSession(configuration: config)

        let url = URL(string: "https://maps.googleapis.com/maps/api/directions/json?origin=\(source.latitude),\(source.longitude)&destination=\(destination.latitude),\(destination.longitude)&sensor=true&mode=driving&key=\(APIEnvironment.GoogleMapKey.rawValue)")!

            let task = session.dataTask(with: url, completionHandler: {
                (data, response, error) in
                if error != nil {
                    print(error!.localizedDescription)
//                    self.activityIndicator.stopAnimating()
                }
                else {
                    do {
                        if let json : [String:Any] = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: Any]{

                            guard let routes = json["routes"] as? NSArray else {
                                DispatchQueue.main.async {
//                                    self.activityIndicator.stopAnimating()
                                }
                                return
                            }
                            if (routes.count > 0) {
                                let overview_polyline = routes[0] as? NSDictionary
                                let dictPolyline = overview_polyline?["overview_polyline"] as? NSDictionary

                                let points = dictPolyline?.object(forKey: "points") as? String

                                DispatchQueue.main.async {
                                    self.showPath(polyStr: points!)
//                                    self.activityIndicator.stopAnimating()
                                }
                            }
                            else {
                                DispatchQueue.main.async {
                                    //self.activityIndicator.stopAnimating()
                                }
                            }
                        }
                    }
                    catch {
                        print("error in JSONSerialization")
                        DispatchQueue.main.async {
                            //self.activityIndicator.stopAnimating()
                        }
                    }
                }
            })
            task.resume()
        }

        func showPath(polyStr :String){
            let path = GMSPath(fromEncodedPath: polyStr)
            let polyline = GMSPolyline(path: path)
            polyline.strokeWidth = 3.0
            polyline.strokeColor = UIColor.black
            polyline.map = mapVw // Your map view
            
//            let bounds = GMSCoordinateBounds(path: path!)
//            self.mapVw.animate(with: GMSCameraUpdate.fit(bounds))
        }
    
    //MARK:- ====== current location Camera setup ====
    func setCurrentLocationClicked(){
        isCameraAnimation = true
        let camera = GMSCameraPosition.camera(withLatitude: Singleton.sharedInstance.latitute, longitude: Singleton.sharedInstance.longtitute, zoom: 13)
            mapVw?.camera = camera
            mapVw?.animate(to: camera)
    }
}

extension HomeVC : CLLocationManagerDelegate {
    
    func delay(seconds: Double, closure: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            closure()
        }
      }
    
    //MARK: - location delegate methods
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation :CLLocation = locations[0] as CLLocation

        print("user latitude = \(userLocation.coordinate.latitude)")
        print("user longitude = \(userLocation.coordinate.longitude)")
        
        Singleton.sharedInstance.latitute = userLocation.coordinate.latitude
        Singleton.sharedInstance.longtitute = userLocation.coordinate.longitude
        
        let center = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)

        let camera = GMSCameraPosition.camera(withLatitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude, zoom: 13);
            self.mapVw.camera = camera
           // self.mapVw.isMyLocationEnabled = true
                isFirstTimeLoadView = true
                mapVw.clear()
                //Current Location pin setup
                let CurrentLocMarker = GMSMarker()
                CurrentLocMarker.position = center
              //  CurrentLocMarker.snippet = "Your Location"
                
                let markerView2 = MarkerView()
                markerView2.markerImage = UIImage(named: "iconCurrentLocPin")
                markerView2.layoutSubviews()
                
                CurrentLocMarker.iconView = markerView2
                CurrentLocMarker.map = self.mapVw
                self.mapVw.selectedMarker = CurrentLocMarker
    
            locationManager.stopUpdatingLocation()

        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(userLocation) { (placemarks, error) in
            if (error != nil){
                print("error in reverseGeocode")
            }
            guard let placemark = placemarks as? [CLPlacemark] else {return}
            if placemark.count>0{
                let placemark = placemarks![0]
                print(placemark.locality!)
                print(placemark.administrativeArea!)
                print(placemark.country!)
               
                self.txtFieldWhereAreYouGoing.text = "\(placemark.name ?? ""), \(placemark.thoroughfare ?? ""), \(placemark.subThoroughfare ?? ""), \(placemark.subLocality ?? ""), \(placemark.locality ?? ""), \(placemark.postalCode ?? ""), \(placemark.country ?? "")"
            }
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error \(error)")
    }
}

