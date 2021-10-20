//
//  WebServicesSubclass.swift
//  Danfo_Rider
//
//  Created by Hiral Jotaniya on 04/06/21.
//

import Foundation
import UIKit

class WebServiceSubClass{

    //MARK:- Init
    class func InitApi(completion: @escaping (Bool,String,RootInit?,Any) -> ()) {
        URLSessionRequestManager.makeGetRequest(urlString: ApiKey.Init.rawValue + kAPPVesion + "/" + Singleton.sharedInstance.UserId, responseModel: RootInit.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    class func GetCountryList(completion: @escaping (Bool,String,CountryListModel?,Any) -> ()){
        URLSessionRequestManager.makeGetRequest(urlString: ApiKey.getCountryList.rawValue, responseModel: CountryListModel.self) { (status, message, response, error) in
            if status{
                Singleton.sharedInstance.CountryList = response?.data ?? []
            }
            completion(status, message, response, error)
        }
    }
    
    //MARK:- Auth
    class func LoginApi(reqModel: LoginRequestModel, completion: @escaping (Bool,String,LoginResponseModel?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.login.rawValue, requestModel: reqModel, responseModel: LoginResponseModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    class func LogoutApi(completion: @escaping (Bool,String,Any) -> ()){
        URLSessionRequestManager.makeGetRequest(urlString: ApiKey.logout.rawValue + Singleton.sharedInstance.UserId, responseModel: CommonResponseModel.self) { (status, message, response, error) in
            completion(status, message, error)
        }
    }
    
    class func OTPRequestApi(reqModel : OTPRequestModel , completion: @escaping (Bool,String,OTPResponseModel?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.registerOTP.rawValue, requestModel: reqModel, responseModel: OTPResponseModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    class func RegisterApi(reqModel : RegisterRequestModel , completion: @escaping (Bool,String,LoginResponseModel?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.register.rawValue, requestModel: reqModel, responseModel: LoginResponseModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    class func SocialLoginApi(reqModel : SocialLoginRequestModel , completion: @escaping (Bool,String,LoginResponseModel?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.socialLogin.rawValue, requestModel: reqModel, responseModel: LoginResponseModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    class func ForgotPasswordApi(reqModel : ForgotPasswordReqModel , completion: @escaping (Bool,String,PasswordResponseModel?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.forgotPassword.rawValue, requestModel: reqModel, responseModel: PasswordResponseModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    class func ChangePasswordApi(reqModel : ChangePasswordReqModel , completion: @escaping (Bool,String,PasswordResponseModel?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.changePassword.rawValue, requestModel: reqModel, responseModel: PasswordResponseModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    class func ProfileApi(reqModel : ProfileReqModel, completion: @escaping (Bool,String,LoginResponseModel?,Any) -> ()){
        URLSessionRequestManager.makeImageUploadRequest(urlString: ApiKey.updateProfile.rawValue, requestModel: reqModel, responseModel: LoginResponseModel.self, image: reqModel.profileImage ?? UIImage(), imageKey: reqModel.profilePictureKey ?? "") { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    //MARK:- Card
    class func AddCardApi(reqModel : AddCardReqModel, completion: @escaping (Bool,String,CardListModel?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.addCard.rawValue, requestModel: reqModel, responseModel: CardListModel.self) { (status, message, response, error) in
            if status{
                Singleton.sharedInstance.CardList = response?.cards ?? []
            }
            completion(status, message, response, error)
        }
    }
    
    class func CardListApi(completion: @escaping (Bool,String,CardListModel?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.cardlist.rawValue, requestModel: CardListReqModel(), responseModel: CardListModel.self) { (status, message, response, error) in
            if status{
                Singleton.sharedInstance.CardList = response?.cards ?? []
            }
            completion(status, message, response, error)
        }
    }
    
    class func RemoveCardApi(reqModel : CardListReqModel, completion: @escaping (Bool,String,CardListModel?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.removeCard.rawValue, requestModel: reqModel, responseModel: CardListModel.self) { (status, message, response, error) in
            if status{
                Singleton.sharedInstance.CardList = response?.cards ?? []
            }
            completion(status, message, response, error)
        }
    }
    
    //MARK:- Wallet
    class func WalletHistoryApi(reqModel : WalletHistoryRequestModel, completion: @escaping (Bool,String,WalletHistoryModel?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.walletHistory.rawValue, requestModel: reqModel, responseModel: WalletHistoryModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    class func AddMoneyApi(reqModel : AddMoneyRequestModel, completion: @escaping (Bool,String,AddMoneyResponseModel?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.addMoney.rawValue, requestModel: reqModel, responseModel: AddMoneyResponseModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    class func BookingRequestApi(reqModel : BookingReqModel, completion: @escaping (Bool,String,BookingModel?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.bookingRequest.rawValue, requestModel: reqModel, responseModel: BookingModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    class func CancelTripApi(reqModel : CancelTripReqModel, completion: @escaping (Bool,String,CommonResponseModel?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.cancelTrip.rawValue, requestModel: reqModel, responseModel: CommonResponseModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    //MARK:- Promo Code
    class func PromoCodeListApi(completion: @escaping (Bool,String,PromoCodeListModel?,Any) -> ()){
        URLSessionRequestManager.makeGetRequest(urlString: ApiKey.promocodeList.rawValue, responseModel: PromoCodeListModel.self){ (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    class func CheckPromoCodeApi(reqModel : CheckPromoReqModel, completion: @escaping (Bool,String,CommonResponseModel?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.checkPromocode.rawValue, requestModel: reqModel, responseModel: CommonResponseModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    
    class func AddPlaces(reqModel : AddPlacesReqModel , completion : @escaping (Bool,String,RootPlaces?,Any) -> ()) {
        
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.addFavourite.rawValue, requestModel: reqModel, responseModel: RootPlaces.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    class func FavoritList(CustomerId : String , complition : @escaping (Bool,String,RootPlaces?,Any)->()){
        URLSessionRequestManager.makeGetRequest(urlString: ApiKey.FavoriteList.rawValue + "/\(CustomerId)", responseModel: RootPlaces.self) { (status, message, response, error) in
            complition(status,message,response,error)
        }
    }

    class func UpComingBookingHistory(CustomerId:String, PageNo : Int , complition : @escaping (Bool,String,RootBookingHistory?,Any)->()){
        URLSessionRequestManager.makeGetRequest(urlString: ApiKey.upcomingBookingHistory.rawValue + "/\(CustomerId)/\(PageNo)", responseModel: RootBookingHistory.self) { status, message, response, error in
            complition(status,message,response,error)
        }
    }
    
    class func GetRideHistoryApi(Page: String, completion: @escaping (Bool,String,PastBookingResModel?,Any) -> ()) {
        URLSessionRequestManager.makeGetRequest(urlString: ApiKey.pastBookingHistory.rawValue + Singleton.sharedInstance.UserId + "/" + Page, responseModel: PastBookingResModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    
    class func AddReviewRating(reqModel : ReviewRatingModel , completion : @escaping (Bool,String,RootRating?,Any) -> ()) {
        
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.RatingReview.rawValue, requestModel: reqModel, responseModel: RootRating.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    class func CurrentBookingHistory(CustomerId:String,complition : @escaping (Bool,String,RootCurrentBooking?,Any)->()){
        
        URLSessionRequestManager.makeGetRequest(urlString: ApiKey.currentBooking.rawValue + "/\(CustomerId)", responseModel: RootCurrentBooking.self) { status, message, response, error in
            complition(status,message,response,error)
        }
    }
    
    class func GetUpcomingRideApi(Page: String, completion: @escaping (Bool,String,PastBookingResModel?,Any) -> ()) {
        URLSessionRequestManager.makeGetRequest(urlString: ApiKey.upcomingBookingHistory.rawValue + Singleton.sharedInstance.UserId + "/" + Page, responseModel: PastBookingResModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    class func GetInProcessBookingRideApi(Page: String, completion: @escaping (Bool,String,PastBookingResModel?,Any) -> ()) {
        URLSessionRequestManager.makeGetRequest(urlString: ApiKey.inProcessBookingHistory.rawValue + Singleton.sharedInstance.UserId + "/" + Page, responseModel: PastBookingResModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    class func AcceptBookLaterAPI(reqModel : RidesRequestModel , completion: @escaping (Bool,String,LogoutReponseModel?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.acceptBookLaterRequest.rawValue, requestModel: reqModel, responseModel: LogoutReponseModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    class func GetChatHistoryApi(BookingID: String, completion: @escaping (Bool,String,chatHistoryModel?,Any) -> ()) {
        URLSessionRequestManager.makeGetRequest(urlString: ApiKey.chatHistory.rawValue + BookingID, responseModel: chatHistoryModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    
    

}
