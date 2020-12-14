//
//  Constants.swift
//  Virtuwoof Pet
//
//  Created by EWW80 on 02/10/19.
//  Copyright © 2019 EWW80. All rights reserved.
//

import Foundation
import UIKit


let keywindow = UIApplication.shared.keyWindow

let appDel = UIApplication.shared.delegate as! AppDelegate
let kAPPVesion = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String
let AppName = "Virtuwoof"
let AppURL = "itms-apps://itunes.apple.com/app/id1488928328"

let themeColor = hexStringToUIColor(hex: "2ab6b6")
let themeColorOrange = hexStringToUIColor(hex: "ff8b7b")
let themeColorOffWhite = hexStringToUIColor(hex: "efecef")

let themeStatusRed = hexStringToUIColor(hex: "DF1A49")
let themeStatusYellow = hexStringToUIColor(hex: "EFB818")
let themeStatusGreen = hexStringToUIColor(hex: "1AC62F")


let NotificationBadges = NSNotification.Name(rawValue:"NotificationBadges")


enum DateFormatterString : String{
    case timeWithDate = "yyyy-MM-dd HH:mm:ss"
    case onlyDate = "yyyy-MM-dd"
}

