//
//  NearByDrivers.swift
//  PickARide User
//
//  Created by Admin on 29/09/21.
//  Copyright © 2021 EWW071. All rights reserved.
//

import Foundation
import SwiftyJSON


class RootNearByDrivers : Codable{

    var drivers : [Driver]!

    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        drivers = [Driver]()
        let driversArray = json["drivers"].arrayValue
        for driversJson in driversArray{
            let value = Driver(fromJson: driversJson)
            drivers.append(value)
        }
    }
}


class Driver : Codable{

    var id : String!
    var busy : Int!
    var createdAt : String!
    var driverId : Int!
    var location : [String]!
    var start : Int!
    var status : Int!
    var updatedTime : Int!
    var vehicleTypeId : [String]!

    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        id = json["_id"].stringValue
        busy = json["busy"].intValue
        createdAt = json["created_at"].stringValue
        driverId = json["driver_id"].intValue
        location = [String]()
        let locationArray = json["location"].arrayValue
        for locationJson in locationArray{
            location.append(locationJson.stringValue)
        }
        start = json["start"].intValue
        status = json["status"].intValue
        updatedTime = json["updated_time"].intValue
        vehicleTypeId = [String]()
        let vehicleTypeIdArray = json["vehicle_type_id"].arrayValue
        for vehicleTypeIdJson in vehicleTypeIdArray{
            vehicleTypeId.append(vehicleTypeIdJson.stringValue)
        }
    }

  
}
