//
//  PromoCodeModel.swift
//  PickARide User
//
//  Created by apple on 8/18/21.
//  Copyright © 2021 EWW071. All rights reserved.
//

import Foundation

//MARK:- Check Promo Request Model
class CheckPromoReqModel: Encodable{
    var promocode : String?
    
    enum CodingKeys: String, CodingKey {
        case promocode
    }
}

//MARK:- Promo Code Response Model
class PromoCodeListModel : Codable {
    let data : [PromoDetailsModel]?
    let message : String?
    let status : Bool?
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
        case message = "message"
        case status = "status"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try? decoder.container(keyedBy: CodingKeys.self)
        data = try? values?.decodeIfPresent([PromoDetailsModel].self, forKey: .data)
        message = try? values?.decodeIfPresent(String.self, forKey: .message)
        status = try? values?.decodeIfPresent(Bool.self, forKey: .status)
    }
    
}

class PromoDetailsModel : Codable {
    
    let createdAt : String?
    let discountType : String?
    let discountValue : String?
    let endDate : String?
    let id : String?
    let promocode : String?
    let promocodeMaxDiscount : String?
    let promocodeUseLimit : String?
    let startDate : String?
    let status : String?
    let trash : String?
    
    enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
        case discountType = "discount_type"
        case discountValue = "discount_value"
        case endDate = "end_date"
        case id = "id"
        case promocode = "promocode"
        case promocodeMaxDiscount = "promocode_max_discount"
        case promocodeUseLimit = "promocode_use_limit"
        case startDate = "start_date"
        case status = "status"
        case trash = "trash"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try? decoder.container(keyedBy: CodingKeys.self)
        createdAt = try? values?.decodeIfPresent(String.self, forKey: .createdAt)
        discountType = try? values?.decodeIfPresent(String.self, forKey: .discountType)
        discountValue = try? values?.decodeIfPresent(String.self, forKey: .discountValue)
        endDate = try? values?.decodeIfPresent(String.self, forKey: .endDate)
        id = try? values?.decodeIfPresent(String.self, forKey: .id)
        promocode = try? values?.decodeIfPresent(String.self, forKey: .promocode)
        promocodeMaxDiscount = try? values?.decodeIfPresent(String.self, forKey: .promocodeMaxDiscount)
        promocodeUseLimit = try? values?.decodeIfPresent(String.self, forKey: .promocodeUseLimit)
        startDate = try? values?.decodeIfPresent(String.self, forKey: .startDate)
        status = try? values?.decodeIfPresent(String.self, forKey: .status)
        trash = try? values?.decodeIfPresent(String.self, forKey: .trash)
    }
    
}

