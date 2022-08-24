//
//  BookingReqModel.swift
//  PickARide User
//
//  Created by apple on 8/18/21.
//  Copyright © 2021 EWW071. All rights reserved.
//

import Foundation

//MARK:- Booking Request Model
enum BookingType : String{
    case BookNow = "book_now"
    case BookLater = "book_later"
}

enum PaymentType : String{
    case Cash = "cash"
    case Wallet = "wallet"
    case Card = "card"
}



//"booking_type:book_now OR book_later
//customer_id:1
//vehicle_type_id:1
//pickup_location:Nikol Ahmedabad
//dropoff_location:Bopal Ahmedabad
//pickup_lat:23.0726365
//pickup_lng:72.51641870000003
//dropoff_lat:23.0499889
//dropoff_lng:72.66996730000005
//no_of_passenger:2
//payment_type:cash OR wallet OR card
//estimated_fare:2
//trip_duration:10
//distance:2
//pickup_date_time:2021-08-16 15:04:32
//promocode:Test"


//MARK:- Booking Request Model
class BookingReqModel : Encodable{
    
    var promoCode : String?
    var pickupDateTime : String?
    var distance : String?
    var tripDuration : String?
    var vehicleTypeId : String?
    var customerId : String? = Singleton.sharedInstance.UserId
    var bookingType : BookingType.RawValue? // book_now OR book_later
    var pickupAddress : String?
    var dropoffAddress : String?
    var pickupLatitude : String?
    var pickupLongitude : String?
    var dropoffLatitude : String?
    var dropoffLongitude : String?
    var noOfPassenger : String?
    var paymentType : PaymentType.RawValue? // cash OR wallet OR card
    var estimatedFare : String?
    var cardId : String?
    var cityName: String?
    
    enum CodingKeys: String, CodingKey {
        
        case cardId = "card_id"
        case pickupDateTime = "pickup_date_time"
        case promoCode = "promocode"
        case distance = "distance"
        case tripDuration = "trip_duration"
        case vehicleTypeId = "vehicle_type_id"
        case customerId = "customer_id"
        case bookingType = "booking_type"
        case pickupAddress = "pickup_location"
        case dropoffAddress = "dropoff_location"
        case pickupLatitude = "pickup_lat"
        case pickupLongitude = "pickup_lng"
        case dropoffLatitude = "dropoff_lat"
        case dropoffLongitude = "dropoff_lng"
        case noOfPassenger = "no_of_passenger"
        case paymentType = "payment_type"
        case estimatedFare = "estimated_fare"
        case cityName = "city_name"
    }
}

//MARK:- Booking Response Model
class BookingModel: Codable {
    let status: Bool?
    let message: String?
    let data: BookingDetails?
    
    required init(from decoder: Decoder) throws {
        let values = try? decoder.container(keyedBy: CodingKeys.self)
        data = try? values?.decodeIfPresent(BookingDetails.self, forKey: .data)
        message = try? values?.decodeIfPresent(String.self, forKey: .message)
        status = try? values?.decodeIfPresent(Bool.self, forKey: .status)
    }
}

// MARK: - DataClass
class BookingDetails: Codable {
    let id, bookingType, driverID, customerID: String?
    let vehicleTypeID, pickupLocation, dropoffLocation, pickupLat: String?
    let pickupLng, dropoffLat, dropoffLng, status: String?
    let onTheWay, pickupDateTime, bookingTime, acceptTime: String?
    let arrivedTime, pickupTime, dropoffTime, waitingTime: String?
    let waitingTimeCharge, paymentType, cardID, paymentStatus: String?
    let referenceID, paymentResponse, promocode, tipsStatus: String?
    let tripDuration, distance, tips, distanceFare: String?
    let durationFare, baseFare, bookingFee, extraCharge: String?
    let subTotal, discount, grandTotal, tax: String?
    let driverAmount, companyAmount, noOfPassenger, cancellationCharge: String?
    let cancelBy, cancelReason, estimatedFare: String?
    let customerInfo: CustomerInfoModel?
    let vehicleType: VehicleDetailsModel?
    
