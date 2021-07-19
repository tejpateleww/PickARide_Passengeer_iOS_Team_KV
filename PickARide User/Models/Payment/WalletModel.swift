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
    let walletBalance: Int?
    let message: String?

    enum CodingKeys: String, CodingKey {
        case status
        case walletBalance = "wallet_balance"
        case message
    }

    init(status: Bool, walletBalance: Int, message: String) {
        self.status = status
        self.walletBalance = walletBalance
        self.message = message
    }
}
