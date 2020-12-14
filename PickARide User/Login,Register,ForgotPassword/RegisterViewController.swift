//
//  RegisterViewController.swift
//  ApiStructureModule
//
//  Created by EWW071 on 14/03/20.
//  Copyright © 2020 EWW071. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    //MARK:- Outlet
    @IBOutlet weak var txtFirstName:customTextField!
    @IBOutlet weak var txtLastName:customTextField!
    @IBOutlet weak var txtEmail:customTextField!
    @IBOutlet weak var txtPassword:customTextField!
    @IBOutlet weak var txtConPassword:customTextField!
    @IBOutlet weak var btnSignUp:GradientButton!
    @IBOutlet weak var btnLogin:UIButton!
    @IBOutlet weak var lblOr:UILabel!
    //MARK:- Properties
    
    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        btnSignUp.setGradientView(topGradientColor: colors.gradient1.value, bottomGradientColor: colors.gradient2.value)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    //MARK:- SETUP
    func setUp(){
        btnLogin.setColorFont(color: .white, font: CustomFont.bold.returnFont(17))
        btnSignUp.setTitleColorFont(title: "Sign Up", color: .white, font: CustomFont.bold.returnFont(17))
        lblOr.setTitleColorFont(color: .white, font: CustomFont.regular.returnFont(17))
        btnLogin.setTextColor(str1: "Already have an Account?", str2: " Login", color1: .white, color2: colors.appColor.value)
        lblOr.text = "or"
        txtFirstName.delegate = self
        txtLastName.delegate = self
        txtEmail.delegate = self
        txtPassword.delegate = self
        txtConPassword.delegate = self
        
    }
    
    //MARK:- Button action
    @IBAction func btnSignUp(sender:Any){
        if(validation())
        {
            webserviceForRegister()
        }
    }
    
    @IBAction func btnBackLogin(sender:UIButton){
        self.navigationController?.popViewController(animated: true)//dismiss(animated: true, completion: nil)
    }
    @IBAction func btnFacebookSignUp(sender:UIButton){
        
    }
    @IBAction func btnGoogleSignUp(sender:UIButton){
        
    }
    
    //MARK :- Validation
    func validation() -> Bool
    {
        let firstName = txtFirstName.validatedText(validationType: .requiredField(field: txtFirstName.placeholder ?? ""))
        let lastName = txtLastName.validatedText(validationType: .requiredField(field: txtLastName.placeholder ?? ""))
        let checkEmail = txtEmail.validatedText(validationType: ValidatorType.email)
        let checkPassword = txtPassword.validatedText(validationType: ValidatorType.password)
        
        if(!firstName.0)
        {
            Utilities.displayAlert(firstName.1)
            return firstName.0
        }
        if(!lastName.0)
        {
            Utilities.displayAlert(lastName.1)
            return lastName.0
        }
        if(!checkEmail.0)
        {
            Utilities.displayAlert(checkEmail.1)
            return checkEmail.0
        }
        else  if(!checkPassword.0)
        {
            Utilities.displayAlert(checkPassword.1)
            return checkPassword.0
        }
        else if (txtPassword.text != txtConPassword.text)
        {
            Utilities.displayAlert("Password do not match")
            return checkPassword.0
        }
        return true
    }
    
    //MARK:- Webservice
    func webserviceForRegister()
    {
        guard let strFirstName = self.txtFirstName.text else {return}
        guard let strLastName = self.txtLastName.text else {return}
        guard let strEmail = self.txtEmail.text else {return}
        guard let strPassword = self.txtPassword.text else {return}
        let strDeviceToken = SingletonClass.sharedInstance.DeviceToken
        let strDeviceType = AppInfo.deviceType
        
        
        let register = RegisterReqModel(firstName: strFirstName, lastName: strLastName, email: strEmail, mobileNumber: "", deviceToken: strDeviceToken, deviceType: strDeviceType, password: strPassword)
      
        WebServiceSubClass.register(registerModel: register, showHud: true) { (json, status, response) in
            
            if(status)
            {
                UserDefaults.standard.set(true, forKey: UserDefaultsKey.isUserLogin.rawValue)
                let loginModelDetails = UserInfo.init(fromJson: json)
                UserDefaults.standard.set(loginModelDetails.xApiKey , forKey: UserDefaultsKey.X_API_KEY.rawValue)
                SingletonClass.sharedInstance.UserId = loginModelDetails.data.iD
                SingletonClass.sharedInstance.Api_Key = loginModelDetails.xApiKey
//                let encodedData = NSKeyedArchiver.archivedData(withRootObject: loginModelDetails)
                userDefault.set(loginModelDetails, forKey:  UserDefaultsKey.userProfile.rawValue)
                SingletonClass.sharedInstance.LoginRegisterUpdateData = loginModelDetails
                appDel.navigateToHomeScreen()
            }
            else
            {
                Utilities.displayErrorAlert(json["message"].string ?? "Something went wrong")
            }
        }
    }
    
}
extension RegisterViewController:UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        let newText = NSString(string: textField.text!).replacingCharacters(in: range, with: string)
        let numberOfChars = newText.count
        if textField.tag == 3 || textField.tag == 4{
            return numberOfChars < 15
        }else{
            return numberOfChars < 50
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
