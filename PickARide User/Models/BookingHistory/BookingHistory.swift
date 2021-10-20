//
//  BookingHistory.swift
//  PickARide User
//
//  Created by Admin on 27/09/21.
//  Copyright © 2021 EWW071. All rights reserved.
//

import Foundation

class RootCurrentBooking : Codable {

            let data : CurrentBookingData?
            let message : String?
            let status : Bool?

            enum CodingKeys: String, CodingKey {
                    case data = "data"
                    case message = "message"
                    case status = "status"
            }
        
    required init(from decoder: Decoder) throws {
                    let values = try? decoder.container(keyedBy: CodingKeys.self)
                     data = try values?.decodeIfPresent(CurrentBookingData.self, forKey: .data)
                    message = try values?.decodeIfPresent(String.self, forKey: .message)
                    status = try values?.decodeIfPresent(Bool.self, forKey: .status)
                   }
                 }


class CurrentBookingData : Codable {

        let acceptTime : String?
        let arrivedTime : String?
        let baseFare : String?
        let bookingFee : String?
        let bookingTime : String?
        let bookingType : String?
        let cancelBy : String?
        let cancelReason : String?
        let cancellationCharge : String?
        let cardId : String?
        let companyAmount : String?
        let customerId : String?
        let customerInfo : CustomerInfo?
        let discount : String?
        let distance : String?
        let distanceFare : String?
        let driverAmount : String?
        let driverId : String?
        let driverInfo : DriverInfo?
        let driverVehicleInfo : DriverVehicleInfo?
        let dropoffLat : String?
        let dropoffLng : String?
        let dropoffLocation : String?
        let dropoffTime : String?
        let durationFare : String?
        let estimatedFare : String?
        let extraCharge : String?
        let grandTotal : String?
        let id : String?
        let noOfPassenger : String?
        let onTheWay : String?
        let paymentResponse : String?
        let paymentStatus : String?
        let paymentType : String?
        let pickupDateTime : String?
        let pickupLat : String?
        let pickupLng : String?
        let pickupLocation : String?
        let pickupTime : String?
        let promocode : String?
        let referenceId : String?
        let status : String?
        let subTotal : String?
        let tax : String?
        let tips : String?
        let tipsStatus : String?
        let tripDuration : String?
        let vehicleType : VehicleType?
        let vehicleTypeId : String?
        let waitingTime : String?
        let waitingTimeCharge : String?

        enum CodingKeys: String, CodingKey {
                case acceptTime = "accept_time"
                case arrivedTime = "arrived_time"
                case baseFare = "base_fare"
                case bookingFee = "booking_fee"
                case bookingTime = "booking_time"
                case bookingType = "booking_type"
                case cancelBy = "cancel_by"
                case cancelReason = "cancel_reason"
                case cancellationCharge = "cancellation_charge"
                case cardId = "card_id"
                case companyAmount = "company_amount"
                case customerId = "customer_id"
                case customerInfo = "customer_info"
                case discount = "discount"
                case distance = "distance"
                case distanceFare = "distance_fare"
                case driverAmount = "driver_amount"
                case driverId = "driver_id"
                case driverInfo = "driver_info"
                case driverVehicleInfo = "driver_vehicle_info"
                case dropoffLat = "dropoff_lat"
                case dropoffLng = "dropoff_lng"
                case dropoffLocation = "dropoff_location"
                case dropoffTime = "dropoff_time"
                case durationFare = "duration_fare"
                case estimatedFare = "estimated_fare"
                case extraCharge = "extra_charge"
                case grandTotal = "grand_total"
                case id = "id"
                case noOfPassenger = "no_of_passenger"
                case onTheWay = "on_the_way"
                case paymentResponse = "payment_response"
                case paymentStatus = "payment_status"
                case paymentType = "payment_type"
                case pickupDateTime = "pickup_date_time"
                case pickupLat = "pickup_lat"
                case pickupLng = "pickup_lng"
                case pickupLocation = "pickup_location"
                case pickupTime = "pickup_time"
                case promocode = "promocode"
                case referenceId = "reference_id"
                case status = "status"
                case subTotal = "sub_total"
                case tax = "tax"
                case tips = "tips"
                case tipsStatus = "tips_status"
                case tripDuration = "trip_duration"
                case vehicleType = "vehicle_type"
                case vehicleTypeId = "vehicle_type_id"
                case waitingTime = "waiting_time"
                case waitingTimeCharge = "waiting_time_charge"
        }
    
