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
