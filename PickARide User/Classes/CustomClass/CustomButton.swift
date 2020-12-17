//
//  CustomButton.swift
//  PickARide User
//
//  Created by Apple on 14/12/20.
//  Copyright © 2020 EWW071. All rights reserved.
//

import Foundation
import AVKit

class submitButton : UIButton
{
    override func awakeFromNib() {
        self.layer.cornerRadius = 4
        self.backgroundColor = colors.submitButtonColor.value
        self.clipsToBounds = true
        self.setTitleColor(colors.white.value, for: .normal)
        self.titleLabel?.font = CustomFont.medium.returnFont(18)
    }
}

class loginScreenButton : UIButton
{
    @IBInspectable var isForgotPassword : Bool = false
    @IBInspectable var issignUp : Bool = false
    override func awakeFromNib() {
        if isForgotPassword {
            self.setTitleColor(colors.black.value, for: .normal)
            self.titleLabel?.font = CustomFont.regular.returnFont(13)
        } else if issignUp {
            
            self.setunderline(title: self.titleLabel?.text ?? "", color: colors.submitButtonColor, font: CustomFont.medium.returnFont(14))
        }
    }
}
class ResendCodeButton : UIButton
{
  
   
    override func awakeFromNib() {
      
            self.setTitleColor(colors.submitButtonColor.value, for: .normal)
            self.titleLabel?.font = CustomFont.medium.returnFont(15)
        
    }
}
class MyofferScreenButton : UIButton
{
    @IBInspectable var isApply : Bool = false
    @IBInspectable var isUseNow : Bool = false
    override func awakeFromNib() {
        if isApply {
            self.setTitleColor(colors.submitButtonColor.value, for: .normal)
            self.titleLabel?.font = CustomFont.regular.returnFont(18)
        } else if isUseNow {
            self.setTitleColor(colors.submitButtonColor.value, for: .normal)
            self.titleLabel?.font = CustomFont.regular.returnFont(13)
        }
    }
}
class MyRidesButton : UIButton
{
    override func awakeFromNib() {
        self.layer.cornerRadius = 4
        self.backgroundColor = colors.submitButtonColor.value
        self.clipsToBounds = true
        self.setTitleColor(colors.white.value, for: .normal)
        self.titleLabel?.font = CustomFont.medium.returnFont(15)
    }
}
