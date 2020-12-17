//
//  CustomLabel.swift
//  PickARide User
//
//  Created by Apple on 14/12/20.
//  Copyright © 2020 EWW071. All rights reserved.
//

import Foundation
import UIKit

class loginScreenLabel : UILabel {
    @IBInspectable var isWelcome : Bool = false
    @IBInspectable var istitle : Bool = false
    @IBInspectable var isORlbl : Bool = false
    @IBInspectable var isDontHaveAccount : Bool = false
    override func awakeFromNib() {
        if isWelcome {
            self.font = CustomFont.regular.returnFont(26)
            self.textColor = colors.loginText.value
        } else if istitle {
            self.font = CustomFont.bold.returnFont(33)
            self.textColor = colors.loginText.value
        } else if isORlbl {
            self.font = CustomFont.regular.returnFont(14)
                self.textColor = colors.black.value
        } else if isDontHaveAccount {
            self.font = CustomFont.regular.returnFont(14)
                self.textColor = colors.black.value
        }
    }
}

class registerScreenLabel : UILabel {
    @IBInspectable var isSignUp : Bool = false
    override func awakeFromNib() {
        self.font = CustomFont.bold.returnFont(38)
        self.textColor = colors.loginPlaceHolderColor.value
    }
}

class verifyVcLabel : UILabel {
    @IBInspectable var IsVerifyPhoneNumber : Bool = false
    @IBInspectable var IsCheckYourPhoneNumber : Bool = false
    @IBInspectable var IsnotRecive : Bool = false
    override func awakeFromNib() {
        if IsVerifyPhoneNumber {
            self.textColor = colors.loginPlaceHolderColor.value
            self.font = CustomFont.bold.returnFont(29)
          
        } else if IsCheckYourPhoneNumber {
            self.textColor = colors.phoneNumberColor.value

         
         
        } else if IsnotRecive {
            self.font = CustomFont.medium.returnFont(15)
                self.textColor = colors.loginPlaceHolderColor.value
        }
      
    }
}

class changePasswordLabel : UILabel {
    override func awakeFromNib() {
        self.textColor = colors.loginPlaceHolderColor.value
        self.font = CustomFont.medium.returnFont(28)
    }
}
class NotificationLabel: UILabel {
    @IBInspectable var isTitle:Bool = false
    
    @IBInspectable var isNotificatioTitle:Bool = false
    @IBInspectable var isNotificatioDescription:Bool = false
    override func awakeFromNib() {
        super.awakeFromNib()
        if isTitle {
            self.textColor = colors.loginPlaceHolderColor.value
            self.font = CustomFont.bold.returnFont(40)
        } else if isNotificatioTitle {
            self.font = CustomFont.medium.returnFont(17)
            self.textColor = UIColor(hexString: "#242E42")
        } else if isNotificatioDescription {
            self.font = CustomFont.medium.returnFont(17)
            self.textColor = UIColor(hexString: "#242E42")
        }
        
        
    }
}
class SelectDestinationLabel : UILabel {
    @IBInspectable var isTitle:Bool = false
    @IBInspectable var isSubTitle:Bool = false
    override func awakeFromNib() {
        super.awakeFromNib()
        if isTitle {
            self.textColor = colors.loginPlaceHolderColor.value
            self.font = CustomFont.regular.returnFont(18)
        } else if isSubTitle {
            self.font = CustomFont.regular.returnFont(18)
            self.textColor = colors.phoneNumberColor.value
        }
        
        
    }
}
class ForgotPasswordLabel : UILabel {
    @IBInspectable var isForgot : Bool = false
    @IBInspectable var isquestion : Bool = false
    @IBInspectable var iscountryCode : Bool = false
    @IBInspectable var isDescription : Bool = false
    
    override func awakeFromNib() {
        if isForgot{
            self.font = CustomFont.bold.returnFont(29)
            self.textColor = colors.loginPlaceHolderColor.value
        }else if isquestion{
            self.font = CustomFont.bold.returnFont(21)
            self.textColor = UIColor(hexString: "#9095A2")
        }else if iscountryCode{
            self.font = CustomFont.bold.returnFont(12)
            self.textColor = UIColor(hexString: "#8F9BB3")
        }else if isDescription{
            self.font = CustomFont.regular.returnFont(17)
            self.textColor = UIColor(hexString: "#222B45")
        }
    }
}
class myofferLabel : UILabel{
    @IBInspectable var isMyOffer : Bool = false
    @IBInspectable var isOfferDetails : Bool = false
    @IBInspectable var isvalidto: Bool = false
    
    override func awakeFromNib() {
        if isMyOffer{
            self.font = CustomFont.medium.returnFont(40)
            self.textColor = colors.loginPlaceHolderColor.value
        }else if isOfferDetails{
            self.font = CustomFont.medium.returnFont(18)
            self.textColor = colors.loginPlaceHolderColor.value
        }else if isvalidto{
            self.font = CustomFont.regular.returnFont(13)
            self.textColor = UIColor(hexString: "#ACB1C0")
        }
    }
}
class myRidesLabel : UILabel{
    @IBInspectable var isMyRides : Bool = false
    @IBInspectable var isDate : Bool = false
    @IBInspectable var isname : Bool = false
    @IBInspectable var isAddress: Bool = false
    @IBInspectable var isPrice : Bool = false
    @IBInspectable var isTotal: Bool = false
    @IBInspectable var isSelectType: Bool = false
    override func awakeFromNib() {
        if isMyRides{
            self.font = CustomFont.medium.returnFont(40)
            self.textColor = colors.loginPlaceHolderColor.value
        }else if isDate{
            self.font = CustomFont.regular.returnFont(15)
            self.textColor = colors.loginPlaceHolderColor.value
        }else if isname{
            self.font = CustomFont.bold.returnFont(15)
            self.textColor = colors.loginPlaceHolderColor.value
        }else if isAddress{
            self.font = CustomFont.regular.returnFont(13)
            self.textColor = colors.loginPlaceHolderColor.value
        }else if isPrice{
            self.font = CustomFont.regular.returnFont(13)
            self.textColor = UIColor(hexString: "#ACB1C0")
        }else if isTotal{
            self.font = CustomFont.bold.returnFont(13)
            self.textColor = colors.loginPlaceHolderColor.value
        } else if isSelectType {
            self.font = CustomFont.medium.returnFont(15)
            self.textColor = colors.loginPlaceHolderColor.value
        }
    }
}
