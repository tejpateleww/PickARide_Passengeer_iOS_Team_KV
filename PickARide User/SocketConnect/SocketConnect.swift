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
    static let KGetEstimateFare = "get_estimate_fare"
    static let KAcceptBookingRequest = "accept_booking_request"
    static let KCancelTrip       = "cancel_trip"
    static let KStartTrip        = "start_trip"
    static let KCompleteTrip       = "complete_trip"
    static let KPickupLat = "pickup_lat"
    static let KPickupLng  = "pickup_lng"
    static let KDropOffLat = "dropoff_lat"
    static let KDropOffLng  = "dropoff_lng"
    static let KCityName = "city_name"
    static let KdriverArrived  = "arrived_at_pickup_location"
    static let KCancelBookingRequestBySystem = "cancelled_booking_request_by_system"
    static let KLiveTracking = "live_tracking"
    static let KstartTrip = "start_trip"
    static let KNearByDriver = "near_by_driver"
    static let KCurrentLat = "current_lat"
    static let KCurrentLng  = "current_lng"
    static let KVerifyCustomer = "verify_customer"
    static let KSendMsg       = "send_message"
    static let KReceiveMsg   = "receive_message"
        
    
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
            Utilities.showHud()
            //        if !SocketIOManager.shared.isSocketOn {
            SocketIOManager.shared.socket.on(clientEvent: .disconnect) { (data, ack) in
                print ("socket is disconnected please reconnect")
                // SwiftMessages.hideAll()
                SocketIOManager.shared.isSocketOn = false
                Utilities.hideHud()
            }
            
            SocketIOManager.shared.socket.on(clientEvent: .reconnect) { (data, ack) in
                print ("socket is reconnected")
                SocketIOManager.shared.isSocketOn = true
                Utilities.hideHud()

                
            }
            
            SocketIOManager.shared.socket.on(clientEvent: .connect) { (data, ack) in
                print ("socket connected")
                SocketIOManager.shared.isSocketOn = true
                // hiding loading hud in on socket connected method
                self.onSocketConnectUser()
                self.emitSocket_UserConnect()
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
                Utilities.hideHud()
                print(json)
                self.allSocketOffMethod()
                self.onSocketGetEstimateFare()
                self.onSocketAcceptDriverRequest()
                self.onSocketCancellBySysteem()
                self.OnSocketArrivedLocation()
                self.OnSocketStartTrip()
                self.OnSocketLiveTracking()
                self.onSocketNearByDriver()
                self.onSocketCancelTrip()
                self.onsocketVerifyCustomer()
                self.OnSocketCompleteTrip()
              
            }
        }
    
    func allSocketOffMethod(){
        SocketIOManager.shared.socket.off(socketApikeys.KCancelTrip)
        SocketIOManager.shared.socket.off(socketApikeys.KdriverArrived)
        SocketIOManager.shared.socket.off(socketApikeys.KGetEstimateFare)
        SocketIOManager.shared.socket.off(socketApikeys.KAcceptBookingRequest)
        SocketIOManager.shared.socket.off(socketApikeys.KdriverArrived)
        SocketIOManager.shared.socket.off(socketApikeys.KStartTrip)
        SocketIOManager.shared.socket.off(socketApikeys.KLiveTracking)
        SocketIOManager.shared.socket.off(socketApikeys.KNearByDriver)
        SocketIOManager.shared.socket.off(socketApikeys.KVerifyCustomer)
        SocketIOManager.shared.socket.off(socketApikeys.KCompleteTrip)


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
    
