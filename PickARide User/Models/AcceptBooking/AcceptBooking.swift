//
//  AcceptBooking.swift
//  PickARide User
//
//  Created by Admin on 27/09/21.
//  Copyright © 2021 EWW071. All rights reserved.
//

import Foundation
import SwiftyJSON

class RootBookingRequestAccept : Codable{

    var bookingInfo : BookingInfoData!
    var message : String!
    var status : Bool!

    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        let bookingInfoJson = json["booking_info"]
        if !bookingInfoJson.isEmpty{
            bookingInfo = BookingInfoData(fromJson: bookingInfoJson)
        }

//        let bookingInfoJsonData = json["data"]
//        if !bookingInfoJsonData.isEmpty{
//            bookingData = BookingInfoData(fromJson: bookingInfoJsonData)
//        }
        message = json["message"].stringValue
        status = json["status"].boolValue

    }
    
    
    

}




class BookingInfoData : Codable {

    var id : String!
    var acceptTime : Int!
    var arrivedTime : String!
    var baseFare : String!
    var bookingFee : String!
    var bookingTime : String!
    var bookingType : String!
    var cancelBy : String!
    var cancelReason : String!
    var cancellationCharge : String!
    var cardId : String!
    var companyAmount : String!
    var customerId : String!
    var customerInfo : CustomerInfoData!
    var discount : String!
    var distance : String!
    var distanceFare : String!
    var driverAmount : String!
    var driverId : Int!
    var driverInfo : DriverInfoData!
    var driverVehicleInfo : DriverVehicleInfoData!
    var dropoffLat : String!
    var dropoffLng : String!
    var dropoffLocation : String!
    var dropoffTime : String!
    var durationFare : String!
    var estimatedFare : String!
    var extraCharge : String!
    var grandTotal : String!
    var noOfPassenger : String!
    var onTheWay : String!
    var paymentResponse : String!
    var paymentStatus : String!
    var paymentType : String!
    var pickupDateTime : String!
    var pickupLat : String!
    var pickupLng : String!
    var pickupLocation : String!
    var pickupTime : String!
    var promocode : String!
    var referenceId : String!
    var status : String!
    var subTotal : String!
    var tax : String!
    var tips : String!
    var tipsStatus : String!
    var tripDuration : String!
    var vehicleType : VehicleTypeData!
    var vehicleTypeId : String!
    var waitingTime : String!
    var waitingTimeCharge : String!

    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        id = json["_id"].stringValue
        acceptTime = json["accept_time"].intValue
        arrivedTime = json["arrived_time"].stringValue
        baseFare = json["base_fare"].stringValue
        bookingFee = json["booking_fee"].stringValue
        bookingTime = json["booking_time"].stringValue
        bookingType = json["booking_type"].stringValue
        cancelBy = json["cancel_by"].stringValue
        cancelReason = json["cancel_reason"].stringValue
        cancellationCharge = json["cancellation_charge"].stringValue
        cardId = json["card_id"].stringValue
        companyAmount = json["company_amount"].stringValue
        customerId = json["customer_id"].stringValue
        let customerInfoJson = json["customer_info"]
        if !customerInfoJson.isEmpty{
            customerInfo = CustomerInfoData(fromJson: customerInfoJson)
        }
        discount = json["discount"].stringValue
        distance = json["distance"].stringValue
        distanceFare = json["distance_fare"].stringValue
        driverAmount = json["driver_amount"].stringValue
        driverId = json["driver_id"].intValue
        let driverInfoJson = json["driver_info"]
        if !driverInfoJson.isEmpty{
            driverInfo = DriverInfoData(fromJson: driverInfoJson)
        }
        let driverVehicleInfoJson = json["driver_vehicle_info"]
        if !driverVehicleInfoJson.isEmpty{
            driverVehicleInfo = DriverVehicleInfoData(fromJson: driverVehicleInfoJson)
        }
        dropoffLat = json["dropoff_lat"].stringValue
        dropoffLng = json["dropoff_lng"].stringValue
        dropoffLocation = json["dropoff_location"].stringValue
        dropoffTime = json["dropoff_time"].stringValue
        durationFare = json["duration_fare"].stringValue
        estimatedFare = json["estimated_fare"].stringValue
        extraCharge = json["extra_charge"].stringValue
        grandTotal = json["grand_total"].stringValue
        id = json["id"].stringValue
        noOfPassenger = json["no_of_passenger"].stringValue
        onTheWay = json["on_the_way"].stringValue
        paymentResponse = json["payment_response"].stringValue
        paymentStatus = json["payment_status"].stringValue
        paymentType = json["payment_type"].stringValue
        pickupDateTime = json["pickup_date_time"].stringValue
        pickupLat = json["pickup_lat"].stringValue
        pickupLng = json["pickup_lng"].stringValue
        pickupLocation = json["pickup_location"].stringValue
        pickupTime = json["pickup_time"].stringValue
        promocode = json["promocode"].stringValue
        referenceId = json["reference_id"].stringValue
        status = json["status"].stringValue
        subTotal = json["sub_total"].stringValue
        tax = json["tax"].stringValue
        tips = json["tips"].stringValue
        tipsStatus = json["tips_status"].stringValue
        tripDuration = json["trip_duration"].stringValue
        let vehicleTypeJson = json["vehicle_type"]
        if !vehicleTypeJson.isEmpty{
            vehicleType = VehicleTypeData(fromJson: vehicleTypeJson)
        }
        vehicleTypeId = json["vehicle_type_id"].stringValue
        waitingTime = json["waiting_time"].stringValue
        waitingTimeCharge = json["waiting_time_charge"].stringValue
    }
    
            
    }



