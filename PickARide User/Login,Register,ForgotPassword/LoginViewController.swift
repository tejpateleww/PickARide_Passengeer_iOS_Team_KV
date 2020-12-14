//
//  LoginViewController.swift
//  ApiStructureModule
//
//  Created by EWW071 on 14/03/20.
//  Copyright © 2020 EWW071. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var txtEmail : UITextField!
    @IBOutlet weak var txtPassword : UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let loginModel = LoginReqModel(email: "rahul.bbit@gmail.com", password: "12345678", deviceToken: SingletonClass.sharedInstance.DeviceToken, deviceName: "", deviceType: "iOS",Latitude: "0",Longitude: "0",language: "1")
        webserviceForlogin(loginData: loginModel)
        
    }
    
   //MARK:- Webservice
    func webserviceForlogin(loginData : LoginReqModel)
    {

        WebServiceSubClass.login(loginModel: loginData, showHud: true) { (json, status, response) in
           
            if(status)
            {
                UserDefaults.standard.set(true, forKey: UserDefaultsKey.isUserLogin.rawValue)
                
                let loginModelDetails = UserInfo.init(fromJson: json)
                UserDefaults.standard.set(loginModelDetails.xApiKey , forKey: UserDefaultsKey.X_API_KEY.rawValue)
                
                SingletonClass.sharedInstance.UserId = loginModelDetails.data.iD
                SingletonClass.sharedInstance.Api_Key = loginModelDetails.xApiKey
                let encodedData = NSKeyedArchiver.archivedData(withRootObject: loginModelDetails)
                userDefault.set(encodedData, forKey:  UserDefaultsKey.userProfile.rawValue)
                userDefault.synchronize()
                SingletonClass.sharedInstance.LoginRegisterUpdateData = loginModelDetails
                appDel.navigateToHomeScreen()
            }
            else
            {
                Utilities.displayErrorAlert(json["message"].string ?? "Something went wrong")
            }
        }
    }
    

    
    func webserviceForForgotPassword(strEmail : String)
    {
        
        WebServiceSubClass.ForgotPassword(email: strEmail, showHud: true) { (json, status, response) in
            if(status)
            {
                let msg = json["message"].stringValue
                // create the alert
                let alert = UIAlertController(title: AppInfo.appName, message: msg, preferredStyle: UIAlertController.Style.alert)
                
                
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (Action) in
                    self.dismiss(animated: true, completion: nil)
                }))
                
                
                // show the alert
                self.present(alert, animated: true, completion: nil)
            }
            else
            {
                Utilities.displayErrorAlert(json["message"].string ?? "Something went wrong")
            }
        }
    }
    
    
    //MARK:- Validation
    func validation() -> Bool
    {
        let checkEmail = txtEmail.validatedText(validationType: ValidatorType.email)
        let checkPassword = txtPassword.validatedText(validationType: ValidatorType.password)
        
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
        
        return true
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
