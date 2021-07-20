//
//  WalletModel.swift
//  PickARide User
//
//  Created by apple on 7/9/21.
//  Copyright © 2021 EWW071. All rights reserved.
//

import Foundation

//MARK:- Wallet History Request Model
class WalletHistoryRequestModel: Encodable {
    var customerId: String? = Singleton.sharedInstance.UserId
    var page: String? = "1"
    
    enum CodingKeys: String, CodingKey {
        case customerId = "customer_id"
        case page = "page"
    }
}

//MARK:- Wallet History Response Model
class WalletHistoryModel: Codable {
    let status: Bool?
    let walletBalance: String?
    let data: [WalletDetails]?
    
    enum CodingKeys: String, CodingKey {
        case status
        case walletBalance = "wallet_balance"
        case data
    }
    
    init(status: Bool, walletBalance: String, data: [WalletDetails]) {
        self.status = status
        self.walletBalance = walletBalance
        self.data = data
    }
    
    required init(from decoder: Decoder) throws {
        let values = try? decoder.container(keyedBy: CodingKeys.self)
        data = try? values?.decodeIfPresent([WalletDetails].self, forKey: .data)
        status = try? values?.decodeIfPresent(Bool.self, forKey: .status)
        walletBalance = try? values?.decodeIfPresent(String.self, forKey: .walletBalance)
    }
}

// MARK: - Datum
class WalletDetails: Codable {
    let id, userID, userType, amount: String?
    let type, datumDescription, referenceID, createdDate: String?
    let transactionType, transactionSubtype, bankReferenceID, response: String?
    let status, cardID: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case userType = "user_type"
        case amount, type
        case datumDescription = "description"
        case referenceID = "reference_id"
        case createdDate = "created_date"
        case transactionType = "transaction_type"
        case transactionSubtype = "transaction_subtype"
        case bankReferenceID = "bank_reference_id"
        case response, status
        case cardID = "card_id"
    }
    
    init(id: String, userID: String, userType: String, amount: String, type: String, datumDescription: String, referenceID: String, createdDate: String, transactionType: String, transactionSubtype: String, bankReferenceID: String, response: String, status: String, cardID: String) {
        self.id = id
        self.userID = userID
        self.userType = userType
        self.amount = amount
        self.type = type
        self.datumDescription = datumDescription
        self.referenceID = referenceID
        self.createdDate = createdDate
        self.transactionType = transactionType
        self.transactionSubtype = transactionSubtype
        self.bankReferenceID = bankReferenceID
        self.response = response
        self.status = status
        self.cardID = cardID
    }
    
    required init(from decoder: Decoder) throws {
        let values = try? decoder.container(keyedBy: CodingKeys.self)
        amount = try? values?.decodeIfPresent(String.self, forKey: .amount)
        bankReferenceID = try? values?.decodeIfPresent(String.self, forKey: .bankReferenceID)
        cardID = try? values?.decodeIfPresent(String.self, forKey: .cardID)
        createdDate = try? values?.decodeIfPresent(String.self, forKey: .createdDate)
        datumDescription = try? values?.decodeIfPresent(String.self, forKey: .datumDescription)
        id = try? values?.decodeIfPresent(String.self, forKey: .id)
        referenceID = try? values?.decodeIfPresent(String.self, forKey: .referenceID)
        response = try? values?.decodeIfPresent(String.self, forKey: .response)
        status = try? values?.decodeIfPresent(String.self, forKey: .status)
        transactionSubtype = try? values?.decodeIfPresent(String.self, forKey: .transactionSubtype)
        transactionType = try? values?.decodeIfPresent(String.self, forKey: .transactionType)
        type = try? values?.decodeIfPresent(String.self, forKey: .type)
        userID = try? values?.decodeIfPresent(String.self, forKey: .userID)
        userType = try? values?.decodeIfPresent(String.self, forKey: .userType)
    }
}

//MARK:- Add Money Request Model
class AddMoneyRequestModel: Encodable {
    var customerId: String? = Singleton.sharedInstance.UserId
    var cardId: String?
    var amount: String?
    
    enum CodingKeys: String, CodingKey {
        case customerId = "customer_id"
        case cardId = "card_id"
        case amount = "amount"
    }
}

//MARK:- Add Money Response Model
class AddMoneyResponseModel: Codable {
    let status: Bool?
    let walletBalance: Float?
    let message: String?
    
    enum CodingKeys: String, CodingKey {
        case status
        case walletBalance = "wallet_balance"
        case message
    }
    
    init(status: Bool, walletBalance: Float, message: String) {
        self.status = status
        self.walletBalance = walletBalance
        self.message = message
    }
    
    required init(from decoder: Decoder) throws {
        let values = try? decoder.container(keyedBy: CodingKeys.self)
        message = try? values?.decodeIfPresent(String.self, forKey: .message)
        status = try? values?.decodeIfPresent(Bool.self, forKey: .status)
        walletBalance = try? values?.decodeIfPresent(Float.self, forKey: .walletBalance)
    }
}
