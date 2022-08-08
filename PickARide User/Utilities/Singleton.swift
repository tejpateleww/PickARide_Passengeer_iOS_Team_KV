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
    var AppInitModel : RootInit?
    var UserProfilData : ProfileModel?
    var CountryList = [CountryDetilsModel]()
    var CityList = [CityDetailsModel]()
    var CardList = [CardDetailModel]()
    var latitute = Double()
    var longtitute = Double()
    var PrivacyUrl = String()
    var HelpUrl = String()
    var termsConditionURL = String()
    var Api_Key = String()
    var DeviceType : String = "ios"
    var DeviceToken : String = ""
    var selectedTaxiId = String()
    
    //MARK:- User' Custom Details
    var userCurrentLocation : CLLocationCoordinate2D?
  
    
    func locationString() -> (latitude: String, longitude: String){
        return (String(format: "%4d", userCurrentLocation?.latitude ?? 0.0), String(format: "%4d", userCurrentLocation?.longitude ?? 0.0))
    }
    
    var arrFutureYears:[String] {
        get {
            let calendar = Calendar.current
            let currentYear = calendar.component(.year, from: Date())
            return (currentYear...(currentYear + 11)).map { String($0)}
        }
    }
    
    //MARK:- ====== Clear Singltones ======
    func clearSingletonClass() {
        Singleton.sharedInstance.UserId = ""
        Singleton.sharedInstance.UserProfilData = nil
        Singleton.sharedInstance.Api_Key = ""
        Singleton.sharedInstance.CardList = []
    }
}

