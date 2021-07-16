//
//  WalletUserModel.swift
//  PickARide User
//
//  Created by apple on 7/9/21.
//  Copyright © 2021 EWW071. All rights reserved.
//

import Foundation

class WalletUserModel{
    weak var walletHistoryVC : WalletHistoryVC? = nil
    
    func webserviceWalletHistory(reqModel: WalletHistoryRequestModel){
        Utilities.showHud()
        WebServiceSubClass.WalletHistoryApi(reqModel: reqModel) { (status, apiMessage, response, error) in
            Utilities.hideHud()
            if status{
                self.walletHistoryVC?.walletObj = response
                self.walletHistoryVC?.lblTotalMoney.text = response?.walletBalance ?? ""
                Singleton.sharedInstance.UserProfilData?.walletBalance = response?.walletBalance
                self.walletHistoryVC?.tblWalletHistory.reloadData()
            }
            
            self.walletHistoryVC?.lblNoDataFound.isHidden = response?.data?.count != 0
        }
    }
}
