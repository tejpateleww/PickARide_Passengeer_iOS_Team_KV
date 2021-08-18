//
//  BookingUserModel.swift
//  PickARide User
//
//  Created by apple on 8/18/21.
//  Copyright © 2021 EWW071. All rights reserved.
//

import Foundation

class BookingUserModel{
    func webserviceBookingRequestApi(reqModel: BookingReqModel){
        Utilities.showHud()
        WebServiceSubClass.BookingRequestApi(reqModel: reqModel) { (status, apiMessage, response, error) in
            Utilities.hideHud()
            Toast.show(title: status ? UrlConstant.Success : UrlConstant.Failed, message: apiMessage, state: status ? .success : .failure)
            
            if status{
        
                
            }
        }
    }
}
