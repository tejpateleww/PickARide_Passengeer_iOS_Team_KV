//
//  LoginViewModel.swift
//  PickARide User
//
//  Created by apple on 6/29/21.
//  Copyright © 2021 EWW071. All rights reserved.
//

import Foundation
import UIKit
class LoginUserModel{
    weak var loginVC : LoginVC? = nil
    
    func webserviceLogin(reqModel: LoginRequestModel){
        Utilities.showHud()
        WebServiceSubClass.LoginApi(reqModel: reqModel) { (status, apiMessage, response, error) in
            Utilities.hideHud()
            
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
                Toast.show(title: UrlConstant.Success, message: apiMessage, state: .success)
                appDel.navigateToMain()
            }else{
                Toast.show(title: UrlConstant.Failed, message: apiMessage, state: .failure)
            }
        }
    }
    
    func webserviceSocialLogin(reqModel: SocialLoginRequestModel){
        Utilities.showHud()
        
        WebServiceSubClass.SocialLoginApi(reqModel: reqModel) { (status, apiMessage, response, error) in
            Utilities.hideHud()
            
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
                
                Toast.show(title: UrlConstant.Success, message: apiMessage, state: .success)
                appDel.navigateToMain()
            }else{
                Toast.show(title: UrlConstant.Failed, message: apiMessage, state: .failure)
            }
        }
    }
}