    required init(from decoder: Decoder) throws {
                let values = try? decoder.container(keyedBy: CodingKeys.self)
                acceptTime = try? values?.decodeIfPresent(String.self, forKey: .acceptTime)
                arrivedTime = try values?.decodeIfPresent(String.self, forKey: .arrivedTime)
        baseFare = try values?.decodeIfPresent(String.self, forKey: .baseFare)
        bookingFee = try values?.decodeIfPresent(String.self, forKey: .bookingFee)
        bookingTime = try values?.decodeIfPresent(String.self, forKey: .bookingTime)
        bookingType = try values?.decodeIfPresent(String.self, forKey: .bookingType)
        cancelBy = try values?.decodeIfPresent(String.self, forKey: .cancelBy)
        cancelReason = try values?.decodeIfPresent(String.self, forKey: .cancelReason)
        cancellationCharge = try values?.decodeIfPresent(String.self, forKey: .cancellationCharge)
        cardId = try values?.decodeIfPresent(String.self, forKey: .cardId)
        companyAmount = try values?.decodeIfPresent(String.self, forKey: .companyAmount)
        customerId = try values?.decodeIfPresent(String.self, forKey: .customerId)
            customerInfo = try values?.decodeIfPresent(CustomerInfo.self, forKey: .customerInfo)
        discount = try values?.decodeIfPresent(String.self, forKey: .discount)
        distance = try values?.decodeIfPresent(String.self, forKey: .distance)
        distanceFare = try values?.decodeIfPresent(String.self, forKey: .distanceFare)
        driverAmount = try values?.decodeIfPresent(String.self, forKey: .driverAmount)
        driverId = try values?.decodeIfPresent(String.self, forKey: .driverId)
            driverInfo = try values?.decodeIfPresent(DriverInfo.self, forKey: .driverInfo)
            driverVehicleInfo = try values?.decodeIfPresent(DriverVehicleInfo.self, forKey: .driverVehicleInfo)
        dropoffLat = try values?.decodeIfPresent(String.self, forKey: .dropoffLat)
        dropoffLng = try values?.decodeIfPresent(String.self, forKey: .dropoffLng)
        dropoffLocation = try values?.decodeIfPresent(String.self, forKey: .dropoffLocation)
        dropoffTime = try values?.decodeIfPresent(String.self, forKey: .dropoffTime)
        durationFare = try values?.decodeIfPresent(String.self, forKey: .durationFare)
        estimatedFare = try values?.decodeIfPresent(String.self, forKey: .estimatedFare)
        extraCharge = try values?.decodeIfPresent(String.self, forKey: .extraCharge)
        grandTotal = try values?.decodeIfPresent(String.self, forKey: .grandTotal)
        id = try values?.decodeIfPresent(String.self, forKey: .id)
        noOfPassenger = try values?.decodeIfPresent(String.self, forKey: .noOfPassenger)
        onTheWay = try values?.decodeIfPresent(String.self, forKey: .onTheWay)
        paymentResponse = try values?.decodeIfPresent(String.self, forKey: .paymentResponse)
        paymentStatus = try values?.decodeIfPresent(String.self, forKey: .paymentStatus)
        paymentType = try values?.decodeIfPresent(String.self, forKey: .paymentType)
        pickupDateTime = try values?.decodeIfPresent(String.self, forKey: .pickupDateTime)
        pickupLat = try values?.decodeIfPresent(String.self, forKey: .pickupLat)
        pickupLng = try values?.decodeIfPresent(String.self, forKey: .pickupLng)
        pickupLocation = try values?.decodeIfPresent(String.self, forKey: .pickupLocation)
        pickupTime = try values?.decodeIfPresent(String.self, forKey: .pickupTime)
        promocode = try values?.decodeIfPresent(String.self, forKey: .promocode)
        referenceId = try values?.decodeIfPresent(String.self, forKey: .referenceId)
        status = try values?.decodeIfPresent(String.self, forKey: .status)
        subTotal = try values?.decodeIfPresent(String.self, forKey: .subTotal)
        tax = try values?.decodeIfPresent(String.self, forKey: .tax)
        tips = try values?.decodeIfPresent(String.self, forKey: .tips)
        tipsStatus = try values?.decodeIfPresent(String.self, forKey: .tipsStatus)
        tripDuration = try values?.decodeIfPresent(String.self, forKey: .tripDuration)
            vehicleType = try values?.decodeIfPresent(VehicleType.self, forKey: .vehicleType)
        vehicleTypeId = try values?.decodeIfPresent(String.self, forKey: .vehicleTypeId)
        waitingTime = try values?.decodeIfPresent(String.self, forKey: .waitingTime)
        waitingTimeCharge = try values?.decodeIfPresent(String.self, forKey: .waitingTimeCharge)
        }

}