    enum CodingKeys: String, CodingKey {
        case id
        case bookingType = "booking_type"
        case driverID = "driver_id"
        case customerID = "customer_id"
        case vehicleTypeID = "vehicle_type_id"
        case pickupLocation = "pickup_location"
        case dropoffLocation = "dropoff_location"
        case pickupLat = "pickup_lat"
        case pickupLng = "pickup_lng"
        case dropoffLat = "dropoff_lat"
        case dropoffLng = "dropoff_lng"
        case status
        case onTheWay = "on_the_way"
        case pickupDateTime = "pickup_date_time"
        case bookingTime = "booking_time"
        case acceptTime = "accept_time"
        case arrivedTime = "arrived_time"
        case pickupTime = "pickup_time"
        case dropoffTime = "dropoff_time"
        case waitingTime = "waiting_time"
        case waitingTimeCharge = "waiting_time_charge"
        case paymentType = "payment_type"
        case cardID = "card_id"
        case paymentStatus = "payment_status"
        case referenceID = "reference_id"
        case paymentResponse = "payment_response"
        case promocode
        case tipsStatus = "tips_status"
        case tripDuration = "trip_duration"
        case distance, tips
        case distanceFare = "distance_fare"
        case durationFare = "duration_fare"
        case baseFare = "base_fare"
        case bookingFee = "booking_fee"
        case extraCharge = "extra_charge"
        case subTotal = "sub_total"
        case discount
        case grandTotal = "grand_total"
        case tax
        case driverAmount = "driver_amount"
        case companyAmount = "company_amount"
        case noOfPassenger = "no_of_passenger"
        case cancellationCharge = "cancellation_charge"
        case cancelBy = "cancel_by"
        case cancelReason = "cancel_reason"
        case estimatedFare = "estimated_fare"
        case customerInfo = "customer_info"
        case vehicleType = "vehicle_type"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try? decoder.container(keyedBy: CodingKeys.self)
        acceptTime = try? values?.decodeIfPresent(String.self, forKey: .acceptTime)
        arrivedTime = try? values?.decodeIfPresent(String.self, forKey: .arrivedTime)
        baseFare = try? values?.decodeIfPresent(String.self, forKey: .baseFare)
        bookingFee = try? values?.decodeIfPresent(String.self, forKey: .bookingFee)
        bookingTime = try? values?.decodeIfPresent(String.self, forKey: .bookingTime)
        bookingType = try? values?.decodeIfPresent(String.self, forKey: .bookingType)
        cancelBy = try? values?.decodeIfPresent(String.self, forKey: .cancelBy)
        cancelReason = try? values?.decodeIfPresent(String.self, forKey: .cancelReason)
        cancellationCharge = try? values?.decodeIfPresent(String.self, forKey: .cancellationCharge)
        cardID = try? values?.decodeIfPresent(String.self, forKey: .cardID)
        companyAmount = try? values?.decodeIfPresent(String.self, forKey: .companyAmount)
        customerID = try? values?.decodeIfPresent(String.self, forKey: .customerID)
        customerInfo = try? values?.decodeIfPresent(CustomerInfoModel.self, forKey: .customerInfo)
        discount = try? values?.decodeIfPresent(String.self, forKey: .discount)
        distance = try? values?.decodeIfPresent(String.self, forKey: .distance)
        distanceFare = try? values?.decodeIfPresent(String.self, forKey: .distanceFare)
        driverAmount = try? values?.decodeIfPresent(String.self, forKey: .driverAmount)
        driverID = try? values?.decodeIfPresent(String.self, forKey: .driverID)
        dropoffLat = try? values?.decodeIfPresent(String.self, forKey: .dropoffLat)
        dropoffLng = try? values?.decodeIfPresent(String.self, forKey: .dropoffLng)
        dropoffLocation = try? values?.decodeIfPresent(String.self, forKey: .dropoffLocation)
        dropoffTime = try? values?.decodeIfPresent(String.self, forKey: .dropoffTime)
        durationFare = try? values?.decodeIfPresent(String.self, forKey: .durationFare)
        estimatedFare = try? values?.decodeIfPresent(String.self, forKey: .estimatedFare)
        extraCharge = try? values?.decodeIfPresent(String.self, forKey: .extraCharge)
        grandTotal = try? values?.decodeIfPresent(String.self, forKey: .grandTotal)
        id = try? values?.decodeIfPresent(String.self, forKey: .id)
        noOfPassenger = try? values?.decodeIfPresent(String.self, forKey: .noOfPassenger)
        onTheWay = try? values?.decodeIfPresent(String.self, forKey: .onTheWay)
        paymentResponse = try? values?.decodeIfPresent(String.self, forKey: .paymentResponse)
        paymentStatus = try? values?.decodeIfPresent(String.self, forKey: .paymentStatus)
        paymentType = try? values?.decodeIfPresent(String.self, forKey: .paymentType)
        pickupDateTime = try? values?.decodeIfPresent(String.self, forKey: .pickupDateTime)
        pickupLat = try? values?.decodeIfPresent(String.self, forKey: .pickupLat)
        pickupLng = try? values?.decodeIfPresent(String.self, forKey: .pickupLng)
        pickupLocation = try? values?.decodeIfPresent(String.self, forKey: .pickupLocation)
        pickupTime = try? values?.decodeIfPresent(String.self, forKey: .pickupTime)
        promocode = try? values?.decodeIfPresent(String.self, forKey: .promocode)
        referenceID = try? values?.decodeIfPresent(String.self, forKey: .referenceID)
        status = try? values?.decodeIfPresent(String.self, forKey: .status)
        subTotal = try? values?.decodeIfPresent(String.self, forKey: .subTotal)
        tax = try? values?.decodeIfPresent(String.self, forKey: .tax)
        tips = try? values?.decodeIfPresent(String.self, forKey: .tips)
        tipsStatus = try? values?.decodeIfPresent(String.self, forKey: .tipsStatus)
        tripDuration = try? values?.decodeIfPresent(String.self, forKey: .tripDuration)
        vehicleType = try? values?.decodeIfPresent(VehicleDetailsModel.self, forKey: .vehicleType)
        vehicleTypeID = try? values?.decodeIfPresent(String.self, forKey: .vehicleTypeID)
        waitingTime = try? values?.decodeIfPresent(String.self, forKey: .waitingTime)
        waitingTimeCharge = try? values?.decodeIfPresent(String.self, forKey: .waitingTimeCharge)
    }
}

