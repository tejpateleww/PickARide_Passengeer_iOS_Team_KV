//
//  ReviewRatingModel.swift
//  PickARide User
//
//  Created by Admin on 01/10/21.
//  Copyright © 2021 EWW071. All rights reserved.
//

import Foundation
import SwiftyJSON

//"booking_id:1
//rating:10
//comment:Nice"

//MARK:- Request Model
class ReviewRatingModel: Encodable{
    
    var booking_id : String?
    var rating : String?
    var comment : String?
    
    enum CodingKeys: String, CodingKey {
        case booking_id = "booking_id"
        case rating = "rating"
        case comment = "comment"
    }
}





class RootRating : Codable {

        let message : String?
        let status : Bool?
        let yourRating : Int?

        enum CodingKeys: String, CodingKey {
                case message = "message"
                case status = "status"
                case yourRating = "your_rating"
        }
    
           required init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                message = try values.decodeIfPresent(String.self, forKey: .message)
                status = try values.decodeIfPresent(Bool.self, forKey: .status)
                yourRating = try values.decodeIfPresent(Int.self, forKey: .yourRating)
        }

}
