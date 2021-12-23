//
//  DateFormatterHelper.swift
//  PickARide User
//
//  Created by Admin on 17/12/21.
//  Copyright © 2021 EWW071. All rights reserved.
//

import Foundation


enum DateFormatHelper: String {
    case standard       = "yyyy-MM-dd HH:mm:ss" //2020-02-17 16:42:37
    case fullDateTime   = "dd MMM yyyy, h:mm a" //12 Jan 2020, 5:15 pm
    case fullDate       = "dd MMMM yyyy"
    case twentyHrTime   = "h:mma"
    //case dateformate   = "yyyy-MM-dd"
    case digitDate      = "yyyy-MM-dd" // 1992-07-07
    case TimeFormate =   "HH:mm:ss"
    case twelveHrTime   = "h:mm a"
    case dayDateMonth   = "E, d MMM" //Tue, 7 Sep
    case slashDate      = "dd/MM/yyyy"
    case ddMMyyyy = "dd-MM-yyyy"
    case onlyNameOfDay = "EEEE"


    var dateFormatter: DateFormatter {
        let dateformat = DateFormatter()
        dateformat.dateFormat = self.rawValue
        return dateformat
    }

    func getDateString(from date: Date) -> String {
        return dateFormatter.string(from: date).lowercased()
    }

    func getDate(from string: String) -> Date? {
        return dateFormatter.date(from: string)
    }
    
    

}