class VehicleTypeData : Codable{

    var baseCharge : String!
    var baseKm : String!
    var bookingFee : String!
    var capacity : String!
    var commission : String!
    var createdAt : String!
    var customerCancellationFee : String!
    var descriptionField : String!
    var driverCancellationFee : String!
    var extraCharge : String!
    var freeCancallationTime : String!
    var id : String!
    var image : String!
    var isNightCharge : String!
    var isSpecialEventCharge : String!
    var name : String!
    var nightCharge : String!
    var nightFrom : String!
    var nightTo : String!
    var perKmCharge : String!
    var perMinuteCharge : String!
    var premiumCharge : String!
    var specialEventCharge : String!
    var specialEventFrom : String!
    var specialEventTo : String!
    var status : String!
    var trash : String!
    var unselectImage : String!
    var updatedAt : String!
    var waitingTimePerMinCharge : String!

    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        baseCharge = json["base_charge"].stringValue
        baseKm = json["base_km"].stringValue
        bookingFee = json["booking_fee"].stringValue
        capacity = json["capacity"].stringValue
        commission = json["commission"].stringValue
        createdAt = json["created_at"].stringValue
        customerCancellationFee = json["customer_cancellation_fee"].stringValue
        descriptionField = json["description"].stringValue
        driverCancellationFee = json["driver_cancellation_fee"].stringValue
        extraCharge = json["extra_charge"].stringValue
        freeCancallationTime = json["free_cancallation_time"].stringValue
        id = json["id"].stringValue
        image = json["image"].stringValue
        isNightCharge = json["is_night_charge"].stringValue
        isSpecialEventCharge = json["is_special_event_charge"].stringValue
        name = json["name"].stringValue
        nightCharge = json["night_charge"].stringValue
        nightFrom = json["night_from"].stringValue
        nightTo = json["night_to"].stringValue
        perKmCharge = json["per_km_charge"].stringValue
        perMinuteCharge = json["per_minute_charge"].stringValue
        premiumCharge = json["premium_charge"].stringValue
        specialEventCharge = json["special_event_charge"].stringValue
        specialEventFrom = json["special_event_from"].stringValue
        specialEventTo = json["special_event_to"].stringValue
        status = json["status"].stringValue
        trash = json["trash"].stringValue
        unselectImage = json["unselect_image"].stringValue
        updatedAt = json["updated_at"].stringValue
        waitingTimePerMinCharge = json["waiting_time_per_min_charge"].stringValue
    }

    
    
   
}


class DriverVehicleInfoData : Codable{

    var carBack : String!
    var carFront : String!
    var carLeft : String!
    var carRight : String!
    var color : String!
    var companyId : Int!
    var driverId : Int!
    var id : Int!
    var noOfPassenger : Int!
    var plateNumber : String!
    var vehicleImage : String!
    var vehicleType : String!
    var vehicleTypeManufacturerId : Int!
    var vehicleTypeManufacturerName : String!
    var vehicleTypeModelId : Int!
    var vehicleTypeModelName : String!
    var yearOfManufacture : Int!

    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        carBack = json["car_back"].stringValue
        carFront = json["car_front"].stringValue
        carLeft = json["car_left"].stringValue
        carRight = json["car_right"].stringValue
        color = json["color"].stringValue
        companyId = json["company_id"].intValue
        driverId = json["driver_id"].intValue
        id = json["id"].intValue
        noOfPassenger = json["no_of_passenger"].intValue
        plateNumber = json["plate_number"].stringValue
        vehicleImage = json["vehicle_image"].stringValue
        vehicleType = json["vehicle_type"].stringValue
        vehicleTypeManufacturerId = json["vehicle_type_manufacturer_id"].intValue
        vehicleTypeManufacturerName = json["vehicle_type_manufacturer_name"].stringValue
        vehicleTypeModelId = json["vehicle_type_model_id"].intValue
        vehicleTypeModelName = json["vehicle_type_model_name"].stringValue
        yearOfManufacture = json["year_of_manufacture"].intValue
    }

    
    

    }



