//
//  SelectTaxiTypeViewController.swift
//  PickARide User
//
//  Created by Apple on 21/12/20.
//  Copyright © 2020 EWW071. All rights reserved.
//

import UIKit
import GoogleMaps
import GoogleMaps

class SelectTaxiTypeViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource {
   
    

    //MARK: -Properties
    var taxiData = [suggestRide]()
    var selectedTaxi = 0
    //MARK: -IBOutlets
    
    @IBOutlet weak var showRouteMapView: GMSMapView!
   
    @IBOutlet weak var lblCardPayment: suggestedRidesLabel!
    @IBOutlet weak var lblSuggestedRide: suggestedRidesLabel!
    @IBOutlet weak var btnCardPayment: UIButton!
    @IBOutlet weak var btnOffer: UIButton!
    @IBOutlet weak var btnBookNow: submitButton!
    @IBOutlet weak var tblSuggestedRidesHeight: NSLayoutConstraint!
    @IBOutlet weak var tblSuggestedRides: UITableView!
    @IBOutlet weak var mapVw: GMSMapView!
    
    //MARK: -View Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        
        setLocalization()
        setValue()
        taxiData.append(suggestRide(name: "Taxi/Cab", capacity: "4 Seats", price: "$25.50", Time: "1-4 min", img: UIImage(named: "ic_dummyTexi1")!))
        taxiData.append(suggestRide(name: "Basic", capacity: "4 Seats", price: "$35.00", Time: "1-5 min", img: UIImage(named: "ic_dummyTexi2")!))
        
        taxiData.append(suggestRide(name: "Basic", capacity: "4 Seats", price: "$35.00", Time: "1-5 min", img: UIImage(named: "ic_dummyTexi2")!))
        
        taxiData.append(suggestRide(name: "Basic", capacity: "4 Seats", price: "$35.00", Time: "1-5 min", img: UIImage(named: "ic_dummyTexi2")!))
        
        taxiData.append(suggestRide(name: "Basic", capacity: "4 Seats", price: "$35.00", Time: "1-5 min", img: UIImage(named: "ic_dummyTexi2")!))
        tblSuggestedRides.reloadData()
        DispatchQueue.main.async { [self] in
            if taxiData.count > 2 {
                tblSuggestedRidesHeight.constant = (tblSuggestedRides.contentSize.height / CGFloat(taxiData.count)) * 2
            } else {
                tblSuggestedRidesHeight.constant = tblSuggestedRides.contentSize.height
            }
        }
        setNavigationBarInViewController(controller: self, naviColor: colors.submitButtonColor.value, naviTitle: NavTitles.CommonView.value, leftImage: NavItemsLeft.back.value, rightImages: [NavItemsRight.none.value], isTranslucent: true, CommonViewTitles: ["Destination 1","Destination 2"])
       
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    override func viewDidDisappear(_ animated: Bool) {
        //self.navigationController?.navigationBar.isHidden = false
    }
    //MARK: -other methods
    func setLocalization() {
        lblSuggestedRide.text = "SuggestedTaxiVC_lblTitle".Localized()
        lblCardPayment.text = "SuggestedTaxiVC_lblCardPayment".Localized()
        
        btnBookNow.setTitle("SuggestedTaxiVC_btnBookNow".Localized(), for: .normal)
        btnOffer.setunderline(title: "SuggestedTaxiVC_lblOffer".Localized(), color: colors.loginPlaceHolderColor.value, font: CustomFont.regular.returnFont(15))
    }
    func setValue() {
       
    }
    
//    func getRouteSteps(from source: CLLocationCoordinate2D, to destination: CLLocationCoordinate2D) {
//
//        let session = URLSession.shared
//
//        let url = URL(string: "https://maps.googleapis.com/maps/api/directions/json?origin=\(source.latitude),\(source.longitude)&destination=\(destination.latitude),\(destination.longitude)&sensor=false&mode=driving&key=\(AppInfo.Google_API_Key)")!
//
//        let task = session.dataTask(with: url, completionHandler: {
//            (data, response, error) in
//
//            guard error == nil else {
//                print(error!.localizedDescription)
//                return
//            }
//
//            guard let jsonResult = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: Any] else {
//
//                print("error in JSONSerialization")
//                return
//
//            }
//
//
//
//            guard let routes = jsonResult["routes"] as? [Any] else {
//                return
//            }
//
//            guard let route = routes[0] as? [String: Any] else {
//                return
//            }
//
//            guard let legs = route["legs"] as? [Any] else {
//                return
//            }
//
//            guard let leg = legs[0] as? [String: Any] else {
//                return
//            }
//
//            guard let steps = leg["steps"] as? [Any] else {
//                return
//            }
//              for item in steps {
//
//                guard let step = item as? [String: Any] else {
//                    return
//                }
//
//                guard let polyline = step["polyline"] as? [String: Any] else {
//                    return
//                }
//
//                guard let polyLineString = polyline["points"] as? String else {
//                    return
//                }
//
//                //Call this method to draw path on map
//                DispatchQueue.main.async {
//                    self.drawPath(from: polyLineString)
//                }
//
//            }
//        })
//        task.resume()
//    }
//    func drawPath(from polyStr: String){
//        let path = GMSPath(fromEncodedPath: polyStr)
//        let polyline = GMSPolyline(path: path)
//        polyline.strokeWidth = 3.0
//        polyline.map = showRouteMapView // Google MapView
//
//
//        let cameraUpdate = GMSCameraUpdate.fit(GMSCoordinateBounds(coordinate: sourceLocationCordinates, coordinate: destinationLocationCordinates))
//        showRouteMapView.moveCamera(cameraUpdate)
//        let currentZoom = showRouteMapView.camera.zoom
//        showRouteMapView.animate(toZoom: currentZoom - 1.4)
//    }
    //MARK: -tblViewMethods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taxiData.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblSuggestedRides.dequeueReusableCell(withIdentifier: suggestedVisitCell.reuseIdentifier, for: indexPath) as! suggestedVisitCell
        if indexPath.row == selectedTaxi {
            cell.suggestTaxiBackgroundView.backgroundColor = colors.white.value
            cell.suggestTaxiBackgroundView.layer.borderWidth = 1
            cell.TaxiType.textColor = colors.submitButtonColor.value
            
            
        } else {
            cell.suggestTaxiBackgroundView.backgroundColor = UIColor(hexString: "#000000").withAlphaComponent(0.03)
            cell.suggestTaxiBackgroundView.layer.borderWidth = 0
            cell.TaxiType.textColor = colors.loginPlaceHolderColor.value
        }
       
