//
//  String+DateFormats.swift
//  PickARide User
//
//  Created by apple on 7/13/21.
//  Copyright © 2021 EWW071. All rights reserved.
//

import Foundation
import UIKit

extension String{
    func getDateTimeFromTimeStamp() -> String{
        let timeStamp = Double(self) ?? 0.0
        let date = Date(timeIntervalSince1970: timeStamp)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormatsEnum.FullDateWithTime.rawValue
        dateFormatter.timeZone = .current
        return dateFormatter.string(from: date)
    }
}
