//
//  CurrentRideDetail.swift
//  PickARide User
//
//  Created by Admin on 03/01/22.
//  Copyright © 2022 EWW071. All rights reserved.
//

import Foundation
import UIKit
import Cosmos

class CurrentRideDetail : UIView {
    
    @IBOutlet weak var imgDriver: UIImageView!
    @IBOutlet weak var lblDriverName: currentRideLabel!
    @IBOutlet weak var lblRidego: currentRideLabel!
    @IBOutlet weak var lblVehicalData: currentRideLabel!
    @IBOutlet weak var mainVW: UIView!
    @IBOutlet weak var mainVWBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var driverProfileOuterVW: UIView!
    @IBOutlet weak var rideDetailsStkVWTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var ratingsView: CosmosView!
    @IBOutlet weak var lblAvgRating: UILabel!
    @IBOutlet weak var btnGoToRatings: UIButton!
    
    
    var objCurrentBooking : CurrentBookingData!
    var objBookingInfo : BookingInfoData!
    var vehicalNumber = ""
    var heightGet : ((CGFloat , Bool)->())? = nil
    var heightOfView = CGFloat()
    var isExpandCategory:  Bool  = false {
        didSet {
            self.driverProfileOuterVW.isHidden = !isExpandCategory
            mainVWBottomConstraint.constant = isExpandCategory ? 0 : -50
            self.btnGoToRatings.isHidden = !isExpandCategory
            self.ratingsView.isHidden = !isExpandCategory
            self.lblAvgRating.isHidden = !isExpandCategory
            self.rideDetailsStkVWTopConstraint.constant = isExpandCategory ? 0 : 10
           // self.view.endEditing(true)
            DispatchQueue.main.async {
                self.heightOfView = self.isExpandCategory ? self.mainVW.frame.height + 40 : (self.mainVW.frame.height + self.mainVWBottomConstraint.constant)
                
                if let height = self.heightGet {
                    height(self.heightOfView, self.isExpandCategory)
                }
            }
            UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [.curveEaseInOut, .allowUserInteraction, .beginFromCurrentState], animations: {
                //self.view.layoutIfNeeded()
            }) { (success) in
                
            }
        }
    }
    
    var closeBtnClosure : (()->())?
    
    override func draw(_ rect: CGRect) {
        self.setupViewCategory()
       // self.setNavigationBarInViewController(controller: self, naviColor: colors.submitButtonColor.value, naviTitle: NavTitles.CommonView.value, leftImage: NavItemsLeft.none.value, rightImages: [NavItemsRight.none.value], isTranslucent: true, CommonViewTitles: ["J'Adore Interiors","280 Hemlock Ln"], isTwoLabels: false, isDisableBack: true)
    }
    

    
    @IBAction func btnCancel(_ sender: Any) {
        appDel.navigateToMain()
    }
    
    @IBAction func btnActionCurrentLocation(_ sender: UIButton) {
        guard let NavVc = appDel.window?.rootViewController as? UINavigationController else {return}
        print(NavVc.children[0].children)
        if let objhomeVC = NavVc.children[0].children[0] as? UINavigationController  {
            if let homeVC = objhomeVC.children[0] as? HomeVC {
                homeVC.setCurrentLocationClicked()
            }
        }
    }
    
    @IBAction func btnProfileClicked(_ sender: Any) {
        //        let controller = RatingYourTripVC.instantiate(fromAppStoryboard: .Main)
        //        self.navigationController?.pushViewController(controller, animated: true)
    }
    func setUpUI(isFromApi : Bool){
        
        if isFromApi == true {
            lblDriverName.text = (objCurrentBooking.driverInfo?.firstName ?? "") + " " + (objCurrentBooking.driverInfo?.lastName ?? "")
            lblRidego.text = objCurrentBooking.driverVehicleInfo?.vehicleType ?? ""
            self.imgDriver.loadSDImage(imgUrl: objCurrentBooking.driverInfo?.profileImage ?? "")
            self.vehicalNumber = objCurrentBooking.driverVehicleInfo?.vehicleTypeManufacturerName ?? ""
            self.lblVehicalData.text = (objCurrentBooking.driverVehicleInfo?.vehicleTypeManufacturerName ?? "" ) + " - " + (objCurrentBooking.driverVehicleInfo?.vehicleTypeModelName  ?? "")
            self.lblAvgRating.text = "(\(objCurrentBooking.driverInfo?.rating ?? "0"))"
            self.ratingsView.rating = objCurrentBooking.driverInfo?.rating?.toDouble() ?? 0.0
            lblRidego.text = objCurrentBooking.driverVehicleInfo?.plateNumber
            self.setLabel()
        }
        else {
            lblDriverName.text = objBookingInfo.driverInfo.firstName + " " + objBookingInfo.driverInfo.lastName
            lblRidego.text = objBookingInfo.driverVehicleInfo.vehicleType
            self.imgDriver.loadSDImage(imgUrl: objBookingInfo.driverInfo.profileImage ?? "")
            self.vehicalNumber = objBookingInfo.driverVehicleInfo.vehicleTypeManufacturerName
            self.lblVehicalData.text = objBookingInfo.driverVehicleInfo.vehicleTypeManufacturerName + " - " + objBookingInfo.driverVehicleInfo.vehicleTypeModelName
            self.lblAvgRating.text = "(\(objBookingInfo.driverInfo.rating ?? "0"))"
            self.ratingsView.rating = objBookingInfo.driverInfo.rating.toDouble()
            lblRidego.text = objBookingInfo.driverVehicleInfo.plateNumber
            self.setLabel()
        }
    }
    
    func setLabel() {
        let attributedString = NSMutableAttributedString(string: lblVehicalData.text!)
        let strNumber : NSString = lblVehicalData.text as NSString? ?? NSString()
        let range = (strNumber).range(of: vehicalNumber)
        print(range.location)
        attributedString.addAttribute(NSAttributedString.Key.font, value: CustomFont.medium.returnFont(15), range: NSMakeRange(0, attributedString.length))
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: colors.loginPlaceHolderColor.value, range: NSMakeRange(0, attributedString.length))
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: colors.phoneNumberColor.value , range: range)
        lblVehicalData.attributedText = attributedString
    }
    
    func setupViewCategory() {
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture(gesture:)))
        swipeUp.direction = UISwipeGestureRecognizer.Direction.up
       // self.topVW.addGestureRecognizer(swipeUp)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture(gesture:)))
        swipeDown.direction = UISwipeGestureRecognizer.Direction.down
       // self.topVW.addGestureRecognizer(swipeDown)
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
