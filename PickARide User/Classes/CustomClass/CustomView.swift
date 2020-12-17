//
//  CustomView.swift
//  PickARide User
//
//  Created by Apple on 14/12/20.
//  Copyright © 2020 EWW071. All rights reserved.
//

import Foundation
import AVKit

class viewWithClearBg : UIView {
    override func awakeFromNib() {
        self.backgroundColor = .clear
    }
}

class loginView : UIView {
    override func awakeFromNib() {

        self.layer.borderColor = colors.loginViewColor.value.cgColor
        self.layer.borderWidth = 1
    }
}
class RegisterView : UIView {
    override func awakeFromNib() {
        self.layer.cornerRadius = 4
        self.layer.borderColor = colors.loginViewColor.value.cgColor
        self.layer.borderWidth = 1
    }
}
class verifyPinView : UIView {
    override func awakeFromNib() {
        self.backgroundColor = .clear
        self.layer.cornerRadius = 4
        self.layer.borderColor = colors.loginViewColor.value.cgColor
        self.layer.borderWidth = 1
    }
}
class changePasswordView : UIView {
    override func awakeFromNib() {
        self.layer.cornerRadius = 4
        self.layer.borderColor = colors.loginViewColor.value.cgColor
        self.layer.borderWidth = 1
    }
}
class whereAreYouGoingView : UIView {
    override func awakeFromNib() {
        self.layer.cornerRadius = 9
        self.layer.borderColor = colors.loginViewColor.value.cgColor
        self.layer.borderWidth = 1
    }
}
class seperatorView : UIView {
   
    override func awakeFromNib() {
        self.backgroundColor = colors.seperatorColor.value
    }
}
class selectDestinationView : UIView {
    override func awakeFromNib() {
        self.layer.cornerRadius = 16
        self.layer.shadowColor = colors.black.value.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = 7
        self.layer.shadowOpacity = 0.4
    }
}
class viewBorder : UIView {
    @IBInspectable var isViewRadius : Bool = false
    override func awakeFromNib() {
        self.layer.cornerRadius = 4
        self.layer.borderColor = colors.loginViewColor.value.cgColor
        self.layer.borderWidth = 1
    }
}
class myOfferView : UIView {
    @IBInspectable var isViewRadius : Bool = false
    //@IBInspectable var isRadius : Bool = false
    @IBInspectable var isShadow : Bool = false
    override func awakeFromNib() {
        if isViewRadius{
            self.layer.cornerRadius = 8
        }else if isShadow{
            self.layer.cornerRadius = 5
            self.clipsToBounds = false
            self.layer.masksToBounds = true;
            self.backgroundColor = UIColor.white
            self.layer.shadowColor = colors.loginViewColor.value.cgColor
            self.layer.shadowOpacity = 1
            self.layer.shadowOffset = CGSize(width: 4.0, height: 4.0)
            self.layer.shadowRadius = 4.0
            self.layer.masksToBounds = false
        }
    }
}
class MyRidesView : UIView {
    @IBInspectable var isShadow : Bool = false
    override func awakeFromNib() {
        if isShadow{
            self.clipsToBounds = false
            self.backgroundColor = UIColor.white
            self.layer.shadowColor = colors.loginViewColor.value.cgColor
            self.layer.shadowOpacity = 1
            self.layer.shadowOffset = CGSize(width: 4.0, height: 4.0)
            self.layer.shadowRadius = 4.0
        }
    }
}
