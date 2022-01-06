//
//  RideDetailsVC.swift
//  PickaRideDriver
//
//  Created by Admin on 10/05/21.
//

import UIKit
import SDWebImage
import Cosmos

protocol AcceptBookingReqDelgate {
    func onAcceptBookingReq()
}

class RideDetailsVC: BaseViewController {

    //MARK: ===== Outlets =========
    @IBOutlet weak var stackviewRecieptBottom: NSLayoutConstraint!
    @IBOutlet weak var stackviewRecieptTop: NSLayoutConstraint!
    @IBOutlet weak var stackviewRecieptHeight: NSLayoutConstraint!
    @IBOutlet weak var vwMap: UIView!
    @IBOutlet weak var lblTime: RideDetailLabel!
    @IBOutlet weak var imgMapView: UIImageView!
    @IBOutlet weak var MyOfferView: UIView!
    @IBOutlet weak var lblRidigo: RideDetailLabel!
    @IBOutlet weak var lblCarName: RideDetailLabel!
    @IBOutlet weak var lblAddress: RideDetailLabel!
    @IBOutlet weak var lblPrice: RideDetailLabel!
    @IBOutlet weak var lblPickupLocation: RideDetailLabel!
    @IBOutlet weak var lblDestLocation: RideDetailLabel!
    @IBOutlet weak var imgProfilw: ProfileView!
    @IBOutlet weak var lblRideCustomerName: RideDetailLabel!
    @IBOutlet weak var btnRepeateRide: UIButton!
    @IBOutlet weak var btnReceipt: RidesDetailsButton!
    @IBOutlet weak var ratingVw: CosmosView!
    @IBOutlet weak var btnAccept: themeButton!
    @IBOutlet weak var btnReject: CancelButton!
    @IBOutlet weak var imgStatus: UIImageView!
    @IBOutlet weak var viewProfile: UIView!
    
    
    
