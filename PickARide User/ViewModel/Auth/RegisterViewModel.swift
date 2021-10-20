//
//  RegisterViewModel.swift
//  PickARide User
//
//  Created by apple on 7/8/21.
//  Copyright © 2021 EWW071. All rights reserved.
//

import Foundation
import UIKit

class RegisterUserModel{
    
    weak var registerVc : RegisterVC? = nil
    weak var otpVC : OtpVC? = nil
    var isFromOtp = false
    weak var VerifyVc : VerifyVC? = nil
    var registerReqModel = RegisterRequestModel()
    
    func webserviceOTP(reqModel: OTPRequestModel){
        Utilities.showHud()
        WebServiceSubClass.OTPRequestApi(reqModel: reqModel) { (status, apiMessage, response, error) in
            Utilities.hideHud()
            Toast.show(title: status ? UrlConstant.Success : UrlConstant.Failed, message: apiMessage, state: status ? .success : .failure)
            
            if status{
                if self.isFromOtp == true {
                    self.otpVC?.StringOTP = String(format: "%d", response?.otp ?? 0)
                }
                else {
                    
                    let controller = OtpVC.instantiate(fromAppStoryboard: .Login)
                    controller.isFrmRegister = true
                    controller.StringOTP = String(format: "%d", response?.otp ?? 0)
                    controller.registerReqModel = self.registerReqModel
                    self.registerVc?.navigationController?.pushViewController(controller, animated: true)
                }
             
            }
        }
    }
}

class OTPUserModel{
    weak var otpVC : OtpVC? = nil
    
    func webserviceFinalRegister(reqModel: RegisterRequestModel){
        Utilities.showHud()
        WebServiceSubClass.RegisterApi(reqModel: reqModel) { (status, apiMessage, response, error) in
            Utilities.hideHud()
            Toast.show(title: status ? UrlConstant.Success : UrlConstant.Failed, message: apiMessage, state: status ? .success : .failure)
            
            if status{
                userDefaults.setValue(true, forKey: UserDefaultsKey.isUserLogin.rawValue)
                userDefaults.setValue(response?.data?.xAPIKey, forKey: UserDefaultsKey.X_API_KEY.rawValue)
                
                Singleton.sharedInstance.UserProfilData = response?.data
                userDefaults.setUserData()
                
                if let apikey = response?.data?.xAPIKey{
                    Singleton.sharedInstance.Api_Key = apikey
                    userDefaults.setValue(apikey, forKey: UserDefaultsKey.X_API_KEY.rawValue)
                }
                
                if let userID = response?.data?.id{
                    Singleton.sharedInstance.UserId = userID
                }
                
                appDel.navigateToMain()
            }
        }
    }
}
