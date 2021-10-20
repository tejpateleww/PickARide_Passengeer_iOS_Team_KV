//
//  PlacesResponseModel.swift
//  PickARide User
//
//  Created by Admin on 07/09/21.
//  Copyright © 2021 EWW071. All rights reserved.
//

import Foundation

class RootPlaces: Codable {
    
    let data : [PlaceData]?
    let message : String?
    let status : Bool?

    enum CodingKeys: String, CodingKey {
            case data = "data"
            case message = "message"
            case status = "status"
    }

      required init(from decoder: Decoder) throws {
            let values = try? decoder.container(keyedBy: CodingKeys.self)
        data = try? values?.decodeIfPresent([PlaceData].self, forKey: .data)
        message = try? values?.decodeIfPresent(String.self, forKey: .message)
        status = try? values?.decodeIfPresent(Bool.self, forKey: .status)
    }
}


class PlaceData : Codable {

        let createdAt : String?
        let customerId : String?
        let id : String?
        let lat : String?
        let lng : String?
        let location : String?
        let placeName : String?

        enum CodingKeys: String, CodingKey {
            case createdAt = "created_at"
            case customerId = "customer_id"
            case id = "id"
            case lat = "lat"
            case lng = "lng"
            case location = "location"
            case placeName = "place_name"
        }
    

    required init(from decoder: Decoder) throws {
            let values = try? decoder.container(keyedBy: CodingKeys.self)
        createdAt = try? values?.decodeIfPresent(String.self, forKey: .createdAt)
        customerId = try? values?.decodeIfPresent(String.self, forKey: .customerId)
        id = try? values?.decodeIfPresent(String.self, forKey: .id)
        lat = try? values?.decodeIfPresent(String.self, forKey: .lat)
        lng = try? values?.decodeIfPresent(String.self, forKey: .lng)
        location = try? values?.decodeIfPresent(String.self, forKey: .location)
        placeName = try? values?.decodeIfPresent(String.self, forKey: .placeName)
    }
//
    init?(customerId:String,CreatedAt:String,placename:String,placeid:String,Lat:String,Lng:String,Location:String) {
        self.customerId = customerId
        self.createdAt = CreatedAt
        self.placeName = placename
        self.id = placeid
        self.lat = Lat
        self.lng = Lng
        self.location = Location
    }
   
    
    
    

}
