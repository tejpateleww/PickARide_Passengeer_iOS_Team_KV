//
//  ColorsTypes.swift
//  PickARide User
//
//  Created by apple on 6/22/21.
//  Copyright © 2021 EWW071. All rights reserved.
//

import Foundation
import UIKit

enum ThemeColorEnum {
    case Theme
    case ThemeOrange
    case ThemeWhite
    case ThemeRed
    case ThemeYellow
    case ThemeGreen
    case ThemeGray
}

extension ThemeColorEnum: RawRepresentable {
    typealias RawValue = UIColor

    init?(rawValue: RawValue) {
        switch rawValue {
        case #colorLiteral(red: 0, green: 0.6666666667, blue: 0.4941176471, alpha: 1): self = .Theme
        case #colorLiteral(red: 1, green: 0.5450980392, blue: 0.4823529412, alpha: 1): self = .ThemeOrange
        case #colorLiteral(red: 0.937254902, green: 0.9254901961, blue: 0.937254902, alpha: 1): self = .ThemeWhite
        case #colorLiteral(red: 0.8745098039, green: 0.1019607843, blue: 0.2862745098, alpha: 1): self = .ThemeRed
        case #colorLiteral(red: 0.937254902, green: 0.7215686275, blue: 0.09411764706, alpha: 1): self = .ThemeYellow
        case #colorLiteral(red: 0.1019607843, green: 0.7764705882, blue: 0.1843137255, alpha: 1): self = .ThemeGreen
        case #colorLiteral(red: 0.4980392157, green: 0.4980392157, blue: 0.4980392157, alpha: 1): self = .ThemeGreen
        default: return nil
    }
}

var rawValue: RawValue {
        switch self {
        case .Theme: return #colorLiteral(red: 0, green: 0.6666666667, blue: 0.4941176471, alpha: 1)
        case .ThemeOrange: return #colorLiteral(red: 1, green: 0.5450980392, blue: 0.4823529412, alpha: 1)
        case .ThemeWhite: return #colorLiteral(red: 0.937254902, green: 0.9254901961, blue: 0.937254902, alpha: 1)
        case .ThemeRed: return #colorLiteral(red: 0.8745098039, green: 0.1019607843, blue: 0.2862745098, alpha: 1)
        case .ThemeYellow: return #colorLiteral(red: 0.937254902, green: 0.7215686275, blue: 0.09411764706, alpha: 1)
        case .ThemeGreen: return #colorLiteral(red: 0.1019607843, green: 0.7764705882, blue: 0.1843137255, alpha: 1)
        case .ThemeGray: return #colorLiteral(red: 0.4980392157, green: 0.4980392157, blue: 0.4980392157, alpha: 1)
        }
    }
}