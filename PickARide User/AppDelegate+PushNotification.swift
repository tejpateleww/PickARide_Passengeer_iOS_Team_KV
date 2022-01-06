//
//  AppDelegate+PushNotification.swift
//  PickARide User
//
//  Created by apple on 6/29/21.
//  Copyright © 2021 EWW071. All rights reserved.
//

import Foundation
import IQKeyboardManagerSwift
import Firebase
import UserNotifications
import GoogleMaps
import SideMenuSwift
import FirebaseMessaging

extension AppDelegate{
    func registerForPushNotifications() {
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = self
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            
            UNUserNotificationCenter.current().requestAuthorization(options: authOptions, completionHandler: {_ , _ in })
            Messaging.messaging().delegate = self
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            UIApplication.shared.registerUserNotificationSettings(settings)
        }
        
        UIApplication.shared.registerForRemoteNotifications()
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        let token = fcmToken ?? "No Token found"
        print("Firebase registration token: \(fcmToken ?? "No Token found")")
        Singleton.sharedInstance.DeviceToken = token
        userDefaults.set(fcmToken, forKey: UserDefaultsKey.DeviceToken.rawValue)
        
        
        let dataDict:[String: String] = ["token": token]
        NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
        Messaging.messaging().token { token, error in
            if let error = error {
                print("Error fetching remote instance ID: \(error)")
            } else if let result = token {
                print("Remote instance ID token: \(result)")
                UserDefaults.standard.set(Singleton.sharedInstance.DeviceToken, forKey: UserDefaultsKey.DeviceToken.rawValue)
            }
        }
    }
    
    func messaging(_ messaging: Messaging, didRefreshRegistrationToken fcmToken: String) {
        print(fcmToken)
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        print(#function, notification)
        let content = notification.request.content
        let userInfo = notification.request.content.userInfo
        
        print(userInfo)
        print(appDel.window?.rootViewController?.navigationController?.children.first as Any)
        
        NotificationCenter.default.post(name: NotificationBadges, object: content)
       // completionHandler([.alert, .sound])
        print(#function, notification)
        
        
        if let mainDic = userInfo as? [String: Any]{
            
            let pushObj = NotificationObjectModel()
            if let bookingId = mainDic["gcm.notification.booking_id"]{
                pushObj.booking_id = bookingId as? String ?? ""
            }
            if let type = mainDic["gcm.notification.type"]{
                pushObj.type = type as? String ?? ""
            }
            if let title = mainDic["title"]{
                pushObj.title = title as? String ?? ""
            }
            if let text = mainDic["text"]{
                pushObj.text = text as? String ?? ""
            }
            
            AppDelegate.pushNotificationObj = pushObj
            AppDelegate.pushNotificationType = pushObj.type
            
            if pushObj.type == NotificationTypes.notifLoggedOut.rawValue {
                completionHandler([.alert, .sound])
                appDel.dologout()
                return
            }
            if pushObj.type == NotificationTypes.chat.rawValue {
                if let navVc = (appDel.window?.rootViewController as? UINavigationController)?.children.first?.children.first as? UINavigationController{
                    if let chatVc = navVc.topViewController as? ChatVC {
                        return
                    }
                    else {
                        completionHandler([.alert, .sound])
                    }
                }
            }
        }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        print("USER INFo : ",userInfo)
        
        if let mainDic = userInfo as? [String: Any]{
            
            let pushObj = NotificationObjectModel()
            if let bookingId = mainDic["gcm.notification.booking_id"]{
                pushObj.booking_id = bookingId as? String ?? ""
            }
            if let type = mainDic["gcm.notification.type"]{
                pushObj.type = type as? String ?? ""
            }
            if let title = mainDic["title"]{
                pushObj.title = title as? String ?? ""
            }
            if let text = mainDic["text"]{
                pushObj.text = text as? String ?? ""
            }
            
            AppDelegate.pushNotificationObj = pushObj
            AppDelegate.pushNotificationType = pushObj.type
            
            if pushObj.type == NotificationTypes.notifLoggedOut.rawValue {
                appDel.dologout()
                completionHandler()
                return
            }
        }
    }
}

extension Notification.Name {
    static let sessionExpire = NSNotification.Name("Logout")
    //static let refreshHomeScreen = NSNotification.Name("refreshHomeScreen")
}

enum NotificationTypes : String {
    case notifLoggedOut = "logout"
    case newBooking = "newBooking"
    case chat = "chat_notification"
}

class NotificationObjectModel: Codable {
    var booking_id: String?
    var type: String?
    var title: String?
    var text: String?
}
