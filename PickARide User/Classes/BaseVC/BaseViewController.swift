//
//  ViewController.swift
//  HJM
//
//  Created by EWW082 on 19/08/19.
//  Copyright © 2019 EWW082. All rights reserved.
//

import UIKit
//import LGSideMenuController

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        self.UpdateView()
    }
//    
//    var lblNavNotifBadge = badgeLabel()
//    var btnNavProfile = buttonForProfile()
//    var switchNavLanguage = switchLanguageSegment()
//    var btnNavSkip = themeSubmitBtn()
    
    func setNavigationBarInViewController (controller : UIViewController,naviColor : UIColor, naviTitle : String, leftImage : String , rightImages : [String], isTranslucent : Bool)
    {
        UIApplication.shared.statusBarStyle = .lightContent
        controller.navigationController?.isNavigationBarHidden = false
        controller.navigationController?.navigationBar.isOpaque = false;
        
        controller.navigationController?.navigationBar.isTranslucent = isTranslucent
        
        controller.navigationController?.navigationBar.barTintColor = naviColor;
        controller.navigationController?.navigationBar.tintColor = colors.white.value;
        if naviTitle == NavTitles.Home.value {
            controller.navigationItem.titleView = UIView()
        } else {
            let label = UILabel()
            label.text = naviTitle
            label.textColor = colors.black.value
            label.font = CustomFont.bold.returnFont(20)
            label.adjustsFontSizeToFitWidth = true
           // controller.navigationItem.title = naviTitle //.Localized()
            controller.navigationItem.titleView = label
        }
            //controller.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : colors.black.value, NSAttributedString.Key.font: CustomFont.bold.returnFont(20)]
        
       
        controller.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        controller.navigationController?.navigationBar.shadowImage = UIImage()

        if leftImage != "" {
            if leftImage == NavItemsLeft.back.value {
                let btnLeft = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
                btnLeft.setImage(UIImage.init(named: "nav_back"), for: .normal)
                btnLeft.layer.setValue(controller, forKey: "controller")
                btnLeft.addTarget(self, action: #selector(self.btnBackAction), for: .touchUpInside)
                let LeftView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
                LeftView.addSubview(btnLeft)
            
                let btnLeftBar : UIBarButtonItem = UIBarButtonItem.init(customView: LeftView)
                btnLeftBar.style = .plain
                controller.navigationItem.leftBarButtonItem = btnLeftBar
            } else if leftImage == NavItemsLeft.skip.value {
//                let LeftView = viewWithClearBg(frame: CGRect(x: 0, y: 0, width: 48, height: 31))
//                btnNavSkip = themeSubmitBtn(frame: CGRect(x: 0, y: 0, width: 48, height: 31))
//                btnNavSkip.setImage(UIImage.init(named: "skipArrow"), for: .normal)
//                btnNavSkip.setTitle("login_btnSkip".Localized(), for: .normal)
//                btnNavSkip.semanticContentAttribute = .forceRightToLeft
//                btnNavSkip.isSkipBtn = true
//                btnNavSkip.addTarget(self, action: #selector(self.btnSkipAction), for: .touchUpInside)
//                LeftView.addSubview(btnNavSkip)
//
//                let btnLeftBar : UIBarButtonItem = UIBarButtonItem.init(customView: LeftView)
//                btnLeftBar.style = .plain
//                controller.navigationItem.leftBarButtonItem = btnLeftBar
            }
        }
        if rightImages.count != 0 {
            var arrButtons = [UIBarButtonItem]()
            rightImages.forEach { (title) in
                if title == NavItemsRight.notifications.value {
//                    let vwNotif = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
//
//                    let btnNotif = UIButton.init()
//                    btnNotif.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
//                    btnNotif.setImage(UIImage.init(named: "ic_notification"), for: .normal)
//                    btnNotif.addTarget(self, action: #selector(OpenNotificationsVC(_:)), for: .touchUpInside)
//                    btnNotif.layer.setValue(controller, forKey: "controller")
//                    vwNotif.addSubview(btnNotif)
//
//                    lblNavNotifBadge = badgeLabel.init(frame: CGRect(x: 26, y: 0, width: 17, height: 17))
//                    lblNavNotifBadge.isNotifBadge = true
//                    lblNavNotifBadge.text = "0"
//                    vwNotif.addSubview(lblNavNotifBadge)
//
//                    let btnRightBar : UIBarButtonItem = UIBarButtonItem.init(customView: vwNotif)
//                    btnRightBar.style = .plain
//                    arrButtons.append(btnRightBar)
                }
//                else if title == NavItemsRight.profile.value {
//                    let vwProfile = viewfullCornerRadiusForProfile(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
//
//                    btnNavProfile = buttonForProfile.init(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
//                    btnNavProfile.addTarget(self, action: #selector(OpenOtherProfileVC(_:)), for: .touchUpInside)
//                    btnNavProfile.layer.setValue(controller, forKey: "controller")
//                    vwProfile.addSubview(btnNavProfile)
//
//                    let btnRightBar : UIBarButtonItem = UIBarButtonItem.init(customView: vwProfile)
//                    btnRightBar.style = .plain
//                    arrButtons.append(btnRightBar)
//                }
               
            }
            controller.navigationItem.rightBarButtonItems = arrButtons
        }
        
        /*
        if rightImage != "" {
            
            let btnRight = UIButton.init()
            btnRight.setImage(UIImage.init(named: rightImage), for: .normal)
            btnRight.layer.setValue(controller, forKey: "controller")
            
//            if rightImage == iconWhiteCall {
                btnRight.addTarget(self, action: #selector(self.btnCallAction), for: .touchUpInside)
//            }
            
            let btnRightBar : UIBarButtonItem = UIBarButtonItem.init(customView: btnRight)
            btnRightBar.style = .plain
            controller.navigationItem.rightBarButtonItem = btnRightBar
            
        }
        */
        
    }
    
    func UpdateView() {
        
        if let lang = userDefault.value(forKey: "language") as? String {
//            if lang == LanguageKey.EnglishLanguage {
//                UIView.appearance().semanticContentAttribute = .forceLeftToRight
//                UITableView.appearance().semanticContentAttribute = .forceLeftToRight
//                self.view.semanticContentAttribute = .forceLeftToRight
//                UITextView.appearance().semanticContentAttribute = .forceLeftToRight
//                UITextField.appearance().semanticContentAttribute = .forceLeftToRight
//                UILabel.appearance().semanticContentAttribute = .forceLeftToRight
//            }
//            else {
//                UIView.appearance().semanticContentAttribute = .forceRightToLeft
//                UITableView.appearance().semanticContentAttribute = .forceRightToLeft
//                self.view.semanticContentAttribute = .forceRightToLeft
//                UITextView.appearance().semanticContentAttribute = .forceRightToLeft
//                UITextField.appearance().semanticContentAttribute = .forceRightToLeft
//                UILabel.appearance().semanticContentAttribute = .forceRightToLeft
//            }
        }
    }
    
    func LanguageUpdate() {
        
        if let lang = userDefault.value(forKey: "language") as? String {
//            if lang == LanguageKey.EnglishLanguage {
//                self.navigationController?.navigationBar.semanticContentAttribute = .forceLeftToRight
//                if let NavController = self.navigationController?.children {
//                    NavController.last?.view.semanticContentAttribute = .forceLeftToRight
//                }
//            }
//            else {
                self.navigationController?.navigationBar.semanticContentAttribute = .forceRightToLeft
                if let NavController = self.navigationController?.children {
                    NavController.last?.view.semanticContentAttribute = .forceRightToLeft
                }
//            }
        }
    }
    
//    @objc func  EditProfileViewController(_ sender: UIButton?) {
//        guard let ProfilePage = sender?.layer.value(forKey: "controller") as? ProfileViewController else {
//            return
//        }
//        ProfilePage.EditTapped()
//    }
    
//    @objc func  ShowTickets(_ sender: UIButton?) {
//        guard let controller = sender?.layer.value(forKey: "controller") as? GenerateTicketVC else {
//            return
//        }
//        let TickelistPage:MyTicketVC = UIViewController.viewControllerInstance(storyBoard: AppStoryboards.Help)
//        controller.navigationController?.pushViewController(TickelistPage, animated: true)
//    }
    
//    @objc func  SelectPremium(_ sender: UIButton?) {
////        guard sender == UIButton else {
////            return
////        }
//        self.btnPremium.isSelected = !self.btnPremium.isSelected
//        self.isPremiumBooking = self.btnPremium.isSelected
//        if self.btnPremium.isSelected {
//
//            let  infoPopup:HeaderWithDescription = UIViewController.viewControllerInstance(storyBoard: AppStoryboards.CustomPopup)
//            infoPopup.Title = "Premium Search"
//            infoPopup.Desc = UtilityClass.GetPremiumDesc()
//        appDel.window?.rootViewController?.present(infoPopup, animated: true, completion: nil)
//        }
//
//    }
    
    @objc func OpenSideMenu(_ sender: UIButton?) {
//        let controller = sender?.layer.value(forKey: "controller") as? UIViewController
//        let vc = AppStoryboard.Popup.instance.instantiateViewController(withIdentifier: SideMenuVC.storyboardID)
//        let navController = UINavigationController.init(rootViewController: vc)
//        navController.modalPresentationStyle = .overFullScreen
//        navController.navigationController?.modalTransitionStyle = .crossDissolve
//        controller?.present(navController, animated: false, completion: nil)
    }
    
    @objc func OpenMailVC(_ sender: UIButton?) {
   
//        controller?.navigationController?.pushViewController(docInfoVc, animated: true)
    }
    
    @objc func OpenNotificationsVC(_ sender: UIButton?) {
//        let controller = sender?.layer.value(forKey: "controller") as? UIViewController
//        let notifVc = AppStoryboard.Home.instance.instantiateViewController(withIdentifier: NotificationsListVC.storyboardID)
//        controller?.navigationController?.pushViewController(notifVc, animated: true)
    }
    
    @objc func OpenOtherProfileVC(_ sender: UIButton?) {
//        let controller = sender?.layer.value(forKey: "controller") as? UIViewController
//        let notifVc = AppStoryboard.Home.instance.instantiateViewController(withIdentifier: ProfileVC.storyboardID)
//        controller?.navigationController?.pushViewController(notifVc, animated: true)
    }
    
    @objc func OpenChatVC(_ sender: UIButton?) {
//            let controller = sender?.layer.value(forKey: "controller") as? UIViewController
//            let chatVc = AppStoryboard.Home.instance.instantiateViewController(withIdentifier: MedicalFollowUpChatVC.storyboardID)
           // controller?.navigationController?.pushViewController(chatVc, animated: true)
        }
    @objc func OpenEditProfileVC(_ sender: UIButton?) {
//        let controller = sender?.layer.value(forKey: "controller") as? UIViewController
//        let notifVc = AppStoryboard.Home.instance.instantiateViewController(withIdentifier: ProfileVC.storyboardID)
//        controller?.navigationController?.pushViewController(notifVc, animated: true)
    }
    
    @objc func DismissViewController (_ sender: UIButton?)
    {
        let controller = sender?.layer.value(forKey: "controller") as? UIViewController
        controller?.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    @objc func poptoViewController (_ sender: UIButton?)
    {
        let controller = sender?.layer.value(forKey: "controller") as? UIViewController
        controller?.navigationController?.popViewController(animated: true)
    }
    @objc func OpenMenuViewController (_ sender: UIButton?)
    {
       
//        let controller = sender?.layer.value(forKey: "controller") as? UIViewController
//        controller?.frostedViewController.view.endEditing(true)
//        controller?.frostedViewController.presentMenuViewController()
        //        controller?.sideMenuViewController?._presentLeftMenuViewController()
    }
    
    
    func setNavBarWithMenu(Title:String, IsNeedRightButton:Bool){
        
        if Title == "Home"
        {
            //            let titleImage = UIImageView(frame: CGRect(x: 10, y: 0, width: 100, height: 30))
            //            titleImage.contentMode = .scaleAspectFit
            //            titleImage.image = UIImage(named: "Title_logo")
            ////            titleImage.backgroundColor  = themeYellowColor
            //             self.navigationItem.titleView = titleImage
            self.title = title?.uppercased()
        }
        else
        {
            self.navigationItem.title = Title.uppercased()
        }
        
        self.navigationController?.navigationBar.barTintColor = colors.black.value
        self.navigationController?.navigationBar.tintColor = colors.black.value
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        
        
//        let leftNavBarButton = UIBarButtonItem(image: UIImage(named: "menu"), style: .plain, target: self, action: #selector(self.OpenMenuAction))
//        self.navigationItem.leftBarButtonItem = nil
//        self.navigationItem.leftBarButtonItem = leftNavBarButton
       
    }
    
    
    // MARK:- Navigation Bar Button Action Methods
    
//    @objc func OpenMenuAction()
//    {
//        if sideMenuController?.isRightViewVisible == true{
//            sideMenuController?.hideRightView()
//        }
//        else if sideMenuController?.isLeftViewVisible == true  {
//            sideMenuController?.hideLeftView()
//        }
//        else {
////            sideMenuController?.showLeftView(animated: true, completionHandler: nil)
////            appDel.setLanguage()
//
//            if let lang = userDefault.value(forKey: "language") as? String{
//                if lang == LanguageKey.EnglishLanguage {
//                    sideMenuController?.showLeftView(animated: true, completionHandler: nil)
//                }
//                else {
//                    sideMenuController?.showRightView(animated: true, completionHandler: nil)
//                }
////                appDel.setLanguage()
//            }
//        }
//    }
    
    @objc func btnBackAction() {
        
        if self.navigationController?.children.count == 1 {
            self.navigationController?.dismiss(animated: true, completion: nil)
        }
        else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @objc func btnSkipAction() {
        //appDel.navigateToHome()
    }
//    @objc func DeleteAllNotification()
//    {
//        let AlrtMsg = UIAlertController(title: "", message: "Are you sure want to clear all notifications?".Localized(), preferredStyle: .alert)
//        AlrtMsg.addAction(UIAlertAction(title: "OK".Localized(), style: .default, handler: { (UIAlertAction) in
//            self.webServiceForDeleteAllNotifications()
//        }))
//
//        AlrtMsg.addAction(UIAlertAction(title: "Cancel".Localized(), style: .cancel, handler: nil))
//        AlrtMsg.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
//        appDel.window?.rootViewController?.present(AlrtMsg, animated: true, completion: nil)
//    }
    
//    @objc func btnCallAction() {
//
//                let contactNumber = helpLineNumber
//                if contactNumber == "" {
////                    UtilityClass.setCustomAlert(title: "\(appName)", message: "Contact number is not available") { (index, title) in
////                    }
//                }
//                else
//                {
//                    callNumber(phoneNumber: contactNumber)
//                }
//    }
//
    
  func callNumber(phoneNumber:String) {
        
        if let phoneCallURL = URL(string: "tel://\(phoneNumber)") {
            
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                application.open(phoneCallURL, options: [:], completionHandler: nil)
            }
        }
    }

    //MARK:- Webservice Methods
    
//    func webServiceForDeleteAllNotifications() {
//
//        UserWebserviceSubclass.deleteNotificationListService(strURL: "") { (Response, Status) in
//            if Status {
//                NotificationCenter.default.post(name: NotificationListReloadKey, object: nil)
//            }
//            else {
//                if let ResponseDict = Response.dictionary {
//                    if let errorMsg = ResponseDict[UtilityClass.GetResponseErrorMessageKey()]?.string {
//                       AlertMessage.showMessageForError(errorMsg)
//                    }
//                }
//            }
//        }
//    }

}

