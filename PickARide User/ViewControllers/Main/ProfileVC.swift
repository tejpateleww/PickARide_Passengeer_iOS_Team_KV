//
//  ProfileVC.swift
//  PickARide User
//
//  Created by baps on 17/12/20.
//  Copyright © 2020 EWW071. All rights reserved.
//

import UIKit

class ProfileVC: BaseViewController {

    
    //MARK: -Properties
   
    //MARK: -IBOutlets
    
    @IBOutlet weak var lblTitle: ProfileLabel!
    @IBOutlet weak var lblFirstName: ProfileLabel!
    @IBOutlet weak var textFieldFirstName: ProfileTextField!
    @IBOutlet weak var lblLastName: ProfileLabel!
    @IBOutlet weak var textFieldLastName: MyOfferTextField!
    @IBOutlet weak var lblEmail: ProfileLabel!
    @IBOutlet weak var textFieldEmail: ProfileTextField!
    @IBOutlet weak var lblPhoneNumber: ProfileLabel!
    @IBOutlet weak var textFieldPhoneNumber: ProfileTextField!
    @IBOutlet weak var lblPassword: ProfileLabel!
    @IBOutlet weak var textFieldPassword: ProfileTextField!
    
    
    @IBOutlet var textFieldCollection: [ProfileTextField]!
    
    //MARK: -View Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocalization()
        makeEditProfile(isEditProfile: false)
       
       
    }
    //MARK: -Other Methods
    func setupLocalization(){
               
        lblTitle.text = "ProfileVC_lblTitle".Localized()
        lblFirstName.text = "ProfileVC_lblFirstName".Localized()
        textFieldFirstName.placeholder = "ProfileVC_textFieldFirstName".Localized()
        lblLastName.text = "ProfileVC_lblLastName".Localized()
        textFieldLastName.placeholder = "ProfileVC_textFieldLastName".Localized()
        lblEmail.text = "ProfileVC_lblEmail".Localized()
        textFieldEmail.placeholder = "ProfileVC_textFieldEmail".Localized()
        lblPhoneNumber.text = "ProfileVC_lblPhoneNumber".Localized()
        textFieldPhoneNumber.placeholder = "ProfileVC_textFieldPhoneNumber".Localized()
        lblPassword.text = "ProfileVC_lblPassword".Localized()
        textFieldPassword.placeholder = "ProfileVC_textFieldPassword".Localized()
    }
    
    func makeEditProfile(isEditProfile : Bool) {
        for i in textFieldCollection {
            i.isUserInteractionEnabled = isEditProfile ? true : false
        }
       // textFieldCollection.forEach({ $0.isUserInteractionEnabled = isEditProfile ? true : false})
        
        setNavigationBarInViewController(controller: self, naviColor: colors.submitButtonColor.value, naviTitle: NavTitles.none.value, leftImage: NavItemsLeft.back.value, rightImages: isEditProfile ? [NavItemsRight.none.value] : [NavItemsRight.userProfile.value], isTranslucent: true)
        
        
        
    }
    
    //MARK: -IBActions
    
    //MARK: -API Calls
}
