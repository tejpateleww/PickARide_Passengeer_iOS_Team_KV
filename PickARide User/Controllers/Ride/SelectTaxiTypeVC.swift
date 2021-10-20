//
//  SelectTaxiTypeViewController.swift
//  PickARide User
//
//  Created by Apple on 21/12/20.
//  Copyright © 2020 EWW071. All rights reserved.
//

import UIKit
import GoogleMaps

class SelectTaxiTypeVC: BaseViewController{
   
    @IBOutlet weak var lblCardPayment: suggestedRidesLabel!
    @IBOutlet weak var lblSuggestedRide: suggestedRidesLabel!
    @IBOutlet weak var btnCardPayment: UIButton!
    @IBOutlet weak var btnOffer: UIButton!
    @IBOutlet weak var btnBookNow: submitButton!
    @IBOutlet weak var tblSuggestedRidesHeight: NSLayoutConstraint!
    @IBOutlet weak var tblSuggestedRides: UITableView!
    @IBOutlet weak var btnPromo: UIButton!
    @IBOutlet weak var btnCancelPromo: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    
    //Gesture
    @IBOutlet weak var topVW: UIView!
    @IBOutlet weak var suggestedTexiView: suggestedTaxiView!
    @IBOutlet weak var suggestedVWBottomConstraint: NSLayoutConstraint!
    
    var taxiData = [EstimateFare]()
    var selectedTaxi = NSNotFound
    var bookingReqModel = BookingReqModel()
    var navigateToCurrentLocation : (()->())?
    var heightOfView = CGFloat()
    var heightGet : ((CGFloat , Bool)->())? = nil
    