//class CurrentBookingData : Codable {
//
//        let acceptTime : String?
//        let arrivedTime : String?
//        let baseFare : String?
//        let bookingFee : String?
//        let bookingTime : String?
//        let bookingType : String?
//        let cancelBy : String?
//        let cancelReason : String?
//        let cancellationCharge : String?
//        let cardId : String?
//        let companyAmount : String?
//        let customerId : String?
//        let customerInfo : CustomerInfo?
//        let discount : String?
//        let distance : String?
//        let distanceFare : String?
//        let driverAmount : String?
//        let driverId : String?
//        let driverInfo : DriverInfo?
//        let driverVehicleInfo : DriverVehicleInfo?
//        let dropoffLat : String?
//        let dropoffLng : String?
//        let dropoffLocation : String?
//        let dropoffTime : String?
//        let durationFare : String?
//        let estimatedFare : String?
//        let extraCharge : String?
//        let grandTotal : String?
//        let id : String?
//        let noOfPassenger : String?
//        let onTheWay : String?
//        let paymentResponse : String?
//        let paymentStatus : String?
//        let paymentType : String?
//        let pickupDateTime : String?
//        let pickupLat : String?
//        let pickupLng : String?
//        let pickupLocation : String?
//        let pickupTime : String?
//        let promocode : String?
//        let referenceId : String?
//        let status : String?
//        let subTotal : String?
//        let tax : String?
//        let tips : String?
//        let tipsStatus : String?
//        let tripDuration : String?
//        let vehicleType : VehicleType?
//        let vehicleTypeId : String?
//        let waitingTime : String?
//        let waitingTimeCharge : String?
//
//        enum CodingKeys: String, CodingKey {
//                case acceptTime = "accept_time"
//                case arrivedTime = "arrived_time"
//                case baseFare = "base_fare"
//                case bookingFee = "booking_fee"
//                case bookingTime = "booking_time"
//                case bookingType = "booking_type"
//                case cancelBy = "cancel_by"
//                case cancelReason = "cancel_reason"
//                case cancellationCharge = "cancellation_charge"
//                case cardId = "card_id"
//                case companyAmount = "company_amount"
//                case customerId = "customer_id"
//                case customerInfo = "customer_info"
//                case discount = "discount"
//                case distance = "distance"
//                case distanceFare = "distance_fare"
//                case driverAmount = "driver_amount"
//                case driverId = "driver_id"
//                case driverInfo = "driver_info"
//                case driverVehicleInfo = "driver_vehicle_info"
//                case dropoffLat = "dropoff_lat"
//                case dropoffLng = "dropoff_lng"
//                case dropoffLocation = "dropoff_location"
//                case dropoffTime = "dropoff_time"
//                case durationFare = "duration_fare"
//                case estimatedFare = "estimated_fare"
//                case extraCharge = "extra_charge"
//                case grandTotal = "grand_total"
//                case id = "id"
//                case noOfPassenger = "no_of_passenger"
//                case onTheWay = "on_the_way"
//                case paymentResponse = "payment_response"
//                case paymentStatus = "payment_status"
//                case paymentType = "payment_type"
//                case pickupDateTime = "pickup_date_time"
//                case pickupLat = "pickup_lat"
//                case pickupLng = "pickup_lng"
//                case pickupLocation = "pickup_location"
//                case pickupTime = "pickup_time"
//                case promocode = "promocode"
//                case referenceId = "reference_id"
//                case status = "status"
//                case subTotal = "sub_total"
//                case tax = "tax"
//                case tips = "tips"
//                case tipsStatus = "tips_status"
//                case tripDuration = "trip_duration"
//                case vehicleType = "vehicle_type"
//                case vehicleTypeId = "vehicle_type_id"
//                case waitingTime = "waiting_time"
//                case waitingTimeCharge = "waiting_time_charge"
//        }
//
//    required init(from decoder: Decoder) throws {
//                let values = try decoder.container(keyedBy: CodingKeys.self)
//                acceptTime = try values.decodeIfPresent(String.self, forKey: .acceptTime)
//                arrivedTime = try values.decodeIfPresent(String.self, forKey: .arrivedTime)
//                baseFare = try values.decodeIfPresent(String.self, forKey: .baseFare)
//                bookingFee = try values.decodeIfPresent(String.self, forKey: .bookingFee)
//                bookingTime = try values.decodeIfPresent(String.self, forKey: .bookingTime)
//                bookingType = try values.decodeIfPresent(String.self, forKey: .bookingType)
//                cancelBy = try values.decodeIfPresent(String.self, forKey: .cancelBy)
//                cancelReason = try values.decodeIfPresent(String.self, forKey: .cancelReason)
//                cancellationCharge = try values.decodeIfPresent(String.self, forKey: .cancellationCharge)
//                cardId = try values.decodeIfPresent(String.self, forKey: .cardId)
//                companyAmount = try values.decodeIfPresent(String.self, forKey: .companyAmount)
//                customerId = try values.decodeIfPresent(String.self, forKey: .customerId)
//        customerInfo = try CustomerInfo(from: decoder)
//                discount = try values.decodeIfPresent(String.self, forKey: .discount)
//                distance = try values.decodeIfPresent(String.self, forKey: .distance)
//                distanceFare = try values.decodeIfPresent(String.self, forKey: .distanceFare)
//                driverAmount = try values.decodeIfPresent(String.self, forKey: .driverAmount)
//                driverId = try values.decodeIfPresent(String.self, forKey: .driverId)
//        driverInfo = try DriverInfo(from: decoder)
//        driverVehicleInfo = try DriverVehicleInfo(from: decoder)
//                dropoffLat = try values.decodeIfPresent(String.self, forKey: .dropoffLat)
//                dropoffLng = try values.decodeIfPresent(String.self, forKey: .dropoffLng)
//                dropoffLocation = try values.decodeIfPresent(String.self, forKey: .dropoffLocation)
//                dropoffTime = try values.decodeIfPresent(String.self, forKey: .dropoffTime)
//                durationFare = try values.decodeIfPresent(String.self, forKey: .durationFare)
//                estimatedFare = try values.decodeIfPresent(String.self, forKey: .estimatedFare)
//                extraCharge = try values.decodeIfPresent(String.self, forKey: .extraCharge)
//                grandTotal = try values.decodeIfPresent(String.self, forKey: .grandTotal)
//                id = try values.decodeIfPresent(String.self, forKey: .id)
//                noOfPassenger = try values.decodeIfPresent(String.self, forKey: .noOfPassenger)
//                onTheWay = try values.decodeIfPresent(String.self, forKey: .onTheWay)
//                paymentResponse = try values.decodeIfPresent(String.self, forKey: .paymentResponse)
//                paymentStatus = try values.decodeIfPresent(String.self, forKey: .paymentStatus)
//                paymentType = try values.decodeIfPresent(String.self, forKey: .paymentType)
//                pickupDateTime = try values.decodeIfPresent(String.self, forKey: .pickupDateTime)
//                pickupLat = try values.decodeIfPresent(String.self, forKey: .pickupLat)
//                pickupLng = try values.decodeIfPresent(String.self, forKey: .pickupLng)
//                pickupLocation = try values.decodeIfPresent(String.self, forKey: .pickupLocation)
//                pickupTime = try values.decodeIfPresent(String.self, forKey: .pickupTime)
//                promocode = try values.decodeIfPresent(String.self, forKey: .promocode)
//                referenceId = try values.decodeIfPresent(String.self, forKey: .referenceId)
//                status = try values.decodeIfPresent(String.self, forKey: .status)
//                subTotal = try values.decodeIfPresent(String.self, forKey: .subTotal)
//                tax = try values.decodeIfPresent(String.self, forKey: .tax)
//                tips = try values.decodeIfPresent(String.self, forKey: .tips)
//                tipsStatus = try values.decodeIfPresent(String.self, forKey: .tipsStatus)
//                tripDuration = try values.decodeIfPresent(String.self, forKey: .tripDuration)
//        vehicleType = try? VehicleType(from: decoder)
//                vehicleTypeId = try values.decodeIfPresent(String.self, forKey: .vehicleTypeId)
//                waitingTime = try values.decodeIfPresent(String.self, forKey: .waitingTime)
//                waitingTimeCharge = try values.decodeIfPresent(String.self, forKey: .waitingTimeCharge)
//        }
//
//}




