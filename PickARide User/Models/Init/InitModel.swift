//
//  InitResponseModel.swift
//  PickARide User
//
//  Created by apple on 7/7/21.
//  Copyright © 2021 EWW071. All rights reserved.
//

import Foundation
class InitResponseModel: Codable {
    let status: Bool?

    init(status: Bool) {
        self.status = status
    }
}



class RootInit : Codable {

        let appLinks : [AppLink]?
        let locationCriteria : String?
        let status : Bool?

        enum CodingKeys: String, CodingKey {
                case appLinks = "app_links"
                case locationCriteria = "location_criteria"
                case status = "status"
        }
    
    required init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                appLinks = try values.decodeIfPresent([AppLink].self, forKey: .appLinks)
                locationCriteria = try values.decodeIfPresent(String.self, forKey: .locationCriteria)
                status = try values.decodeIfPresent(Bool.self, forKey: .status)
        }

}


class AppLink : Codable {

        let name : String?
        let showName : String?
        let url : String?

        enum CodingKeys: String, CodingKey {
                case name = "name"
                case showName = "show_name"
                case url = "url"
        }
    
    required init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                name = try values.decodeIfPresent(String.self, forKey: .name)
                showName = try values.decodeIfPresent(String.self, forKey: .showName)
                url = try values.decodeIfPresent(String.self, forKey: .url)
        }

}
