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
    var navBtnProfile = UIButton()
    
    func setNavigationBarInViewController (controller : UIViewController,naviColor : UIColor, naviTitle : String, leftImage : String , rightImages : [String], isTranslucent : Bool, CommonViewTitles : [String])
    {
        UIApplication.shared.statusBarStyle = .lightContent
        controller.navigationController?.isNavigationBarHidden = false
        controller.navigationController?.navigationBar.isOpaque = false
        
        controller.navigationController?.navigationBar.isTranslucent = isTranslucent
        
        controller.navigationController?.navigationBar.barTintColor = naviColor;
        controller.navigationController?.navigationBar.tintColor = colors.white.value;
        if naviTitle == NavTitles.Home.value {
            controller.navigationItem.titleView = UIView()
        } else {
           
            
            if naviTitle == "CommonView" {
                let viewForTop = UIView()
                viewForTop.frame = CGRect(x: 0, y: 0, width: ((controller.navigationController?.navigationBar.frame.size.width)!), height: 40)
                viewForTop.backgroundColor = .clear
                let xibView : navigationCommonView = navigationCommonView.loadFromXib()
                xibView.frame = CGRect(x: 0, y: 0, width: viewForTop.frame.size.width, height: 40)
                xibView.lblEndRideAddress.text = CommonViewTitles[1]
                xibView.lblStartRideAddress.text = CommonViewTitles[0]
              
                viewForTop.addSubview(xibView)
                
                controller.navigationItem.titleView = viewForTop
            } else if naviTitle.contains("MultiLine"){
                
                let label = UILabel()
                
                let newNavTitle = naviTitle.replacingOccurrences(of: "MultiLine", with: "")
                let fullNameArr = newNavTitle.split{$0 == "\n"}.map(String.init)
                print(fullNameArr)
                
                let myMutableString1 = NSMutableAttributedString(string: fullNameArr[0], attributes: [NSAttributedString.Key.font : CustomFont.bold.returnFont(18)])
                let myMutableString2 = NSMutableAttributedString(string: "\n\(fullNameArr[1])", attributes: [NSAttributedString.Key.font : CustomFont.medium.returnFont(13)])
                myMutableString1.addAttribute(NSAttributedString.Key.foregroundColor, value: colors.loginPlaceHolderColor.value, range: NSRange(location: 0, length: fullNameArr[0].count - 1))
                myMutableString2.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(hexString: "#ACB1C0"), range: NSRange(location: 0, length: fullNameArr[1].count + 1))
                
                let combination = NSMutableAttributedString()

                combination.append(myMutableString1)
              
                combination.append(myMutableString2)
                
                label.attributedText = combination
                label.textAlignment = .center
                label.numberOfLines = 0
                label.adjustsFontSizeToFitWidth = true
                controller.navigationItem.titleView = label
            } else {
                let label = UILabel()
                label.text = naviTitle
                label.textColor = colors.loginPlaceHolderColor.value
                label.font = CustomFont.bold.returnFont(18)
                if naviTitle == "NavigationTitle_Rating".Localized() {
                    label.textColor = colors.white.value
                }
                label.numberOfLines = 0
                label.textAlignment = .center
                label.adjustsFontSizeToFitWidth = true
               // controller.navigationItem.title = naviTitle //.Localized()
                controller.navigationItem.titleView = label
            }
            
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
            } else if leftImage == NavItemsLeft.menu.value {
                let btnLeft = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
                btnLeft.setImage(UIImage.init(named: "ic_menu"), for: .normal)
                btnLeft.layer.setValue(controller, forKey: "controller")
                btnLeft.addTarget(self, action: #selector(self.btMenuAction), for: .touchUpInside)
                
                btnLeft.layer.shadowColor = colors.black.value.cgColor
                btnLeft.layer.shadowOffset = CGSize(width: 0, height: 0)
                btnLeft.layer.shadowRadius = 3
                btnLeft.layer.shadowOpacity = 0.4
                
                
                let LeftView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
                LeftView.addSubview(btnLeft)
            
                let btnLeftBar : UIBarButtonItem = UIBarButtonItem.init(customView: LeftView)
                btnLeftBar.style = .plain
                controller.navigationItem.leftBarButtonItem = btnLeftBar
            } else if leftImage == NavItemsLeft.cancel.value {
                let btnLeft = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
                btnLeft.setImage(UIImage.init(named: "ic_Cancel"), for: .normal)
                btnLeft.layer.setValue(controller, forKey: "controller")
                
                btnLeft.addTarget(self, action: #selector(self.btnBackAction), for: .touchUpInside)
                let LeftView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
                LeftView.addSubview(btnLeft)
            
                let btnLeftBar : UIBarButtonItem = UIBarButtonItem.init(customView: LeftView)
                btnLeftBar.style = .plain
                controller.navigationItem.leftBarButtonItem = btnLeftBar
            } else if leftImage == NavItemsLeft.cancelWhite.value {
                let btnLeft = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
                btnLeft.setImage(UIImage.init(named: "ic_cancelWhite"), for: .normal)
                btnLeft.layer.setValue(controller, forKey: "controller")
                
                btnLeft.addTarget(self, action: #selector(self.btnBackAction), for: .touchUpInside)
                let LeftView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
                LeftView.addSubview(btnLeft)
            
                let btnLeftBar : UIBarButtonItem = UIBarButtonItem.init(customView: LeftView)
                btnLeftBar.style = .plain
                controller.navigationItem.leftBarButtonItem = btnLeftBar
            }
        } else {
            let emptyView = UIView()
            let btnLeftBar : UIBarButtonItem = UIBarButtonItem.init(customView: emptyView)
            btnLeftBar.style = .plain
            controller.navigationItem.leftBarButtonItem = btnLeftBar
        }
        if rightImages.count != 0 {
            var arrButtons = [UIBarButtonItem]()
            rightImages.forEach { (title) in
                if title == NavItemsRight.login.value {
                    
                    
                    
                    let viewLogin = UIView(frame: CGRect(x: 0, y: 0, width: 60, height: 40))

                    let btnLogin = UIButton.init()
                    btnLogin.frame = CGRect(x: 0, y: 0, width: 60, height: 40)
                    btnLogin.setTitle("NavigationButton_btnLogin".Localized(), for: .normal)
                    btnLogin.titleLabel?.font = CustomFont.bold.returnFont(18)
                    btnLogin.setTitleColor(colors.submitButtonColor.value, for: .normal)
                    btnLogin.addTarget(self, action: #selector(openLoginVC(_:)), for: .touchUpInside)
                    btnLogin.layer.setValue(controller, forKey: "controller")
                    viewLogin.addSubview(btnLogin)

                

                    let btnRightBar : UIBarButtonItem = UIBarButtonItem.init(customView: viewLogin)
                    btnRightBar.style = .plain
                    arrButtons.append(btnRightBar)
                } else if title == NavItemsRight.EditProfile.value {
                    
                    
                    let viewProfile = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))

                    navBtnProfile = UIButton.init()
                    navBtnProfile.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
                    navBtnProfile.setImage(UIImage.init(named: "ic_ProfileEdit"), for: .normal)
                   
                   // btnProfile.addTarget(self, action: #selector(openLoginVC(_:)), for: .touchUpInside)
                    navBtnProfile.layer.setValue(controller, forKey: "controller")
                    viewProfile.addSubview(navBtnProfile)

                    navBtnProfile.layer.shadowColor = colors.black.value.cgColor
                    navBtnProfile.layer.shadowOffset = CGSize(width: 0, height: 0)
                    navBtnProfile.layer.shadowRadius = 3
                    navBtnProfile.layer.shadowOpacity = 0.4

                    let btnRightBar : UIBarButtonItem = UIBarButtonItem.init(customView: viewProfile)
                    btnRightBar.style = .plain
                    arrButtons.append(btnRightBar)
                } else if title == NavItemsRight.userProfile.value {
                    
                    
                    
                    let viewProfileEdit = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))

                    let btnProfileEdit = UIButton.init()
                    btnProfileEdit.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
                    btnProfileEdit.setImage(UIImage.init(named: "nav_dummy_userImage"), for: .normal)
                    btnProfileEdit.addTarget(self, action: #selector(EditUserProfile(_:)), for: .touchUpInside)
                   // btnProfile.addTarget(self, action: #selector(openLoginVC(_:)), for: .touchUpInside)
                    btnProfileEdit.layer.setValue(controller, forKey: "controller")
                    viewProfileEdit.addSubview(btnProfileEdit)

                  

                    let btnRightBar : UIBarButtonItem = UIBarButtonItem.init(customView: viewProfileEdit)
                    btnRightBar.style = .plain
                    arrButtons.append(btnRightBar)
                } else  if title == NavItemsRight.Done.value {
                    
                    
                    
                    let viewLogin = UIView(frame: CGRect(x: 0, y: 0, width: 60, height: 40))

                    let btnLogin = UIButton.init()
                    btnLogin.frame = CGRect(x: 0, y: 0, width: 60, height: 40)
                    btnLogin.setTitle("NavigationButton_btnDone".Localized(), for: .normal)
                    btnLogin.titleLabel?.font = CustomFont.bold.returnFont(18)
                    btnLogin.setTitleColor(colors.submitButtonColor.value, for: .normal)
                   
                   // btnLogin.addTarget(self, action: #selector(openLoginVC(_:)), for: .touchUpInside)
                    btnLogin.layer.setValue(controller, forKey: "controller")
                    viewLogin.addSubview(btnLogin)

                

                    let btnRightBar : UIBarButtonItem = UIBarButtonItem.init(customView: viewLogin)
                    btnRightBar.style = .plain
                    arrButtons.append(btnRightBar)
                }
               
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
    @objc func openLoginVC(_ sender: UIButton?) {
        let controller = sender?.layer.value(forKey: "controller") as? UIViewController
//        let notifVc = AppStoryboard.Login.instance.instantiateViewController(withIdentifier: NotificationsListVC.storyboardID)
        controller?.navigationController?.popViewController(animated: true)
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
    @objc func EditUserProfile(_ sender: UIButton?) {
        
        let rtViewVC = (appDel.window?.rootViewController as! UINavigationController).children
        for i in rtViewVC {
            if i.isKind(of: ProfileVC.self) {
                let vc:ProfileVC = i as! ProfileVC
                vc.makeEditProfile(isEditProfile: true)
            }
        }
        
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
    
    @objc func btMenuAction (_ sender: UIButton?) {
//    @objc func btMenuAction() {
        let controller = sender?.layer.value(forKey: "controller") as? UIViewController
        controller?.sideMenuController?.revealMenu()
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

