//
//  ChatResponseModel.swift
//  PickARide User
//
//  Created by Admin on 12/10/21.
//  Copyright © 2021 EWW071. All rights reserved.
//

import Foundation

class chatHistoryModel : Codable {
    
    let data : [chatHistoryData]?
    let message : String?
    let status : Bool?
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
        case message = "message"
        case status = "status"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent([chatHistoryData].self, forKey: .data)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
    }
    
}

class chatHistoryData : Codable {
    
    var bookingId : String?
    var createdAt : String?
    var id : String?
    var message : String?
    var receiverId : String?
    var receiverType : String?
    var senderId : String?
    var senderType : String?
    
    enum CodingKeys: String, CodingKey {
        case bookingId = "booking_id"
        case createdAt = "created_at"
        case id = "id"
        case message = "message"
        case receiverId = "receiver_id"
        case receiverType = "receiver_type"
        case senderId = "sender_id"
        case senderType = "sender_type"
    }
    
    init() {}
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        bookingId = try values.decodeIfPresent(String.self, forKey: .bookingId)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        receiverId = try values.decodeIfPresent(String.self, forKey: .receiverId)
        receiverType = try values.decodeIfPresent(String.self, forKey: .receiverType)
        senderId = try values.decodeIfPresent(String.self, forKey: .senderId)
        senderType = try values.decodeIfPresent(String.self, forKey: .senderType)
    }
    
}
