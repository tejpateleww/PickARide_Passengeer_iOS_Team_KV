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
