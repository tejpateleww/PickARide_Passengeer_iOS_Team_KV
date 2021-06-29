//
//  LoginViewModel.swift
//  PickARide User
//
//  Created by apple on 6/29/21.
//  Copyright © 2021 EWW071. All rights reserved.
//

import Foundation
class LoginUserModel{
    weak var loginVC : LoginVC? = nil
    
    func webserviceLogin(reqModel: LoginRequestModel){
        
        Utilities.showHud()
        WebServiceSubClass.LoginApi(reqModel: reqModel){ (status, response, error) in
            Utilities.hideHud()
            user_defaults.setValue(true, forKey: UserDefaultsKey.isUserLogin.rawValue)
            appDel.navigateToMain()
        }
    }
}
