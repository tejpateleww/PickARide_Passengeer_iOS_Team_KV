//
//  SplashVC.swift
//  PickARide User
//
//  Created by Apple on 14/12/20.
//  Copyright © 2020 EWW071. All rights reserved.
//

import UIKit
import SideMenuSwift
import CoreLocation

class SplashVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let _ = userDefaults.getUserData()
        
        DispatchQueue.global(qos: .background).async {
            self.webserviceGetCountryList()
            self.webserviceGetCardList()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.webserviceInit()
        }
    }
}

//MARK:- Apis
extension SplashVC{
    func webserviceInit(){
        WebServiceSubClass.InitApi { (status, message, response, error) in
            if let dic = error as? [String: Any], let msg = dic["message"] as? String, msg == UrlConstant.NoInternetConnection || msg == UrlConstant.SomethingWentWrong || msg == UrlConstant.RequestTimeOut{
                Utilities.showAlertWithTitleFromVC(vc: self, title: "", message: msg, buttons: [UrlConstant.Retry], isOkRed: false) { (ind) in
                    self.webserviceInit()
                }
                return
            }
            
            if status {
                Singleton.sharedInstance.AppInitModel = response
                if let responseDic = error as? [String:Any], let _ = responseDic["update"] as? Bool{
                    Utilities.showAlertWithTitleFromWindow(title: "", andMessage: message, buttons: [UrlConstant.Ok,UrlConstant.Cancel]) { (ind) in
                        if ind == 0{
                            if let url = URL(string: AppURL) {
                                UIApplication.shared.open(url)
                            }
                        }else {
                            self.setRootViewController()
                        }
                    }
                }
                else if  let responseDic = error as? [String:Any], let _ = responseDic["app_links"]{
 
                    guard  let obj = response else { return }
                    if obj.appLinks?.count != 0 {
                        guard let appLink = obj.appLinks else { return }
                        for i in appLink {
                            let name = i.name
                            switch name{
                            case "terms_and_condition" :
                                Singleton.sharedInstance.termsConditionURL = i.url ?? ""
                            case "privacy_policy" :
                                Singleton.sharedInstance.PrivacyUrl = i.url ?? ""
                            case "help" :
                                Singleton.sharedInstance.HelpUrl = i.url ?? ""
                            default:
                                break
                            }
                        }
                    }
                    self.setRootViewController()
                    
                }
                else{
                    self.setRootViewController()
                }
            }else{
                if let responseDic = error as? [String:Any], let _ = responseDic["maintenance"] as? Bool{
                    //MARK:- OPEN MAINTENANCE SCREEN
                    Utilities.showAlertWithTitleFromWindow(title: "", andMessage: message, buttons: []) {_ in}
                }else{
                    if let responseDic = error as? [String:Any], let _ = responseDic["update"] as? Bool{
                        self.openForceUpdateAlert(msg: message)
                    }else{
                        Utilities.showAlertOfAPIResponse(param: error, vc: self)
                    }
                }
            }
            
            DispatchQueue.global(qos: .background).async {
                self.webserviceGetCountryList()
                self.webserviceGetCardList()
            }
        }
    }
    
    func webserviceGetCountryList(){
        WebServiceSubClass.GetCountryList {_, _, _, _ in}
    }
    
    func webserviceGetCardList(){
        WebServiceSubClass.CardListApi {_, _, _, _ in}
    }
}

//MARK:- Methods
extension SplashVC{
    func openForceUpdateAlert(msg: String){
        Utilities.showAlertWithTitleFromWindow(title: "", andMessage: msg, buttons: [UrlConstant.Ok]) { (ind) in
            if ind == 0{
                if let url = URL(string: AppURL) {
                    UIApplication.shared.open(url)
                }
                self.openForceUpdateAlert(msg: msg)
            }
        }
    }
    
    func setRootViewController() {
        let isLogin = UserDefaults.standard.bool(forKey: UserDefaultsKey.isUserLogin.rawValue)
        
        if isLogin, let _ = userDefaults.getUserData() {
            appDel.navigateToMain()
        }else{
            appDel.navigateToLogin()
        }
    }
}