class RootBookingHistory : Codable {

        let data : [BookingData]?
        let message : String?
        let status : Bool?

        enum CodingKeys: String, CodingKey {
                case data = "data"
                case message = "message"
                case status = "status"
        }
    
    required init(from decoder: Decoder) throws {
                let values = try? decoder.container(keyedBy: CodingKeys.self)
                data = try? values?.decodeIfPresent([BookingData].self, forKey: .data)
                message = try? values?.decodeIfPresent(String.self, forKey: .message)
                status = try? values?.decodeIfPresent(Bool.self, forKey: .status)
        }

}



class BookingData : Codable {

        let bookingInfo : BookingInfo?
        let customerInfo : CustomerInfo?
        let driverInfo : DriverInfo?
        let driverVehicleInfo : DriverVehicleInfo?
        let vehicleType : VehicleType?

        enum CodingKeys: String, CodingKey {
                case bookingInfo = "booking_info"
                case customerInfo = "customer_info"
                case driverInfo = "driver_info"
                case driverVehicleInfo = "driver_vehicle_info"
                case vehicleType = "vehicle_type"
        }
    
    required init(from decoder: Decoder) throws {
        let values = try? decoder.container(keyedBy: CodingKeys.self)
       
        bookingInfo =  try? values?.decodeIfPresent(BookingInfo.self, forKey: .bookingInfo)
        customerInfo = try? values?.decodeIfPresent(CustomerInfo.self, forKey: .customerInfo)
        driverInfo = try? values?.decodeIfPresent(DriverInfo.self, forKey: .driverInfo)
        driverVehicleInfo = try? values?.decodeIfPresent(DriverVehicleInfo.self, forKey: .driverVehicleInfo)
        vehicleType = try? values?.decodeIfPresent(VehicleType.self, forKey: .vehicleType)

        }

}



class VehicleType : Codable {

        let baseCharge : String?
        let baseKm : String?
        let bookingFee : String?
        let capacity : String?
        let commission : String?
        let createdAt : String?
        let customerCancellationFee : String?
        let descriptionField : String?
        let driverCancellationFee : String?
        let extraCharge : String?
        let freeCancallationTime : String?
        let id : String?
        let image : String?
        let isNightCharge : String?
        let isSpecialEventCharge : String?
        let name : String?
        let nightCharge : String?
        let nightFrom : String?
        let nightTo : String?
        let perKmCharge : String?
        let perMinuteCharge : String?
        let premiumCharge : String?
        let specialEventCharge : String?
        let specialEventFrom : String?
        let specialEventTo : String?
        let status : String?
        let trash : String?
        let unselectImage : String?
        let updatedAt : String?
        let waitingTimePerMinCharge : String?

        enum CodingKeys: String, CodingKey {
                case baseCharge = "base_charge"
                case baseKm = "base_km"
                case bookingFee = "booking_fee"
                case capacity = "capacity"
                case commission = "commission"
                case createdAt = "created_at"
                case customerCancellationFee = "customer_cancellation_fee"
                case descriptionField = "description"
                case driverCancellationFee = "driver_cancellation_fee"
                case extraCharge = "extra_charge"
                case freeCancallationTime = "free_cancallation_time"
                case id = "id"
                case image = "image"
                case isNightCharge = "is_night_charge"
                case isSpecialEventCharge = "is_special_event_charge"
                case name = "name"
                case nightCharge = "night_charge"
                case nightFrom = "night_from"
                case nightTo = "night_to"
                case perKmCharge = "per_km_charge"
                case perMinuteCharge = "per_minute_charge"
                case premiumCharge = "premium_charge"
                case specialEventCharge = "special_event_charge"
                case specialEventFrom = "special_event_from"
                case specialEventTo = "special_event_to"
                case status = "status"
                case trash = "trash"
                case unselectImage = "unselect_image"
                case updatedAt = "updated_at"
                case waitingTimePerMinCharge = "waiting_time_per_min_charge"
        }
    
