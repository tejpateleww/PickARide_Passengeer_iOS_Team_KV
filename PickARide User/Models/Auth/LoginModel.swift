//
//  LoginModel.swift
//  PickARide User
//
//  Created by apple on 6/29/21.
//  Copyright © 2021 EWW071. All rights reserved.
//

import Foundation

//MARK:- Request Model
class LoginRequestModel: Encodable{
    var userName : String?
    var password : String?
    var deviceType : String? = Singleton.sharedInstance.DeviceType
    var deviceToken : String? = Singleton.sharedInstance.DeviceToken
    var latitude : String? = Singleton.sharedInstance.locationString().latitude
    var longitude : String? = Singleton.sharedInstance.locationString().longitude
    
    enum CodingKeys: String, CodingKey {
        case userName = "username"
        case password = "password"
        case deviceType = "device_type"
        case deviceToken = "device_token"
        case latitude = "lat"
        case longitude = "lng"
    }
}

//MARK:- Response Model
class LoginResponseModel: Codable{
    var status: Bool?
    var message: String?
    var data: ProfileModel?
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
        case message = "message"
        case status = "status"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try? values.decode(ProfileModel.self, forKey: .data)
        message = try? values.decode(String.self, forKey: .message)
        status = try? values.decode(Bool.self, forKey: .status)
    }
}

class AppleDetailsResponseModel: Codable{
    var status: Bool?
    var message: String?
    var data: AppleDetailsSubModel?

    enum CodingKeys: String, CodingKey {
        case data = "data"
        case message = "message"
        case status = "status"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try? values.decode(AppleDetailsSubModel.self, forKey: .data)
        message = try? values.decode(String.self, forKey: .message)
        status = try? values.decode(Bool.self, forKey: .status)
    }
}

class AppleDetailsSubModel: Codable{
    var id: String?
    var token: String?
    var email: String?
    var name: String?
    var date: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case token = "token"
        case email = "email"
        case name = "name"
        case date = "date"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try? values.decode(String.self, forKey: .id)
        token = try? values.decode(String.self, forKey: .token)
        email = try? values.decode(String.self, forKey: .email)
        name = try? values.decode(String.self, forKey: .name)
        date = try? values.decode(String.self, forKey: .date)
    }
}


// MARK: - DataClass
class ProfileModel: Codable {
    var id, companyID, firstName, lastName, dispatcherId: String?
    var email, countryID, cityId, cityName,countryCode, mobileNo: String?
    var dob, gender, walletBalance, deviceType: String?
    var deviceToken, lat, lng, qrCode: String?
    var profileImage, socialID, socialType, rememberToken: String?
    var address, trash, status, referralCode: String?
    var createdAt, rating, xAPIKey, currencySymbol: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case companyID = "company_id"
        case firstName = "first_name"
        case lastName = "last_name"
        case email
        case countryCode = "country_code"
        case cityId = "city_id"
        case countryID = "country_id"
        case cityName = "city_name"
        case mobileNo = "mobile_no"
        case dob, gender
        case walletBalance = "wallet_balance"
        case deviceType = "device_type"
        case deviceToken = "device_token"
        case lat, lng
        case qrCode = "qr_code"
        case profileImage = "profile_image"
        case socialID = "social_id"
        case socialType = "social_type"
        case rememberToken = "remember_token"
        case address, trash, status
        case referralCode = "referral_code"
        case createdAt = "created_at"
        case rating
        case xAPIKey = "x-api-key"
        case dispatcherId = "dispatcher_id"
        case currencySymbol = "currency_symbol"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        address = try? values.decode(String.self, forKey: .address)
        companyID = try? values.decode(String.self, forKey: .companyID)
        countryCode = try? values.decode(String.self, forKey: .countryCode)
        countryID = try? values.decode(String.self, forKey: .countryID)
        cityId = try? values.decode(String.self, forKey: .cityId)
        cityName = try? values.decode(String.self, forKey: .cityName)
        createdAt = try? values.decode(String.self, forKey: .createdAt)
        deviceToken = try? values.decode(String.self, forKey: .deviceToken)
        deviceType = try? values.decode(String.self, forKey: .deviceType)
        dob = try? values.decode(String.self, forKey: .dob)
        email = try? values.decode(String.self, forKey: .email)
        firstName = try? values.decode(String.self, forKey: .firstName)
        gender = try? values.decode(String.self, forKey: .gender)
        id = try? values.decode(String.self, forKey: .id)
        lastName = try? values.decode(String.self, forKey: .lastName)
        lat = try? values.decode(String.self, forKey: .lat)
        lng = try? values.decode(String.self, forKey: .lng)
        mobileNo = try? values.decode(String.self, forKey: .mobileNo)
        profileImage = try? values.decode(String.self, forKey: .profileImage)
        qrCode = try? values.decode(String.self, forKey: .qrCode)
        rating = try? values.decode(String.self, forKey: .rating)
        referralCode = try? values.decode(String.self, forKey: .referralCode)
        rememberToken = try? values.decode(String.self, forKey: .rememberToken)
        socialID = try? values.decode(String.self, forKey: .socialID)
        socialType = try? values.decode(String.self, forKey: .socialType)
        status = try? values.decode(String.self, forKey: .status)
        trash = try? values.decode(String.self, forKey: .trash)
        walletBalance = try? values.decode(String.self, forKey: .walletBalance)
        xAPIKey = try? values.decode(String.self, forKey: .xAPIKey)
        dispatcherId = try? values.decode(String.self, forKey: .dispatcherId)
        currencySymbol = try? values.decode(String.self, forKey: .currencySymbol)
    }
    
}

//MARK:- Apple User Model
class AppleUserDetailModel: Codable{
    
}
