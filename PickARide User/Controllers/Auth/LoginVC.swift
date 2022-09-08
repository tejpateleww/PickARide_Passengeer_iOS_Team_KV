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
    @IBOutlet weak var lblPasswordTitle: ProfileLabel!
    @IBOutlet weak var txtPassword: emailPasswordTextField!
    @IBOutlet weak var lblEmailTitle: ProfileLabel!
    @IBOutlet weak var txtEmail: emailPasswordTextField!
    @IBOutlet weak var btnForgotPassword: loginScreenButton!
    @IBOutlet weak var btnSignIN: submitButton!
    @IBOutlet weak var lblOR: loginScreenLabel!
    @IBOutlet weak var lblDontHaveanAccount: loginScreenLabel!
    @IBOutlet weak var btnSIgnUP: loginScreenButton!
    
    var loginUserModel = LoginUserModel()
    var appleSignInManager : AppleSignInProvider?
    var googleSignInManager : GoogleLoginProvider?
    var locationManager : LocationService?
    
    var cityNameSelectedIndex = 0
    let viewForPicker = UIView()
    let pickerViewForCityName = UIPickerView()
    let pickerToolBar = UIToolbar()

    override func viewDidLoad() {
        super.viewDidLoad()
        let _ = self.getLocation()
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
            if self.getLocation(){
                self.callLoginApi()
            }
        }
    }
    
    @IBAction func ForgotPassword(_ sender: Any) {
        let controller = ForgotPasswordVC.instantiate(fromAppStoryboard: .Login)
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func btnSocialRequests(_ sender: UIButton) {
        self.view.endEditing(true)
        print(#function)
        if self.getLocation(){
            if sender.tag == 0 {
                self.appleSignInManager = AppleSignInProvider()
                self.appleSignInManager?.delegate = self
            } else if sender.tag == 1 {
                let faceBookSignInManager = FacebookLoginProvider(self)
                faceBookSignInManager.delegate = self
                faceBookSignInManager.fetchToken(from: self)
            }else{
                self.googleSignInManager = GoogleLoginProvider(self)
                self.googleSignInManager?.delegate = self
            }
        }
    }
}

//MARK: Other Methods
extension LoginVC{
   
    
    func setupLocalization() {
        lblSignIN.text = "LoginScreen_lblSignIN".Localized()
        lblWelcomeBack.text = "LoginScreen_lblWelcomeBack".Localized()
        
        lblEmailTitle.text = "LoginScreen_lblEmail".Localized()
        txtEmail.placeholder = "LoginScreen_textFieldEmailID_place".Localized()
        
        lblPasswordTitle.text = "LoginScreen_lblPassword".Localized()
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
    
    func callSocialLoginApi(reqModel: SocialLoginRequestModel){
        self.loginUserModel.loginVC = self
        self.loginUserModel.webserviceSocialLogin(reqModel: reqModel)
    }
    
    func callSocialUpdateApi() {
        let socialUpdatereqModel = SocialUpdateRequestModel()
        socialUpdatereqModel.cityId = Singleton.sharedInstance.CityList[cityNameSelectedIndex].id
        socialUpdatereqModel.countryId = Singleton.sharedInstance.CityList[cityNameSelectedIndex].countryId
        self.loginUserModel.webserviceSocialUpdate(reqModel: socialUpdatereqModel)
    }
    
    func callAppleDetailsApi(socialId: String){
        self.loginUserModel.loginVC = self
        let reqModel = AppleDetailsRequestModel()
        reqModel.socialId = socialId
        self.loginUserModel.webserviceAppleDetails(reqModel: reqModel)
    }
}
//MARK:- TextField Delegate
extension LoginVC: UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == txtPassword {
            let currentString: NSString = textField.text as NSString? ?? ""
            let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
            return string == "" || newString.length <= TEXTFIELD_MaximumLimit
        }
        return true
    }
}

//MARK:- Social Sign In
extension LoginVC: SocialSignInDelegate{
    func FetchUser(socialType: SocialType, success: Bool, user: SocialUser?, error: String?) {
        if let userObj = user{
            let reqModel = SocialLoginRequestModel()
            reqModel.socialId = userObj.userId
            reqModel.socialType = socialType.rawValue
            reqModel.firstName = userObj.firstName
            reqModel.lastName = userObj.lastName
            reqModel.email = userObj.email
            reqModel.userName = userObj.email
            
            if socialType == .Apple {
                if let email = userObj.email , email != ""{
                    self.callSocialLoginApi(reqModel: reqModel)
                } else{
                    self.callAppleDetailsApi(socialId: userObj.userId)
                }
            } else {
                self.callSocialLoginApi(reqModel: reqModel)
            }
        }
    }
}

