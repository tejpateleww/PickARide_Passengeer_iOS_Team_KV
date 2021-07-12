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

    init(status: Bool, message: String, data: ProfileModel) {
        self.status = status
        self.message = message
        self.data = data
    }
}

// MARK: - DataClass
class ProfileModel: Codable {
    var id, companyID, firstName, lastName: String?
    var email, countryID, countryCode, mobileNo: String?
    var dob, gender, walletBalance, deviceType: String?
    var deviceToken, lat, lng, qrCode: String?
    var profileImage, socialID, socialType, rememberToken: String?
    var address, trash, status, referralCode: String?
    var createdAt, rating, xAPIKey: String?

    enum CodingKeys: String, CodingKey {
        case id
        case companyID = "company_id"
        case firstName = "first_name"
        case lastName = "last_name"
        case email
        case countryID = "country_id"
        case countryCode = "country_code"
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
    }

    init(id: String, companyID: String, firstName: String, lastName: String, email: String, countryID: String, countryCode: String, mobileNo: String, dob: String, gender: String, walletBalance: String, deviceType: String, deviceToken: String, lat: String, lng: String, qrCode: String, profileImage: String, socialID: String, socialType: String, rememberToken: String, address: String, trash: String, status: String, referralCode: String, createdAt: String, rating: String, xAPIKey: String) {
        self.id = id
        self.companyID = companyID
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.countryID = countryID
        self.countryCode = countryCode
        self.mobileNo = mobileNo
        self.dob = dob
        self.gender = gender
        self.walletBalance = walletBalance
        self.deviceType = deviceType
        self.deviceToken = deviceToken
        self.lat = lat
        self.lng = lng
        self.qrCode = qrCode
        self.profileImage = profileImage
        self.socialID = socialID
        self.socialType = socialType
        self.rememberToken = rememberToken
        self.address = address
        self.trash = trash
        self.status = status
        self.referralCode = referralCode
        self.createdAt = createdAt
        self.rating = rating
        self.xAPIKey = xAPIKey
    }
}

//MARK:- Apple User Model
class AppleUserDetailModel: Codable{
    
}
