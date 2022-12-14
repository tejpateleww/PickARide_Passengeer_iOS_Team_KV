//
//  ProfileViewModel.swift
//  PickARide User
//
//  Created by apple on 7/8/21.
//  Copyright © 2021 EWW071. All rights reserved.


import Foundation
import UIKit

class ProfileUserModel{
    weak var profileVC : ProfileVC? = nil
    
    func webserviceProfile(reqModel: ProfileReqModel){
        Utilities.showHud()
        WebServiceSubClass.ProfileApi(reqModel: reqModel) { (status, apiMessage, response, error) in
            Utilities.hideHud()
            Toast.show(title: status ? UrlConstant.Success : UrlConstant.Failed, message: apiMessage, state: status ? .success : .failure)
            
            if status{
                if let obj = self.profileVC?.profileUpdateClosure{
                    obj()
                }
                
                self.profileVC?.makeEditableTrue(self.profileVC?.navBtnProfile ?? UIButton())
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
                NotificationCenter.default.post(name: NSNotification.Name("UpdateProfile"), object: nil)
                self.profileVC?.navigationController?.popToRootViewController(animated: true)
            }
        }
    }
}
    
