//
//  PromoViewModel.swift
//  PickARide User
//
//  Created by apple on 8/18/21.
//  Copyright © 2021 EWW071. All rights reserved.
//

import Foundation

class PromoViewModel{
    
    weak var promoVC : MyOfferVC? = nil
    
    //MARK:- Promo Code List
    func webservicePromoListApi(){
        Utilities.showHud()
        WebServiceSubClass.PromoCodeListApi { (status, apiMessage, response, error) in
            Utilities.hideHud()
            
            if status{
                DispatchQueue.main.async {
                    self.promoVC?.promoCodeList = response?.data ?? [PromoDetailsModel]()
                    self.promoVC?.tblMyOffers.reloadData()
                }
            }
        }
    }
    
    //MARK:-
    func webserviceCheckPromoCodeApi(reqModel: CheckPromoReqModel){
        Utilities.showHud()
        WebServiceSubClass.CheckPromoCodeApi(reqModel: reqModel) { (status, apiMessage, response, error) in
            Utilities.hideHud()
            Toast.show(title: status ? UrlConstant.Success : UrlConstant.Failed, message: apiMessage, state: status ? .success : .failure)
            
            if status{
                DispatchQueue.main.async {
                    
                }
            }
        }
    }
}
