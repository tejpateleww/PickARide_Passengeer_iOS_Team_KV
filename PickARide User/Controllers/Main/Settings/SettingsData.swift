//
//  SettingsData.swift
//  PickARide User
//
//  Created by apple on 7/6/21.
//  Copyright © 2021 EWW071. All rights reserved.
//

import Foundation
import UIKit

class SettingData {
    var titleName : String?
    var titleButton : String?
    var subData : [SubSettingsData]?
    var isForLanguage : Bool?
    
    init(name:String? = "", button:String? = "", subsetting:[SubSettingsData] = [], isForLanguage: Bool? = Bool()) {
        self.titleName = name
        self.titleButton = button
        self.subData = subsetting
        self.isForLanguage = isForLanguage
    }
    
    static var SettingList = [SettingData]()
}

class SubSettingsData {
    var titleName : String?
    var titleImage : UIImage?
    
    init(name:String? = "", img:UIImage? = nil) {
        self.titleName = name
        self.titleImage = img
    }
}

struct SettingImages {
    static let SettingHome = #imageLiteral(resourceName: "ic_settingsHome")
    static let SettingWork = #imageLiteral(resourceName: "ic_SettingWork")
    static let SettingRightArrow = #imageLiteral(resourceName: "ImgGraterThen")
    static let SettingDownArrow = #imageLiteral(resourceName: "ic_DownReg")
}

struct SettingsTitle {
    static let Favoutite = "SettingsVC_Favourites".Localized()
    static let Add = "SettingsVC_btnAdd".Localized()
    static let Home = "SettingsVC_Home".Localized()
    static let Work = "SettingsVC_Work".Localized()
    static let MoreSavedPlaces = "SettingsVC_btnMoreSavedPlaces".Localized()
    static let PrivacyPolicy = "SettingsVC_privacyPolicy".Localized()
    static let Language = "SettingsVC_Language".Localized()
}

func addValuesInSettingList(){
    SettingData.SettingList.append(SettingData())
    SettingData.SettingList.append(SettingData(name: SettingsTitle.Favoutite, button: SettingsTitle.Add, subsetting: [SubSettingsData(name: SettingsTitle.Home, img: SettingImages.SettingHome), SubSettingsData(name: SettingsTitle.Work, img: SettingImages.SettingWork)]))
    SettingData.SettingList.append(SettingData(button: SettingsTitle.MoreSavedPlaces, subsetting: [SubSettingsData(name: SettingsTitle.PrivacyPolicy)]))
    SettingData.SettingList.append(SettingData(name: SettingsTitle.Language))
}
