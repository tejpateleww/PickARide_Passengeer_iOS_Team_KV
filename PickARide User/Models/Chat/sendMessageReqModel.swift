//
//  sendMessageReqModel.swift
//  PickaRideDriver
//
//  Created by Tej on 06/10/21.
//

import Foundation

class sendMessageReqModel1 : Encodable{
    var senderId : String? = Singleton.sharedInstance.UserId
    var receiverId: String?
    var message: String?
    var senderType: String?
    var receiverType: String?
    var bookingId: String?
    
    enum CodingKeys: String, CodingKey {
        case senderId = "sender_id"
        case receiverId = "receiver_id"
        case message = "message"
        case senderType = "sender_type"
        case receiverType = "receiver_type"
        case bookingId = "booking_id"
    }
}

class DispatcherChatRequestModel : Encodable{
    var customerID : String? = Singleton.sharedInstance.UserId
    var dispatcherId: String?
   
    enum CodingKeys: String, CodingKey {
        case customerID = "customer_id"
        case dispatcherId = "dispatcher_id"
     }
}


class sendMessageReqModel : RequestModel {
    var sender_id : String = ""
    var receiver_id : String = ""
    var message : String = ""
    var sender_type : String = ""
    var receiver_type : String = ""
    var booking_id : String = ""
}



class RequestModel
{
    
    func  generatPostParams() -> [String : Any]
    {
        
        var params = [:] as [String : Any]
        
        let bookMirror = Mirror(reflecting: self)
        for (name, value) in bookMirror.children {
            guard let name = name else { continue }
            params[name] = "\(value)"
            
            
            print("\(name): \(type(of: value)) = '\(value)'")
        }
        return params
    }
    
    func  generatGetParams() -> String
    {
        
        var url_params : String = ""
        
        
        let bookMirror = Mirror(reflecting: self)
        
        for (name, value) in bookMirror.children {
            guard let name = name else { continue }
            
            if value as? String != "" {
                if(url_params.isEmpty)
                {
                    url_params = "?"+"\(name)="+"\(value)"
                }
                else{
                    url_params += "&"+"\(name)="+"\(value)"
                }
            }
            
            print("\(name): \(type(of: value)) = '\(value)'")
        }
        
        print("params")
        print(url_params)
        return url_params
    }
    
    
    
    
    func generatGetParams_() -> String
    {
        
        var url_params : String = ""
        
        
        let bookMirror = Mirror(reflecting: self)
        
        for children in bookMirror.children {
            
            let name_ : String = children.label!
            // guard  let name = name_ else { continue }
            
            let value : String = children.value as! String;
            
            print("\(name_): \(type(of: value)) = '\(value)'")
            if let value_ = value.encodeUTF8() {
                
                
                if (value_ != "" )
                {
                    if(url_params.isEmpty)
                    {
                        url_params = "?"+"\(name_)="+"\(value_)"
                    }
                    else{
                        url_params += "&"+"\(name_)="+"\(value_)"
                    }
                }
                
                
            }else {
                
            }
            
            print("\(name_): \(type(of: value)) = '\(value)'")
        }
        
        print("params")
        print(url_params)
        return url_params
    }
    
    
}

