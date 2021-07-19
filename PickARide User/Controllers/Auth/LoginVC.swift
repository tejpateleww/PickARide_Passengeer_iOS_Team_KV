//
//  LoginViewController.swift
//  ApiStructureModule
//
//  Created by EWW071 on 14/03/20.
//  Copyright © 2020 EWW071. All rights reserved.
//

import UIKit
import CoreLocation

class LoginVC: UIViewController {
  
    @IBOutlet weak var lblSignIN: loginScreenLabel!
    @IBOutlet weak var lblWelcomeBack: loginScreenLabel!
    @IBOutlet weak var txtPassword: emailPasswordTextField!
    @IBOutlet weak var txtEmail: emailPasswordTextField!
    @IBOutlet weak var btnForgotPassword: loginScreenButton!
    @IBOutlet weak var btnSignIN: submitButton!
    @IBOutlet weak var lblOR: loginScreenLabel!
    @IBOutlet weak var lblDontHaveanAccount: loginScreenLabel!
    @IBOutlet weak var btnSIgnUP: loginScreenButton!
    
    var loginUserModel = LoginUserModel()
    var googleSignInManager : GoogleLoginProvider?
    var locationManager : LocationService?
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let _ = self.getLocation()
        self.setupLocalization()
        self.txtPassword.setPasswordVisibility(vc: self, action: #selector(self.showHidePassword(_:)))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.view.endEditing(true)
    }
    
    @IBAction func signUP(_ sender: Any) {
        let controller = RegisterVC.instantiate(fromAppStoryboard: .Login)
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func btnSignInClicked(_ sender: Any) {
        if self.validation(){
//            if self.getLocation(){
//                self.callLoginApi()
                userDefaults.setValue(true, forKey: UserDefaultsKey.isUserLogin.rawValue)
                appDel.navigateToMain()
//            }
        }
    }
    
    @IBAction func ForgotPassword(_ sender: Any) {
        let controller = ForgotPasswordVC.instantiate(fromAppStoryboard: .Login)
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func btnSocialRequests(_ sender: UIButton) {
        self.view.endEditing(true)
        print(#function)
        
//        if self.getLocation(){
            return
                
            if sender.tag == 0{
                let faceBookSignInManager = FacebookLoginProvider(self)
                faceBookSignInManager.delegate = self
                faceBookSignInManager.fetchToken(from: self)
            }else{
                self.googleSignInManager = GoogleLoginProvider(self)
                self.googleSignInManager?.delegate = self
            }
//        }
    }
}

//MARK: Other Methods
extension LoginVC{
    func setupLocalization() {
        lblSignIN.text = "LoginScreen_lblSignIN".Localized()
        lblWelcomeBack.text = "LoginScreen_lblWelcomeBack".Localized()
        txtEmail.placeholder = "LoginScreen_textFieldEmailID_place".Localized()
        txtPassword.placeholder = "LoginScreen_textFieldPassword_place".Localized()
        btnForgotPassword.setTitle("LoginScreen_btnForgotPassword".Localized(), for: .normal)
        btnSignIN.setTitle("LoginScreen_btnSignIN".Localized(), for: .normal)
        lblOR.text = "LoginScreen_lblOR".Localized()
        lblDontHaveanAccount.text = "LoginScreen_lblDontHaveanAccount".Localized()
        btnSIgnUP.setTitle("LoginScreen_btnSIgnUP".Localized(), for: .normal)
    }
    
    @objc func showHidePassword(_ sender : UIButton) {
        sender.isSelected = !sender.isSelected
        self.txtPassword.isSecureTextEntry = sender.isSelected
    }
    
    func getLocation() -> Bool {
        if Singleton.sharedInstance.userCurrentLocation == nil{
            self.locationManager = LocationService()
            self.locationManager?.startUpdatingLocation()
            return false
        }else{
            return true
        }
    }
}

//MARK:- Validation & Api
extension LoginVC{
    func validation()->Bool{
        var strTitle : String?
        let checkEmail = txtEmail.validatedText(validationType: .email)
        let password = txtPassword.validatedText(validationType: .password(field: self.txtPassword.placeholder?.lowercased() ?? ""))
        
        if !checkEmail.0{
            strTitle = checkEmail.1
        }else if !password.0{
            strTitle = password.1
        }

        if let str = strTitle{
            Toast.show(title: UrlConstant.Required, message: str, state: .failure)
            return false
        }
        
        return true
    }
    
    func callLoginApi(){
        self.loginUserModel.loginVC = self
        
        let reqModel = LoginRequestModel()
        reqModel.userName = self.txtEmail.text ?? ""
        reqModel.password = self.txtPassword.text ?? ""
        
        self.loginUserModel.webserviceLogin(reqModel: reqModel)
    }
    
    func callSocialLoginApi(){
        self.loginUserModel.loginVC = self
        
        let reqModel = SocialLoginRequestModel()
        
        self.loginUserModel.webserviceSocialLogin(reqModel: reqModel)
    }
}

//MARK:- Social Sign In
extension LoginVC: SocialSignInDelegate{
    func FatchUser(socialType: SocialType, success: Bool, user: SocialUser?, error: String?) {
        if let userObj = user{
            if let _ = userObj.email{
            }else{
            }
        }
    }
}


