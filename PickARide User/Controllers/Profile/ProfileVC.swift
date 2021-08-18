//
//  ProfileVC.swift
//  PickARide User
//
//  Created by baps on 17/12/20.
//  Copyright © 2020 EWW071. All rights reserved.
//

import UIKit

class ProfileVC: BaseViewController {
    
    @IBOutlet weak var imgProfile: ProfileView!
    @IBOutlet weak var btnProfile: UIButton!
    @IBOutlet weak var lblTitle: ProfileLabel!
    @IBOutlet weak var lblFirstName: ProfileLabel!
    @IBOutlet weak var txtFirstName: ProfileTextField!
    @IBOutlet weak var lblLastName: ProfileLabel!
    @IBOutlet weak var txtLastName: ProfileTextField!
    @IBOutlet weak var lblEmail: ProfileLabel!
    @IBOutlet weak var txtEmail: ProfileTextField!
    @IBOutlet weak var lblPhoneNumber: ProfileLabel!
    @IBOutlet weak var txtPhone: ProfileTextField!
    @IBOutlet weak var lblPassword: ProfileLabel!
    @IBOutlet weak var txtPassword: ProfileTextField!
    @IBOutlet weak var btnCamera: UIButton!
    @IBOutlet weak var btnSave: submitButton!
    @IBOutlet var textFieldCollection: [ProfileTextField]!
    @IBOutlet weak var btnPasword: UIButton!
    @IBOutlet weak var txtCountryCode: ProfileTextField!
    
    var currentEditStatus = false
    var imagePicker : ImagePicker?
    var selectedImage : UIImage?
    
    var pickerView = UIPickerView()
    var selectedIndexOfPicker = Int()
    var profileUserModel = ProfileUserModel()
    var authUser = Singleton.sharedInstance.UserProfilData
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupLocalization()
        self.setUpUI()
        navBtnProfile.isSelected = true
        self.makeEditableTrue(navBtnProfile)
        self.setUserProfileInfo()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarInViewController(controller: self, naviColor: colors.submitButtonColor.value, naviTitle: NavTitles.viewProfile.value, leftImage: NavItemsLeft.back.value, rightImages: [NavItemsRight.EditProfile.value], isTranslucent: true, CommonViewTitles: [], isTwoLabels: false)
        navBtnProfile.isSelected = !currentEditStatus
        navBtnProfile.addTarget(self, action: #selector(makeEditableTrue), for: .touchUpInside)
        self.makeEditableTrue(navBtnProfile)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.view.endEditing(true)
    }
    
    @IBAction func btnProfile(_ sender: Any) {
        self.view.endEditing(true)
        self.imagePicker?.present(from: self.imgProfile, image: self.imgProfile.image ?? UIImage())
    }
    
    @IBAction func btnEditProfileClicked(_ sender: Any) {
        appDel.navigateToMain()
    }
    
    @IBAction func btnPasswordClicked(_ sender: Any) {
        let controller = ChangePasswordVC.instantiate(fromAppStoryboard: .Login)
        controller.submitButtonText = "ChangePassword_btnChangePassword".Localized()
        controller.isChangePassword = true
        controller.btnSubmitClosure = {
            self.dismiss(animated: true, completion: nil)
        }
        controller.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        let navigationController = UINavigationController(rootViewController: controller)
        navigationController.modalPresentationStyle = .overCurrentContext
        navigationController.modalTransitionStyle = .crossDissolve
        navigationController.navigationBar.isHidden = true
        self.present(navigationController, animated: true, completion: nil)
    }
    
    @IBAction func btnSave(_ sender: Any) {
        if self.validation(){
            self.callUpdateProfileApi()
        }
    }
}

//MARK: Other Methods
extension ProfileVC{
    func setUpUI(){
        self.imgProfile.image = UserPlaceHolder
        self.imagePicker = ImagePicker(presentationController: self, delegate: self, allowsEditing: false)
        
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
        if Singleton.sharedInstance.CountryList.count == 0{
            WebServiceSubClass.GetCountryList {_, _, _, _ in}
        }else{
            self.txtCountryCode.text = Singleton.sharedInstance.CountryList[selectedIndexOfPicker].countryCode
        }
    }
    
    @objc func makeEditableTrue(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        
        let label = UILabel()
        label.text = sender.isSelected ? NavTitles.editProfile.value : NavTitles.viewProfile.value
        label.textColor = colors.loginPlaceHolderColor.value
        label.font = CustomFont.bold.returnFont(18)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        self.navigationItem.titleView = label
        
        self.currentEditStatus = sender.isSelected
        for i in textFieldCollection {
            i.isUserInteractionEnabled = sender.isSelected
        }
        self.btnPasword.isUserInteractionEnabled = sender.isSelected
        self.btnProfile.isUserInteractionEnabled = sender.isSelected
        self.btnCamera.isHidden = !sender.isSelected
        self.btnSave.isHidden = !sender.isSelected
        navBtnProfile.isHidden = sender.isSelected
    }
    
