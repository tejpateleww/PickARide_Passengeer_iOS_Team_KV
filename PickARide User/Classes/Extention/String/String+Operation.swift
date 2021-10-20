//
//  extension+String.swift
//  Virtuwoof Pet
//
//  Created by EWW80 on 02/10/19.
//  Copyright © 2019 EWW80. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    func grouping(every groupSize: String.IndexDistance, with separator: Character) -> String {
        let cleanedUpCopy = replacingOccurrences(of: String(separator), with: "")
        return String(cleanedUpCopy.enumerated().map() {
            $0.offset % groupSize == 0 ? [separator, $0.element] : [$0.element]
            }.joined().dropFirst())
    }
    
    func isEmptyOrWhitespace() -> Bool {
        
        return self.trimmingCharacters(in: (.whitespaces)).isEmpty
    }
    func toDouble() -> Double? {
        return NumberFormatter().number(from: self)?.doubleValue
    }
    
    
    
    func trim() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    /// - Returns: formatted phone number or original value
    public func toPhoneNumber() -> String {
        let digits = self.digitsOnly
        if digits.count == 10 {
            return digits.replacingOccurrences(of: "(\\d{3})(\\d{3})(\\d+)", with: "($1)-$2-$3", options: .regularExpression, range: nil)
        }
        else if digits.count == 11 {
            return digits.replacingOccurrences(of: "(\\d{1})(\\d{3})(\\d{3})(\\d+)", with: "$1($2)-$3-$4", options: .regularExpression, range: nil)
        }
        else {
            return self
        }
    }
    
    func encodeUTF8() -> String? {
        
        //If I can create an NSURL out of the string nothing is wrong with it
        if let _ = URL(string: self) {
            
            return self
        }
        
        //Get the last component from the string this will return subSequence
        let optionalLastComponent = self.split { $0 == "/" }.last
        
        
        if let lastComponent = optionalLastComponent {
            
            //Get the string from the sub sequence by mapping the characters to [String] then reduce the array to String
            let lastComponentAsString = lastComponent.map { String($0) }.reduce("", +)
            
            
            //Get the range of the last component
            if let rangeOfLastComponent = self.range(of: lastComponentAsString) {
                //Get the string without its last component
                let stringWithoutLastComponent = self.substring(to: rangeOfLastComponent.lowerBound)
                
                
                //Encode the last component
                if let lastComponentEncoded = lastComponentAsString.addingPercentEncoding(withAllowedCharacters: CharacterSet.alphanumerics) {
                    
                    
                    //Finally append the original string (without its last component) to the encoded part (encoded last component)
                    let encodedString = stringWithoutLastComponent + lastComponentEncoded
                    
                    //Return the string (original string/encoded string)
                    return encodedString
                }
            }
        }
        
        return nil;
    }

}
extension StringProtocol {
    
    /// Returns the string with only [0-9], all other characters are filtered out
    var digitsOnly: String {
        return String(filter(("0"..."9").contains))
    }
    
}
extension Date {
    func currentTimeZoneDate() -> String {
        let dtf = DateFormatter()
        dtf.timeZone = TimeZone.current
        dtf.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        return dtf.string(from: self)
    }

        func timeAgoSinceDate(isForNotification : Bool = false) -> String {
            
            let weekdays = [
                "Sunday",
                "Monday",
                "Tuesday",
                "Wednesday",
                "Thursday",
                "Friday",
                "Saturday"
            ]
            
            let calendar = NSCalendar.current
            
            let dateFormatter = DateFormatter()
            dateFormatter.timeZone = TimeZone(identifier: "Europe/London") //TimeZone.current
            
            if calendar.isDateInToday(self) {
                var title = "Today"
                if !isForNotification{
                    dateFormatter.dateFormat = "h:mm a"
                    title = "Today, " + dateFormatter.string(from: self)
                }
                return title
            }else if calendar.isDateInTomorrow(self) {
                var title = "Tomorrow"
                if !isForNotification{
                    dateFormatter.dateFormat = "h:mm a"
                    title = "Tomorrow, " + dateFormatter.string(from: self)
                }
                return title
            }else if calendar.isDateInYesterday(self) {
                var title = "Yesterday"
                if !isForNotification{
                    dateFormatter.dateFormat = "h:mm a"
                    title = "Yesterday, " + dateFormatter.string(from: self)
                }
                return title
                
            }else{
                if isForNotification{
                    dateFormatter.dateFormat = "yyyy-MM-dd"
                }else{
                    dateFormatter.dateFormat = "yyyy-MM-dd, h:mm a"
                }
                return dateFormatter.string(from: self)
            }
        }
    }
extension String {
    
    var ampmDateString: String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        if let date = dateFormatter.date(from: self){
            dateFormatter.dateFormat = "h:mm a"
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            return dateFormatter.string(from: date)
        }
        else{
            return nil
        }
    }
    
    ///"2020-03-26 00:00:00
    
    var serverDateStringToDateType1: Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        return dateFormatter.date(from: self)
    }
    
    func convertDateString(inputFormat: DateFormatInputType, outputFormat: DateFormatOutputType) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = inputFormat.rawValue
        
        if let date = dateFormatter.date(from: self) {
            dateFormatter.dateFormat = outputFormat.rawValue
            return  dateFormatter.string(from: date)
        }else{
            print("Could not get the dat string from dateformattere")
            return ""
        }
    }
    
    
    
    //    func convertToDate(inputFormat: DateFormatInputType) -> Date? {
    //
    //        UtilityClass.commonDateFormatter.locale = Locale(identifier: "en_US_POSIX")
    //        UtilityClass.commonDateFormatter.dateFormat = inputFormat.rawValue
    //
    //        if let date = UtilityClass.commonDateFormatter.date(from: self) {
    //            print("Date got successfully")
    //            return date
    //        }else{
    //            print("Could not find the date correctly")
    //            return nil
    //       }
    //
    //    }
    
    
}







extension NSMutableAttributedString {
 var fontSize:CGFloat { return 18 }
    var normalFont:UIFont { return CustomFont.regular.returnFont(fontSize) }
    
    func bold(_ value:String , fontSize : CGFloat,  fontColor : UIColor = .white) -> NSMutableAttributedString {
        
        let attributes:[NSAttributedString.Key : Any] = [
            .font : CustomFont.bold.returnFont(fontSize) ,//boldFont,
            .foregroundColor : fontColor
        ]
        
        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
    
    func normal(_ value:String, fontSize : CGFloat , fontColor : UIColor = .white) -> NSMutableAttributedString {
        
        let attributes:[NSAttributedString.Key : Any] = [
            .font : CustomFont.medium.returnFont(fontSize),//normalFont,
            .foregroundColor : fontColor
        ]
        
        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
    /* Other styling methods */
    func orangeHighlight(_ value:String) -> NSMutableAttributedString {
        
        let attributes:[NSAttributedString.Key : Any] = [
            .font :  normalFont,
            .foregroundColor : UIColor.white,
            .backgroundColor : UIColor.orange
        ]
        
        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
    
    func blackHighlight(_ value:String) -> NSMutableAttributedString {
        
        let attributes:[NSAttributedString.Key : Any] = [
            .font :  normalFont,
            .foregroundColor : UIColor.white,
            .backgroundColor : UIColor.black
            
        ]
        
        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
    
    func underlined(_ value:String) -> NSMutableAttributedString {
        
        let attributes:[NSAttributedString.Key : Any] = [
            .font :  normalFont,
            .underlineStyle : NSUnderlineStyle.single.rawValue
            
        ]
        
        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
}