    required init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                baseCharge = try values.decodeIfPresent(String.self, forKey: .baseCharge)
                baseKm = try values.decodeIfPresent(String.self, forKey: .baseKm)
                bookingFee = try values.decodeIfPresent(String.self, forKey: .bookingFee)
                capacity = try values.decodeIfPresent(String.self, forKey: .capacity)
                commission = try values.decodeIfPresent(String.self, forKey: .commission)
                createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
                customerCancellationFee = try values.decodeIfPresent(String.self, forKey: .customerCancellationFee)
                descriptionField = try values.decodeIfPresent(String.self, forKey: .descriptionField)
                driverCancellationFee = try values.decodeIfPresent(String.self, forKey: .driverCancellationFee)
                extraCharge = try values.decodeIfPresent(String.self, forKey: .extraCharge)
                freeCancallationTime = try values.decodeIfPresent(String.self, forKey: .freeCancallationTime)
                id = try values.decodeIfPresent(String.self, forKey: .id)
                image = try values.decodeIfPresent(String.self, forKey: .image)
                isNightCharge = try values.decodeIfPresent(String.self, forKey: .isNightCharge)
                isSpecialEventCharge = try values.decodeIfPresent(String.self, forKey: .isSpecialEventCharge)
                name = try values.decodeIfPresent(String.self, forKey: .name)
                nightCharge = try values.decodeIfPresent(String.self, forKey: .nightCharge)
                nightFrom = try values.decodeIfPresent(String.self, forKey: .nightFrom)
                nightTo = try values.decodeIfPresent(String.self, forKey: .nightTo)
                perKmCharge = try values.decodeIfPresent(String.self, forKey: .perKmCharge)
                perMinuteCharge = try values.decodeIfPresent(String.self, forKey: .perMinuteCharge)
                premiumCharge = try values.decodeIfPresent(String.self, forKey: .premiumCharge)
                specialEventCharge = try values.decodeIfPresent(String.self, forKey: .specialEventCharge)
                specialEventFrom = try values.decodeIfPresent(String.self, forKey: .specialEventFrom)
                specialEventTo = try values.decodeIfPresent(String.self, forKey: .specialEventTo)
                status = try values.decodeIfPresent(String.self, forKey: .status)
                trash = try values.decodeIfPresent(String.self, forKey: .trash)
                unselectImage = try values.decodeIfPresent(String.self, forKey: .unselectImage)
                updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
                waitingTimePerMinCharge = try values.decodeIfPresent(String.self, forKey: .waitingTimePerMinCharge)
        }

}


class DriverVehicleInfo : Codable {

        let carBack : String?
        let carFront : String?
        let carLeft : String?
        let carRight : String?
        let color : String?
        let companyId : String?
        let driverId : String?
        let id : String?
        let noOfPassenger : String?
        let plateNumber : String?
        let vehicleImage : String?
        let vehicleType : String?
        let vehicleTypeManufacturerId : String?
        let vehicleTypeManufacturerName : String?
        let vehicleTypeModelId : String?
        let vehicleTypeModelName : String?
        let vehicleTypeName : String?
        let yearOfManufacture : String?

        enum CodingKeys: String, CodingKey {
                case carBack = "car_back"
                case carFront = "car_front"
                case carLeft = "car_left"
                case carRight = "car_right"
                case color = "color"
                case companyId = "company_id"
                case driverId = "driver_id"
                case id = "id"
                case noOfPassenger = "no_of_passenger"
                case plateNumber = "plate_number"
                case vehicleImage = "vehicle_image"
                case vehicleType = "vehicle_type"
                case vehicleTypeManufacturerId = "vehicle_type_manufacturer_id"
                case vehicleTypeManufacturerName = "vehicle_type_manufacturer_name"
                case vehicleTypeModelId = "vehicle_type_model_id"
                case vehicleTypeModelName = "vehicle_type_model_name"
                case vehicleTypeName = "vehicle_type_name"
                case yearOfManufacture = "year_of_manufacture"
        }
    
    required init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                carBack = try values.decodeIfPresent(String.self, forKey: .carBack)
                carFront = try values.decodeIfPresent(String.self, forKey: .carFront)
                carLeft = try values.decodeIfPresent(String.self, forKey: .carLeft)
                carRight = try values.decodeIfPresent(String.self, forKey: .carRight)
                color = try values.decodeIfPresent(String.self, forKey: .color)
                companyId = try values.decodeIfPresent(String.self, forKey: .companyId)
                driverId = try values.decodeIfPresent(String.self, forKey: .driverId)
                id = try values.decodeIfPresent(String.self, forKey: .id)
                noOfPassenger = try values.decodeIfPresent(String.self, forKey: .noOfPassenger)
                plateNumber = try values.decodeIfPresent(String.self, forKey: .plateNumber)
                vehicleImage = try values.decodeIfPresent(String.self, forKey: .vehicleImage)
                vehicleType = try values.decodeIfPresent(String.self, forKey: .vehicleType)
                vehicleTypeManufacturerId = try values.decodeIfPresent(String.self, forKey: .vehicleTypeManufacturerId)
                vehicleTypeManufacturerName = try values.decodeIfPresent(String.self, forKey: .vehicleTypeManufacturerName)
                vehicleTypeModelId = try values.decodeIfPresent(String.self, forKey: .vehicleTypeModelId)
                vehicleTypeModelName = try values.decodeIfPresent(String.self, forKey: .vehicleTypeModelName)
                vehicleTypeName = try values.decodeIfPresent(String.self, forKey: .vehicleTypeName)
                yearOfManufacture = try values.decodeIfPresent(String.self, forKey: .yearOfManufacture)
        }

}



