//
//  ForgotPasswordVC.swift
//  PickARide User
//
//  Created by baps on 15/12/20.
//  Copyright © 2020 EWW071. All rights reserved.
//

import UIKit

class ForgotPasswordVC: BaseViewController {
    
    @IBOutlet weak var lblForgotPassword: ForgotPasswordLabel!
    @IBOutlet weak var lblQuestion: ForgotPasswordLabel!
    @IBOutlet weak var lblDescription: ForgotPasswordLabel!
    @IBOutlet weak var lblCountryCode: ForgotPasswordLabel!
    @IBOutlet weak var textFieldPhoneNumber: phonenumberTextField!
    @IBOutlet weak var btnContinue: submitButton!
    
    var forgotPasswordUserModel = PasswordUserModel()
    
    override func viewDidLoad() {
        setNavigationBarInViewController(controller: self, naviColor: colors.appColor.value, naviTitle: NavTitles.none.value, leftImage: NavItemsLeft.back.value, rightImages: [NavItemsRight.none.value], isTranslucent: true, CommonViewTitles: [], isTwoLabels: false)
        super.viewDidLoad()
        setupLocalization()
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
        let controller = OtpVC.instantiate(fromAppStoryboard: .Login)
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

//MARK:- Validation & Api
extension ForgotPasswordVC{
    func validation()->Bool{
        var strTitle : String?
        let checkEmail = textFieldPhoneNumber.validatedText(validationType: .email)
        
        if !checkEmail.0{
            strTitle = checkEmail.1
        }

        if let str = strTitle{
            Toast.show(title: UrlConstant.Required, message: str, state: .failure)
            return false
        }
        
        return true
    }
    
    func callForgotPasswordApi(){
        self.forgotPasswordUserModel.forgotPasswordVC = self
        
        let reqModel = ForgotPasswordReqModel()
        reqModel.email = self.textFieldPhoneNumber.text ?? ""
        
        self.forgotPasswordUserModel.webserviceForgotPassword(reqModel: reqModel)
    }
}
