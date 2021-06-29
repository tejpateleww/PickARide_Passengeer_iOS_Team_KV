//
//  WebServicesSubclass.swift
//  Danfo_Rider
//
//  Created by Hiral Jotaniya on 04/06/21.
//

import Foundation
class WebServiceSubClass{

//    class func InitApi(keyPath : String , completion: @escaping (Bool,String,ResposneInitClass?,Any) -> ()) {
//        URLSessionRequestManager.makeGetRequest(urlString: keyPath, responseModel: ResposneInitClass.self) { (status, response, error) in
//            completion(status, response, error)
//        }
//    }
    
    class func GetCountryList(completion: @escaping (Bool,String,CountryListModel?,Any) -> ()){
        URLSessionRequestManager.makeGetRequest(urlString: ApiKey.getCountryList.rawValue, responseModel: CountryListModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    class func LoginApi(reqModel: LoginRequestModel, completion: @escaping (Bool,String,LoginResponseModel?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.login.rawValue, requestModel: reqModel, responseModel: LoginResponseModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    class func OTPRequestApi(reqModel : OTPRequestModel , completion: @escaping (Bool,String,OTPResponseModel?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.registerOTP.rawValue, requestModel: reqModel, responseModel: OTPResponseModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    class func RegisterApi(reqModel : RegisterRequestModel , completion: @escaping (Bool,String,LoginResponseModel?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.register.rawValue, requestModel: reqModel, responseModel: LoginResponseModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    class func SocialLoginApi(reqModel : SocialLoginRequestModel , completion: @escaping (Bool,String,LoginResponseModel?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.socialLogin.rawValue, requestModel: reqModel, responseModel: LoginResponseModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
}
