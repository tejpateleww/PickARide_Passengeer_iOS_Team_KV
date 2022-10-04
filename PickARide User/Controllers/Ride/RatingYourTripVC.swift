//
//  RatingYourTripVC.swift
//  PickARide User
//
//  Created by baps on 30/12/20.
//  Copyright © 2020 EWW071. All rights reserved.
//

import UIKit
import Cosmos

class RatingYourTripVC: BaseViewController {

    //MARK:- ===== Outlets =======
    @IBOutlet weak var DotedLine: UIView!
    @IBOutlet weak var btnSkip: loginScreenButton!
    @IBOutlet weak var lblDriverName: RatingYourTripLabel!
    @IBOutlet weak var viewRating: CosmosView!
    @IBOutlet weak var lblVehicleData: RatingYourTripLabel!
    @IBOutlet weak var lblRating: RatingYourTripLabel!
    @IBOutlet weak var viewGivenRating: CosmosView!
    @IBOutlet weak var txtReview: ratingTextview!
    @IBOutlet weak var lblRideGo: RatingYourTripLabel!
    @IBOutlet weak var imgProfile: UIImageView!
    
    @IBOutlet weak var lblVechicleName: RatingYourTripLabel!
    @IBOutlet weak var lblModelNo: RatingYourTripLabel!
    
    
    //MARK:- ====== Variables =======
    var objBookingInfo : BookingInfoData!
    var vehicalNumber = ""
    var skipBtnClicked : (()->())?
    var RatingReviewClicked : (()->())?

    
    //MARK:- ==== View Controller Life Cycle =====
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        viewRating.rating = 0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarInViewController(controller: self, naviColor: colors.submitButtonColor.value, naviTitle: NavTitles.rating.value, leftImage: NavItemsLeft.cancelWhite.value, rightImages: [NavItemsRight.none.value], isTranslucent: true, CommonViewTitles: [], isTwoLabels: false)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.DotedLine.createDottedLine(width: 1.0, color: UIColor.cyan.cgColor)
    }
    
    @IBAction func btnSubmitReviewClicked(_ sender: Any) {
        webServiceCallAddRating()
    }
    
    @IBAction func btnSkip(_ sender: Any) {
        skipBtnClicked?()
        self.dismiss(animated: true)
    }
    
    
    
    
    func setUpUI(){
        self.lblDriverName.text = objBookingInfo.driverInfo.firstName + " " + objBookingInfo.driverInfo.lastName
        self.lblRideGo.text = objBookingInfo.driverVehicleInfo.vehicleType
        self.imgProfile.loadSDImage(imgUrl: objBookingInfo.driverInfo.profileImage ?? "")
        self.vehicalNumber = objBookingInfo.driverVehicleInfo.vehicleTypeManufacturerName
        self.lblVechicleName.text = objBookingInfo.driverVehicleInfo.vehicleTypeModelName
        self.lblModelNo.text = vehicalNumber
        //self.lblVehicleData.text = objBookingInfo.driverVehicleInfo.vehicleTypeManufacturerName + " - " + objBookingInfo.driverVehicleInfo.vehicleTypeModelName
        self.lblRating.text = "(\(objBookingInfo.driverInfo.rating ?? "0"))"
        self.viewRating.rating = objBookingInfo.driverInfo.rating.toDouble()
        self.lblRideGo.text = objBookingInfo.driverVehicleInfo.plateNumber
       // self.setLabel()
    }
    
    func setLabel() {
        let attributedString = NSMutableAttributedString(string: lblVehicleData.text ?? "")
        let strNumber : NSString = lblVehicleData.text as NSString? ?? NSString()
        let range = (strNumber).range(of: vehicalNumber)
        print(range.location)
        attributedString.addAttribute(NSAttributedString.Key.font, value: CustomFont.medium.returnFont(15), range: NSMakeRange(0, attributedString.length))
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: colors.phoneNumberColor.value, range: NSMakeRange(0, attributedString.length))
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: colors.loginPlaceHolderColor.value , range: range)
        lblVehicleData.attributedText = attributedString
    }
    
}

//MARK:- Set Up UI
extension RatingYourTripVC{
    
    func webServiceCallAddRating(){
        let reqmodel = ReviewRatingModel()
        reqmodel.booking_id = objBookingInfo.id ?? ""
        reqmodel.rating = "\(viewGivenRating.rating)"
        reqmodel.comment = txtReview.text ?? ""
        
        WebServiceSubClass.AddReviewRating(reqModel: reqmodel) { Status, msg, response, error in
            print(response)
            Toast.show(message: msg, state: .success)
            self.skipBtnClicked?()
            self.dismiss(animated: true)
        }
       
    }
    
}
