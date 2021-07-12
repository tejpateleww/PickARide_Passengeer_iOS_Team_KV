//
//  RegisterViewController.swift
//  ApiStructureModule
//
//  Created by EWW071 on 14/03/20.
//  Copyright © 2020 EWW071. All rights reserved.
//

import UIKit

class RegisterVC: BaseViewController {
    
    @IBOutlet weak var lblSignUP: registerScreenLabel!
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var lblCountryCode: registerScreenLabel!
    @IBOutlet weak var txtPhoneNumber: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var btnSignUP: submitButton!
    @IBOutlet weak var txtCountryCode: customTextField!
    
    var pickerView = UIPickerView()
    var selectedIndexOfPicker = Int()
    
    var registerUserModel = RegisterUserModel()
    var locationManager : LocationService?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
        self.setLocalization()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        setNavigationBarInViewController(controller: self, naviColor: colors.appColor.value, naviTitle: NavTitles.none.value, leftImage: NavItemsLeft.back.value, rightImages: [NavItemsRight.login.value], isTranslucent: true, CommonViewTitles: [], isTwoLabels: false)
    }
    
    //MARK: -IBActions
    @IBAction func signUP(_ sender: Any) {
        if self.validation(){
            if self.getLocation(){
                //            self.callOtpApi()
                let controller = OtpVC.instantiate(fromAppStoryboard: .Login)
                controller.isFrmRegister = true
                self.navigationController?.pushViewController(controller, animated: true)
            }
        }
    }
}

