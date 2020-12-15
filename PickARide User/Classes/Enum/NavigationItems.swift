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
    case none, back
    
    var value:String {
        switch self {
        case .none:
            return ""
        case .back:
            return "back"
        }
    }
}


enum NavItemsRight {
    case none,login
    
    var value:String {
        switch self {
        case .none:
            return ""
        case .login:
            return "login"
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
