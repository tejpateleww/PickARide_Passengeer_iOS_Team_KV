import UIKit
import IQKeyboardManagerSwift
import Firebase
import UserNotifications
import GoogleMaps
import GooglePlaces
import SideMenuSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,UNUserNotificationCenterDelegate,MessagingDelegate {
    
    var window: UIWindow?
    static var shared: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
//        setupNavigation()
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        
        FirebaseApp.configure()
        GMSServices.provideAPIKey("\(AppInfo.Google_API_Key)")
        GMSPlacesClient.provideAPIKey("\(AppInfo.Google_API_Key)")
        
        SideMenuController.preferences.basic.menuWidth = UIScreen.main.bounds.width - 100
        SideMenuController.preferences.basic.defaultCacheKey = "0"
        
        checkAndSetDefaultLanguage()
        registerForPushNotifications()
        if user_defaults.object(forKey: UserDefaultsKey.isUserLogin.rawValue) as? Bool == true{
            self.navigateToMain()
        } else {
            self.navigateToLogin()
        }
        return true
    }
    func checkAndSetDefaultLanguage() {
        if user_defaults.value(forKey: UserDefaultsKey.selLanguage.rawValue) == nil {
            setLanguageEnglish()
        }
    }
    func setLanguageEnglish() {
        user_defaults.setValue("en", forKey: UserDefaultsKey.selLanguage.rawValue)
    }
    func application(_ application: UIApplication, handleEventsForBackgroundURLSession identifier: String, completionHandler: @escaping () -> Void) {
        debugPrint("handleEventsForBackgroundURLSession: \(identifier)")
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
    }
    
    func setupNavigation(){
        if #available(iOS 13.0, *) {
            // prefer a light interface style with this:
            //  window?.overrideUserInterfaceStyle = .light
        }
        let attributes = [NSAttributedString.Key.font: CustomFont.medium.returnFont(23),NSAttributedString.Key.foregroundColor:UIColor.white]
        UINavigationBar.appearance().titleTextAttributes = attributes
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().barTintColor = UIColor.white
        UINavigationBar.appearance().isTranslucent = true
        
    }
    func NavigateToIntroSlider(){
//        let navigationController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NavigationController") as! NavigationController
//        navigationController.setViewControllers([UIStoryboard(name: "Authentication", bundle: nil).instantiateViewController(withIdentifier: "SliderViewController")], animated: false)
//        navigationController.isNavigationBarHidden = true
//        let window = UIApplication.shared.delegate!.window!!
//        UIView.transition(with: window, duration: 0.3, options: [.transitionCrossDissolve], animations: nil, completion: nil)
//        window.rootViewController = navigationController
        
    }
    
    func navigateToLogin(){
        let storyborad = UIStoryboard(name: "Login", bundle: nil)
        let splash = storyborad.instantiateViewController(withIdentifier: LoginViewController.className) as! LoginViewController
        let NavHomeVC = UINavigationController(rootViewController: splash)
        NavHomeVC.navigationBar.isHidden = true
        self.window?.rootViewController = NavHomeVC
    }
    
    func navigateToMain(){
        
        //SideMenuController
        let storyborad = UIStoryboard(name: "Main", bundle: nil)
        let Home = storyborad.instantiateViewController(withIdentifier: SideMenuController.className) as! SideMenuController
        let HomeVC = UINavigationController(rootViewController: Home)
        HomeVC.navigationBar.isHidden = true
        self.window?.rootViewController = HomeVC
        
//        let storyborad = UIStoryboard(name: "Main", bundle: nil)
//        let Home = storyborad.instantiateViewController(withIdentifier: HomeViewController.className) as! HomeViewController
//        let HomeVC = UINavigationController(rootViewController: Home)
//        self.window?.rootViewController = HomeVC
    }
    
    func clearData()
    {
        for (key, value) in UserDefaults.standard.dictionaryRepresentation() {
            
            if key != UserDefaultsKey.DeviceToken.rawValue && key  != "language"  {
                print("\(key) = \(value) \n")
                 UserDefaults.standard.removeObject(forKey: key)
            }
        }
        UserDefaults.standard.set(false, forKey: UserDefaultsKey.isUserLogin.rawValue)
        
        SingletonClass.sharedInstance.clearSingletonClass()
    }
   
    func navigateToHomeScreen()
    {
//        let mainViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as! MainViewController
//        let window = UIApplication.shared.delegate!.window!!
//        window.rootViewController = mainViewController
//        UIView.transition(with: window, duration: 0.3, options: [.transitionCrossDissolve], animations: nil, completion: nil)
    }
    
    func registerForPushNotifications() {
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_ , _ in })
            // For iOS 10 data message (sent via FCM)
            Messaging.messaging().delegate = self
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            UIApplication.shared.registerUserNotificationSettings(settings)
        }
        UIApplication.shared.registerForRemoteNotifications()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        print(#function, notification)
        
        let content = notification.request.content
        let userInfo = notification.request.content.userInfo
        print(userInfo)
        print(appDel.window?.rootViewController?.navigationController?.children.first as Any)
        
        NotificationCenter.default.post(name: NotificationBadges, object: content)
        completionHandler([.alert, .sound])
        
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        //        if let refreshedToken = InstanceID.instanceID().token() {
        //            print("InstanceID token: \(refreshedToken)")
        //        }
        
        Messaging.messaging().apnsToken = deviceToken
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        let token = fcmToken ?? "No Token found"
        print("Firebase registration token: \(fcmToken ?? "No Token found")")
        SingletonClass.sharedInstance.DeviceToken = token
        user_defaults.set(fcmToken, forKey: UserDefaultsKey.DeviceToken.rawValue)
        
        
        let dataDict:[String: String] = ["token": token]
        NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
        // TODO: If necessary send token to application server.
        // Note: This callback is fired at each app startup and whenever a new token is generated.
        Messaging.messaging().token { token, error in
           // Check for error. Otherwise do what you will with token here
            if let error = error {
                print("Error fetching remote instance ID: \(error)")
            } else if let result = token {
                print("Remote instance ID token: \(result)")
                // self.instanceIDTokenMessage.text  = "Remote InstanceID token: \(result.token)"
                UserDefaults.standard.set(SingletonClass.sharedInstance.DeviceToken, forKey: UserDefaultsKey.DeviceToken.rawValue)
            }
        }
        
//        InstanceID.instanceID().instanceID { (result, error) in
//            if let error = error {
//                print("Error fetching remote instance ID: \(error)")
//            } else if let result = result {
//                print("Remote instance ID token: \(result.token)")
//                // self.instanceIDTokenMessage.text  = "Remote InstanceID token: \(result.token)"
//                UserDefaults.standard.set(SingletonClass.sharedInstance.DeviceToken, forKey: UserDefaultsKey.DeviceToken.rawValue)
//            }
//        }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        
        
        let userInfo = response.notification.request.content.userInfo
        print(userInfo)
        completionHandler()
    }
    
    func messaging(_ messaging: Messaging, didRefreshRegistrationToken fcmToken: String) {
        print(fcmToken)
    }
    
}

