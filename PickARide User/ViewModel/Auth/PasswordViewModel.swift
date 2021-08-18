//
//  PasswordViewModel.swift
//  PickARide User
//
//  Created by apple on 7/6/21.
//  Copyright © 2021 EWW071. All rights reserved.
//

import Foundation
class PasswordUserModel{
    weak var forgotPasswordVC : ForgotPasswordVC? = nil
    weak var changePasswordVC : ChangePasswordVC? = nil
    
    func webserviceForgotPassword(reqModel: ForgotPasswordReqModel){
        Utilities.showHud()
        WebServiceSubClass.ForgotPasswordApi(reqModel: reqModel) { (status, apiMessage, response, error) in
            Utilities.hideHud()
            Toast.show(title: status ? UrlConstant.Success : UrlConstant.Failed, message: apiMessage, state: status ? .success : .failure) {
                if status{
                    self.forgotPasswordVC?.navigationController?.popViewController(animated: true)
//                    let controller = OtpVC.instantiate(fromAppStoryboard: .Login)
//                    self.forgotPasswordVC?.navigationController?.pop(controller, animated: true)
                }
            }
        }
    }
    
    func webserviceChangePassword(reqModel: ChangePasswordReqModel){
        Utilities.showHud()
        
        WebServiceSubClass.ChangePasswordApi(reqModel: reqModel) { (status, apiMessage, response, error) in
            Utilities.hideHud()
            
            if status{
                if let click = self.changePasswordVC?.btnSubmitClosure {
                    click()
                }
            }
            
            Toast.show(title: status ? UrlConstant.Success : UrlConstant.Failed, message: apiMessage, state: status ? .success : .failure)
        }
    }
}
