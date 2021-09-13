//
//  AddPlace.swift
//  PickARide User
//
//  Created by Admin on 07/09/21.
//  Copyright © 2021 EWW071. All rights reserved.
//

import Foundation

class AddPlaceViewModel {
    
    weak var AddPlaceVC : AddNewDestinationVC? = nil
    weak var chooseDestinationVC : ChooseDestinationVC? = nil
    weak var settingVc : SettingVC? = nil
    
    func webserviceCallAddPlaces(reqmodel:AddPlacesReqModel){
        Utilities.showHud()
        WebServiceSubClass.AddPlaces(reqModel: reqmodel) { (status, message, response, error )in
            if status {
                Utilities.hideHud()
                Toast.show(title: status ? UrlConstant.Success : UrlConstant.Failed, message: message, state: status ? .success : .failure)
                
                if status{
                    appDel.navigateToMain()
                }
        }
      }
    }
    
    
    func webserviceCallFavPlacesList(){
        Utilities.showHud()
        WebServiceSubClass.FavoritList(CustomerId: Singleton.sharedInstance.UserId) { (status, message, response,error) in
            if status {
                Utilities.hideHud()
                print(response)
                if status {
                    DispatchQueue.main.async {
                        if self.settingVc != nil {
                            self.settingVc?.addValuesInSettingList(SavedPlaces: (response?.data)!)
                            self.settingVc?.tblSettings.reloadData()
                        }
                        self.chooseDestinationVC?.arrayForSavedPlaces = response?.data ?? [PlaceData]()
                        self.chooseDestinationVC?.tblPlacePicker.reloadData()
                    }
                }
               
            }
        }
    }
    
}

