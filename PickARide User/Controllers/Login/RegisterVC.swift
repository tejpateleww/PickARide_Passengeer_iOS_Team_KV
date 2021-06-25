//
//  RegisterViewController.swift
//  ApiStructureModule
//
//  Created by EWW071 on 14/03/20.
//  Copyright © 2020 EWW071. All rights reserved.
//

import UIKit

class RegisterVC: BaseViewController {
    
    //MARK: -Properties
    
    //MARK: -IBOutlets
    @IBOutlet weak var lblSignUP: registerScreenLabel!
    @IBOutlet weak var textFieldFirstName: UITextField!
    @IBOutlet weak var textFieldLastName: UITextField!
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var lblCountryCode: registerScreenLabel!
    @IBOutlet weak var textFieldPhoneNumber: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var btnSignUP: submitButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLocalization()
        setNavigationBarInViewController(controller: self, naviColor: colors.appColor.value, naviTitle: NavTitles.none.value, leftImage: NavItemsLeft.back.value, rightImages: [NavItemsRight.login.value], isTranslucent: true, CommonViewTitles: [], isTwoLabels: false)
        self.setupTextfields(textfield: self.textFieldPassword)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    //MARK: -IBActions
    @IBAction func signUP(_ sender: Any) {
        let controller = VerifyVC.instantiate(fromAppStoryboard: .Login)
        controller.isFrmRegister = true
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

//MARK: Other methods
extension RegisterVC{
    func setLocalization() {
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
    
    func setupTextfields(textfield : UITextField) {
        let button = UIButton(type: .custom)
        button.isSelected = true
        button.setImage(ShowPassword, for: .normal)
        button.setImage(HidePassword, for: .selected)
        button.imageEdgeInsets = UIEdgeInsets(top: 5, left: -16, bottom: -5, right: 0)
        button.frame = CGRect(x: CGFloat(textfield.frame.size.width - 25), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
        button.tag = textfield.tag
        textfield.isSelected = true
        button.addTarget(self, action: #selector(showHidePassword(_:)), for: .touchUpInside)
        textfield.rightView = button
        textfield.rightViewMode = .always
    }
    
    @objc func showHidePassword(_ sender : UIButton) {
        sender.isSelected = !sender.isSelected
        self.textFieldPassword.isSecureTextEntry = sender.isSelected
    }
}

extension RegisterVC: UITextViewDelegate{
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        
        let controller = AppStoryboard.Main.instance.instantiateViewController(withIdentifier: CommonWebViewVC.storyboardID) as! CommonWebViewVC
        if (URL.absoluteString ==  "SignUpPage_textViewText2".Localized().replacingOccurrences(of: " ", with: "")) {
            print("Print termsAndConditions")
            controller.strNavTitle = "SignUpPage_textViewText2".Localized().capitalized
        } else if (URL.absoluteString ==  "SignUpPage_textViewText4".Localized().replacingOccurrences(of: " ", with: "")) {
            print("Print privacypolicy")
            controller.strNavTitle = "SignUpPage_textViewText4".Localized().capitalized
        }
        
        self.navigationController?.pushViewController(controller, animated: true)
        return false
    }
}