    func setupLocalization(){
        lblTitle.text = "ProfileVC_lblTitle".Localized()
        lblFirstName.text = "ProfileVC_lblFirstName".Localized()
        txtFirstName.placeholder = "ProfileVC_textFieldFirstName".Localized()
        lblLastName.text = "ProfileVC_lblLastName".Localized()
        txtLastName.placeholder = "ProfileVC_textFieldLastName".Localized()
        lblEmail.text = "ProfileVC_lblEmail".Localized()
        txtEmail.placeholder = "ProfileVC_textFieldEmail".Localized()
        lblPhoneNumber.text = "SignUpPage_lblCountryCode".Localized()
        txtPhone.placeholder = "ProfileVC_textFieldPhoneNumber".Localized()
        lblPassword.text = "ProfileVC_lblPassword".Localized()
        txtPassword.placeholder = "ProfileVC_textFieldPassword".Localized()
    }
    
    @objc func cancelAction(_ sender: UIBarButtonItem) {
        self.txtCountryCode.endEditing(true)
    }
    
    @objc func doneAction(_ sender: UIBarButtonItem) {
        self.txtCountryCode.text = Singleton.sharedInstance.CountryList[self.selectedIndexOfPicker].countryCode
        self.txtCountryCode.endEditing(true)
    }
    
    func setUserProfileInfo(){
        self.txtFirstName.text = self.authUser?.firstName?.capitalized
        self.txtLastName.text = self.authUser?.lastName?.capitalized
        self.txtEmail.text = self.authUser?.email ?? ""
        self.txtCountryCode.text = self.authUser?.countryCode ?? DefaultCouuntryCode
        self.txtPhone.text = self.authUser?.mobileNo ?? ""
        
    }
}

//MARK:- Validation & Api
extension ProfileVC{
    func validation()->Bool{
        var strTitle : String?
        let firstName = self.txtFirstName.validatedText(validationType: .username(field: self.txtFirstName.placeholder?.lowercased() ?? ""))
        let lastName = self.txtLastName.validatedText(validationType: .username(field: self.txtLastName.placeholder?.lowercased() ?? ""))
        let checkEmail = self.txtEmail.validatedText(validationType: .email)
        let mobileNo = self.txtPhone.validatedText(validationType: .requiredField(field: self.txtPhone.placeholder?.lowercased() ?? ""))
        
        if !firstName.0{
            strTitle = firstName.1
        }else if !lastName.0{
            strTitle = lastName.1
        }else if !checkEmail.0{
            strTitle = checkEmail.1
        }else if !mobileNo.0{
            strTitle = mobileNo.1
        }else if self.txtPhone.text?.count != 10 {
            strTitle = UrlConstant.ValidPhoneNo
        }
        
        if let str = strTitle{
            Toast.show(title: UrlConstant.Required, message: str, state: .failure)
            return false
        }
        
        return true
    }
    
    func callUpdateProfileApi(){
        self.profileUserModel.profileVC = self
        
        let reqModel = ProfileReqModel()
        reqModel.firstName = self.txtFirstName.text ?? ""
        reqModel.lastName = self.txtPassword.text ?? ""
        
        self.profileUserModel.webserviceProfile(reqModel: reqModel)
    }
}

//MARK:- TextView Delegate
extension ProfileVC: UITextFieldDelegate{
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == self.txtCountryCode{
            if Singleton.sharedInstance.CountryList.count == 0{
                WebServiceSubClass.GetCountryList {_, _, _, _ in}
                return false
            }
        }
        
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == txtPhone || textField == txtFirstName || textField == txtLastName{
            let currentString: NSString = textField.text as NSString? ?? ""
            let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
            return string == "" || newString.length <= ((textField == txtPhone) ? MAX_PHONE_DIGITS : TEXTFIELD_MaximumLimit)
        }
        
        return true
    }
}

extension ProfileVC: ImagePickerDelegate {
    
    func didSelect(image: UIImage?, button SelectedTag:Int) {
        if(image == nil && SelectedTag == 101){
            self.selectedImage = UIImage()
            self.imgProfile.image = UserPlaceHolder
        }else if let img = image{
            self.imgProfile.image = img
            self.selectedImage = self.imgProfile.image
        }else{
            return
        }
    }
}

//MARK:- Country Code Picker Set Up
extension ProfileVC : UIPickerViewDelegate, UIPickerViewDataSource {
    
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
