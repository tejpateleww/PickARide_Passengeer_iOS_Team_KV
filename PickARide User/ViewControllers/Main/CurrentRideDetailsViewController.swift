//
//  CurrentRideDetailsViewController.swift
//  PickARide User
//
//  Created by Apple on 21/12/20.
//  Copyright © 2020 EWW071. All rights reserved.
//

import UIKit
import GoogleMaps

class CurrentRideDetailsViewController: BaseViewController {

    //MARK: -Properties
    var vehicalNumber = "ST3751"
    //MARK: -IBOutlets
    @IBOutlet weak var lblDriverName: currentRideLabel!
    @IBOutlet weak var lblRidego: currentRideLabel!
    @IBOutlet weak var lblVehicalData: currentRideLabel!
    @IBOutlet weak var mapVw: GMSMapView!
    @IBOutlet weak var vwMain: suggestedTaxiView!
    
    //MARK: -View Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLocalization()
        setValue()
        setLabel()
        
        setNavigationBarInViewController(controller: self, naviColor: colors.submitButtonColor.value, naviTitle: NavTitles.CommonView.value, leftImage: NavItemsLeft.none.value, rightImages: [NavItemsRight.none.value], isTranslucent: true, CommonViewTitles: ["Seattle","280 Hemlock Ln"], isTwoLabels: false)
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        vwMain.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        //self.navigationController?.navigationBar.isHidden = true
    }
    override func viewDidDisappear(_ animated: Bool) {
        //self.navigationController?.navigationBar.isHidden = false
    }
    
    //MARK: -other methods
    func setLocalization() {
        
    }
    func setValue() {
        
    }
    func setLabel() {
        let attributedString = NSMutableAttributedString(string: lblVehicalData.text!)
        
        let strNumber : NSString = lblVehicalData.text as! NSString
        let range = (strNumber).range(of: vehicalNumber)
        print(range.location)
        attributedString.addAttribute(NSAttributedString.Key.font, value: CustomFont.medium.returnFont(15), range: NSMakeRange(0, attributedString.length))
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: colors.loginPlaceHolderColor.value, range: NSMakeRange(0, attributedString.length))
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: colors.phoneNumberColor.value , range: range)
        lblVehicalData.attributedText = attributedString
        //
    }
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        appDel.navigateToMain()
    }
    //MARK: -IBActions
    
    @IBAction func btnProfileClicked(_ sender: Any) {
        let controller = AppStoryboard.Main.instance.instantiateViewController(withIdentifier: RatingYourTripVC.storyboardID)
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    //MARK: -API Calls
    
    
    
    

}
