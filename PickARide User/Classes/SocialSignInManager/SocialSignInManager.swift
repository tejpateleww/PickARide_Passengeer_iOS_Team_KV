//
//  SocialSignInManager.swift
//  ClothesLyne
//
//  Created by Apple on 09/05/21.
//

import Foundation
import AuthenticationServices
import GoogleSignIn
import FBSDKLoginKit

class SocialUser: Codable{
    var userId : String = ""
    var token : String = ""
    var firstName : String = ""
    var lastName : String = ""
    var email : String? = nil
    var profile : String = ""
    var socialType : String = ""
}

enum LoginResult {
    case success((SocialUser, String))
    case failure(String)
}

enum SocialType: String {
    case Apple = "apple"
    case Google = "google"
    case FaceBook = "facebook"
}

protocol SocialSignInDelegate{
    func FatchUser(socialType: SocialType, success: Bool, user: SocialUser?, error: String?)
}

class FacebookLoginProvider {
    private let loginManager: LoginManager = LoginManager()
    private let viewController: UIViewController
    var delegate : SocialSignInDelegate? = nil

    init(_ viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func fetchToken(from viewController: UIViewController) {
        loginManager.logIn(permissions: [.publicProfile, .email], viewController: viewController) { result in
            switch result {
            case .cancelled:
                self.delegate?.FatchUser(socialType: .FaceBook, success: false, user: nil, error: "Cancelled")
            case .failed(let error):
                self.delegate?.FatchUser(socialType: .FaceBook, success: false, user: nil, error: error.localizedDescription)
            case .success(_, _, let authToken):
                self.getFBUserDetail(VC: viewController, token: authToken?.tokenString ?? "") { (user, error) in
                    self.delegate?.FatchUser(socialType: .FaceBook, success: error == nil, user: user, error: error)
                }
            }
        }
    }
    
    func getFBUserDetail(VC: UIViewController, token: String, completion: @escaping (_ user: SocialUser?, _ error: String?)-> Void){
        let parameters = ["fields" : "email, name, first_name, last_name, picture.type(large)"]
        GraphRequest(graphPath: "me", parameters: parameters).start { (connection, conresult, error) in
            if let Err = error{
                completion(nil, Err.localizedDescription)
            }else{
                if let result = conresult, let dataDic = result as? [String: Any]{
                    let obj = SocialUser()
                    obj.socialType = SocialType.FaceBook.rawValue
                    obj.userId = dataDic["id"] as? String ?? ""
                    obj.token = token
                    obj.firstName = dataDic["first_name"] as? String ?? ""
                    obj.lastName = dataDic["last_name"] as? String ?? ""
                    obj.email = dataDic["email"] as? String ?? ""
                    if let profileUrl = dataDic["profileURL"] as? URL{
                        obj.profile = profileUrl.absoluteString
                    }
                    completion(obj, nil)
                }
            }
        }
    }
}

class GoogleLoginProvider: NSObject {

    var delegate : SocialSignInDelegate? = nil
    
    init(_ viewController: UIViewController) {
        super.init()
        GIDSignIn.sharedInstance()?.presentingViewController = viewController
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance()?.signIn()
    }
}

extension GoogleLoginProvider: GIDSignInDelegate {
     @objc func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        guard error == nil else {
            let errorCode = (error as NSError).code
            if let signInError = GIDSignInErrorCode(rawValue: errorCode) {
                if case .canceled = signInError {
                    self.delegate?.FatchUser(socialType: .Google, success: false, user: nil, error: "Cancelled")
                    return
                }
            }
            
            self.delegate?.FatchUser(socialType: .Google, success: false, user: nil, error: error.localizedDescription)
            return
        }

        let obj = SocialUser()
        obj.socialType = SocialType.Google.rawValue
        obj.userId = user.userID
        obj.token = user.authentication.idToken
        obj.email = user.profile.email
        obj.firstName = user.profile.givenName ?? ""
        obj.lastName = user.profile.familyName ?? ""
        obj.profile = user.profile.imageURL(withDimension: 200)?.absoluteString ?? ""

        self.delegate?.FatchUser(socialType: .Google, success: true, user: obj, error: nil)
    }
}
