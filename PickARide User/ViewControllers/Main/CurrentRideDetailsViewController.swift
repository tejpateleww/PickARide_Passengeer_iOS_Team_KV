//
//  CurrentRideDetailsViewController.swift
//  PickARide User
//
//  Created by Apple on 21/12/20.
//  Copyright © 2020 EWW071. All rights reserved.
//

import UIKit

class CurrentRideDetailsViewController: BaseViewController {

    //MARK: -Properties
    var vehicalNumber = "ST3751"
    //MARK: -IBOutlets
    @IBOutlet weak var lblDriverName: currentRideLabel!
    @IBOutlet weak var lblRidego: currentRideLabel!
    @IBOutlet weak var lblVehicalData: currentRideLabel!
    @IBOutlet weak var lblStartRideAddress: currentRideLabel!
    @IBOutlet weak var lblEndRideAddress: currentRideLabel!
    //MARK: -View Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLocalization()
        setValue()
        setLabel()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    //MARK: -other methods
    func setLocalization() {
        
    }
    func setValue() {
        lblStartRideAddress.text = "Seattle"
        lblEndRideAddress.text = "280 Hemlock Ln"
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
    //MARK: -IBActions
    
    
    //MARK: -API Calls
    
    
    
    

}
