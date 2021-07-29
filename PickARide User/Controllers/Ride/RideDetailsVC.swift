//
//  RideDetailsVC.swift
//  PickARide User
//
//  Created by baps on 18/12/20.
//  Copyright © 2020 EWW071. All rights reserved.
//

import UIKit

class RideDetailsVC: BaseViewController {
    
    @IBOutlet weak var lblRideDetails: RideDetailLabel!
    @IBOutlet weak var lblDate: RideDetailLabel!
    @IBOutlet weak var lblPlaceCode: RideDetailLabel!
    @IBOutlet weak var lblPlace: RideDetailLabel!
    @IBOutlet weak var lblAddress: RideDetailLabel!
    @IBOutlet weak var lblPrice: RideDetailLabel!
    @IBOutlet weak var lblTotal: RideDetailLabel!
    @IBOutlet weak var lblPickup: RideDetailLabel!
    @IBOutlet weak var lblPickupDetail: RideDetailLabel!
    @IBOutlet weak var lblDestination: RideDetailLabel!
    @IBOutlet weak var lblDestinationDetail: RideDetailLabel!
    @IBOutlet weak var btnReceipt: RidesDetailsButton!
    @IBOutlet weak var btnRepeatRide: RidesDetailsButton!
    @IBOutlet weak var lblName: RideDetailLabel!
    @IBOutlet weak var lblRating: RideDetailLabel!
    @IBOutlet weak var btnHelp: RidesDetailsButton!
    @IBOutlet weak var receptOuterVWHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var receiptBtnOuterVWBottomConstraint: NSLayoutConstraint!
    
    var isFromPastRide = Bool()
    override func viewDidLoad() {
        self.setUpUI()
        super.viewDidLoad()
        self.setupLocalization()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarInViewController(controller: self, naviColor: colors.submitButtonColor.value, naviTitle: NavTitles.rideDetails.value, leftImage: NavItemsLeft.back.value, rightImages: [NavItemsRight.none.value], isTranslucent: true, CommonViewTitles: [], isTwoLabels: false)
    }
    
    @IBAction func btnRideReceipt(_ sender: Any) {
        let controller = RideReceiptDetailsVC.instantiate(fromAppStoryboard: .Main)
        controller.isFromPastRide = isFromPastRide
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
}

//MARK:- Set Up UI
extension RideDetailsVC{
    func setUpUI(){
        self.receptOuterVWHeightConstraint.constant = !self.isFromPastRide ? 0 : 30
        self.receiptBtnOuterVWBottomConstraint.constant = !self.isFromPastRide ? 0 : 25
    }
    
    func setupLocalization(){
        lblRideDetails.text = "RideDetailsVC_lblRideDetails".Localized()
        lblDate.text = "RideDetailsVC_lblDate".Localized()
        lblPlaceCode.text = "RideDetailsVC_lblPlaceCode".Localized()
        lblPlace.text = "RideDetailsVC_lblPlace".Localized()
        lblAddress.text = "RideDetailsVC_lblAddress".Localized()
        lblPrice.text = "RideDetailsVC_lblPrice".Localized()
        lblTotal.text = "RideDetailsVC_lblTotal".Localized()
        lblPickup.text = "RideDetailsVC_lblPickup".Localized()
        lblPickupDetail.text = "RideDetailsVC_lblPickupDetail".Localized()
        lblDestination.text = "RideDetailsVC_lblDestination".Localized()
        lblDestinationDetail.text = "RideDetailsVC_lblDestinationDetail".Localized()
        lblName.text = "RideDetailsVC_lblName".Localized()
        lblRating.text = "RideDetailsVC_lblRating".Localized()
        btnReceipt.setTitle("RideDetailsVC_btnReceipt".Localized(), for: .normal)
        btnRepeatRide.setTitle("RideDetailsVC_btnRepeatRide".Localized(), for: .normal)
        btnHelp.setTitle("RideDetailsVC_btnHelp".Localized(), for: .normal)
    }
}
