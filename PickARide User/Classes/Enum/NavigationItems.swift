//
//  NavigationItems.swift
//  HC Pro Patient
//
//  Created by Shraddha Parmar on 30/09/20.
//  Copyright © 2020 EWW071. All rights reserved.
//

import Foundation
import Foundation
import UIKit

enum NavItemsLeft {
    case none, back , menu , cancel
    
    var value:String {
        switch self {
        case .none:
            return ""
        case .back:
            return "back"
        case .menu:
            return "menu"
        case .cancel:
            return "cancel"
        }
    }
}


enum NavItemsRight {
    case none,login,userProfile,Done,EditProfile
    
    var value:String {
        switch self {
        case .none:
            return ""
        case .login:
            return "login"
        case .userProfile:
            return "userProfile"
        case .Done:
            return "Done"
        case .EditProfile:
            return "EditProfile"
        }
    }
}
enum NavTitles {
    case none, Home,reasonForCancle
    
    var value:String {
        switch self {
        case .none:
            return ""
        case .Home:
            return ""
        case .reasonForCancle:
            return "NavigationTitle_reasonForCancle".Localized()
        }
    }
}
