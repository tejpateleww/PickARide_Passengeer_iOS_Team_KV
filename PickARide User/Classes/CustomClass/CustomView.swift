//
//  CustomView.swift
//  PickARide User
//
//  Created by Apple on 14/12/20.
//  Copyright © 2020 EWW071. All rights reserved.
//

import Foundation
import AVKit

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
