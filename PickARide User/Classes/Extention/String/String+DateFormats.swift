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
    
    func timeInterval() -> String
    {
        let dateFormat = "yyyy-MM-dd H:mm:ss"
        let df = DateFormatter()
        
        df.dateFormat = dateFormat
        let dateWithTime = df.date(from: self)
        
        let interval = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: dateWithTime ?? Date(), to: Date())
        
        if let year = interval.year, year > 0 {
            return year == 1 ? "\(year)" + " " + "year ago" : "\(year)" + " " + "years ago"
        } else if let month = interval.month, month > 0 {
            return month == 1 ? "\(month)" + " " + "month ago" : "\(month)" + " " + "months ago"
        } else if let day = interval.day, day > 0 {
            return day == 1 ? "\(day)" + " " + "day ago" : "\(day)" + " " + "days ago"
        }else if let hour = interval.hour, hour > 0 {
            return hour == 1 ? "\(hour)" + " " + "hour ago" : "\(hour)" + " " + "hours ago"
        }else if let minute = interval.minute, minute > 0 {
            return minute == 1 ? "\(minute)" + " " + "minute ago" : "\(minute)" + " " + "minutes ago"
        }else if let second = interval.second, second > 0 {
            return second == 1 ? "\(second)" + " " + "second ago" : "\(second)" + " " + "seconds ago"
        } else {
            return "Just Now"
            
        }
    }
    
    //MARK:- Get Date From String
    func getDateFromString(formatter: DateFormatsEnum) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formatter.rawValue
        return dateFormatter.date(from: self)
        //https://stackoverflow.com/questions/35700281/date-format-in-swift
    }
    
    //MARK:- Get Formated Date String From String
    func getDateFromString(formatter: DateFormatsEnum = DateFormatsEnum.DateWithFullTime) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormatsEnum.DateWithFullTime.rawValue
        
        let strDateFormatter = DateFormatter()
        strDateFormatter.dateFormat = formatter.rawValue
        return strDateFormatter.string(from: dateFormatter.date(from: self) ?? Date())
    }
}

