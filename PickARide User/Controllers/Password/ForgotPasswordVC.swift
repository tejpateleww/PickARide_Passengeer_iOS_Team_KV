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
    @IBOutlet weak var lblEmailTitle: ForgotPasswordLabel!
    @IBOutlet weak var textFieldPhoneNumber: phonenumberTextField!
    @IBOutlet weak var btnContinue: submitButton!
    @IBOutlet weak var txtEmail: emailPasswordTextField!
    
    var forgotPasswordUserModel = PasswordUserModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocalization()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.setNavigationBarInViewController(controller: self, naviColor: colors.appColor.value, naviTitle: NavTitles.forgotPassword.value, leftImage: NavItemsLeft.back.value, rightImages: [NavItemsRight.none.value], isTranslucent: true, CommonViewTitles: [], isTwoLabels: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.view.endEditing(true)
    }
    
    @IBAction func btnContinue(_ sender: Any) {
//        if self.validation(){
//            self.callForgotPasswordApi()
            let controller = OtpVC.instantiate(fromAppStoryboard: .Login)
            self.navigationController?.pushViewController(controller, animated: true)
//        }
    }
}

//MARK:- Methods
extension ForgotPasswordVC{
    func setupLocalization() {
//        lblForgotPassword.text = "ForgotPasswordScreen_lblForgotPassword".Localized()
        lblQuestion.text = "ForgotPasswordScreen_lblQuestion".Localized()
        lblDescription.text = "ForgotPasswordScreen_lblDescription".Localized()
        lblEmailTitle.text = "LoginScreen_lblEmail".Localized()
        textFieldPhoneNumber.placeholder = "ForgotPasswordScreen_textFieldPhoneNumber".Localized()
        btnContinue.setTitle("ForgotPasswordScreen_btnContinue".Localized(), for: .normal)
    }
}

//MARK:- Validation & Api
extension ForgotPasswordVC{
    func validation()->Bool{
        var strTitle : String?
        let checkEmail = self.txtEmail.validatedText(validationType: .email)
        
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
