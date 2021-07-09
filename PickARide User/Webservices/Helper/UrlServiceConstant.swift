//
//  UrlServiceConstant.swift
//  Danfo_Rider
//
//  Created by Hiral Jotaniya on 04/06/21.
//

import Foundation

class UrlConstant{
    //MARK:- WebService Header Key
    static let HeaderKey = "key"
    static let XApiKey = "x-api-key"
    static let AppHostKey = "PickARide951*#*"
    
    static let ResponseMessage = "message"
    
    //MARK:- Message Title
    static let Required = "UrlConstant_Required".Localized()
    static let Success = "UrlConstant_Success".Localized()
    static let Failed = "UrlConstant_Failed".Localized()
    static let Status = "status"
    static let SomethingWentWrong = "UrlConstant_SomethingWentWrong".Localized()
    static let NoInternetConnection =  "UrlConstant_NoInternetConnection".Localized()
    static let RequestTimeOut = "UrlConstant_RequestTimeOut".Localized()
    
    static let Ok = "UrlConstant_Ok".Localized()
    static let Yes = "UrlConstant_Yes".Localized()
    static let Cancel = "UrlConstant_Cancel".Localized()
    static let No = "UrlConstant_No".Localized()
    static let Retry = "UrlConstant_Retry".Localized()
    static let SelectCard = "UrlConstant_SelectCard".Localized()
    static let Continue = "UrlConstant_Continue".Localized()
    
    //Validation Message
    static let ValidPhoneNo = "UrlConstant_ValidPhoneNo".Localized()
    static let AgeIsRequired = "UrlConstant_AgeIsRequired".Localized()
    static let AgeMustNumber = "UrlConstant_AgeMustNumber".Localized()
    static let InvalidAgeNumber = "UrlConstant_InvalidAgeNumber".Localized()
    static let Age18YearsOld = "UrlConstant_Age18YearsOld".Localized()
    static let RequiredVerificationCode = "UrlConstant_RequiredVerificationCode".Localized()
    static let InvalidVerificationCode = "UrlConstant_InvalidVerificationCode".Localized()
}

let ErrorResponseDic = [UrlConstant.ResponseMessage: UrlConstant.SomethingWentWrong]
let NoInternetResponseDic = [UrlConstant.ResponseMessage: UrlConstant.NoInternetConnection]



