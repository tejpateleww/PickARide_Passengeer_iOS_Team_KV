//
//  Theme.swift
//  PickARide User
//
//  Created by Harsh on 30/06/21.
//  Copyright © 2021 EWW071. All rights reserved.
//

import Foundation
import UIKit


class themeTextField : UITextField{
    
    @IBInspectable var Font_Size : CGFloat = 16.0
    @IBInspectable public var isbold: Bool = false
    @IBInspectable public var isMedium: Bool = false
    @IBInspectable public var islight: Bool = false
    @IBInspectable var Font_Color = UIColor.white
    override func awakeFromNib() {
        super.awakeFromNib()
        //            self.font = CustomFont.regular.returnFont(16.0)
        //            self.placeHolderColor = colors.lightGrey.value
        //            self.textColor = colors.lightGrey.value
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: self.frame.height))
        self.leftViewMode = .always
        self.layer.borderWidth = 1
        self.layer.borderColor = colors.textfieldbordercolor.value.cgColor
        self.tintColor = themeColor
        if isbold{
            self.font = CustomFont.bold.returnFont(Font_Size)
        }else if isMedium{
            self.font = CustomFont.medium.returnFont(Font_Size)
        }else if islight {
            self.font = CustomFont.light.returnFont(Font_Size)
        }else{
            self.font = CustomFont.regular.returnFont(Font_Size)
        }
    }
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}

class themeLabel : UILabel{
    @IBInspectable var Font_Size : CGFloat = 14.0
    @IBInspectable public var isbold: Bool = false
    @IBInspectable public var islight: Bool = false
    @IBInspectable public var isMedium: Bool = false
    //    @IBInspectable public var islight: Bool = false
    @IBInspectable public var isblack: Bool = false
    @IBInspectable public var isgray: Bool = false
    
    @IBInspectable public var fontColor: UIColor = hexStringToUIColor(hex: "000000")
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if isblack{
            self.textColor = colors.black.value
        }else if isgray{
            self.textColor = colors.gray.value
        }else{
            self.textColor = fontColor
        }
        
        if isbold{
            self.font = CustomFont.bold.returnFont(Font_Size)
        }else if isMedium{
            self.font = CustomFont.medium.returnFont(Font_Size)
        }else if islight{
            self.font = CustomFont.light.returnFont(Font_Size)
        }else{
            self.font = CustomFont.regular.returnFont(Font_Size)
        }
        //        self.textColor = fontColor
    }
    
    //    override func drawText(in rect: CGRect) {
    //        super.drawText(in: rect.inset(by: UIEdgeInsets(top: 0, left: 2, bottom: 0, right: 2)))
    //    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
}
class themeButton : UIButton{
    @IBInspectable var isShadow : Bool = false
    @IBInspectable var Font_Size : CGFloat = 14.0
    @IBInspectable public var isbold: Bool = false
    @IBInspectable public var isMedium: Bool = false
    @IBInspectable public var islight: Bool = false
    @IBInspectable var Font_Color = UIColor.white
    @IBInspectable public var isRound: Bool = false
    @IBInspectable var isthemeBg : Bool = false
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if isRound{
            self.layer.cornerRadius = self.frame.height/2
        }else{
            self.layer.cornerRadius = 4
         
        }
     
        if isthemeBg{
            self.tintColor = Font_Color
            self.backgroundColor = ThemeColorEnum.Theme.rawValue
            if isShadow == true {
                
                addShadow()
            }
        }else{
            self.backgroundColor = .clear
        }
        
        if isbold{
            self.titleLabel?.font = CustomFont.bold.returnFont(Font_Size)
        }else if isMedium{
            self.titleLabel?.font = CustomFont.medium.returnFont(Font_Size)
        }else if islight {
            self.titleLabel?.font = CustomFont.light.returnFont(Font_Size)
        }else{
            self.titleLabel?.font = CustomFont.regular.returnFont(Font_Size)
        }
    }
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//    }
    
    func addShadow(){
        let shadowPath = UIBezierPath(rect: self.bounds)
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor(hexString: "#222B45").cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 10)
        self.layer.shadowOpacity = 0.3
        self.layer.shadowRadius = 8
        self.layer.shadowPath = shadowPath.cgPath
    }
    
}