class DriverInfo : Codable {

        let accountHolderName : String?
        let accountNumber : String?
        let address : String?
        let bankName : String?
        let busy : String?
        let companyId : String?
        let countryCode : String?
        let countryId : String?
        let createdAt : String?
        let deviceToken : String?
        let deviceType : String?
        let dob : String?
        let duty : String?
        let email : String?
        let firstName : String?
        let gender : String?
        let id : String?
        let ifscCode : String?
        let inviteCode : String?
        let lastName : String?
        let lat : String?
        let lng : String?
        let mobileNo : String?
        let password : String?
        let profileImage : String?
        let qrCode : String?
        let rating : String?
        let referralCode : String?
        let rememberToken : String?
        let status : String?
        let trash : String?
        let vehicleType : String?
        let verify : String?
        let walletBalance : String?

        enum CodingKeys: String, CodingKey {
                case accountHolderName = "account_holder_name"
                case accountNumber = "account_number"
                case address = "address"
                case bankName = "bank_name"
                case busy = "busy"
                case companyId = "company_id"
                case countryCode = "country_code"
                case countryId = "country_id"
                case createdAt = "created_at"
                case deviceToken = "device_token"
                case deviceType = "device_type"
                case dob = "dob"
                case duty = "duty"
                case email = "email"
                case firstName = "first_name"
                case gender = "gender"
                case id = "id"
                case ifscCode = "ifsc_code"
                case inviteCode = "invite_code"
                case lastName = "last_name"
                case lat = "lat"
                case lng = "lng"
                case mobileNo = "mobile_no"
                case password = "password"
                case profileImage = "profile_image"
                case qrCode = "qr_code"
                case rating = "rating"
                case referralCode = "referral_code"
                case rememberToken = "remember_token"
                case status = "status"
                case trash = "trash"
                case vehicleType = "vehicle_type"
                case verify = "verify"
                case walletBalance = "wallet_balance"
        }
    
    required init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                accountHolderName = try values.decodeIfPresent(String.self, forKey: .accountHolderName)
                accountNumber = try values.decodeIfPresent(String.self, forKey: .accountNumber)
                address = try values.decodeIfPresent(String.self, forKey: .address)
                bankName = try values.decodeIfPresent(String.self, forKey: .bankName)
                busy = try values.decodeIfPresent(String.self, forKey: .busy)
                companyId = try values.decodeIfPresent(String.self, forKey: .companyId)
                countryCode = try values.decodeIfPresent(String.self, forKey: .countryCode)
                countryId = try values.decodeIfPresent(String.self, forKey: .countryId)
                createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
                deviceToken = try values.decodeIfPresent(String.self, forKey: .deviceToken)
                deviceType = try values.decodeIfPresent(String.self, forKey: .deviceType)
                dob = try values.decodeIfPresent(String.self, forKey: .dob)
                duty = try values.decodeIfPresent(String.self, forKey: .duty)
                email = try values.decodeIfPresent(String.self, forKey: .email)
                firstName = try values.decodeIfPresent(String.self, forKey: .firstName)
                gender = try values.decodeIfPresent(String.self, forKey: .gender)
                id = try values.decodeIfPresent(String.self, forKey: .id)
                ifscCode = try values.decodeIfPresent(String.self, forKey: .ifscCode)
                inviteCode = try values.decodeIfPresent(String.self, forKey: .inviteCode)
                lastName = try values.decodeIfPresent(String.self, forKey: .lastName)
                lat = try values.decodeIfPresent(String.self, forKey: .lat)
                lng = try values.decodeIfPresent(String.self, forKey: .lng)
                mobileNo = try values.decodeIfPresent(String.self, forKey: .mobileNo)
                password = try values.decodeIfPresent(String.self, forKey: .password)
                profileImage = try values.decodeIfPresent(String.self, forKey: .profileImage)
                qrCode = try values.decodeIfPresent(String.self, forKey: .qrCode)
                rating = try values.decodeIfPresent(String.self, forKey: .rating)
                referralCode = try values.decodeIfPresent(String.self, forKey: .referralCode)
                rememberToken = try values.decodeIfPresent(String.self, forKey: .rememberToken)
                status = try values.decodeIfPresent(String.self, forKey: .status)
                trash = try values.decodeIfPresent(String.self, forKey: .trash)
                vehicleType = try values.decodeIfPresent(String.self, forKey: .vehicleType)
                verify = try values.decodeIfPresent(String.self, forKey: .verify)
                walletBalance = try values.decodeIfPresent(String.self, forKey: .walletBalance)
        }

}


class CustomerInfo : Codable {

        let address : String?
        let companyId : String?
        let countryCode : String?
        let countryId : String?
        let createdAt : String?
        let deviceToken : String?
        let deviceType : String?
        let dob : String?
        let email : String?
        let firstName : String?
        let gender : String?
        let id : String?
        let isSocial : String?
        let lastName : String?
        let lat : String?
        let lng : String?
        let mobileNo : String?
        let password : String?
        let profileImage : String?
        let qrCode : String?
        let rating : String?
        let referralCode : String?
        let rememberToken : String?
        let socialId : String?
        let socialType : String?
        let status : String?
        let trash : String?
        let walletBalance : String?