    var isExpandCategory:  Bool  = false {
        didSet {
            suggestedVWBottomConstraint.constant = isExpandCategory ? 0 : (-suggestedTexiView.frame.height + topVW.frame.height + 60)
            self.tblSuggestedRides.isHidden = !isExpandCategory
            self.view.endEditing(true)
            DispatchQueue.main.async {
                self.heightOfView = self.isExpandCategory ? self.suggestedTexiView.frame.height + 40 : (self.suggestedTexiView.frame.height + self.suggestedVWBottomConstraint.constant)
 
                if let height = self.heightGet {
                    height(self.heightOfView, self.isExpandCategory)
                }
            }
            UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [.curveEaseInOut, .allowUserInteraction, .beginFromCurrentState], animations: {
                self.view.layoutIfNeeded()
            }) { (success) in
                
            }
        }
    }
    
    var closeBtnClosure : (()->())?
    var bookingSucess : (()->())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        registerNIB()
        //tblSuggestedRides.register(UINib(nibName: "NoDataViewCell", bundle: nil), forCellReuseIdentifier: "NoDataViewCell")
        
        self.setLocalization()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.setNavigationBarInViewController(controller: self, naviColor: colors.submitButtonColor.value, naviTitle: NavTitles.CommonView.value, leftImage: NavItemsLeft.none.value, rightImages: [NavItemsRight.none.value], isTranslucent: true, CommonViewTitles: ["Pick Up","Destination"], isTwoLabels: false)
    }
    
    
    func registerNIB(){
        tblSuggestedRides.register(UINib(nibName:NoDataTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: NoDataTableViewCell.reuseIdentifier)
    }
    
    @IBAction func btnCancel(_ sender: Any) {
        
        if let clicked = closeBtnClosure {
            clicked()
        }
        
    }

    @IBAction func btnPromo(_ sender: Any) {
    }
   
    @IBAction func btnScheduleClick(_ sender: Any) {
        
//        if selectedTaxi == NSNotFound {
//            Toast.show(title: UrlConstant.Required, message: "Please select taxi type", state: .failure)
//
//        }
//        else {
            let controller : ScheduleRideVC = ScheduleRideVC.instantiate(fromAppStoryboard: .Main)
            controller.selectedTaxi = selectedTaxi
            controller.setClosour = { (strDateTime , TaxiSelected) in
                self.bookingReqModel.bookingType = BookingType.BookLater.rawValue
                self.bookingReqModel.pickupDateTime = strDateTime
                self.selectedTaxi = TaxiSelected
                if self.selectedTaxi == NSNotFound {
                    Toast.show(message: "Please select taxi type", state: .failure)
                }
                else {
                    let vc : AddPaymentVC = AddPaymentVC.instantiate(fromAppStoryboard: .Main)
                    vc.selectedTaxiType = self.taxiData[self.selectedTaxi]
                    vc.isFromSchedulled = true
                    vc.bookingReqModel = self.bookingReqModel
                    self.navigationController?.pushViewController(vc, animated: true)

                }
                
            }
            controller.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
            let navigationController = UINavigationController(rootViewController: controller)
            navigationController.modalPresentationStyle = .overCurrentContext
            navigationController.modalTransitionStyle = .crossDissolve
            navigationController.navigationBar.isHidden = true
            self.present(navigationController, animated: true, completion: nil)
        //}
    }
    
    @IBAction func btnBookNowClick(_ sender: Any) {
        
        if selectedTaxi == NSNotFound {
            Toast.show(title: UrlConstant.Required, message: "Please select taxi type", state: .failure)

        }
        else {
            let controller :AddPaymentVC  = AddPaymentVC.instantiate(fromAppStoryboard: .Main)
            controller.bookingAdded = {
                if let bookingAdd = self.bookingSucess {
                    bookingAdd()
                }
            }
            bookingReqModel.bookingType = BookingType.BookNow.rawValue
            controller.bookingReqModel = bookingReqModel
            controller.isFromSideMenu = false
            controller.selectedTaxiType = self.taxiData[self.selectedTaxi]
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    @IBAction func btnOfferClick(_ sender: Any) {
        let controller = MyOfferVC.instantiate(fromAppStoryboard: .Main)
        controller.PromoCodeValid = { (objPromo) in
            self.bookingReqModel.promoCode = objPromo.promocode
            self.btnPromo.isHidden = false
            self.btnPromo.setTitle(objPromo.promocode, for: .normal)
            
        }
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func btnCardPaymentClick(_ sender: Any) {
        
    }
    
    //MARK:- ==== Btn Action Current location ==
    @IBAction func btnActionCurrentLocation(_ sender: UIButton) {
        
        if let getcurrentlocation = navigateToCurrentLocation {
            getcurrentlocation()
        }
    }
    
    
}

//MARK:- Methods
extension SelectTaxiTypeVC{
    func setUPUI(isExpand : Bool){
        
       
        tblSuggestedRides.rowHeight = UITableView.automaticDimension
        tblSuggestedRides.estimatedRowHeight = 200
        
//        taxiData.append(suggestRide(name: "TAXI/CAB", capacity: "4 Seats", price: "$25.50", Time: "1-4 min", img: UIImage(named: "ic_dummyTexi1")!))
//        taxiData.append(suggestRide(name: "Basic", capacity: "4 Seats", price: "$35.00", Time: "1-5 min", img: UIImage(named: "ic_dummyTexi2")!))
//
//        taxiData.append(suggestRide(name: "Basic", capacity: "4 Seats", price: "$35.00", Time: "1-5 min", img: UIImage(named: "ic_dummyTexi2")!))
//
//        taxiData.append(suggestRide(name: "Basic", capacity: "4 Seats", price: "$35.00", Time: "1-5 min", img: UIImage(named: "ic_dummyTexi2")!))
//
//        taxiData.append(suggestRide(name: "Basic", capacity: "4 Seats", price: "$35.00", Time: "1-5 min", img: UIImage(named: "ic_dummyTexi2")!))
        tblSuggestedRides.reloadData()
        tblSuggestedRides.layoutIfNeeded()
        DispatchQueue.main.async { [self] in
            if taxiData.count > 2 {
                tblSuggestedRidesHeight.constant = (tblSuggestedRides.contentSize.height / CGFloat(taxiData.count)) * 2
            } else {
                tblSuggestedRidesHeight.constant = tblSuggestedRides.contentSize.height
            }
        }
        isExpandCategory =  isExpand
        self.setupViewCategory()
    }
    
    func setLocalization() {
        lblSuggestedRide.text = "SuggestedTaxiVC_lblTitle".Localized()
        lblCardPayment.text = "SuggestedTaxiVC_lblCardPayment".Localized()
        
        btnBookNow.setTitle("SuggestedTaxiVC_btnBookNow".Localized(), for: .normal)
        btnOffer.setunderline(title: "SuggestedTaxiVC_lblOffer".Localized(), color: colors.loginPlaceHolderColor.value, font: CustomFont.regular.returnFont(15))
        btnPromo.setTitle("SuggestedTaxiVC_btnPromo".Localized(), for: .normal)
    }
    
    func setupViewCategory() {
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture(gesture:)))
        swipeUp.direction = UISwipeGestureRecognizer.Direction.up
        self.topVW.addGestureRecognizer(swipeUp)

        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture(gesture:)))
        swipeDown.direction = UISwipeGestureRecognizer.Direction.down
        self.topVW.addGestureRecognizer(swipeDown)
    }
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizer.Direction.down:
                print("Swiped down")
                self.isExpandCategory = false
                
            case UISwipeGestureRecognizer.Direction.up:
                print("Swiped up")
                self.isExpandCategory = true
                
            default:
                break
            }
        }
    }
    
//    @objc func setBottomViewOnclickofViewTop(){
//        self.isExpandCategory = !self.isExpandCategory
//    }
}

//MARK:- TableView Delegate
extension SelectTaxiTypeVC: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taxiData.count != 0 ? taxiData.count : 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
     if taxiData.count != 0 {
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
       
        cell.TaxiType.text = taxiData[indexPath.row].vehicleTypeName.uppercased()
        cell.TotalSeat.text = taxiData[indexPath.row].capacity + "seats"
        let strEstimateFare = twoDecimals(number:taxiData[indexPath.row].estimateTripFare ?? 0)
            //"\(taxiData[indexPath.row].estimateTripFare ?? 0)"
        
        cell.SuggestedMoney.text = "$ \(strEstimateFare)"
        cell.SuggestedTime.text = "1-\(taxiData[indexPath.row].driverReachInMinute ?? 0) min"
        cell.TaxiImage.loadSDImage(imgUrl: taxiData[indexPath.row].image)

        return cell
       }
        
     else{
         let NoDatacell = self.tblSuggestedRides.dequeueReusableCell(withIdentifier: "NoDataTableViewCell", for: indexPath) as! NoDataTableViewCell
         return NoDatacell
     }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if taxiData.count != 0 {
            selectedTaxi = indexPath.row
            tblSuggestedRides.reloadData()
        }
    }
    
    
    func twoDecimals(number: Float) -> String{
        return String(format: "%.2f", number)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return taxiData.count != 0 ? 100 : tblSuggestedRides.frame.height
    }
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
