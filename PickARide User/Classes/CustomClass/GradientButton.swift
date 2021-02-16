//
//  GradientButton.swift
//  CoreSound
//
//  Created by EWW083 on 03/02/20.
//  Copyright © 2020 EWW083. All rights reserved.
//

import Foundation
import UIKit

class GradientButton: UIButton {
    let gradientLayer = CAGradientLayer()
    
    @IBInspectable
    var topGradientColor: UIColor? {
        didSet {
            setGradient(topGradientColor: topGradientColor, bottomGradientColor: bottomGradientColor)
        }
    }
    
    @IBInspectable
    var bottomGradientColor: UIColor? {
        didSet {
            setGradient(topGradientColor: topGradientColor, bottomGradientColor: bottomGradientColor)
        }
    }
    
    private func setGradient(topGradientColor: UIColor?, bottomGradientColor: UIColor?) {
        if let topGradientColor = topGradientColor, let bottomGradientColor = bottomGradientColor {
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
            gradientLayer.frame = self.bounds
            gradientLayer.colors = [topGradientColor.cgColor, bottomGradientColor.cgColor]
            gradientLayer.borderColor = layer.borderColor
            gradientLayer.borderWidth = layer.borderWidth
            gradientLayer.cornerRadius = self.frame.height/2
            layer.insertSublayer(gradientLayer, at: 0)
        } else {
            gradientLayer.removeFromSuperlayer()
        }
    }
}
class RidesDetailsButton : UIButton
{
    @IBInspectable var isReceipt : Bool = false
    @IBInspectable var isRepeatRide : Bool = false
    override func awakeFromNib() {
        if isReceipt{
            self.clipsToBounds = true
            self.layer.cornerRadius = 4
            self.layer.borderColor = colors.submitButtonColor.value.cgColor
            self.layer.borderWidth = 1
            self.setTitleColor(colors.submitButtonColor.value, for: .normal)
            self.titleLabel?.font = CustomFont.medium.returnFont(15)
        }else if isRepeatRide{
            self.clipsToBounds = true
            self.layer.cornerRadius = 4
            self.layer.borderColor = colors.loginPlaceHolderColor.value.cgColor
            self.layer.borderWidth = 1
            self.setTitleColor(colors.loginPlaceHolderColor.value, for: .normal)
            self.titleLabel?.font = CustomFont.medium.returnFont(15)
        }
    }
}
