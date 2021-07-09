//
//  Singleton.swift
//  Virtuwoof Pet
//
//  Created by EWW80 on 09/11/19.
//  Copyright © 2019 EWW80. All rights reserved.
//

import Foundation
import CoreLocation

class Singleton: NSObject{
    static let sharedInstance = Singleton()
    
    var UserId = String()
    
    //Objects
    var AppInitModel : InitResponseModel?
    var UserProfilData : ProfileModel?
    var CountryList = [CountryDetilsModel]()
    var CardList = [CardDetailModel]()
    
    var Api_Key = String()
    var DeviceType : String = "ios"
    var DeviceToken : String = ""
    
    //MARK:- User' Custom Details
    var userCurrentLocation : CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
  
    func locationString() -> (latitude: String, longitude: String){
        return (String(format: "%4d", userCurrentLocation.latitude), String(format: "%4d", userCurrentLocation.longitude))
    }
    
    var arrFutureYears:[String] {
        get {
            let calendar = Calendar.current
            let currentYear = calendar.component(.year, from: Date())
            return (currentYear...(currentYear + 11)).map { String($0)}
        }
    }
    
    func clearSingletonClass() {
        Singleton.sharedInstance.UserId = ""
        Singleton.sharedInstance.UserProfilData = nil
        Singleton.sharedInstance.Api_Key = ""
    }
}

