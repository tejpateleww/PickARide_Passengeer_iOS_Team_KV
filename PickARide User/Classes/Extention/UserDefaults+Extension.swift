//
//  UserDefaults+Extension.swift
//  PickARide User
//
//  Created by apple on 6/29/21.
//  Copyright © 2021 EWW071. All rights reserved.
//

import Foundation
extension UserDefaults{
    func set<T: Codable>(object: T, forKey: String) throws {
        
        let jsonData = try JSONEncoder().encode(object)
        
        set(jsonData, forKey: forKey)
    }
    
    
    func get<T: Codable>(objectType: T.Type, forKey: String) throws -> T? {
        
        guard let result = value(forKey: forKey) as? Data else {
            return nil
        }
        
        return try JSONDecoder().decode(objectType, from: result)
    }
    
    func setCountryData() {
        try? UserDefaults.standard.set(object: Singleton.sharedInstance.CountryList, forKey: UserDefaultsKey.countryList.rawValue)
    }
    
    func getCountryData() -> [CountryDetilsModel]? {
        let objResponse = try? UserDefaults.standard.get(objectType: [CountryDetilsModel].self, forKey:  UserDefaultsKey.countryList.rawValue)
        return objResponse ?? nil
    }
    
    func setUserData() {
        try? UserDefaults.standard.set(object:  Singleton.sharedInstance.UserProfilData, forKey: UserDefaultsKey.userProfile.rawValue)
    }
    
    func getUserData() -> LoginResponseModel? {
        let objResponse = try? UserDefaults.standard.get(objectType: LoginResponseModel.self, forKey:  UserDefaultsKey.userProfile.rawValue)
        return objResponse ?? nil
    }

}