class CustomerInfoData : Codable{

    var address : String!
    var companyId : String!
    var countryCode : String!
    var countryId : String!
    var createdAt : String!
    var deviceToken : String!
    var deviceType : String!
    var dob : String!
    var email : String!
    var firstName : String!
    var gender : String!
    var id : String!
    var isSocial : String!
    var lastName : String!
    var lat : String!
    var lng : String!
    var mobileNo : String!
    var password : String!
    var profileImage : String!
    var qrCode : String!
    var rating : String!
    var referralCode : String!
    var rememberToken : String!
    var socialId : String!
    var socialType : String!
    var status : String!
    var trash : String!
    var walletBalance : String!

    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        address = json["address"].stringValue
        companyId = json["company_id"].stringValue
        countryCode = json["country_code"].stringValue
        countryId = json["country_id"].stringValue
        createdAt = json["created_at"].stringValue
        deviceToken = json["device_token"].stringValue
        deviceType = json["device_type"].stringValue
        dob = json["dob"].stringValue
        email = json["email"].stringValue
        firstName = json["first_name"].stringValue
        gender = json["gender"].stringValue
        id = json["id"].stringValue
        isSocial = json["is_social"].stringValue
        lastName = json["last_name"].stringValue
        lat = json["lat"].stringValue
        lng = json["lng"].stringValue
        mobileNo = json["mobile_no"].stringValue
        password = json["password"].stringValue
        profileImage = json["profile_image"].stringValue
        qrCode = json["qr_code"].stringValue
        rating = json["rating"].stringValue
        referralCode = json["referral_code"].stringValue
        rememberToken = json["remember_token"].stringValue
        socialId = json["social_id"].stringValue
        socialType = json["social_type"].stringValue
        status = json["status"].stringValue
        trash = json["trash"].stringValue
        walletBalance = json["wallet_balance"].stringValue
    }
    
   
    }


class DriverInfoData : Codable{

    var accountHolderName : String!
    var accountNumber : String!
    var address : String!
    var bankName : String!
    var busy : Int!
    var companyId : Int!
    var countryCode : String!
    var countryId : Int!
    var createdAt : String!
    var deviceToken : String!
    var deviceType : String!
    var dob : String!
    var duty : Int!
    var email : String!
    var firstName : String!
    var gender : String!
    var id : Int!
    var ifscCode : String!
    var inviteCode : String!
    var lastName : String!
    var lat : String!
    var lng : String!
    var mobileNo : String!
    var password : String!
    var profileImage : String!
    var qrCode : String!
    var rating : String!
    var referralCode : String!
    var rememberToken : String!
    var status : Int!
    var trash : Int!
    var vehicleType : String!
    var verify : Int!
    var walletBalance : Int!

    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        accountHolderName = json["account_holder_name"].stringValue
        accountNumber = json["account_number"].stringValue
        address = json["address"].stringValue
        bankName = json["bank_name"].stringValue
        busy = json["busy"].intValue
        companyId = json["company_id"].intValue
        countryCode = json["country_code"].stringValue
        countryId = json["country_id"].intValue
        createdAt = json["created_at"].stringValue
        deviceToken = json["device_token"].stringValue
        deviceType = json["device_type"].stringValue
        dob = json["dob"].stringValue
        duty = json["duty"].intValue
        email = json["email"].stringValue
        firstName = json["first_name"].stringValue
        gender = json["gender"].stringValue
        id = json["id"].intValue
        ifscCode = json["ifsc_code"].stringValue
        inviteCode = json["invite_code"].stringValue
        lastName = json["last_name"].stringValue
        lat = json["lat"].stringValue
        lng = json["lng"].stringValue
        mobileNo = json["mobile_no"].stringValue
        password = json["password"].stringValue
        profileImage = json["profile_image"].stringValue
        qrCode = json["qr_code"].stringValue
        rating = json["rating"].stringValue
        referralCode = json["referral_code"].stringValue
        rememberToken = json["remember_token"].stringValue
        status = json["status"].intValue
        trash = json["trash"].intValue
        vehicleType = json["vehicle_type"].stringValue
        verify = json["verify"].intValue
        walletBalance = json["wallet_balance"].intValue
    }
    
   

    }
