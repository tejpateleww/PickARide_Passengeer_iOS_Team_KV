//
//  CurrentRideDriverInformationVC.swift
//  PickARide User
//
//  Created by Apple on 18/01/21.
//  Copyright © 2021 EWW071. All rights reserved.
//

import UIKit
import Cosmos

class CurrentRideDriverInformationVC: BaseViewController {
    
    @IBOutlet weak var lblDriverName: currentRideLabel!
    @IBOutlet weak var lblRidego: currentRideLabel!
    @IBOutlet weak var lblVehicalData: currentRideLabel!
    @IBOutlet weak var vwMain: suggestedTaxiView!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var mainVW: suggestedTaxiView!
    @IBOutlet weak var topVW: UIView!
    @IBOutlet weak var mainVWBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var lblDriverPickUpMsg: currentRideLabel!
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var viewRating: CosmosView!
    @IBOutlet weak var imgDriver: UIImageView!
    @IBOutlet weak var lblTime: currentRideLabel!
    
    
    var timer : Timer?
    var isFromCheckOrder = false
    var toatalRemainingSeconds = Int()
    var objBookingInfo : BookingInfoData!
    var objCurrentBooking : CurrentBookingData!
    var vehicalNumber = ""
    var totalHour = Int()
    var totalMinut = Int()
    var totalSecond = Int()
    var closeBtnClosure : (()->())?
    var isFromApi = false
    var heightOfView = CGFloat()
    var heightGet : ((CGFloat , Bool)->())? = nil

    
    var isExpandCategory:  Bool  = false {
        didSet {
            mainVWBottomConstraint.constant = isExpandCategory ? 0 : (-mainVW.frame.height + topVW.frame.height + 60)
            self.lblDriverPickUpMsg.superview?.isHidden = !isExpandCategory
            
            DispatchQueue.main.async {
                self.heightOfView = self.isExpandCategory ? self.vwMain.frame.height + 40 : (self.vwMain.frame.height + self.mainVWBottomConstraint.constant)
 
                if let height = self.heightGet {
                    height(self.heightOfView, self.isExpandCategory)
                }
            }
            
            self.view.endEditing(true)
            UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [.curveEaseInOut, .allowUserInteraction, .beginFromCurrentState], animations: {
                self.view.layoutIfNeeded()
            }) { (success) in
                
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViewCategory()
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        vwMain.addGestureRecognizer(tap)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarInViewController(controller: self, naviColor: colors.submitButtonColor.value, naviTitle: NavTitles.CommonView.value, leftImage: NavItemsLeft.none.value, rightImages: [NavItemsRight.none.value], isTranslucent: true, CommonViewTitles: ["J'Adore Interiors","280 Hemlock Ln"], isTwoLabels: false, isDisableBack: true)
    }
    
    @IBAction func btnCancel(_ sender: Any) {
        appDel.navigateToMain()
    }
    
    @IBAction func btnProfileClicked(_ sender: Any) {
       // NotificationCenter.default.post(name: .OpenCurrentRideDetailsVC, object: nil)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        
    }
    
    @IBAction func btnCallClick(_ sender: Any) {
        self.view.endEditing(true)
        Utilities.makePhoneCall(phone: "9876543210")
    }
    
    @IBAction func btnMessageClick(_ sender: Any) {
        let controller : ChatVC = ChatVC.instantiate(fromAppStoryboard: .Main)
        controller.currentBookingModel = objBookingInfo
        controller.isFromApi = isFromApi
        controller.objCurrentBooking = objCurrentBooking
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func btnprofileClicked(_ sender: Any) {
//        let controller = CurrentRideDetailsVC.instantiate(fromAppStoryboard: .Main)
//        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func btnCancelClick(_ sender: Any) {
        let controller = CancelTripVC.instantiate(fromAppStoryboard: .Main)
        controller.objBookingInfo = objBookingInfo
        controller.objCurrentBooking = objCurrentBooking
        controller.isFromApi = isFromApi
        controller.mainVCTogo = {
            self.dismiss(animated: true, completion: nil)
             NotificationCenter.default.post(name: .CancelCompleteTRip, object: nil, userInfo: nil)

        }
        let navigationController = UINavigationController(rootViewController: controller)
        navigationController.modalPresentationStyle = .overCurrentContext
        navigationController.modalTransitionStyle = .crossDissolve
        self.present(navigationController, animated: true, completion: nil)
    }
    
    func UpdatestartTimer(){
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateProdTimer), userInfo: nil, repeats: true)
    }
    
  func startTimer(){
      timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countdown), userInfo: nil, repeats: true)
    }

    @objc func countdown() {
       
        var hours: Int
        var minutes : Int
        var seconds : Int

        if totalSecond == 0 {
            lblTime.text = ""
            lblDriverPickUpMsg.text = "Your driver is on the way"
            timer?.invalidate()
            return
        }
        totalSecond = totalSecond - 1
        hours = totalSecond / 3600
        minutes = (totalSecond % 3600) / 60
        seconds = (totalSecond % 3600) % 60
        lblTime.text = String(format: " %02d:%02d:%02d", hours, minutes, seconds)
    }
    
    
    //MARK : -= ====== Start timer For Static Value ======
    @objc func updateProdTimer() {
        
        if toatalRemainingSeconds < 1  {
                    timer?.invalidate()
            lblTime.text = " \(toatalRemainingSeconds)"
           }
                else {
                   
                toatalRemainingSeconds -= 1
                    
                    lblTime.text = prodTimeString(time: TimeInterval(toatalRemainingSeconds))
            }
        

    }
    
    func prodTimeString(time: TimeInterval) -> String {
        let prodMinutes = Int(time) / 60 % 60
        let prodSeconds = Int(time) % 60

        return String(format: "%02d:%02d", prodMinutes, prodSeconds)
 }
    
}

