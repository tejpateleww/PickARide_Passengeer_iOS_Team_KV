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
    case none, signUp, Home, forgotPassword, verify, viewProfile, editProfile, myRides, rideDetails, payment , addCard, notification, reasonForCancle, rating, CommonView, setting, addNewPlace, savedPlaces, wallet
    
    var value:String {
        switch self {
        case .none: return ""
        case .Home: return ""
        case .signUp:
            return "NavigationTitle_SignUp".Localized()
        case .forgotPassword:
            return "NavigationTitle_ForgotPassword".Localized()
        case .verify:
            return "NavigationTitle_Verfiy".Localized()
        case .viewProfile:
            return "NavigationTitle_ViewProfile".Localized()
        case .editProfile:
            return "NavigationTitle_EditProfile".Localized()
        case .myRides:
            return "NavigationTitle_MyRides".Localized()
        case .rideDetails:
            return "RideDetailsVC_lblRideDetails".Localized()
        case .payment:
            return "NavigationTitle_PaymentMethods".Localized()
        case .addCard:
            return "NavigationTitle_AddCard".Localized()
        case .notification:
            return "NavigationTitle_Notifications".Localized()
        case .setting:
            return "NavigationTitle_Settings".Localized()
        case .reasonForCancle:
            return "NavigationTitle_reasonForCancle".Localized()
        case .rating:
            return "NavigationTitle_Rating".Localized()
        case .CommonView:
            return "CommonView"
        case .addNewPlace:
            return "NavigationTitle_AddNewPlace".Localized()
        case .savedPlaces:
            return "NavigationTitle_SavelPlaces".Localized()
        case .wallet:
            return "NavigationTitle_Wallet".Localized()
        }
    }
}
