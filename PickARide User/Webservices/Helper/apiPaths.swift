

import Foundation

typealias NetworkRouterCompletion = ((Data?,[String:Any]?, Bool) -> ())

enum APIEnvironment : String {
 
//Development URL : Pick A Ride Customer
    //case AssetsUrl = "http://65.1.154.172/"
    case Development = "http://65.1.154.172/api/customer_api/"
    case Profilebu = "http://65.1.154.172/"
    case Live = "not provided"
    case GoogleMapKey = "AIzaSyD9IuC2O3dbiKoMZ5bwvLJdttBCuO-1-Rc"
    case GoogleServicesClientId = "698692323787-fg3kv77dtedba29pgdqo6njvdson79qq.apps.googleusercontent.com"
            
            //"AIzaSyDKJGsMhG1iL3NsqDb9PbQ4u1p_jLBB_FA"
            
            //"AIzaSyAJvNxPhmUUxSQde0KHkhaVC-K4ULjvrUY"
            //"AIzaSyDvJt3EcQPwKnsfIuOa0_9zd9P8L2FfUkE"
            //"AIzaSyDKJGsMhG1iL3NsqDb9PbQ4u1p_jLBB_FA"
            //"AIzaSyD9aZBxr4MjVuneyUp4x969up5GUvTY6vk"
            
            //"AIzaSyDU7rSEixg3F-ceR5nz9JAcYxEw5J7hOEI"
            
    static var baseURL: String{
        return APIEnvironment.environment.rawValue
    }
    
    static var environment: APIEnvironment{
        return .Development
    }
    
    static var headers : [String:String]{
        if userDefaults.object(forKey: UserDefaultsKey.isUserLogin.rawValue) != nil {
            
            if userDefaults.object(forKey: UserDefaultsKey.isUserLogin.rawValue) as? Bool == true {
                
                if userDefaults.object(forKey:  UserDefaultsKey.userProfile.rawValue) != nil {
                    do {
                        if UserDefaults.standard.value(forKey: UserDefaultsKey.X_API_KEY.rawValue) != nil, UserDefaults.standard.value(forKey:  UserDefaultsKey.isUserLogin.rawValue) as? Bool ?? Bool(){
                            return [UrlConstant.HeaderKey : UrlConstant.AppHostKey, UrlConstant.XApiKey : Singleton.sharedInstance.UserProfilData?.xAPIKey ?? ""]
                        }else{
                            return [UrlConstant.HeaderKey : UrlConstant.AppHostKey]
                        }
                    }
                }
            }
        }
        return [UrlConstant.HeaderKey : UrlConstant.AppHostKey]
    }
}

enum ApiKey: String {
    case Init                                 = "init/ios/"
    case getCountryList                       = "country_list"
    case getCityList                          = "city_list"
    case login                                = "login"
    case registerOTP                          = "register_otp"
    case uploadDocs                           = "upload_docs"
    case register                             = "register"
    case socialLogin                          = "social_login"
    case socialUpdate                         = "social_update"
    case appleDetails                         = "apple_details"
    case updateProfile                        = "profile_update"
    case changePassword                       = "change_password"
    case forgotPassword                       = "forgot_password"
    case logout                               = "logout/"
    case addCard                              = "add_card"
    case cardlist                             = "card_list"
    case removeCard                           = "remove_card"
    case walletHistory                        = "wallet_history"
    case addMoney                             = "add_money"
    case logOut                               = "logout"
    case bookingRequest                       = "booking_request"
    case cancelTrip                           = "cancel_trip"
    case promocodeList                        = "promocode_list"
    case checkPromocode                       = "check_promocode"
    case addFavourite                         = "add_favourite_address"
    case FavoriteList                         = "favourite_address_list"
    case currentBooking                       = "current_booking"
    case RatingReview                         = "review_rating"
    case pastBookingHistory                   = "past_booking_history/"
    case upcomingBookingHistory               = "upcoming_booking_history/"
    case inProcessBookingHistory              = "in_process_booking_history/"
    case acceptBookLaterRequest               = "accept_book_later_request"
    case chatHistory                          = "chat_history/"
    case notificationList                     = "notification_list"

}

 