//MARK:- Methods
extension CurrentRideDriverInformationVC{
    func setUpUI(isFromArrived : Bool , isFromApi : Bool){
        self.isFromApi = isFromApi
        if isFromApi == true {
            
            lblTime.text = ""
            lblDriverName.text = (objCurrentBooking.driverInfo?.firstName ?? "") + " " + (objCurrentBooking.driverInfo?.lastName  ?? "")
            lblRidego.text = objCurrentBooking.driverVehicleInfo?.vehicleType
            self.imgDriver.loadSDImage(imgUrl: objCurrentBooking.driverInfo?.profileImage ?? "")
            self.vehicalNumber = objCurrentBooking.driverVehicleInfo?.vehicleTypeManufacturerName ?? ""
            self.lblVehicalData.text = (objCurrentBooking.driverVehicleInfo?.vehicleTypeManufacturerName ?? "") + " - " + (objCurrentBooking.driverVehicleInfo?.vehicleTypeModelName ?? "")
            self.lblRating.text = "(\(objCurrentBooking.driverInfo?.rating ?? "0"))"
            self.viewRating.rating = objCurrentBooking.driverInfo?.rating?.toDouble() ?? 0.0
            lblRidego.text = objCurrentBooking.driverVehicleInfo?.plateNumber
            
            if isFromArrived == true {
                lblTime.text = ""
                lblDriverPickUpMsg.text = "Your driver is on the way"
                timer?.invalidate()
            }
            else {
                if objCurrentBooking.tripDuration != "" , objCurrentBooking.tripDuration != nil{
//                    if objCurrentBooking.tripDuration?.contains(":") == true{
//                        let splitStrDuration = objCurrentBooking.tripDuration?.split(separator: ":")
//                        totalMinut = Int(splitStrDuration?[0] ?? "") ?? 0
//                        totalSecond = Int(splitStrDuration?[1] ?? "") ?? 0
//
//                    }
//                 else {
                    //totalMinut = Int(objCurrentBooking.tripDuration ?? "") ?? 0
                    totalSecond = 30
                   // }
                    startTimer()
                    
                }
            }
            self.setLabel()
        }
        else {
            lblTime.text = ""
            lblDriverName.text = objBookingInfo.driverInfo.firstName + " " + objBookingInfo.driverInfo.lastName
            lblRidego.text = objBookingInfo.driverVehicleInfo.vehicleType
            self.imgDriver.loadSDImage(imgUrl: objBookingInfo.driverInfo.profileImage ?? "")
            self.vehicalNumber = objBookingInfo.driverVehicleInfo.vehicleTypeManufacturerName
            self.lblVehicalData.text = objBookingInfo.driverVehicleInfo.vehicleTypeManufacturerName + " - " + objBookingInfo.driverVehicleInfo.vehicleTypeModelName
            self.lblRating.text = "(\(objBookingInfo.driverInfo.rating ?? "0"))"
            self.viewRating.rating = objBookingInfo.driverInfo.rating.toDouble()
            lblRidego.text = objBookingInfo.driverVehicleInfo.plateNumber
            
            if isFromArrived == true {
                lblTime.text = ""
                lblDriverPickUpMsg.text = "Your driver is on the way"
                timer?.invalidate()
            }
            else {
            if objBookingInfo.tripDuration != "" , objBookingInfo.tripDuration != nil{
//                if objBookingInfo.tripDuration?.contains(":") == true{
//                    let splitStrDuration = objBookingInfo.tripDuration?.split(separator: ":")
//                    totalMinut = Int(splitStrDuration?[0] ?? "") ?? 0
//                    totalSecond = Int(splitStrDuration?[1] ?? "") ?? 0
//
//                }
//             else {
               // totalMinut = Int(objBookingInfo.tripDuration ?? "") ?? 0
                totalSecond = 30
                //}
                startTimer()
                
              }
            }
            self.setLabel()
        }
      
    }
    
    func setLabel() {
        let attributedString = NSMutableAttributedString(string: lblVehicalData.text ?? "")
        let strNumber : NSString = lblVehicalData.text as NSString? ?? NSString()
        let range = (strNumber).range(of: vehicalNumber)
        print(range.location)
        attributedString.addAttribute(NSAttributedString.Key.font, value: CustomFont.medium.returnFont(15), range: NSMakeRange(0, attributedString.length))
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: colors.phoneNumberColor.value, range: NSMakeRange(0, attributedString.length))
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: colors.loginPlaceHolderColor.value , range: range)
        lblVehicalData.attributedText = attributedString
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
    
    @objc func setBottomViewOnclickofViewTop(){
        self.isExpandCategory = !self.isExpandCategory
    }
}
