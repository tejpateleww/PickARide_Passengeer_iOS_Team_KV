//
//  NotificationResponseModel.swift
//  PickARide User
//
//  Created by Admin on 28/12/21.
//  Copyright © 2021 EWW071. All rights reserved.
//

import Foundation

// MARK: - RootNotification
class RootNotification: Codable {
    let status: Bool?
    let message: String?
    let data: [NotificationData]?

    init(status: Bool?, message: String?, data: [NotificationData]?) {
        self.status = status
        self.message = message
        self.data = data
    }
}


// MARK: - Datum
class NotificationData : Codable {
    let id: String?
    let userType: UserType?
    let userID, title, datumDescription, readStatusUser: String?
    let createdDate: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case userType = "user_type"
        case userID = "user_id"
        case title
        case datumDescription = "description"
        case readStatusUser = "read_status_user"
        case createdDate = "created_date"
    }

    init(id: String?, userType: UserType?, userID: String?, title: String?, datumDescription: String?, readStatusUser: String?, createdDate: String?) {
        self.id = id
        self.userType = userType
        self.userID = userID
        self.title = title
        self.datumDescription = datumDescription
        self.readStatusUser = readStatusUser
        self.createdDate = createdDate
    }
}

enum UserType: String, Codable {
    case customer = "customer"
}