//MARK: Other Methods
extension RegisterVC{
    func setUpUI(){
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        self.pickerView.showsSelectionIndicator = true
        
        self.txtCountryCode.tintColor = .white
        self.txtCountryCode.delegate = self
        self.txtCountryCode.inputView = pickerView
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.barTintColor = .black
        toolBar.barTintColor = .white
        toolBar.tintColor = themeColor
        toolBar.sizeToFit()
        let done = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneAction))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelAction))
        toolBar.setItems([cancel,space,done], animated: false)
        
        self.txtCountryCode.inputAccessoryView = toolBar
        self.txtCountryCode.text = Singleton.sharedInstance.CountryList[selectedIndexOfPicker].countryCode
        self.txtPassword.setPasswordVisibility(vc: self, action: #selector(self.showHidePassword(_:)))
    }
    
    func setLocalization() {
        lblSignUP.text = "SignUpPage_lblSignUP".Localized()
        txtFirstName.placeholder = "SignUpPage_textFieldFirstName_place".Localized()
        txtLastName.placeholder = "SignUpPage_textFieldLastName_place".Localized()
        txtEmail.placeholder = "SignUpPage_textFieldEmail_place".Localized()
        lblCountryCode.text = "SignUpPage_lblCountryCode".Localized()
        txtPhoneNumber.placeholder = "SignUpPage_textFieldPhoneNumbaer_place".Localized()
        txtPassword.placeholder = "SignUpPage_textFieldPassword_place".Localized()
        textView.delegate = self
        btnSignUP.setTitle("SignUpPage_btnSIgnUP".Localized(), for: .normal)
    }
    
    @objc func showHidePassword(_ sender : UIButton) {
        sender.isSelected = !sender.isSelected
        self.txtPassword.isSecureTextEntry = sender.isSelected
    }
    
    @objc func cancelAction(_ sender: UIBarButtonItem) {
        self.txtCountryCode.endEditing(true)
    }
    
    @objc func doneAction(_ sender: UIBarButtonItem) {
        self.txtCountryCode.text = Singleton.sharedInstance.CountryList[self.selectedIndexOfPicker].countryCode
        self.txtCountryCode.endEditing(true)
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
extension RegisterVC{
    func validation()->Bool{
        var strTitle : String?
        let firstName = self.txtFirstName.validatedText(validationType: .username(field: self.txtFirstName.placeholder?.lowercased() ?? ""))
        let lastName = self.txtLastName.validatedText(validationType: .username(field: self.txtLastName.placeholder?.lowercased() ?? ""))
        let checkEmail = self.txtEmail.validatedText(validationType: .email)
        let mobileNo = self.txtPhoneNumber.validatedText(validationType: .username(field: self.txtPhoneNumber.placeholder?.lowercased() ?? ""))
        let password = self.txtPassword.validatedText(validationType: .password(field: self.txtPassword.placeholder?.lowercased() ?? ""))
        
        if !firstName.0{
            strTitle = firstName.1
        }else if !lastName.0{
            strTitle = lastName.1
        }else if !checkEmail.0{
            strTitle = checkEmail.1
        }else if !mobileNo.0{
            strTitle = mobileNo.1
        }else if self.txtPhoneNumber.text?.count != 10 {
            strTitle = UrlConstant.ValidPhoneNo
        }else if !password.0{
            strTitle = password.1
        }
        
        if let str = strTitle{
            Toast.show(title: UrlConstant.Required, message: str, state: .failure)
            return false
        }
        
        return true
    }
    
    func callOtpApi(){
        self.registerUserModel.registerVc = self
        
        let finalRegisterReqModel = RegisterRequestModel()
        finalRegisterReqModel.firstName = self.txtFirstName.text ?? ""
        finalRegisterReqModel.lastName = self.txtLastName.text ?? ""
        finalRegisterReqModel.email = self.txtEmail.text ?? ""
        finalRegisterReqModel.password = self.txtPassword.text ?? ""
        finalRegisterReqModel.phone = self.txtPhoneNumber.text ?? ""
        finalRegisterReqModel.birthDate = ""
        finalRegisterReqModel.gender = ""
        finalRegisterReqModel.address = ""
        finalRegisterReqModel.countryCode = Singleton.sharedInstance.CountryList[selectedIndexOfPicker].countryCode
        finalRegisterReqModel.countryId = Singleton.sharedInstance.CountryList[selectedIndexOfPicker].id
        
        self.registerUserModel.registerReqModel = finalRegisterReqModel
        
        let otpReqModel = OTPRequestModel()
        otpReqModel.email = self.txtEmail.text ?? ""
        otpReqModel.phone = self.txtPhoneNumber.text ?? ""
        
        self.registerUserModel.webserviceOTP(reqModel: otpReqModel)
    }
}

//MARK:- TextView Delegate
extension RegisterVC: UITextViewDelegate{
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        
        let controller = CommonWebViewVC.instantiate(fromAppStoryboard: .Main)
        if (URL.absoluteString ==  "SignUpPage_textViewText2".Localized().replacingOccurrences(of: " ", with: "")) {
            print("Print termsAndConditions")
            controller.strNavTitle = "SignUpPage_textViewText2".Localized().capitalized
        } else if (URL.absoluteString ==  "SignUpPage_textViewText4".Localized().replacingOccurrences(of: " ", with: "")) {
            print("Print privacypolicy")
            controller.strNavTitle = "SignUpPage_textViewText4".Localized().capitalized
        }
        
        self.navigationController?.pushViewController(controller, animated: true)
        return false
    }
}

//MARK:- TextField Delegate
extension RegisterVC: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == txtPhoneNumber || textField == txtFirstName || textField == txtLastName{
            let currentString: NSString = textField.text as NSString? ?? ""
            let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
            return string == "" || (newString.length <= ((textField == txtPhoneNumber) ? MAX_PHONE_DIGITS : TEXTFIELD_MaximumLimit))
        }
        
        return true
    }
}

//MARK:- Country Code Picker Set Up
extension RegisterVC : UIPickerViewDelegate,UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Singleton.sharedInstance.CountryList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return (Singleton.sharedInstance.CountryList[row].countryCode ?? "") + " - " + (Singleton.sharedInstance.CountryList[row].name ?? "")
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedIndexOfPicker = row
    }
}
