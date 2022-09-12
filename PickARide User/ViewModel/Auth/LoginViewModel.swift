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
//        Utilities.showHud()
        WebServiceSubClass.LoginApi(reqModel: reqModel) { (status, apiMessage, response, error) in
//            Utilities.hideHud()
            Toast.show(title: status ? UrlConstant.Success : UrlConstant.Failed, message: apiMessage, state: status ? .success : .failure)
            if status{
                userDefaults.setValue(true, forKey: UserDefaultsKey.isUserLogin.rawValue)
                userDefaults.setValue(response?.data?.xAPIKey, forKey: UserDefaultsKey.X_API_KEY.rawValue)
                
                Singleton.sharedInstance.UserProfilData = response?.data
                userDefaults.setUserData()
                
                if let apikey = response?.data?.xAPIKey {
                    Singleton.sharedInstance.Api_Key = apikey
                    userDefaults.setValue(apikey, forKey: UserDefaultsKey.X_API_KEY.rawValue)
                }
                
                if let userID = response?.data?.id {
                    Singleton.sharedInstance.UserId = userID
                }
                
                appDel.navigateToMain()
                
            }else{
            }
        }
    }
    
    func webserviceSocialLogin(reqModel: SocialLoginRequestModel){
        Utilities.showHud()
        
        WebServiceSubClass.SocialLoginApi(reqModel: reqModel) { [weak self] (status, apiMessage, response, error) in
            guard let self = self else {
                return
            }
            Utilities.hideHud()
            if !status{
                Toast.show(title: status ? UrlConstant.Success : UrlConstant.Failed, message: apiMessage, state: status ? .success : .failure)
            }else{
                self.savePreferrences(response: response)

                let cityId = response?.data?.cityId ?? ""
                let cityName = response?.data?.cityName ?? ""
                if cityId.isEmptyOrWhitespace() || cityName.isEmptyOrWhitespace() {
                    self.loginVC?.showCityList()
                } else {
                    appDel.navigateToMain()
                }
            }
        }
    }
    
    func webserviceSocialUpdate(reqModel: SocialUpdateRequestModel) {
        Utilities.showHud()
        
        WebServiceSubClass.SocialUpdateApi(reqModel: reqModel) { [weak self] (status, apiMessage, response, error) in
            guard let self = self else {
                return
            }
            Utilities.hideHud()
            if !status{
                Toast.show(title: status ? UrlConstant.Success : UrlConstant.Failed, message: apiMessage, state: status ? .success : .failure)
            }else{
                self.savePreferrences(response: response)
                appDel.navigateToMain()
            }
        }
    }
    
    func savePreferrences(response: LoginResponseModel?) {
        userDefaults.setValue(true, forKey: UserDefaultsKey.isUserLogin.rawValue)
        userDefaults.setValue(response?.data?.xAPIKey, forKey: UserDefaultsKey.X_API_KEY.rawValue)
        
        Singleton.sharedInstance.UserProfilData = response?.data
        userDefaults.setUserData()
        
        if let apikey = response?.data?.xAPIKey {
            Singleton.sharedInstance.Api_Key = apikey
            userDefaults.setValue(apikey, forKey: UserDefaultsKey.X_API_KEY.rawValue)
        }
        
        if let userID = response?.data?.id {
            Singleton.sharedInstance.UserId = userID
        }
    }

    
    func webserviceAppleDetails(reqModel: AppleDetailsRequestModel){
        Utilities.showHud()
        
        WebServiceSubClass.AppleDetailsApi(reqModel: reqModel) { (status, apiMessage, response, error) in
            Utilities.hideHud()
            if !status{
                //Toast.show(title: status ? UrlConstant.Success : UrlConstant.Failed, message: apiMessage, state: status ? .success : .failure)
                Utilities.ShowAlert(OfMessage: apiMessage)
            }else{

                let reqModel = SocialLoginRequestModel()
                reqModel.socialId = response?.data?.id ?? ""
                reqModel.socialType = SocialType.Apple.rawValue
                let nameArray = (response?.data?.name ?? "").components(separatedBy: " ")
                let fName = nameArray.first ?? ""
                let lName = nameArray.count > 1 ? nameArray[1] : ""
                reqModel.firstName = fName
                reqModel.lastName = lName
                reqModel.email = response?.data?.email ?? ""
                reqModel.userName = response?.data?.email ?? ""

                self.webserviceSocialLogin(reqModel: reqModel)
            }
        }
    }
}
