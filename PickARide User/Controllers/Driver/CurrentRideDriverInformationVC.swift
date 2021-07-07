//
//  CurrentRideDriverInformationVC.swift
//  PickARide User
//
//  Created by Apple on 18/01/21.
//  Copyright © 2021 EWW071. All rights reserved.
//

import UIKit
import GoogleMaps

class CurrentRideDriverInformationVC: BaseViewController {
    
    //MARK: -Properties
    var vehicalNumber = "ST3751"
    
    //MARK: -IBOutlets
    @IBOutlet weak var lblDriverName: currentRideLabel!
    @IBOutlet weak var lblRidego: currentRideLabel!
    @IBOutlet weak var lblVehicalData: currentRideLabel!
    @IBOutlet weak var mapVw: GMSMapView!
    @IBOutlet weak var vwMain: suggestedTaxiView!
    
    @IBOutlet weak var btnCancel: UIButton!
    //MARK: -View Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setLabel()
        
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
        let controller = RatingYourTripVC.instantiate(fromAppStoryboard: .Main)
        self.navigationController?.pushViewController(controller, animated: true)
    }
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        
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
    
    @IBAction func btnCallClick(_ sender: Any) {
    }
    
    @IBAction func btnMessageClick(_ sender: Any) {
        let controller = ChatVC.instantiate(fromAppStoryboard: .Main)
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func btnprofileClicked(_ sender: Any) {
        let controller = CurrentRideDetailsVC.instantiate(fromAppStoryboard: .Main)
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func btnCancelClick(_ sender: Any) {
        let controller = CancelTripVC.instantiate(fromAppStoryboard: .Main)
        
        let navigationController = UINavigationController(rootViewController: controller)
        
        navigationController.modalPresentationStyle = .overCurrentContext
        navigationController.modalTransitionStyle = .crossDissolve
        self.present(navigationController, animated: true, completion: nil)
    }
    
}
