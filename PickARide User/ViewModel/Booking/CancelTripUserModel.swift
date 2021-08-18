//
//  CancelTripUserModel.swift
//  PickARide User
//
//  Created by apple on 8/18/21.
//  Copyright © 2021 EWW071. All rights reserved.
//

import Foundation

class CancelTripUserModel{
    
    weak var cancelTripVC : ReasonForCancelVC? = nil
    
    func webserviceCancelTripApi(reqModel: CancelTripReqModel){
        Utilities.showHud()
        WebServiceSubClass.CancelTripApi(reqModel: reqModel) { (status, apiMessage, response, error) in
            Utilities.hideHud()
            Toast.show(title: status ? UrlConstant.Success : UrlConstant.Failed, message: apiMessage, state: status ? .success : .failure)
            
            if status{
        
            }
        }
    }
}