// MARK: - CustomerInfo
class CustomerInfoModel: Codable {
    let id, companyID, firstName, lastName: String?
    let email, countryID, countryCode, mobileNo: String?
    let dob, gender, password, walletBalance: String?
    let deviceType, deviceToken, lat, lng: String?
    let qrCode, profileImage, socialID, socialType: String?
    let isSocial, rememberToken, address, trash: String?
    let status, referralCode, createdAt, rating: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case companyID = "company_id"
        case firstName = "first_name"
        case lastName = "last_name"
        case email
        case countryID = "country_id"
        case countryCode = "country_code"
        case mobileNo = "mobile_no"
        case dob, gender, password
        case walletBalance = "wallet_balance"
        case deviceType = "device_type"
        case deviceToken = "device_token"
        case lat, lng
        case qrCode = "qr_code"
        case profileImage = "profile_image"
        case socialID = "social_id"
        case socialType = "social_type"
        case isSocial = "is_social"
        case rememberToken = "remember_token"
        case address, trash, status
        case referralCode = "referral_code"
        case createdAt = "created_at"
        case rating = "rating"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try? decoder.container(keyedBy: CodingKeys.self)
        address = try? values?.decodeIfPresent(String.self, forKey: .address)
        companyID = try? values?.decodeIfPresent(String.self, forKey: .companyID)
        countryCode = try? values?.decodeIfPresent(String.self, forKey: .countryCode)
        countryID = try? values?.decodeIfPresent(String.self, forKey: .countryID)
        createdAt = try? values?.decodeIfPresent(String.self, forKey: .createdAt)
        deviceToken = try? values?.decodeIfPresent(String.self, forKey: .deviceToken)
        deviceType = try? values?.decodeIfPresent(String.self, forKey: .deviceType)
        dob = try? values?.decodeIfPresent(String.self, forKey: .dob)
        email = try? values?.decodeIfPresent(String.self, forKey: .email)
        firstName = try? values?.decodeIfPresent(String.self, forKey: .firstName)
        gender = try? values?.decodeIfPresent(String.self, forKey: .gender)
        id = try? values?.decodeIfPresent(String.self, forKey: .id)
        isSocial = try? values?.decodeIfPresent(String.self, forKey: .isSocial)
        lastName = try? values?.decodeIfPresent(String.self, forKey: .lastName)
        lat = try? values?.decodeIfPresent(String.self, forKey: .lat)
        lng = try? values?.decodeIfPresent(String.self, forKey: .lng)
        mobileNo = try? values?.decodeIfPresent(String.self, forKey: .mobileNo)
        password = try? values?.decodeIfPresent(String.self, forKey: .password)
        profileImage = try? values?.decodeIfPresent(String.self, forKey: .profileImage)
        qrCode = try? values?.decodeIfPresent(String.self, forKey: .qrCode)
        rating = try? values?.decodeIfPresent(String.self, forKey: .rating)
        referralCode = try? values?.decodeIfPresent(String.self, forKey: .referralCode)
        rememberToken = try? values?.decodeIfPresent(String.self, forKey: .rememberToken)
        socialID = try? values?.decodeIfPresent(String.self, forKey: .socialID)
        socialType = try? values?.decodeIfPresent(String.self, forKey: .socialType)
        status = try? values?.decodeIfPresent(String.self, forKey: .status)
        trash = try? values?.decodeIfPresent(String.self, forKey: .trash)
        walletBalance = try? values?.decodeIfPresent(String.self, forKey: .walletBalance)
    }
    
}

