//
//  NavigationItems.swift
//  HC Pro Patient
//
//  Created by Shraddha Parmar on 30/09/20.
//  Copyright © 2020 EWW071. All rights reserved.
//

import Foundation
import Foundation
import UIKit

enum NavItemsLeft {
    case none, back, skip
    
    var value:String {
        switch self {
        case .none:
            return ""
        case .back:
            return "back"
        case .skip:
            return "skip"
        }
    }
}


enum NavItemsRight {
    case none, notifications, mail, menu, editProfile, profile, chat, languageSegment
    
    var value:String {
        switch self {
        case .none:
            return ""
        case .notifications:
            return "notifications"
        case .mail:
            return "mail"
        case .menu:
            return "menu"
        case .editProfile:
            return "editProfile"
        case .profile:
            return "profile"
        case .chat:
            return "chat"
        case .languageSegment:
            return "languageSegment"
        }
    }
}
enum NavTitles {
    case none, Home, MyMedicalFile, MyAppointmnets, MyProfile, Services, Offers, Settings, MyCareTeam, DoctorDetails, Chat, SelectCategory, SelectDate, DoctorsList, Payment, PaymentMethods, Contactus, Languagesettings, Notificationsettings, FAQ, Notifications, VisitPackage, SelectAddress, AddAddress, DoctorsInformation, MedicalHistory, FamilyMembersList, MemberDetails, AddFamilyMember, patientFileVC,patientInformation,HealthDataVC,AssesmentSheetVC,myAppoitmentVC1,MyAppointmentVC,myAppointMentVC2,UploadProfilePicVC,selectCityVC,jobDescriptionVC,digitalSignatureVG,AssesmentSheetVC2,WalletAddCardsViewControllera,alertScreenVC,EavaluationFormVC,riskEvaluationVC,patientEvaluationVC,patientSignatureVC,selectAvailabilityVC,ServiceRequestVC,RequestMapVC,ChooseDoctorLocationVC,historyVC,LevelCoinsVC,MyLevelVC,BankInformationVC,walletVC,myEarningsVC,completeVisitVC,AddMoney,EmergencyRequestDetailsVC
    
    var value:String {
        switch self {
        case .none:
            return ""
        case .Home:
            return "navTitle_Home".Localized()
        case .MyMedicalFile:
            return "navTitle_MyMedicalFile".Localized()
        case .MyAppointmnets:
            return "navTitle_MyAppointment".Localized()
        case .MyProfile:
            return "navTitle_MyProfile".Localized()
        case .Services:
            return "navTitle_Services".Localized()
        case .Offers:
            return "navTitle_Offers".Localized()
        case .Settings:
            return "navTitle_Settings".Localized()
        case .MyCareTeam:
            return "navTitle_MyCareTeam".Localized()
        case .DoctorDetails:
            return "navTitle_DoctorDetails".Localized()
        case .Chat:
            return "navTitle_Chat".Localized()
        case .SelectCategory:
            return "navTitle_SelectCategory".Localized()
        case .SelectDate:
            return "navTitle_SelectDate".Localized()
        case .DoctorsList:
            return "navTitle_DoctorsList".Localized()
        case .Payment:
            return "navTitle_Payment".Localized()
        case .PaymentMethods:
            return "navTitle_PaymentMethods".Localized()
        case .Contactus:
            return "navTitle_Contactus".Localized()
        case .Languagesettings:
            return "navTitle_Languagesettings".Localized()
        case .Notificationsettings:
            return "navTitle_Notificationsettings".Localized()
        case .FAQ:
            return "navTitle_FAQ".Localized()
        case .Notifications:
            return "navTitle_Notifications".Localized()
        case .VisitPackage:
            return "navTitle_VisitPackage".Localized()
        case .SelectAddress:
            return "navTitle_SelectAddress".Localized()
        case .AddAddress:
            return "navTitle_EnterAddress".Localized()
        case .DoctorsInformation:
            return "navTitle_DoctorInformation".Localized()
        case .MedicalHistory:
            return "navTitle_MedicalHistory".Localized()
        case .FamilyMembersList:
            return "navTitle_FamilyMembersList".Localized()
        case .MemberDetails:
            return "navTitle_MemberDetails".Localized()
        case .AddFamilyMember:
            return "navTitle_AddFamilyMember".Localized()
        case .patientFileVC:
            return "patientFile_title".Localized()
        case .patientInformation:
            return "PatientInfo_title".Localized()
        case .HealthDataVC:
            return "healthDataVC_title".Localized()
        case .AssesmentSheetVC:
            return "AssetmentSheetvc_title".Localized()
        case .myAppoitmentVC1:
             return "appointmentvc1_title".Localized()
        case .MyAppointmentVC:
             return "appointmentvc1_title".Localized()
        case .myAppointMentVC2:
             return "appointmentvc1_title".Localized()
        case .UploadProfilePicVC:
            return "takePhotoScreen_Title".Localized()
        case .selectCityVC:
            return "SelectCityScreen_title".Localized()
        case .jobDescriptionVC:
            return "jobDesciptionSceen_title".Localized()
        case .digitalSignatureVG:
            return "DgSignVC_titel".Localized()
        case .AssesmentSheetVC2:
            return "AssetmentSheetvc_title2".Localized()
        case .WalletAddCardsViewControllera:
            return "navTitle_bankInfo".Localized()
        case .alertScreenVC:
            return "navTitle_Alert".Localized()
        case .EavaluationFormVC:
            return "navTitle_EavaluationForm".Localized()
        case .riskEvaluationVC:
             return "navTitle_riskEvaluationVC".Localized()
        case .patientEvaluationVC:
            return "navTitle_patientEvaluationVC".Localized()
        case .patientSignatureVC:
            return "navTitle_patientSignatureVC".Localized()
        case .selectAvailabilityVC:
            return "navTitle_SelectAvailability".Localized()
        case .ServiceRequestVC:
            return "navTitle_serviceRequestVC".Localized()
        case .RequestMapVC:
            return "navTitle_RequestMapVC".Localized()
        case .ChooseDoctorLocationVC:
            return "navTitle_ChooseDoctorLocationVC".Localized()
        case .historyVC:
            return "navTitle_HistoryVC".Localized()
        case .LevelCoinsVC:
            return "navTitle_LevelCoinsVC".Localized()
        case .MyLevelVC:
            return "navTitle_MyLevelVC".Localized()
        case .BankInformationVC:
            return "navTitle_bankInformation".Localized()
        case .walletVC:
            return "navTitle_walletVC".Localized()
        case .myEarningsVC:
            return "navTitle_myEaringsVC".Localized()
        case .completeVisitVC:
            return "navTitle_CompleteVisit".Localized()
            case .AddMoney:
            return "navTitle_AddMoney".Localized()
        case .EmergencyRequestDetailsVC:
             return "navTitle_RequestsDetail".Localized()
        }
    }
}
