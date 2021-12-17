//
//  UITextField+Extension.swift
//  CoreSound
//
//  Created by EWW083 on 03/02/20.
//  Copyright © 2020 EWW083. All rights reserved.
//

import UIKit

extension UITextField{
    
    //MARK:- ===== Set Cursor Position end Of The text ======
    func setCursorPosition(Textfield:UITextField,View:UIView){
        let point = CGPoint(x: View.bounds.maxX, y: View.bounds.height / 2)
        if let textPosition = Textfield.closestPosition(to: point) {
            Textfield.selectedTextRange = Textfield.textRange(from: textPosition, to: textPosition)
        }
    }
   
    //MARK:- Placeholder Color
   @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? (self.placeholder ?? "") : "", attributes:[NSAttributedString.Key.foregroundColor: newValue ?? UIColor()])
        }
    }
    
    func setBoarderColor(bcolor:colors){
        self.layer.borderColor  = bcolor.value.cgColor
        self.layer.borderWidth = 1
    }
    
    func validatedText(validationType: ValidatorType) -> (Bool,String) {
          let validator = VaildatorFactory.validatorFor(type: validationType)
          return validator.validated(self.text ?? "")
      }
    
    
    func setPasswordVisibility(vc: UIViewController, action: Selector) {
        let button = UIButton(type: .custom)
        button.isSelected = true
        button.setImage(ShowPassword, for: .normal)
        button.setImage(HidePassword, for: .selected)
        button.imageEdgeInsets = UIEdgeInsets(top: 5, left: -10, bottom: 0, right: 0)
        button.frame = CGRect(x: CGFloat(self.frame.size.width - 25), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
        button.tag = self.tag
        self.isSelected = true
        button.addTarget(vc, action: action, for: .touchUpInside)
        self.rightView = button
        self.rightViewMode = .always
    }
}

