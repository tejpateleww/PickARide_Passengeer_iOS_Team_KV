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
    case none, back , menu
    
    var value:String {
        switch self {
        case .none:
            return ""
        case .back:
            return "back"
        case .menu:
            return "menu"
        }
    }
}


enum NavItemsRight {
    case none,login,userProfile
    
    var value:String {
        switch self {
        case .none:
            return ""
        case .login:
            return "login"
        case .userProfile:
            return "userProfile"
        }
    }
}
enum NavTitles {
    case none, Home
    
    var value:String {
        switch self {
        case .none:
            return ""
        case .Home:
            return ""
        }
    }
}
