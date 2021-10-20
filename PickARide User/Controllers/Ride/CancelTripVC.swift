//
//  CancelTripVC.swift
//  PickARide User
//
//  Created by baps on 29/12/20.
//  Copyright © 2020 EWW071. All rights reserved.
//

import UIKit

class CancelTripVC: BaseViewController {
    
    @IBOutlet weak var viewBGBottom: NSLayoutConstraint!
    @IBOutlet weak var viewDragable: UIView!
    @IBOutlet weak var viewBG: UIView!
    @IBOutlet weak var viewMain: viewWithClearBg!
    @IBOutlet weak var btnNo: cancelButton!
    @IBOutlet weak var lblCancel: UILabel!
    @IBOutlet weak var btnCencel: cancelButton!
    
    
    var isFromApi = false
    var objBookingInfo : BookingInfoData!
    var objCurrentBooking : CurrentBookingData!
    var mainVCTogo : (()->())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarInViewController(controller: self, naviColor: colors.submitButtonColor.value, naviTitle: NavTitles.none.value, leftImage: NavItemsLeft.none.value, rightImages: [NavItemsRight.none.value], isTranslucent: true, CommonViewTitles: [], isTwoLabels: false)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.viewBGBottom.constant = 0
        UIView.animate(withDuration: 0.5, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    override func viewDidLayoutSubviews() {
        self.viewBG.layer.cornerRadius = 10
        self.viewBG.clipsToBounds = true
        
    }
    
    @IBAction func btnCancelClick(_ sender: Any) {
        let controller = ReasonForCancelVC.instantiate(fromAppStoryboard: .Main)
        controller.objBookingInfo = objBookingInfo
        controller.objCurrentBooking = objCurrentBooking
        controller.isFromApi = isFromApi
        controller.NavigateToMainScreen = {
            self.dismiss(animated: true, completion: nil)
            if let mainVc = self.mainVCTogo {
                mainVc()
            }
            self.navigationController?.popViewController(animated: true)
        }
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func btnNoClick(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
