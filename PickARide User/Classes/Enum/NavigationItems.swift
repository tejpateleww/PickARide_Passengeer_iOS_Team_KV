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
    case none, back , menu , cancel , cancelWhite
    
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
        case .cancelWhite:
            return "cancelWhite"
        }
    }
}


enum NavItemsRight {
    case none,login,EditProfile,userProfile,Done,addCard,help,add
    
    var value:String {
        switch self {
        case .none:
            return ""
        case .login:
            return "login"
        case .EditProfile:
            return "EditProfile"
        case .userProfile:
            return "like"
        case .Done:
            return "Done"
        case .addCard:
            return "Add Card"
        case .help:
            return "Help"
        case .add:
            return "Add"
        }
    }
}
enum NavTitles {
    case none, signUp, Home, forgotPassword, reasonForCancle,rating, CommonView, rideDetails
    
    var value:String {
        switch self {
        case .none:
            return ""
        case .signUp:
            return "NavigationTitle_SignUp".Localized()
        case .forgotPassword:
            return "NavigationTitle_ForgotPassword".Localized()
        case .Home:
            return ""
        case .reasonForCancle:
            return "NavigationTitle_reasonForCancle".Localized()
        case .rating:
        return "NavigationTitle_Rating".Localized()
        case .CommonView:
            return "CommonView"
        case .rideDetails:
            return "RideDetailsVC_lblRideDetails".Localized()
        }
    }
}
