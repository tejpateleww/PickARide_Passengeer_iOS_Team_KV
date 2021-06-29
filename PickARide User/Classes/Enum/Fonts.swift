//
//  Fonts.swift
//  CoreSound
//
//  Created by EWW083 on 04/02/20.
//  Copyright © 2020 EWW083. All rights reserved.
//
import Foundation
import UIKit
enum CustomFont{
    case italic,lightitalic,medium,light,mediumitalic,bold,bolditalic,regular
    
    func returnFont(_ font:CGFloat) -> UIFont{
        switch self {
            case .italic: return UIFont(name: "Ubuntu-Italic", size: font) ?? UIFont()
            case .lightitalic: return UIFont(name: "Ubuntu-LightItalic", size: font) ?? UIFont()
            case .medium: return UIFont(name: "Ubuntu-Medium", size: font) ?? UIFont()
            case .light: return UIFont(name: "Ubuntu-Light", size: font) ?? UIFont()
            case .mediumitalic: return UIFont(name: "Ubuntu-MediumItalic", size: font) ?? UIFont()
            case .bold: return UIFont(name: "Ubuntu-Bold", size: font) ?? UIFont()
            case .bolditalic: return UIFont(name: "Ubuntu-BoldItalic", size: font) ?? UIFont()
            case .regular: return UIFont(name: "Ubuntu-Regular", size: font) ?? UIFont()
        }
    }
}
