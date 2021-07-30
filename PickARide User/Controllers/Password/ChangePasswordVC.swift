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
    
    @IBOutlet weak var lblOldPassword: ProfileLabel!
    @IBOutlet weak var txtOldPassword: ChangePasswordTextField!
    
    @IBOutlet weak var lblNewPassword: ProfileLabel!
    @IBOutlet weak var txtNewPassword: ChangePasswordTextField!
    
    @IBOutlet weak var lblConfirmPassword: ProfileLabel!
    @IBOutlet weak var txtConfirmPassword: ChangePasswordTextField!
    @IBOutlet weak var btnSubmit: submitButton!
    @IBOutlet weak var btnClose: UIButton!
    
    var submitButtonText = ""
    var isChangePassword : Bool = false
    var btnSubmitClosure : (() -> ())?
    
    var changePasswordUserModel = PasswordUserModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setButtonTitleAndHideView()
        self.setLocalization()
        self.setUpTextField()
    } 
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.view.endEditing(true)
    }
    
    //MARK: -IBActions
    @IBAction func btnClose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnsubmitAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
//        if self.validation(){
//            self.callChangePasswordApi()
//            if let click = self.btnSubmitClosure {
//                click()
//            }
//        }
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
        lblOldPassword.superview?.isHidden = !isChangePassword
        lblChangePassword.text = isChangePassword ? "ChangePassword_lblChangePassword".Localized() : "ChangePassword_lblSetPassword".Localized()
    }
    
    func setLocalization() {
        lblOldPassword.text = "ChangePassword_oldPassword".Localized()
        lblNewPassword.text = "ChangePassword_newPassword".Localized()
        lblConfirmPassword.text = "ChangePassword_confirmPassword".Localized()
        txtOldPassword.placeholder = "ChangePassword_oldPassword_Place".Localized()
        txtNewPassword.placeholder = "ChangePassword_newPassword_Place".Localized()
        txtConfirmPassword.placeholder = "ChangePassword_confirmPassword_Place".Localized()
        btnSubmit.setTitle(submitButtonText, for: .normal)
    }
    
    func setUpTextField(){
        self.txtOldPassword.tag = 0
        self.txtOldPassword.setPasswordVisibility(vc: self, action: #selector(self.showHidePassword(_:)))
        
        self.txtNewPassword.tag = 1
        self.txtNewPassword.setPasswordVisibility(vc: self, action: #selector(self.showHidePassword(_:)))
        
        self.txtConfirmPassword.tag = 2
        self.txtConfirmPassword.setPasswordVisibility(vc: self, action: #selector(self.showHidePassword(_:)))
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
            self.txtOldPassword.isSecureTextEntry = sender.isSelected
        }else if sender.tag == 1{
            self.txtNewPassword.isSecureTextEntry = sender.isSelected
        }else if sender.tag == 2{
            self.txtConfirmPassword.isSecureTextEntry = sender.isSelected
        }
    }
}


//MARK:- Validation & Api
extension ChangePasswordVC{
    func validation()->Bool{
        var strTitle : String?
        let oldPassword = self.txtOldPassword.validatedText(validationType: .password(field: self.txtOldPassword.placeholder?.lowercased() ?? ""))
        let newPassword = txtNewPassword.validatedText(validationType: .password(field: self.txtNewPassword.placeholder?.lowercased() ?? ""))
        let confirmPassword = txtConfirmPassword.validatedText(validationType: .requiredField(field: self.txtConfirmPassword.placeholder?.lowercased() ?? ""))
         
        if isChangePassword && !oldPassword.0{
            strTitle = oldPassword.1
        }else if !newPassword.0{
            strTitle = newPassword.1
        }else if !confirmPassword.0{
            strTitle = confirmPassword.1
        }else if txtNewPassword.text != txtConfirmPassword.text{
            strTitle = "New password & confirm password should be same."
        }

        if let str = strTitle{
            Toast.show(title: UrlConstant.Required, message: str, state: .failure)
            return false
        }
        
        return true
    }
    
    func callChangePasswordApi(){
        self.changePasswordUserModel.changePasswordVC = self
        
        let reqModel = ChangePasswordReqModel()
        reqModel.oldPassword = self.txtOldPassword.text ?? ""
        reqModel.newPassword = self.txtNewPassword.text ?? ""
        
        self.changePasswordUserModel.webserviceChangePassword(reqModel: reqModel)
    }
}
