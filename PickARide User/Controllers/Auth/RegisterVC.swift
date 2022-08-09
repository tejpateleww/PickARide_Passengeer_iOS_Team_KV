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
    @IBOutlet weak var lblFirstNameTitle: ProfileLabel!
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var lblLastNameTitle: ProfileLabel!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var lblEmailTitle: ProfileLabel!
    @IBOutlet weak var txtEmail: UITextField!
    
    @IBOutlet weak var lblCountryCode: ProfileLabel!
    @IBOutlet weak var txtCountryCode: customTextField!
    @IBOutlet weak var txtPhoneNumber: UITextField!
    
    @IBOutlet weak var lblCityNameTitle: ProfileLabel!
    @IBOutlet weak var txtCityName: UITextField!
    
    @IBOutlet weak var lblPassword: ProfileLabel!
    @IBOutlet weak var txtPassword: UITextField!
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var btnSignUP: submitButton!
    
//    var pickerView = UIPickerView()
//    var countryCodeSelectedIndex = 0
    var cityNameSelectedIndex = 0
//    let pickerViewForCountryCode = UIPickerView()
    let pickerViewForCityName = UIPickerView()

    var registerUserModel = RegisterUserModel()
    var locationManager : LocationService?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.isEditable = false
        textView.isSelectable = true
        textView.isScrollEnabled = false //to have own size and behave like a label
        textView.delegate = self
        SetupAttributedTermsCondition()
        self.setUpUI()
        self.setLocalization()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        setNavigationBarInViewController(controller: self, naviColor: colors.appColor.value, naviTitle: NavTitles.signUp.value, leftImage: NavItemsLeft.back.value, rightImages: [NavItemsRight.login.value], isTranslucent: true, CommonViewTitles: [], isTwoLabels: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.view.endEditing(true)
    }
    
    //MARK: -IBActions
    @IBAction func signUP(_ sender: Any) {
        if self.validation(){
            if self.getLocation(){
                self.callOtpApi()
            }
        }
    }
    
    //MARK:- === Terms And Contion Button Setup =====
    func SetupAttributedTermsCondition(){
        
        let attributedText = NSMutableAttributedString(attributedString: textView.attributedText!)

        // Use NSString so the result of rangeOfString is an NSRange.
        let text = textView.text! as NSString

        // Find the range of each element to modify.
        let boldRange = text.range(of: "Terms & conditions")
        let boldFont = CustomFont.bold.returnFont(14.0)
        
        let boldRange1 = text.range(of: "Privacy Policy")
        let boldFont1 = CustomFont.bold.returnFont(14.0)
        
        
        attributedText.addAttribute(NSAttributedString.Key.link, value: "privacypolicy", range:boldRange1)
        attributedText.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.black, range: boldRange)
//
        attributedText.addAttribute(NSAttributedString.Key.font, value: boldFont1, range: boldRange1)
        attributedText.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.green, range: boldRange1)
        
        // Handle bold
        attributedText.addAttribute(NSAttributedString.Key.font, value: boldFont, range: boldRange)
        
        attributedText.addAttribute(NSAttributedString.Key.link, value: "termsandconditions", range:boldRange)

        
        
        let smallRangeAnd = text.range(of: " and ")
        let smallFontAnd = CustomFont.regular.returnFont(14.0)
        
        
        attributedText.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.lightGray, range: smallRangeAnd)
        attributedText.addAttribute(NSAttributedString.Key.font, value: smallFontAnd, range: smallRangeAnd)
    
        // Handle small.
        let smallRange = text.range(of: "By continuing, I confirm that I have read & agree to the ")
        let smallFont = CustomFont.regular.returnFont(14.0)
        

        attributedText.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.lightGray, range: smallRange)
        attributedText.addAttribute(NSAttributedString.Key.font, value: smallFont, range: smallRange)
        
        textView.attributedText = attributedText
       
        
    }
}