    //MARK: - Variables
    var isFromUpcomming : Bool = false
    var isFromPast : Bool = false
    var isFromInprogress : Bool = false
    var PastBookingData : PastBookingResDatum?
    var rideDeatilViewModel = RideDeatilViewModel()
    var delegate : AcceptBookingReqDelgate?

    
    //MARK: - Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareView()
        self.setupData()
    }

    //MARK: - Custom methods
    func prepareView(){
        self.btnAccept.isHidden = true
        self.btnReject.isHidden = true
        self.btnRepeateRide.isHidden = true
        self.setNavigationBarInViewController(controller: self, naviColor: colors.submitButtonColor.value, naviTitle: NavTitles.rideDetails.value, leftImage: NavItemsLeft.back.value, rightImages: [NavItemsRight.none.value], isTranslucent: true, CommonViewTitles: [], isTwoLabels: false)
        
        let BookingStatus = self.PastBookingData?.bookingInfo?.status ?? ""
        let BookingType = self.PastBookingData?.bookingInfo?.bookingType ?? ""

        if(self.isFromPast){
            self.btnAccept.isHidden = true
            self.btnReject.isHidden = true
            self.btnRepeateRide.isHidden = true
            if(BookingStatus == "canceled"){
                self.imgStatus.image = #imageLiteral(resourceName: "Cancel")
                self.btnReceipt.isHidden = true
                self.stackviewRecieptHeight.constant = 0
            }else if(BookingStatus == "completed"){
                self.imgStatus.image = #imageLiteral(resourceName: "Completed")
                self.btnReceipt.isHidden = false
                self.stackviewRecieptHeight.constant = 40
            }
            self.viewProfile.isHidden = false
            let timestamp: TimeInterval =  Double(self.PastBookingData?.bookingInfo?.acceptTime ?? "") ?? 0.0
            let date = Date(timeIntervalSince1970: timestamp)
            let formatedDate = date.timeAgoSinceDate(isForNotification: false)
            self.lblTime.text = formatedDate

        }else if(self.isFromInprogress){
            self.btnReject.setTitle("CANCEL", for: .normal)
            self.btnReject.isHidden = (BookingType == "book_later") ? true : false
            self.stackviewRecieptHeight.constant = (BookingType == "book_later") ? 0 : 0
            self.btnReceipt.isHidden = true
            self.btnAccept.isHidden = true
            self.btnRepeateRide.isHidden = true
            self.imgStatus.image = #imageLiteral(resourceName: "OnGoing")
            self.viewProfile.isHidden = false
            let timestamp: TimeInterval =  Double(self.PastBookingData?.bookingInfo?.bookingTime ?? "") ?? 0.0
            let date = Date(timeIntervalSince1970: timestamp)
            let formatedDate = date.timeAgoSinceDate(isForNotification: false)
            self.lblTime.text = formatedDate

        }else{
            self.viewProfile.isHidden = true
            self.btnAccept.isHidden = true
            self.btnReject.isHidden = true
            self.btnReceipt.isHidden = true
            self.btnRepeateRide.isHidden = true
            self.imgStatus.image = #imageLiteral(resourceName: "Pending")
            self.stackviewRecieptHeight.constant = 0
            let timestamp: TimeInterval =  Double(self.PastBookingData?.bookingInfo?.pickupDateTime ?? "") ?? 0.0
            let date = Date(timeIntervalSince1970: timestamp)
            let formatedDate = date.timeAgoSinceDate(isForNotification: false)
            self.lblTime.text = formatedDate
        }
        self.shadowView(view: MyOfferView)
        self.MyOfferView.layer.cornerRadius = 4
        self.ratingVw.isUserInteractionEnabled = false
    }

    //MARK:- ====== Data Setup ======
    func setupData(){
        if(self.PastBookingData != nil){

            if(isFromUpcomming){
                self.lblRidigo.text = "\(self.PastBookingData?.bookingInfo?.vehicleName ?? "")"
                self.lblCarName.text = ""
            }else{
                self.lblRidigo.text = "\(self.PastBookingData?.bookingInfo?.vehicleName ?? "")(\(self.PastBookingData?.driverVehicleInfo?.plateNumber ?? "")"
                self.lblCarName.text = " - \(self.PastBookingData?.driverVehicleInfo?.vehicleTypeManufacturerName ?? "") \(self.PastBookingData?.driverVehicleInfo?.vehicleTypeModelName ?? ""))"
            }
            self.lblPrice.text = "$\(self.PastBookingData?.bookingInfo?.estimatedFare ?? "0")"
            self.lblAddress.text = self.PastBookingData?.bookingInfo?.pickupLocation ?? ""
            self.lblPickupLocation.text = self.PastBookingData?.bookingInfo?.pickupLocation ?? ""
            self.lblDestLocation.text = self.PastBookingData?.bookingInfo?.dropoffLocation ?? ""
            let strUrl = "\(APIEnvironment.Profilebu.rawValue)" + "\(self.PastBookingData?.driverInfo?.profileImage ?? "")"
            let strURl = URL(string: strUrl)
            self.imgProfilw.sd_imageIndicator = SDWebImageActivityIndicator.gray
            self.imgProfilw.sd_setImage(with: strURl, placeholderImage: UIImage(named: "user_placeholder"), options: .refreshCached, completed: nil)
            let custName = (self.PastBookingData?.driverInfo?.firstName ?? "")! + " " + (self.PastBookingData?.driverInfo?.lastName ?? "")!
            self.lblRideCustomerName.text = custName
            self.ratingVw.rating = Double(self.PastBookingData?.driverInfo?.rating ?? "0.0") ?? 0.0
        }
    }

    //MARK:- ==== View Shadow ======x
    func shadowView(view : UIView){
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOpacity = 0.3
        view.layer.shadowOffset = CGSize.zero
        view.layer.shadowRadius = 4
    }

    //MARK:- ======= Cancel Ride =====
    func cancelRide() {
        NotificationCenter.default.post(name: Notification.Name("CancelTripFromDetail"), object: nil)
      //  self.navigationController?.popToViewController(HomeVC.self)
    }

    //MARK:- ===== Reject Ride =====
    func rejectRide() {
        print("reject ride..")
    }

    //MARK:- ===== Accept Ride =====
    func acceptRide() {
        print("accept ride..")
        self.callAcceptBookingRideAPI(Id: self.PastBookingData?.bookingInfo?.id ?? "")
    }

    //MARK:- ===== Back action =====
    func popBack(){
        self.delegate?.onAcceptBookingReq()
        self.navigationController?.popViewController(animated: true)
    }

    //MARK: - Button action methods
    @IBAction func btnReceiptTap(_ sender: Any) {
        let vc : RideReceiptDetailsVC = RideReceiptDetailsVC.instantiate(fromAppStoryboard: .Main)
        vc.objDetail = PastBookingData
        self.navigationController?.pushViewController(vc, animated: true)
    }

    @IBAction func btnRepeatRideTap(_ sender: Any) {
    }

    @IBAction func btnHelpTap(_ sender: Any) {
        
    }

    @IBAction func btnAcceptAction(_ sender: Any) {
        self.acceptRide()
    }

    @IBAction func btnRejectAction(_ sender: Any) {
        if(self.isFromInprogress){self.cancelRide()}else{self.rejectRide()}
    }
}

//MARK:- Api Calls
extension RideDetailsVC{
    func callAcceptBookingRideAPI(Id : String){
        self.rideDeatilViewModel.rideDetailsVC = self
        let reqModel = RidesRequestModel()
        reqModel.bookingId = Id
        self.rideDeatilViewModel.webserviceAcceptBookingRideAPI(reqModel: reqModel)
    }
}