// MARK: - VehicleType
class VehicleDetailsModel: Codable {
    let id, name, baseKM, baseCharge: String?
    let perKMCharge, perMinuteCharge, waitingTimePerMinCharge, isNightCharge: String?
    let nightFrom, nightTo, nightCharge, isSpecialEventCharge: String?
    let specialEventFrom, specialEventTo, specialEventCharge, premiumCharge: String?
    let bookingFee, driverCancellationFee, customerCancellationFee, freeCancallationTime: String?
    let extraCharge, capacity, commission, image: String?
    let unselectImage, vehicleTypeDescription, trash, createdAt: String?
    let updatedAt, status: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case baseKM = "base_km"
        case baseCharge = "base_charge"
        case perKMCharge = "per_km_charge"
        case perMinuteCharge = "per_minute_charge"
        case waitingTimePerMinCharge = "waiting_time_per_min_charge"
        case isNightCharge = "is_night_charge"
        case nightFrom = "night_from"
        case nightTo = "night_to"
        case nightCharge = "night_charge"
        case isSpecialEventCharge = "is_special_event_charge"
        case specialEventFrom = "special_event_from"
        case specialEventTo = "special_event_to"
        case specialEventCharge = "special_event_charge"
        case premiumCharge = "premium_charge"
        case bookingFee = "booking_fee"
        case driverCancellationFee = "driver_cancellation_fee"
        case customerCancellationFee = "customer_cancellation_fee"
        case freeCancallationTime = "free_cancallation_time"
        case extraCharge = "extra_charge"
        case capacity, commission, image
        case unselectImage = "unselect_image"
        case vehicleTypeDescription = "description"
        case trash
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case status
    }
    
    required init(from decoder: Decoder) throws {
        let values = try? decoder.container(keyedBy: CodingKeys.self)
        baseCharge = try? values?.decodeIfPresent(String.self, forKey: .baseCharge)
        baseKM = try? values?.decodeIfPresent(String.self, forKey: .baseKM)
        bookingFee = try? values?.decodeIfPresent(String.self, forKey: .bookingFee)
        capacity = try? values?.decodeIfPresent(String.self, forKey: .capacity)
        commission = try? values?.decodeIfPresent(String.self, forKey: .commission)
        createdAt = try? values?.decodeIfPresent(String.self, forKey: .createdAt)
        customerCancellationFee = try? values?.decodeIfPresent(String.self, forKey: .customerCancellationFee)
        vehicleTypeDescription = try? values?.decodeIfPresent(String.self, forKey: .vehicleTypeDescription)
        driverCancellationFee = try? values?.decodeIfPresent(String.self, forKey: .driverCancellationFee)
        extraCharge = try? values?.decodeIfPresent(String.self, forKey: .extraCharge)
        freeCancallationTime = try? values?.decodeIfPresent(String.self, forKey: .freeCancallationTime)
        id = try? values?.decodeIfPresent(String.self, forKey: .id)
        image = try? values?.decodeIfPresent(String.self, forKey: .image)
        isNightCharge = try? values?.decodeIfPresent(String.self, forKey: .isNightCharge)
        isSpecialEventCharge = try? values?.decodeIfPresent(String.self, forKey: .isSpecialEventCharge)
        name = try? values?.decodeIfPresent(String.self, forKey: .name)
        nightCharge = try? values?.decodeIfPresent(String.self, forKey: .nightCharge)
        nightFrom = try? values?.decodeIfPresent(String.self, forKey: .nightFrom)
        nightTo = try? values?.decodeIfPresent(String.self, forKey: .nightTo)
        perKMCharge = try? values?.decodeIfPresent(String.self, forKey: .perKMCharge)
        perMinuteCharge = try? values?.decodeIfPresent(String.self, forKey: .perMinuteCharge)
        premiumCharge = try? values?.decodeIfPresent(String.self, forKey: .premiumCharge)
        specialEventCharge = try? values?.decodeIfPresent(String.self, forKey: .specialEventCharge)
        specialEventFrom = try? values?.decodeIfPresent(String.self, forKey: .specialEventFrom)
        specialEventTo = try? values?.decodeIfPresent(String.self, forKey: .specialEventTo)
        status = try? values?.decodeIfPresent(String.self, forKey: .status)
        trash = try? values?.decodeIfPresent(String.self, forKey: .trash)
        unselectImage = try? values?.decodeIfPresent(String.self, forKey: .unselectImage)
        updatedAt = try? values?.decodeIfPresent(String.self, forKey: .updatedAt)
        waitingTimePerMinCharge = try? values?.decodeIfPresent(String.self, forKey: .waitingTimePerMinCharge)
    }
}