        cell.TaxiType.text = taxiData[indexPath.row].taxiName
        cell.TotalSeat.text = taxiData[indexPath.row].taxiTotalCapacity
        cell.SuggestedMoney.text = taxiData[indexPath.row].taxiPrice
        cell.SuggestedTime.text = taxiData[indexPath.row].taxiComingTime
        cell.TaxiImage.image = taxiData[indexPath.row].taxiImage
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedTaxi = indexPath.row
        tblSuggestedRides.reloadData()
    }
    //MARK: -IBActions
    
   
    @IBAction func btnScheduleClick(_ sender: Any) {
        
        let controller = AppStoryboard.Main.instance.instantiateViewController(withIdentifier: ScheduleRideVC.storyboardID) as!
            ScheduleRideVC
        controller.setClosour = {
            let controller = AppStoryboard.Main.instance.instantiateViewController(withIdentifier: MyRidesVC.storyboardID)
            self.navigationController?.pushViewController(controller, animated: true)
            
        }
        controller.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        let navigationController = UINavigationController(rootViewController: controller)
        navigationController.modalPresentationStyle = .overCurrentContext
        navigationController.modalTransitionStyle = .crossDissolve
        navigationController.navigationBar.isHidden = true
        self.present(navigationController, animated: true, completion: nil)
        
//        let controller = AppStoryboard.Main.instance.instantiateViewController(withIdentifier: CurrentRideDetailsViewController.storyboardID)
//        self.navigationController?.pushViewController(controller, animated: true)
        
    }
    @IBAction func btnBookNowClick(_ sender: Any) {
        let controller = AppStoryboard.Main.instance.instantiateViewController(withIdentifier: addPaymentVC.storyboardID) as! addPaymentVC
        controller.isFromSideMenu = true
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
    @IBAction func btnOfferClick(_ sender: Any) {
        let controller = AppStoryboard.Main.instance.instantiateViewController(withIdentifier: MyOfferVC.storyboardID)
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
    @IBAction func btnCardPaymentClick(_ sender: Any) {
       
        
    }
    //MARK: -API Calls
    
    
    
    
}
class suggestedVisitCell : UITableViewCell {
    
    @IBOutlet weak var suggestTaxiBackgroundView: suggestedTaxiView!
    @IBOutlet weak var TaxiType: suggestedRidesLabel!
    @IBOutlet weak var TotalSeat: suggestedRidesLabel!
    @IBOutlet weak var SuggestedMoney: suggestedRidesLabel!
    @IBOutlet weak var SuggestedTime: suggestedRidesLabel!
    @IBOutlet weak var TaxiImage: UIImageView!
}
class suggestRide {
    var taxiName : String?
    var taxiTotalCapacity : String?
    var taxiPrice : String?
    var taxiComingTime : String?
    var taxiImage : UIImage?
    init(name:String,capacity:String,price:String,Time:String,img:UIImage) {
        self.taxiName = name
        self.taxiTotalCapacity = capacity
        self.taxiPrice = price
        self.taxiComingTime = Time
        self.taxiImage = img
    }
}
