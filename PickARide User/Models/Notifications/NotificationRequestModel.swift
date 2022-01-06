//
//  NotificationRequestModel.swift
//  PickARide User
//
//  Created by Admin on 28/12/21.
//  Copyright © 2021 EWW071. All rights reserved.
//

import Foundation

//MARK: - Rides screen
class NotiificationRequestModel : Encodable{
    var customerID : String? = Singleton.sharedInstance.UserId
   
    enum CodingKeys: String, CodingKey {
        case customerID = "customer_id"
     }
}
