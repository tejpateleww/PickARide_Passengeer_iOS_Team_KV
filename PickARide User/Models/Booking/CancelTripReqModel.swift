//
//  CancelTripReqModel.swift
//  PickARide User
//
//  Created by apple on 8/18/21.
//  Copyright © 2021 EWW071. All rights reserved.
//

import Foundation

class CancelTripReqModel : Encodable{
    var bookingId : String?
    var cancelReason : String?
    
    enum CodingKeys: String, CodingKey {
        case bookingId = "booking_id"
        case cancelReason = "cancel_reason"
    }
}
