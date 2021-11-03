//
//  EstimateFare.swift
//  PickARide User
//
//  Created by Admin on 16/09/21.
//  Copyright © 2021 EWW071. All rights reserved.
//

import Foundation
import SwiftyJSON



class RootDrivers : Codable{

    var estimateFare : [EstimateFare]!
    var status : Bool!

    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        estimateFare = [EstimateFare]()
        let estimateFareArray = json["estimate_fare"].arrayValue
        for estimateFareJson in estimateFareArray{
            let value = EstimateFare(fromJson: estimateFareJson)
            estimateFare.append(value)
        }
        status = json["status"].boolValue
    }

}


//class RootDrivers : Codable {
//
//        let estimateFare : [EstimateFare]?
//        let status : Bool?
//
//        enum CodingKeys: String, CodingKey {
//                case estimateFare = "estimate_fare"
//                case status = "status"
//        }
//
//    required init(from decoder: Decoder) throws {
//                let values = try decoder.container(keyedBy: CodingKeys.self)
//                estimateFare = try values.decodeIfPresent([EstimateFare].self, forKey: .estimateFare)
//                status = try values.decodeIfPresent(Bool.self, forKey: .status)
//        }
//
//}
//
//
//class EstimateFare : Codable {
//
//        let capacity : String?
//        let distance : Float?
//        let driverReachInMinute : Int?
//        let durationInMinute : Int?
//        let durationInSecond : Int?
//        let estimateTripFare : Float?
//        let image : String?
//        let vehicleTypeId : String?
//        let vehicleTypeName : String?
//
//        enum CodingKeys: String, CodingKey {
//                case capacity = "capacity"
//                case distance = "distance"
//                case driverReachInMinute = "driver_reach_in_minute"
//                case durationInMinute = "duration_in_minute"
//                case durationInSecond = "duration_in_second"
//                case estimateTripFare = "estimate_trip_fare"
//                case image = "image"
//                case vehicleTypeId = "vehicle_type_id"
//                case vehicleTypeName = "vehicle_type_name"
//        }
//
//    required init(from decoder: Decoder) throws {
//                let values = try? decoder.container(keyedBy: CodingKeys.self)
//        capacity = try? values?.decodeIfPresent(String.self, forKey: .capacity)
//        distance = try? values?.decodeIfPresent(Float.self, forKey: .distance)
//        driverReachInMinute = try? values?.decodeIfPresent(Int.self, forKey: .driverReachInMinute)
//        durationInMinute = try? values?.decodeIfPresent(Int.self, forKey: .durationInMinute)
//        durationInSecond = try values?.decodeIfPresent(Int.self, forKey: .durationInSecond)
//        estimateTripFare = try values?.decodeIfPresent(Float.self, forKey: .estimateTripFare)
//        image = try values?.decodeIfPresent(String.self, forKey: .image)
//        vehicleTypeId = try values?.decodeIfPresent(String.self, forKey: .vehicleTypeId)
//        vehicleTypeName = try values?.decodeIfPresent(String.self, forKey: .vehicleTypeName)
//        }
//
//}

class EstimateFare : Codable{

    var capacity : String!
    var distance : Float!
    var driverReachInMinute : Int!
    var durationInMinute : Int!
    var durationInSecond : Int!
    var estimateTripFare : Float!
    var image : String!
    var vehicleTypeId : String!
    var vehicleTypeName : String!
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        capacity = json["capacity"].stringValue
        distance = json["distance"].floatValue
        driverReachInMinute = json["driver_reach_in_minute"].intValue
        durationInMinute = json["duration_in_minute"].intValue
        durationInSecond = json["duration_in_second"].intValue
        estimateTripFare = json["estimate_trip_fare"].floatValue
        image = json["image"].stringValue
        vehicleTypeId = json["vehicle_type_id"].stringValue
        vehicleTypeName = json["vehicle_type_name"].stringValue
    }

   
}
