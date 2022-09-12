//
//  CancelTripReqModel.swift
//  PickARide User
//
//  Created by apple on 8/18/21.
//  Copyright © 2021 EWW071. All rights reserved.
//

import Foundation

class BlankRequestModel: Encodable {
    
}

class CancelTripReqModel : Encodable{
    var bookingId : String?
    var cancelReason : String?
    
    enum CodingKeys: String, CodingKey {
        case bookingId = "booking_id"
        case cancelReason = "cancel_reason"
    }
}


class AddPlacesReqModel : Encodable {
    var customerId : String? 
    var placeName : String?
    var location : String?
    var lat : Double?
    var lng : Double?
    var cityName: String?
    
    enum CodingKeys : String, CodingKey {
        case customerId = "customer_id"
        case placeName = "place_name"
        case location = "location"
        case lat = "lat"
        case lng = "lng"
        case cityName = "city_name"
    }
}
