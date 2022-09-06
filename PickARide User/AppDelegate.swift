import UIKit
import IQKeyboardManagerSwift
import Firebase
import UserNotifications
import GoogleMaps
import GooglePlaces
import SideMenuSwift
import GoogleSignIn



@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,UNUserNotificationCenterDelegate,MessagingDelegate {
    
    var window: UIWindow?
    static var shared: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    static var pushNotificationObj : NotificationObjectModel?
    static var pushNotificationType : String?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
       
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        IQKeyboardManager.shared.previousNextDisplayMode = .alwaysShow
        FirebaseApp.configure()
        GMSServices.provideAPIKey(APIEnvironment.GoogleMapKey.rawValue)
        GMSPlacesClient.provideAPIKey(APIEnvironment.GoogleMapKey.rawValue)
        GIDSignIn.sharedInstance().clientID = APIEnvironment.GoogleServicesClientId.rawValue
        GIDSignIn.sharedInstance()?.delegate = self
        
        SideMenuController.preferences.basic.menuWidth = UIScreen.main.bounds.width - 100
        SideMenuController.preferences.basic.defaultCacheKey = "0"
        
        self.checkAndSetDefaultLanguage()
        self.registerForPushNotifications()
        
        return true
    }
    
    func application(_ application: UIApplication, handleEventsForBackgroundURLSession identifier: String, completionHandler: @escaping () -> Void) {
        debugPrint("handleEventsForBackgroundURLSession: \(identifier)")
    }

}

extension AppDelegate: GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {}
  
}
