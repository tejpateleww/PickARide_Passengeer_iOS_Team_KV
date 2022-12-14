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
    var subData : [PlaceData]?
    
    init(name:String? = "", button:String? = "", subsetting:[PlaceData] = []) {
        self.titleName = name
        self.titleButton = button
        self.subData = subsetting
    }
    
    static var SettingList = [SettingData]()
    static var LanguageList = ["English","French","Italian"]
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
    static let SettingHomeGray = #imageLiteral(resourceName: "ic_HomeTemp")
    static let SettingWorkGray = #imageLiteral(resourceName: "Dummy_Work")
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


