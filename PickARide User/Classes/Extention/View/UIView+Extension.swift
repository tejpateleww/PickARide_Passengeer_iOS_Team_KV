//
//  UIView+Extension.swift
//  CoreSound
//
//  Created by EWW083 on 04/02/20.
//  Copyright © 2020 EWW083. All rights reserved.
//
import Foundation
import UIKit

extension UIView {
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    func setUpAutomaticRadius(){
        layer.cornerRadius = layer.frame.height/2
    }
    
    public func setGradientView(topGradientColor: UIColor?, bottomGradientColor: UIColor?) {
        let gradientLayer = CAGradientLayer()
        if let topGradientColor = topGradientColor, let bottomGradientColor = bottomGradientColor {
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
            gradientLayer.frame = bounds
            gradientLayer.colors = [topGradientColor.cgColor, bottomGradientColor.cgColor]
            gradientLayer.borderColor = layer.borderColor
            gradientLayer.borderWidth = layer.borderWidth
            gradientLayer.cornerRadius = self.frame.height/2
            layer.insertSublayer(gradientLayer, at: 0)
        } else {
            gradientLayer.removeFromSuperlayer()
        }
    }
    
    func setBorderColor(bcolor:colors){
        self.layer.borderColor  = bcolor.value.cgColor
        self.layer.borderWidth = 1
    }
    
    @IBInspectable var shadow: Bool {
        get {
            return layer.shadowOpacity > 0.0
        }
        set {
            self.addShadow()
            if newValue == true {
                self.addShadow()
            }else{
                self.layer.shadowOpacity = 0.0
            }
        }
    }
    
    @IBInspectable var AddBorder: Bool {
        get {
            return layer.borderWidth == 0
        }
        set {
            self.addBorder()
            if newValue == true {
                self.addBorder()
            }else{
                self.layer.borderWidth = 0.0
            }
        }
    }
    
    func addBorder(){
        layer.borderWidth = 1.5
        layer.cornerRadius = self.frame.height / 2
        layer.backgroundColor = ThemeColorEnum.ThemeWhite.rawValue.cgColor
        layer.borderColor = ThemeColorEnum.ImageBorder.rawValue.cgColor
    }
    
    func addShadow(shadowColor: CGColor = UIColor.black.withAlphaComponent(0.7).cgColor,
                   shadowOffset: CGSize = CGSize(width: 1.0, height: 2.0),
                   shadowOpacity: Float = 0.4,
                   shadowRadius: CGFloat = 3.0) {
        layer.shadowColor = shadowColor
        layer.shadowOffset = shadowOffset
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
    }
    
}

