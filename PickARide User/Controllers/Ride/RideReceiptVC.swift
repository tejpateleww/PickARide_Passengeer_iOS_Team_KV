//
//  RideReceiptVC.swift
//  PickARide User
//
//  Created by apple on 7/12/21.
//  Copyright © 2021 EWW071. All rights reserved.
//


import UIKit
import Cosmos
class RideReceiptDetailsVC: BaseViewController {

    //MARK:- ====== Outlets =======
    @IBOutlet weak var stackViewRating: UIView!
    @IBOutlet weak var vwRatingTop: NSLayoutConstraint!
    @IBOutlet weak var vwRatingBottom: NSLayoutConstraint!
    @IBOutlet weak var lblDiscription: themeLabel!
    @IBOutlet weak var lblPrice: themeLabel!
    @IBOutlet weak var lblTime: themeLabel!
    @IBOutlet weak var lblDistance: themeLabel!
    @IBOutlet weak var lblDateTime: themeLabel!
    @IBOutlet weak var lblServiceType: themeLabel!
    @IBOutlet weak var lblRideType: themeLabel!
    @IBOutlet weak var lblRatedName: themeLabel!
    @IBOutlet weak var imgRatedProfile: ProfileView!
    @IBOutlet weak var vwCosmos: CosmosView!
    @IBOutlet weak var lblYourRated: themeLabel!
    @IBOutlet weak var imgYourRatedProfile: ProfileView!
    @IBOutlet weak var vwCosmosRated: CosmosView!
    @IBOutlet weak var lblRideFares: themeLabel!
    @IBOutlet weak var lblTaxiFee: themeLabel!
    @IBOutlet weak var lblTax: themeLabel!
    @IBOutlet weak var lblDistanceFare: themeLabel!
    @IBOutlet weak var lblDiscount: themeLabel!
    @IBOutlet weak var lblDurationFare: themeLabel!
    @IBOutlet weak var lblYourPayment: themeLabel!
    @IBOutlet weak var lblDestination: themeLabel!
    @IBOutlet weak var lblPickUp: themeLabel!
    @IBOutlet weak var lblName: themeLabel!
    
    
    //MARK:- ===== Variables =====
    var isFromPastRide = Bool()
    var objDetail : PastBookingResDatum?
    
    
    
    //MARK:- ===== ViewController Life cycle =====
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
        self.DataSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.setNavigationBarInViewController(controller: self, naviColor: colors.appColor.value, naviTitle: NavTitles.rideDetails.value, leftImage: NavItemsLeft.back.value, rightImages: [NavItemsRight.help.value], isTranslucent: true, CommonViewTitles: [], isTwoLabels: false)
        self.navBtnDone.addTarget(self, action: #selector(goToHelpScreen), for: .touchUpInside)
    }
    

    //MARK:- ===== Data Setup ====
    func DataSetup(){
        guard let object = objDetail, let bookingInfo = object.bookingInfo else {
            return
        }
        lblRideFares.text = bookingInfo.baseFare?.toCurrencyString()
        lblPickUp.text = bookingInfo.pickupLocation
        lblDestination.text = bookingInfo.dropoffLocation
        lblTax.text = bookingInfo.tax?.toCurrencyString()
        lblTaxiFee.text = bookingInfo.bookingFee?.toCurrencyString()
        lblTime.text = bookingInfo.tripDuration?.secondsToTimeFormate()
        let timestamp: TimeInterval =  Double(bookingInfo.arrivedTime ?? "") ?? 0.0
        let date = Date(timeIntervalSince1970: timestamp)
        let formatedDate = date.timeAgoSinceDate(isForNotification: false)
        self.lblDateTime.text = formatedDate
        lblRideType.text = object.vehicleType?.name
        lblPrice.text = bookingInfo.grandTotal?.toCurrencyString()
        lblYourPayment.text = bookingInfo.grandTotal?.toCurrencyString()
        lblDistanceFare.text = bookingInfo.distanceFare?.toCurrencyString()
        lblDurationFare.text = bookingInfo.durationFare?.toCurrencyString()
        lblDiscount.text = bookingInfo.discount?.toCurrencyString()
        lblDistance.text = bookingInfo.distance?.toDistanceString()
        lblServiceType.text = object.driverVehicleInfo?.vehicleTypeManufacturerName
//        self.lblCarName.text = " - \(self.PastBookingData?.driverVehicleInfo?.vehicleTypeManufacturerName ?? "") \(self.PastBookingData?.driverVehicleInfo?.vehicleTypeModelName ?? ""))"
    }
}

//MARK:- Methods
extension RideReceiptDetailsVC{
    func setUpUI(){
        stackViewRating.isHidden = true
        vwRatingBottom.constant = 0
        vwRatingTop.constant = 0

        let attributedString = NSMutableAttributedString(string: lblDiscription.text ?? "")
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        lblDiscription.attributedText = attributedString
    }
    
    //MARK:- ===== Go To Help Screen =====
    @objc func goToHelpScreen(){
        let controller = CommonWebViewVC.instantiate(fromAppStoryboard: .Main)
        controller.strNavTitle = UrlConstant.Help
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
