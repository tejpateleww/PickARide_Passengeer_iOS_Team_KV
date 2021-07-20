//
//  AddCardReqModel.swift
//  PickARide User
//
//  Created by apple on 7/9/21.
//  Copyright © 2021 EWW071. All rights reserved.
//

import Foundation

//MARK:- Add Card Request Model
class AddCardReqModel : Encodable{
    var customerId: String? = Singleton.sharedInstance.UserId
    var cardNo: String?
    var cardHolderName: String?
    var expiryMonth: String?
    var expiryYear: String?
    var cvv: String?
    
    enum CodingKeys: String, CodingKey {
        case customerId = "customer_id"
        case cardNo = "card_no"
        case cardHolderName = "card_holder_name"
        case expiryMonth = "exp_date_month"
        case expiryYear = "exp_date_year"
        case cvv = "cvv"
    }
}

//MARK:- Card List Request Model
class CardListReqModel : Encodable{
    var customerId: String? = Singleton.sharedInstance.UserId
    var cardId: String?
    
    enum CodingKeys: String, CodingKey {
        case customerId = "customer_id"
        case cardId = "card_id"
    }
}

//MARK:- Card List Response Model
class CardListModel: Codable {
    let status: Bool?
    let message: String?
    let cards: [CardDetailModel]?
    
    init(status: Bool, message: String, cards: [CardDetailModel]) {
        self.status = status
        self.message = message
        self.cards = cards
    }
    
    required init(from decoder: Decoder) throws {
        let values = try? decoder.container(keyedBy: CodingKeys.self)
        cards = try? values?.decodeIfPresent([CardDetailModel].self, forKey: .cards)
        message = try? values?.decodeIfPresent(String.self, forKey: .message)
        status = try? values?.decodeIfPresent(Bool.self, forKey: .status)
    }
}

// MARK: - Card
class CardDetailModel: Codable {
    let id, cardNo, formatedCardNo, cardHolderName: String?
    let cardType, expiryMonth, expiryYear: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case cardNo = "card_no"
        case formatedCardNo = "formated_card_no"
        case cardHolderName = "card_holder_name"
        case cardType = "card_type"
        case expiryMonth = "exp_date_month"
        case expiryYear = "exp_date_year"
    }
    
    init(id: String, cardNo: String, formatedCardNo: String, cardHolderName: String, cardType: String, expiryMonth: String, expiryYear: String) {
        self.id = id
        self.cardNo = cardNo
        self.formatedCardNo = formatedCardNo
        self.cardHolderName = cardHolderName
        self.cardType = cardType
        self.expiryMonth = expiryMonth
        self.expiryYear = expiryYear
    }
    
    required init(from decoder: Decoder) throws {
        let values = try? decoder.container(keyedBy: CodingKeys.self)
        cardHolderName = try? values?.decodeIfPresent(String.self, forKey: .cardHolderName)
        cardNo = try? values?.decodeIfPresent(String.self, forKey: .cardNo)
        cardType = try? values?.decodeIfPresent(String.self, forKey: .cardType)
        expiryMonth = try? values?.decodeIfPresent(String.self, forKey: .expiryMonth)
        expiryYear = try? values?.decodeIfPresent(String.self, forKey: .expiryYear)
        formatedCardNo = try? values?.decodeIfPresent(String.self, forKey: .formatedCardNo)
        id = try? values?.decodeIfPresent(String.self, forKey: .id)
    }
}