//MARK: Other Methods
extension RegisterVC{
    func setUpUI(){
//        setUpListTextField(textField: txtCountryCode)
        setUpListTextField(textField: txtCityName)
        // Get country List
//        showCountryCodeFromList()
        // Get city list
        showCityNameFromList()
        self.txtPassword.setPasswordVisibility(vc: self, action: #selector(self.showHidePassword(_:)))
    }
    
    
    func setLocalization() {
        lblSignUP.text = "SignUpPage_lblSignUP".Localized()
        
        lblFirstNameTitle.text = "ProfileVC_lblFirstName".Localized()
        txtFirstName.placeholder = "SignUpPage_textFieldFirstName_place".Localized()
        
        lblLastNameTitle.text =  "ProfileVC_lblLastName".Localized()
        txtLastName.placeholder = "SignUpPage_textFieldLastName_place".Localized()
        
        lblEmailTitle.text = "LoginScreen_lblEmail".Localized()
        txtEmail.placeholder = "SignUpPage_textFieldEmail_place".Localized()

        lblCityNameTitle.text = "SignUpPage_lblCityName".Localized()
        txtCityName.placeholder = "SignUpPage_textFieldCityName".Localized()

        lblCountryCode.text = "SignUpPage_lblCountryCode".Localized()
        txtPhoneNumber.placeholder = "SignUpPage_textFieldPhoneNumbaer_place".Localized()
        
        lblPassword.text = "ProfileVC_lblPassword".Localized()
        txtPassword.placeholder = "SignUpPage_textFieldPassword_place".Localized()
        
        textView.delegate = self
        btnSignUP.setTitle("SignUpPage_btnSIgnUP".Localized(), for: .normal)
        
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

// MARK: - Validation & Api

extension RegisterVC{
    func validation()->Bool{
        var strTitle : String?
        let firstName = self.txtFirstName.validatedText(validationType: .username(field: self.txtFirstName.placeholder?.lowercased() ?? ""))
        let lastName = self.txtLastName.validatedText(validationType: .username(field: self.txtLastName.placeholder?.lowercased() ?? ""))
        let checkEmail = self.txtEmail.validatedText(validationType: .email)
//        let countryCode = self.txtCountryCode.validatedText(validationType: .requiredField(field: self.txtCountryCode.placeholder?.lowercased() ?? ""))
        let mobileNo = self.txtPhoneNumber.validatedText(validationType: .requiredField(field: self.txtPhoneNumber.placeholder?.lowercased() ?? ""))
        let password = self.txtPassword.validatedText(validationType: .password(field: self.txtPassword.placeholder?.lowercased() ?? ""))
        let cityName = self.txtCityName.validatedText(validationType: .requiredField(field: self.txtCityName.placeholder?.lowercased() ?? ""))

        if !firstName.0{
            strTitle = firstName.1
        } else if !lastName.0 {
            strTitle = lastName.1
        } else if !checkEmail.0 {
            strTitle = checkEmail.1
        } else if !cityName.0 {
            strTitle = cityName.1
        }else if !mobileNo.0 {
            strTitle = mobileNo.1
        } else if self.txtPhoneNumber.text?.count != 10 {
            strTitle = UrlConstant.ValidPhoneNo
        } else if !password.0 {
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
        finalRegisterReqModel.countryCode = Singleton.sharedInstance.CityList[cityNameSelectedIndex].countryCode
        finalRegisterReqModel.countryId =  Singleton.sharedInstance.CityList[cityNameSelectedIndex].countryId
        //Singleton.sharedInstance.CountryList[countryCodeSelectedIndex].id
        finalRegisterReqModel.cityId = Singleton.sharedInstance.CityList[cityNameSelectedIndex].id
        
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
        
        if URL.absoluteString == "privacypolicy" {
            print("Print termsAndConditions")
            controller.strUrl = Singleton.sharedInstance.termsConditionURL
            controller.strNavTitle = "SignUpPage_textViewText2".Localized().capitalized
        }
        else if URL.absoluteString == "termsandconditions" {
            print("Print termsAndConditions")
            controller.strUrl = Singleton.sharedInstance.termsConditionURL
            controller.strNavTitle = "SignUpPage_textViewText2".Localized().capitalized
        }
        
        
//        if (URL.absoluteString ==  "SignUpPage_textViewText2".Localized().replacingOccurrences(of: " ", with: "")) {
//            print("Print termsAndConditions")
//            controller.strUrl = Singleton.sharedInstance.termsConditionURL
//            controller.strNavTitle = "SignUpPage_textViewText2".Localized().capitalized
//        } else if (URL.absoluteString ==  "SignUpPage_textViewText4".Localized().replacingOccurrences(of: " ", with: "")) {
//            print("Print privacypolicy")
//            controller.strUrl = Singleton.sharedInstance.PrivacyUrl
//            controller.strNavTitle = "SignUpPage_textViewText4".Localized().capitalized
//        }
//
        self.navigationController?.pushViewController(controller, animated: true)
        return false
    }
}

//MARK:- TextField Delegate
extension RegisterVC: UITextFieldDelegate{
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
//        if textField == self.txtCountryCode {
//           showCountryCodeFromList()
//        }
        if textField == txtCityName {
            showCityNameFromList()
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == txtPhoneNumber || textField == txtFirstName || textField == txtLastName || textField == txtPassword{
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


// MARK: - Country Code/City Name
extension RegisterVC {
    
    func setUpListTextField(textField: UITextField) {
        
        let pickerView = pickerViewForCityName
        pickerView.tag = textField.tag
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.showsSelectionIndicator = true

        textField.tintColor = .white
        textField.delegate = self
        textField.inputView = pickerView
        
//        self.txtCityName.tintColor = .white
//        self.txtCityName.delegate = self
//        self.txtCityName.inputView = pickerView
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.barTintColor = .black
        toolBar.barTintColor = .white
        toolBar.tintColor = themeColor
        toolBar.sizeToFit()
        let done = UIBarButtonItem(title: "NavigationButton_btnDone".Localized(), style: .plain, target: self, action: #selector(doneAction))
        done.tag = textField.tag
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancel = UIBarButtonItem(title: "UrlConstant_Cancel".Localized(), style: .plain, target: self, action: #selector(cancelAction))
        cancel.tag = textField.tag
        toolBar.setItems([cancel,space,done], animated: false)
        
        textField.inputAccessoryView = toolBar
//        self.txtCityName.inputAccessoryView = toolBar
    }
    
    /// When pciker view for countrycode  list and city list closes
    /// - Parameter sender: Bar button item for picker view tol bar
    @objc func cancelAction(_ sender: UIBarButtonItem) {
        view.endEditing(true)
    }

    /// When pciker view for countrycode  list and city list closes
    /// - Parameter sender: Bar button item for picker view tol bar
    @objc func doneAction(_ sender: UIBarButtonItem) {
//        if sender.tag == RegisterListTextFieldTag.countryCode.rawValue {
//            countryCodeSelectedIndex = pickerViewForCountryCode.selectedRow(inComponent: 0)
//           showCountryCodeFromList()
//        } else {
            // City list
            cityNameSelectedIndex = pickerViewForCityName.selectedRow(inComponent: 0)
            showCityNameFromList()
//        }
        view.endEditing(true)
    }
    
//    func showCountryCodeFromList() {
//        print(#function)
//        if Singleton.sharedInstance.CountryList.count == 0 {
//            WebServiceSubClass.GetCountryList { [weak self] _, _, _, _ in
//                guard let self = self else {
//                    return
//                }
//                self.txtCountryCode.text = Singleton.sharedInstance.CountryList.count > 0 ? Singleton.sharedInstance.CountryList[self.countryCodeSelectedIndex].countryCode : ""
//            }
//        }else{
//            self.txtCountryCode.text = Singleton.sharedInstance.CountryList.count > 0 ? Singleton.sharedInstance.CountryList[countryCodeSelectedIndex].countryCode : ""
//        }
//    }
    
    func showCityNameFromList() {
        print(#function)
        if Singleton.sharedInstance.CityList.count == 0 {
            WebServiceSubClass.GetCityList { [weak self] _, _, _, _ in
                guard let self = self else {
                    return
                }
                self.txtCityName.text = Singleton.sharedInstance.CityList.count > 0 ? Singleton.sharedInstance.CityList[self.cityNameSelectedIndex].cityName : ""
                self.txtCountryCode.text = Singleton.sharedInstance.CityList.count > 0 ? Singleton.sharedInstance.CityList[self.cityNameSelectedIndex].countryCode : ""
            }
        }else{
            self.txtCityName.text = Singleton.sharedInstance.CityList.count > 0 ? Singleton.sharedInstance.CityList[self.cityNameSelectedIndex].cityName : ""
            self.txtCountryCode.text = Singleton.sharedInstance.CityList.count > 0 ? Singleton.sharedInstance.CityList[self.cityNameSelectedIndex].countryCode : ""
        }
    }
    
}
