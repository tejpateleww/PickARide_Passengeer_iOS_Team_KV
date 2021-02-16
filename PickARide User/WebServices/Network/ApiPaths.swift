//
//  ApiPaths.swift
//  Virtuwoof Pet
//
//  Created by EWW80 on 01/11/19.
//  Copyright © 2019 EWW80. All rights reserved.
//

import Foundation
import Alamofire
typealias NetworkRouterCompletion = ((Data?,[String:Any]?, Bool) -> ())
var userDefault = UserDefaults.standard
let kKey = "Movecoin@123*" // Before Login API

enum UserDefaultsKey : String {
    case userProfile = "userProfile"
    case isUserLogin = "isUserLogin"
    case X_API_KEY = "X_API_KEY"
    case DeviceToken = "DeviceToken"
    case selLanguage = "language"
}

enum APIEnvironment : String{
    
    case bu = "https://www.movecoins.net/admin/api/"//"http://admin.virtuwoof.com/Api/"
  
    
    static var baseURL: String{
        return APIEnvironment.environment.rawValue
    }
    
    static var environment: APIEnvironment{
        return .bu
        
    }
    
    static var headers : HTTPHeaders
    {

        if userDefault.object(forKey: UserDefaultsKey.isUserLogin.rawValue) != nil {

            if userDefault.object(forKey: UserDefaultsKey.isUserLogin.rawValue) as? Bool == true {

                if userDefault.object(forKey:  UserDefaultsKey.userProfile.rawValue) != nil {

                    do {
                        if UserDefaults.standard.value(forKey: UserDefaultsKey.isUserLogin.rawValue) != nil,UserDefaults.standard.value(forKey:  UserDefaultsKey.isUserLogin.rawValue) as! Bool
                        {
                            let decoded  = userDefault.object(forKey: UserDefaultsKey.userProfile.rawValue ) as! Data
                            let userdata = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! UserInfo
                            SingletonClass.sharedInstance.Api_Key = userdata.xApiKey

                        return ["X-API-KEY":SingletonClass.sharedInstance.Api_Key,"key": kKey]

                    }

                }
            }
        }

    }
        return ["key": kKey]
    }

}
enum ApiKey: String {
    case Init                  = "user/init/"
    case login                 = "user/login"
    case ForgotPassword        = "User_api/forgot_password"
    case changePassword        = "User_api/change_password"
    case register              = "User_api/register"
    case UpdateProfile         = "User_api/profile_update"
    case Logout                = "User_api/logout/"
    
    // HOME SCREEN API
    case PadsLibraryList       = "Pads_api/pads_library_list"
    case PadsList              = "Pads_api/pads_list"
    case Order                 = "Pads_api/order"
    case CreateSong            = "Pads_api/create_song"
}

