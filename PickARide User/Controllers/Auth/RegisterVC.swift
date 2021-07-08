//
//  RegisterViewController.swift
//  ApiStructureModule
//
//  Created by EWW071 on 14/03/20.
//  Copyright © 2020 EWW071. All rights reserved.
//

import UIKit

class RegisterVC: BaseViewController {
    
    //MARK: -Properties
    
    //MARK: -IBOutlets
    @IBOutlet weak var lblSignUP: registerScreenLabel!
    @IBOutlet weak var textFieldFirstName: UITextField!
    @IBOutlet weak var textFieldLastName: UITextField!
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var lblCountryCode: registerScreenLabel!
    @IBOutlet weak var textFieldPhoneNumber: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var btnSignUP: submitButton!
    @IBOutlet weak var txtCountryCode: customTextField!
    
    var pickerView = UIPickerView()
    var selectedIndexOfPicker = Int()
    
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
        let controller = OtpVC.instantiate(fromAppStoryboard: .Login)
        controller.isFrmRegister = true
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

//MARK: Other methods
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
        self.textFieldPassword.setPasswordVisibility(vc: self, action: #selector(self.showHidePassword(_:)))
    }
    
    func setLocalization() {
        lblSignUP.text = "SignUpPage_lblSignUP".Localized()
        textFieldFirstName.placeholder = "SignUpPage_textFieldFirstName_place".Localized()
        textFieldLastName.placeholder = "SignUpPage_textFieldLastName_place".Localized()
        textFieldEmail.placeholder = "SignUpPage_textFieldEmail_place".Localized()
        lblCountryCode.text = "SignUpPage_lblCountryCode".Localized()
        textFieldPhoneNumber.placeholder = "SignUpPage_textFieldPhoneNumbaer_place".Localized()
        textFieldPassword.placeholder = "SignUpPage_textFieldPassword_place".Localized()
        textView.delegate = self
        btnSignUP.setTitle("SignUpPage_btnSIgnUP".Localized(), for: .normal)
    }
    
    @objc func showHidePassword(_ sender : UIButton) {
        sender.isSelected = !sender.isSelected
        self.textFieldPassword.isSecureTextEntry = sender.isSelected
    }
    
    @objc func cancelAction(_ sender: UIBarButtonItem) {
        self.txtCountryCode.endEditing(true)
    }
    
    @objc func doneAction(_ sender: UIBarButtonItem) {
        self.txtCountryCode.text = Singleton.sharedInstance.CountryList[self.selectedIndexOfPicker].countryCode
        self.txtCountryCode.endEditing(true)
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