        enum CodingKeys: String, CodingKey {
                case address = "address"
                case companyId = "company_id"
                case countryCode = "country_code"
                case countryId = "country_id"
                case createdAt = "created_at"
                case deviceToken = "device_token"
                case deviceType = "device_type"
                case dob = "dob"
                case email = "email"
                case firstName = "first_name"
                case gender = "gender"
                case id = "id"
                case isSocial = "is_social"
                case lastName = "last_name"
                case lat = "lat"
                case lng = "lng"
                case mobileNo = "mobile_no"
                case password = "password"
                case profileImage = "profile_image"
                case qrCode = "qr_code"
                case rating = "rating"
                case referralCode = "referral_code"
                case rememberToken = "remember_token"
                case socialId = "social_id"
                case socialType = "social_type"
                case status = "status"
                case trash = "trash"
                case walletBalance = "wallet_balance"
        }
    
    required init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                address = try values.decodeIfPresent(String.self, forKey: .address)
                companyId = try values.decodeIfPresent(String.self, forKey: .companyId)
                countryCode = try values.decodeIfPresent(String.self, forKey: .countryCode)
                countryId = try values.decodeIfPresent(String.self, forKey: .countryId)
                createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
                deviceToken = try values.decodeIfPresent(String.self, forKey: .deviceToken)
                deviceType = try values.decodeIfPresent(String.self, forKey: .deviceType)
                dob = try values.decodeIfPresent(String.self, forKey: .dob)
                email = try values.decodeIfPresent(String.self, forKey: .email)
                firstName = try values.decodeIfPresent(String.self, forKey: .firstName)
                gender = try values.decodeIfPresent(String.self, forKey: .gender)
                id = try values.decodeIfPresent(String.self, forKey: .id)
                isSocial = try values.decodeIfPresent(String.self, forKey: .isSocial)
                lastName = try values.decodeIfPresent(String.self, forKey: .lastName)
                lat = try values.decodeIfPresent(String.self, forKey: .lat)
                lng = try values.decodeIfPresent(String.self, forKey: .lng)
                mobileNo = try values.decodeIfPresent(String.self, forKey: .mobileNo)
                password = try values.decodeIfPresent(String.self, forKey: .password)
                profileImage = try values.decodeIfPresent(String.self, forKey: .profileImage)
                qrCode = try values.decodeIfPresent(String.self, forKey: .qrCode)
                rating = try values.decodeIfPresent(String.self, forKey: .rating)
                referralCode = try values.decodeIfPresent(String.self, forKey: .referralCode)
                rememberToken = try values.decodeIfPresent(String.self, forKey: .rememberToken)
                socialId = try values.decodeIfPresent(String.self, forKey: .socialId)
                socialType = try values.decodeIfPresent(String.self, forKey: .socialType)
                status = try values.decodeIfPresent(String.self, forKey: .status)
                trash = try values.decodeIfPresent(String.self, forKey: .trash)
                walletBalance = try values.decodeIfPresent(String.self, forKey: .walletBalance)
        }

}



class BookingInfo : Codable {

        let acceptTime : String?
        let arrivedTime : String?
        let baseFare : String?
        let bookingFee : String?
        let bookingTime : String?
        let bookingType : String?
        let cancelBy : String?
        let cancelReason : String?
        let cancellationCharge : String?
        let cardId : String?
        let companyAmount : String?
        let customerId : String?
        let discount : String?
        let distance : String?
        let distanceFare : String?
        let driverAmount : String?
        let driverFirstName : String?
        let driverId : String?
        let driverLastName : String?
        let dropoffLat : String?
        let dropoffLng : String?
        let dropoffLocation : String?
        let dropoffTime : String?
        let durationFare : String?
        let estimatedFare : String?
        let extraCharge : String?
        let grandTotal : String?
        let id : String?
        let noOfPassenger : String?
        let onTheWay : String?
        let paymentResponse : String?
        let paymentStatus : String?
        let paymentType : String?
        let pickupDateTime : String?
        let pickupLat : String?
        let pickupLng : String?
        let pickupLocation : String?
        let pickupTime : String?
        let promocode : String?
        let referenceId : String?
        let status : String?
        let subTotal : String?
        let tax : String?
        let tips : String?
        let tipsStatus : String?
        let tripDuration : String?
        let vehicleName : String?
        let vehicleTypeId : String?
        let waitingTime : String?
        let waitingTimeCharge : String?

