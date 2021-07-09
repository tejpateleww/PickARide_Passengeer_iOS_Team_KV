//
//  ProfileModel.swift
//  PickARide User
//
//  Created by apple on 7/8/21.
//  Copyright © 2021 EWW071. All rights reserved.
//

import Foundation

class ProfileReqModel: Encodable{
    var customerId: String? = Singleton.sharedInstance.UserId
    var firstName: String?
    var lastName: String?
    var birthDate: String?
    var gender: String?
    var address: String?
    
    enum CodingKeys: String, CodingKey {
        case customerId = "customer_id"
        case firstName = "first_name"
        case lastName = "last_name"
        case birthDate = "dob"
        case gender = "gender"
        case address = "address"
    }
}
