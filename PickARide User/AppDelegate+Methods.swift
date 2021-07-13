//
//  AppDelegate+Methods.swift
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
import GooglePlaces
import SideMenuSwift
import GoogleSignIn
import FBSDKLoginKit

extension AppDelegate{
    func checkAndSetDefaultLanguage() {
        if userDefaults.value(forKey: UserDefaultsKey.selLanguage.rawValue) == nil {
            setLanguageEnglish()
        }
    }
    
    func setLanguageEnglish() {
        userDefaults.setValue("en", forKey: UserDefaultsKey.selLanguage.rawValue)
    }
    
    func setupNavigation(){
        let attributes = [NSAttributedString.Key.font: CustomFont.medium.returnFont(23),NSAttributedString.Key.foregroundColor:UIColor.white]
        UINavigationBar.appearance().titleTextAttributes = attributes
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().barTintColor = UIColor.white
        UINavigationBar.appearance().isTranslucent = true
    }
    
    func navigateToLogin(){
        let storyborad = UIStoryboard(name: "Login", bundle: nil)
        let splash = storyborad.instantiateViewController(withIdentifier: LoginVC.className) as! LoginVC
        let NavHomeVC = UINavigationController(rootViewController: splash)
        NavHomeVC.navigationBar.isHidden = true
        self.window?.rootViewController = NavHomeVC
    }
    
    func navigateToMain(){
        let storyborad = UIStoryboard(name: "Main", bundle: nil)
        let Home = storyborad.instantiateViewController(withIdentifier: SideMenuController.className) as! SideMenuController
        let HomeVC = UINavigationController(rootViewController: Home)
        HomeVC.navigationBar.isHidden = true
        self.window?.rootViewController = HomeVC
    }
    
    func clearData(){
        for (key, value) in UserDefaults.standard.dictionaryRepresentation() {
            
            if key != UserDefaultsKey.DeviceToken.rawValue && key  != "language"  {
                print("\(key) = \(value) \n")
                 UserDefaults.standard.removeObject(forKey: key)
            }
        }
        
        
        userDefaults.set(false, forKey: UserDefaultsKey.isUserLogin.rawValue)
        Singleton.sharedInstance.clearSingletonClass()
        userDefaults.setUserData()
    }
    
    func dologout(){
        
    }
}