// MARK: - Country Code/City Name
extension LoginVC {
    
    func setUpCityPicker() {
        
        viewForPicker.frame = CGRect(x: 0,
                                     y: 0,
                                     width: ScreenSize.SCREEN_WIDTH,
                                     height:  pickerViewForCityName.frame.height + 44.0)
        let pickerView = pickerViewForCityName
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.showsSelectionIndicator = true
        
        pickerToolBar.barStyle = UIBarStyle.default
        pickerToolBar.barTintColor = .black
        pickerToolBar.barTintColor = .white
        pickerToolBar.tintColor = themeColor
        pickerToolBar.sizeToFit()
        let done = UIBarButtonItem(title: "NavigationButton_btnDone".Localized(), style: .plain, target: self, action: #selector(doneAction))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancel = UIBarButtonItem(title: "UrlConstant_Cancel".Localized(), style: .plain, target: self, action: #selector(cancelAction))
        pickerToolBar.setItems([cancel,space,done], animated: false)
        
        pickerToolBar.frame = CGRect(x: 0.0,
                                     y: 0.0,
                                        width: ScreenSize.SCREEN_WIDTH,
                                     height: 44.0)
        viewForPicker.addSubview(pickerToolBar)
        
        pickerViewForCityName.frame = CGRect(x: 0.0,
                                y: 44.0,
                                width: ScreenSize.SCREEN_WIDTH,
                                height: pickerViewForCityName.frame.height)
        viewForPicker.addSubview(pickerViewForCityName)
        viewForPicker.backgroundColor = UIColor.white
    }
    
    func showCityList() {
        if pickerToolBar.superview == nil {
            setUpCityPicker()
        }
        if Singleton.sharedInstance.CityList.count == 0 {
            WebServiceSubClass.GetCityList { [weak self] _, _, _, _ in
                guard let self = self else {
                    return
                }
                self.showCityNamePicker()
            }
        }else{
            self.showCityNamePicker()
        }
    }
   
    
    func showCityNamePicker() {
           var pickerRect = viewForPicker.frame
           pickerRect.origin.x = 0.0
           pickerRect.origin.y = ScreenSize.SCREEN_HEIGHT
            viewForPicker.frame = pickerRect
           view.addSubview(viewForPicker)
        UIView.animate(withDuration: 0.5,
                       delay: 0.0, options: .curveLinear,
                       animations: { [weak self] in
            guard let self = self else {
                return
            }
            var pickerRect = self.viewForPicker.frame
            pickerRect.origin.x = 0.0
            pickerRect.origin.y = ScreenSize.SCREEN_HEIGHT - pickerRect.height
            self.viewForPicker.frame = pickerRect
        }, completion: nil)
    }
    
    func hidePicker() {
        UIView.animate(withDuration: 0.5,
                       delay: 0.0, options: .curveLinear,
                       animations: { [weak self] in
            guard let self = self else {
                return
            }
            var pickerRect = self.viewForPicker.frame
            pickerRect.origin.x = 0.0
            pickerRect.origin.y = ScreenSize.SCREEN_HEIGHT
            self.viewForPicker.frame = pickerRect
        }, completion: nil)
    }
    /// When pciker view for countrycode  list and city list closes
    /// - Parameter sender: Bar button item for picker view tol bar
    @objc func cancelAction(_ sender: UIBarButtonItem) {
//        view.endEditing(true)
        hidePicker()
    }

    /// When pciker view for countrycode  list and city list closes
    /// - Parameter sender: Bar button item for picker view tol bar
    @objc func doneAction(_ sender: UIBarButtonItem) {
            cityNameSelectedIndex = pickerViewForCityName.selectedRow(inComponent: 0)
            hidePicker()
            // Call social update api
        self.callSocialUpdateApi()
    }
    
}

//MARK:- Country Code Picker Set Up
extension LoginVC : UIPickerViewDelegate,UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        if pickerView == pickerViewForCountryCode {
//            return Singleton.sharedInstance.CountryList.count
//        } else {
        //if pickerView.tag == RegisterListTextFieldTag.cityName.rawValue {
            return Singleton.sharedInstance.CityList.count
//        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        if pickerView == pickerViewForCountryCode {
//            return (Singleton.sharedInstance.CountryList[row].countryCode ?? "") + " - " + (Singleton.sharedInstance.CountryList[row].name ?? "")
//        } else {
            return (Singleton.sharedInstance.CityList[row].cityName)
//        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        if pickerView.tag == RegisterListTextFieldTag.countryCode.rawValue {
//        } else {
//            cityNameSelectedIndex = row
//        }
    }
}

