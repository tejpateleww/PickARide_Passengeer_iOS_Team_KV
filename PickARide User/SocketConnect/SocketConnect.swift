//
//  SocketConnect.swift
//  Virtuwoof Pet
//
//  Created by EWW074 on 30/03/20.
//  Copyright © 2020 EWW80. All rights reserved.
//

import Foundation
import SocketIO
import SwiftyJSON

struct socketApikeys {
    
    static let BaseUrl =  "http://65.1.154.172:8080"
    static let KCustomerID      = "customer_id"
    static let KConnectCustomer  = "connect_customer"
        
  
    
}

protocol SocketConnected {
    
    func emitSocket_updateLocation(param: [String:Any])

     func onSocket_UpdateLocation()
}

extension HomeVC {
        
        // ----------------------------------------------------
        // MARK:- --- All Socket Methods ---
        // ----------------------------------------------------
        /// Socket On All
        func SocketOnMethods() {
            
            //        if !SocketIOManager.shared.isSocketOn {
            SocketIOManager.shared.socket.on(clientEvent: .disconnect) { (data, ack) in
                print ("socket is disconnected please reconnect")
                // SwiftMessages.hideAll()
                SocketIOManager.shared.isSocketOn = false
            }
            
            SocketIOManager.shared.socket.on(clientEvent: .reconnect) { (data, ack) in
                print ("socket is reconnected")
                SocketIOManager.shared.isSocketOn = true
                
            }
            
            SocketIOManager.shared.socket.on(clientEvent: .connect) { (data, ack) in
                print ("socket connected")
                SocketIOManager.shared.isSocketOn = true
                self.emitSocket_UserConnect()
                self.onSocketConnectUser()

            }
            //Connect User On Socket
            SocketIOManager.shared.establishConnection()
        }
        
        // Socket Emit Connect user
        func emitSocket_UserConnect(){
            let param = [
                
                socketApikeys.KCustomerID : Singleton.sharedInstance.UserId ?? ""
                
                
                ] as [String : Any]
            SocketIOManager.shared.socketEmit(for: socketApikeys.KConnectCustomer, with: param)
        }
        
        // Socket On Connect User
        func onSocketConnectUser() {
            SocketIOManager.shared.socketCall(for: socketApikeys.KConnectCustomer) { (json) in
                
                print(json)
               
            }
        }
    
//    //MARK:- ======== On socket Track update location ======
//    func onSocketTrackUpdateLocation(){
//        SocketIOManager.shared.socketCall(for: socketApikeys.KUpdateLocationTrack) { (json) in
//            print(json)
//        }
//    }
    
    //MARK:- ===== Socket Emit update location =======
//    func emitSocket_UpdateLocation(latitute:Double,long:Double,OrderID:String = ""){
//        let param = [
//            socketApikeys.KdeliveryBoyId :Int(SingletonClass.sharedInstance.LoginRegisterUpdateData?.id ?? "") ?? 0 ,
//            socketApikeys.Klat : SingletonClass.sharedInstance.currentLat ,
//            socketApikeys.Klong : SingletonClass.sharedInstance.currentLong
//           // socketApikeys.KOrderId : OrderID
//
//            ] as [String : Any]
//        SocketIOManager.shared.socketEmit(for: socketApikeys.updatedeliveryBoyLocation, with: param)
//    }
//
//
//
//
//    //MARK:- ====== On sokcet update Location ======
//    func onSocketUpdateLocation(){
//        SocketIOManager.shared.socketCall(for: socketApikeys.updatedeliveryBoyLocation) { (json) in
//            print(json)
//             let dict = json[0]
//
//            _ = dict["lat"].doubleValue
//            _ = dict["lng"].doubleValue
//
//          }
//      }
}
    
