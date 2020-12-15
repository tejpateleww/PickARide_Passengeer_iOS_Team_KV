//
//  RegisterViewController.swift
//  ApiStructureModule
//
//  Created by EWW071 on 14/03/20.
//  Copyright © 2020 EWW071. All rights reserved.
//

import UIKit

class RegisterViewController: BaseViewController, UITextViewDelegate {
  
    //MARK: -Properties
    
    //MARK: -IBOutlets
    @IBOutlet weak var lblSignUP: registerScreenLabel!
    @IBOutlet weak var textFieldFirstName: UITextField!
    @IBOutlet weak var textFieldLastName: UITextField!
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var lblCountryCode: UILabel!
    @IBOutlet weak var textFieldPhoneNumber: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var textView: UITextView!
   
    @IBOutlet weak var btnSignUP: submitButton!
    //MARK: -View Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
       setLocalization()
        setNavigationBarInViewController(controller: self, naviColor: colors.appColor.value, naviTitle: NavTitles.none.value, leftImage: NavItemsLeft.back.value, rightImages: [NavItemsRight.login.value], isTranslucent: true)
       
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        lblSignUP.text = "SignUpPage_lblSignUP".Localized()
        textFieldFirstName.placeholder = "SignUpPage_textFieldFirstName_place".Localized()
        textFieldLastName.placeholder = "SignUpPage_textFieldLastName_place".Localized()
        textFieldEmail.placeholder = "SignUpPage_textFieldEmail_place".Localized()
        lblCountryCode.text = "SignUpPage_lblCountryCode".Localized()
        textFieldPhoneNumber.placeholder = "SignUpPage_textFieldPhoneNumbaer_place".Localized()
        textFieldPassword.placeholder = "SignUpPage_textFieldPassword_place".Localized()
        textView.delegate = self
        btnSignUP.setTitle("SignUpPage_btnSIgnUP".Localized(), for: .normal)
    }
    
    //MARK: -other methods
    func setLocalization() {
        
    }
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {

        if ((URL.scheme?.contains("termsAndConditions")) != nil) {
            print("Print termsAndConditions")
        } else {
            print("Print privacypolicy")
        }

            return false
        }
    //MARK: -IBActions
    @IBAction func signUP(_ sender: Any) {
        let controller = AppStoryboard.Login.instance.instantiateViewController(withIdentifier: VerifyViewController.storyboardID)
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    //MARK: -API Calls
    
    
    
    
    
   
    
}
