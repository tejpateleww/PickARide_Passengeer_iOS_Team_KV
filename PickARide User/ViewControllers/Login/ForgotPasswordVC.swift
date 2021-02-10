//
//  ForgotPasswordVC.swift
//  PickARide User
//
//  Created by baps on 15/12/20.
//  Copyright © 2020 EWW071. All rights reserved.
//

import UIKit

class ForgotPasswordVC: BaseViewController {

    //MARK: -Properties
      
    //MARK: -IBOutlets
    
    
    @IBOutlet weak var lblForgotPassword: ForgotPasswordLabel!
    @IBOutlet weak var lblQuestion: ForgotPasswordLabel!
    @IBOutlet weak var lblDescription: ForgotPasswordLabel!
    @IBOutlet weak var lblCountryCode: ForgotPasswordLabel!
    
    
    @IBOutlet weak var textFieldPhoneNumber: phonenumberTextField!
    
    @IBOutlet weak var btnContinue: submitButton!
    
    //MARK: -View Life Cycle Methods
    override func viewDidLoad() {
        setNavigationBarInViewController(controller: self, naviColor: colors.appColor.value, naviTitle: NavTitles.none.value, leftImage: NavItemsLeft.back.value, rightImages: [NavItemsRight.none.value], isTranslucent: true, CommonViewTitles: [], isTwoLabels: false)
        super.viewDidLoad()
        setupLocalization()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    //MARK: -Other Methods
    func setupLocalization() {
        lblForgotPassword.text = "ForgotPasswordScreen_lblForgotPassword".Localized()
        lblQuestion.text = "ForgotPasswordScreen_lblQuestion".Localized()
        lblDescription.text = "ForgotPasswordScreen_lblDescription".Localized()
        lblCountryCode.text = "ForgotPasswordScreen_lblCountryCode".Localized()
        textFieldPhoneNumber.placeholder = "ForgotPasswordScreen_textFieldPhoneNumber".Localized()
        btnContinue.setTitle("ForgotPasswordScreen_btnContinue".Localized(), for: .normal)
    }
    
    //MARK: -IBActions
    @IBAction func btnContinue(_ sender: Any) {
        let controller = AppStoryboard.Login.instance.instantiateViewController(withIdentifier: VerifyViewController.storyboardID) as! VerifyViewController
        self.navigationController?.pushViewController(controller, animated: true)
    }
    //MARK: -API Calls
}
