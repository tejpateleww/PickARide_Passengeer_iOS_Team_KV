//
//  ChangePasswordPopUpViewController.swift
//  PickARide User
//
//  Created by Apple on 15/12/20.
//  Copyright © 2020 EWW071. All rights reserved.
//

import UIKit

class ChangePasswordVC: UIViewController {

    @IBOutlet weak var vwMain: viewWithClearBg!
    @IBOutlet weak var lblChangePassword: UILabel!
    @IBOutlet weak var textFieldOldPassword: ChangePasswordTextField!
    @IBOutlet weak var textFieldNewPassword: ChangePasswordTextField!
    @IBOutlet weak var textFieldConfirmPassword: ChangePasswordTextField!
    @IBOutlet weak var btnSubmit: submitButton!
    
    @IBOutlet weak var btnClose: UIButton!
    
    var submitButtonText = ""
    var isChangePassword : Bool = false
    var btnSubmitClosure : (() -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setButtonTitleAndHideView()
        self.setLocalization()
        self.setUpTextField()
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)) , name: UIResponder.keyboardWillHideNotification, object: nil)
    } 
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    //MARK: -IBActions
    @IBAction func btnClose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnsubmitAction(_ sender: Any) {
        if let click = self.btnSubmitClosure {
            click()
        }
    }
}

//MARK: Other methods
extension ChangePasswordVC{
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            self.view.frame.origin.y -= keyboardSize.height
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y = 0
    }
    
    func setButtonTitleAndHideView() {
        if isChangePassword {
            textFieldOldPassword.superview?.isHidden = false
            lblChangePassword.text = "ChangePassword_lblChangePassword".Localized()
        } else {
            textFieldOldPassword.superview?.isHidden = true
            lblChangePassword.text = "ChangePassword_lblSetPassword".Localized()
        }
    }
    
    func setLocalization() {
        textFieldOldPassword.placeholder = "ChangePassword_oldPassword_Place".Localized()
        textFieldNewPassword.placeholder = "ChangePassword_newPassword_Place".Localized()
        textFieldConfirmPassword.placeholder = "ChangePassword_confirmPassword_Place".Localized()
        btnSubmit.setTitle(submitButtonText, for: .normal)
    }
    
    func setUpTextField(){
        self.textFieldOldPassword.tag = 0
        self.setupTextfields(textfield: self.textFieldOldPassword)
        
        self.textFieldNewPassword.tag = 1
        self.setupTextfields(textfield: self.textFieldNewPassword)
        
        self.textFieldConfirmPassword.tag = 2
        self.setupTextfields(textfield: self.textFieldConfirmPassword)
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
        
        if sender.tag == 0{
            self.textFieldOldPassword.isSecureTextEntry = sender.isSelected
        }else if sender.tag == 1{
            self.textFieldNewPassword.isSecureTextEntry = sender.isSelected
        }else if sender.tag == 2{
            self.textFieldConfirmPassword.isSecureTextEntry = sender.isSelected
        }
    }
}
