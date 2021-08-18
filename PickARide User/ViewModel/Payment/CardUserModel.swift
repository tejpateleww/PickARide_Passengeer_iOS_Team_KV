//
//  AddCardUserModel.swift
//  PickARide User
//
//  Created by apple on 7/9/21.
//  Copyright © 2021 EWW071. All rights reserved.
//

import Foundation

class CardUserModel{
    weak var addCardVC : AddCardVC? = nil
    weak var addPaymentVC : AddPaymentVC? = nil
    
    func webserviceAddCardApi(reqModel: AddCardReqModel){
        Utilities.showHud()
        WebServiceSubClass.AddCardApi(reqModel: reqModel) { (status, apiMessage, response, error) in
            Utilities.hideHud()
            Toast.show(title: status ? UrlConstant.Success : UrlConstant.Failed, message: apiMessage, state: status ? .success : .failure)
            
            if status{
        
                if let obj = self.addCardVC?.addCardClosure{
                    obj()
                }
            }
        }
    }
    
    func webserviceCardListApi(){
        Utilities.showHud()
        WebServiceSubClass.CardListApi() { (status, apiMessage, response, error) in
            Utilities.hideHud()
            if status {
                self.addPaymentVC?.tblPaymentMethod.reloadData()
            }
        }
    }
    
    func webserviceRemoveCardApi(reqModel: CardListReqModel){
        Utilities.showHud()
        WebServiceSubClass.RemoveCardApi(reqModel: reqModel) { (status, apiMessage, response, error) in
            Utilities.hideHud()
            Toast.show(title: status ? UrlConstant.Success : UrlConstant.Failed, message: apiMessage, state: status ? .success : .failure)
        }
    }
}
