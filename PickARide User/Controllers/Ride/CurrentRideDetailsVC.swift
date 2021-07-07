//
//  CurrentRideDetailsViewController.swift
//  PickARide User
//
//  Created by Apple on 21/12/20.
//  Copyright © 2020 EWW071. All rights reserved.
//

import UIKit
import GoogleMaps

class CurrentRideDetailsVC: BaseViewController {

    @IBOutlet weak var lblDriverName: currentRideLabel!
    @IBOutlet weak var lblRidego: currentRideLabel!
    @IBOutlet weak var lblVehicalData: currentRideLabel!
    @IBOutlet weak var mapVw: GMSMapView!
    @IBOutlet weak var vwMain: suggestedTaxiView!
    @IBOutlet weak var btnCancel: UIButton!
    
    var vehicalNumber = "ST3751"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
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
}

//MARK:- Set Up UI
extension CurrentRideDetailsVC{
    func setUpUI(){
        self.setLabel()
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        self.vwMain.addGestureRecognizer(tap)
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
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        appDel.navigateToMain()
    }
}