        enum CodingKeys: String, CodingKey {
                case acceptTime = "accept_time"
                case arrivedTime = "arrived_time"
                case baseFare = "base_fare"
                case bookingFee = "booking_fee"
                case bookingTime = "booking_time"
                case bookingType = "booking_type"
                case cancelBy = "cancel_by"
                case cancelReason = "cancel_reason"
                case cancellationCharge = "cancellation_charge"
                case cardId = "card_id"
                case companyAmount = "company_amount"
                case customerId = "customer_id"
                case discount = "discount"
                case distance = "distance"
                case distanceFare = "distance_fare"
                case driverAmount = "driver_amount"
                case driverFirstName = "driver_first_name"
                case driverId = "driver_id"
                case driverLastName = "driver_last_name"
                case dropoffLat = "dropoff_lat"
                case dropoffLng = "dropoff_lng"
                case dropoffLocation = "dropoff_location"
                case dropoffTime = "dropoff_time"
                case durationFare = "duration_fare"
                case estimatedFare = "estimated_fare"
                case extraCharge = "extra_charge"
                case grandTotal = "grand_total"
                case id = "id"
                case noOfPassenger = "no_of_passenger"
                case onTheWay = "on_the_way"
                case paymentResponse = "payment_response"
                case paymentStatus = "payment_status"
                case paymentType = "payment_type"
                case pickupDateTime = "pickup_date_time"
                case pickupLat = "pickup_lat"
                case pickupLng = "pickup_lng"
                case pickupLocation = "pickup_location"
                case pickupTime = "pickup_time"
                case promocode = "promocode"
                case referenceId = "reference_id"
                case status = "status"
                case subTotal = "sub_total"
                case tax = "tax"
                case tips = "tips"
                case tipsStatus = "tips_status"
                case tripDuration = "trip_duration"
                case vehicleName = "vehicle_name"
                case vehicleTypeId = "vehicle_type_id"
                case waitingTime = "waiting_time"
                case waitingTimeCharge = "waiting_time_charge"
        }
    
    required init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                acceptTime = try values.decodeIfPresent(String.self, forKey: .acceptTime)
                arrivedTime = try values.decodeIfPresent(String.self, forKey: .arrivedTime)
                baseFare = try values.decodeIfPresent(String.self, forKey: .baseFare)
                bookingFee = try values.decodeIfPresent(String.self, forKey: .bookingFee)
                bookingTime = try values.decodeIfPresent(String.self, forKey: .bookingTime)
                bookingType = try values.decodeIfPresent(String.self, forKey: .bookingType)
                cancelBy = try values.decodeIfPresent(String.self, forKey: .cancelBy)
                cancelReason = try values.decodeIfPresent(String.self, forKey: .cancelReason)
                cancellationCharge = try values.decodeIfPresent(String.self, forKey: .cancellationCharge)
                cardId = try values.decodeIfPresent(String.self, forKey: .cardId)
                companyAmount = try values.decodeIfPresent(String.self, forKey: .companyAmount)
                customerId = try values.decodeIfPresent(String.self, forKey: .customerId)
                discount = try values.decodeIfPresent(String.self, forKey: .discount)
                distance = try values.decodeIfPresent(String.self, forKey: .distance)
                distanceFare = try values.decodeIfPresent(String.self, forKey: .distanceFare)
                driverAmount = try values.decodeIfPresent(String.self, forKey: .driverAmount)
                driverFirstName = try values.decodeIfPresent(String.self, forKey: .driverFirstName)
                driverId = try values.decodeIfPresent(String.self, forKey: .driverId)
                driverLastName = try values.decodeIfPresent(String.self, forKey: .driverLastName)
                dropoffLat = try values.decodeIfPresent(String.self, forKey: .dropoffLat)
                dropoffLng = try values.decodeIfPresent(String.self, forKey: .dropoffLng)
                dropoffLocation = try values.decodeIfPresent(String.self, forKey: .dropoffLocation)
                dropoffTime = try values.decodeIfPresent(String.self, forKey: .dropoffTime)
                durationFare = try values.decodeIfPresent(String.self, forKey: .durationFare)
                estimatedFare = try values.decodeIfPresent(String.self, forKey: .estimatedFare)
                extraCharge = try values.decodeIfPresent(String.self, forKey: .extraCharge)
                grandTotal = try values.decodeIfPresent(String.self, forKey: .grandTotal)
                id = try values.decodeIfPresent(String.self, forKey: .id)
                noOfPassenger = try values.decodeIfPresent(String.self, forKey: .noOfPassenger)
                onTheWay = try values.decodeIfPresent(String.self, forKey: .onTheWay)
                paymentResponse = try values.decodeIfPresent(String.self, forKey: .paymentResponse)
                paymentStatus = try values.decodeIfPresent(String.self, forKey: .paymentStatus)
                paymentType = try values.decodeIfPresent(String.self, forKey: .paymentType)
                pickupDateTime = try values.decodeIfPresent(String.self, forKey: .pickupDateTime)
                pickupLat = try values.decodeIfPresent(String.self, forKey: .pickupLat)
                pickupLng = try values.decodeIfPresent(String.self, forKey: .pickupLng)
                pickupLocation = try values.decodeIfPresent(String.self, forKey: .pickupLocation)
                pickupTime = try values.decodeIfPresent(String.self, forKey: .pickupTime)
                promocode = try values.decodeIfPresent(String.self, forKey: .promocode)
                referenceId = try values.decodeIfPresent(String.self, forKey: .referenceId)
                status = try values.decodeIfPresent(String.self, forKey: .status)
                subTotal = try values.decodeIfPresent(String.self, forKey: .subTotal)
                tax = try values.decodeIfPresent(String.self, forKey: .tax)
                tips = try values.decodeIfPresent(String.self, forKey: .tips)
                tipsStatus = try values.decodeIfPresent(String.self, forKey: .tipsStatus)
                tripDuration = try values.decodeIfPresent(String.self, forKey: .tripDuration)
                vehicleName = try values.decodeIfPresent(String.self, forKey: .vehicleName)
                vehicleTypeId = try values.decodeIfPresent(String.self, forKey: .vehicleTypeId)
                waitingTime = try values.decodeIfPresent(String.self, forKey: .waitingTime)
                waitingTimeCharge = try values.decodeIfPresent(String.self, forKey: .waitingTimeCharge)
        }

}
