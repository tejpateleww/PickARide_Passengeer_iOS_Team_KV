//
//  ChangePasswordPopUpViewController.swift
//  PickARide User
//
//  Created by Apple on 15/12/20.
//  Copyright © 2020 EWW071. All rights reserved.
//

import UIKit

class ChangePasswordPopUpViewController: UIViewController {

    //MARK: -Properties
    var submitButtonText = ""
    var isChangePassword : Bool = false
    var btnSubmitClosure : (() -> ())?
    //MARK: -IBOutlets
    
    @IBOutlet weak var lblChangePassword: UILabel!
    @IBOutlet weak var textFieldOldPassword: UITextField!
    @IBOutlet weak var textFieldNewPassword: UITextField!
    @IBOutlet weak var textFieldConfirmPassword: UITextField!
    @IBOutlet weak var btnSubmit: submitButton!
    //MARK: -View Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setButtonTitleAndHideView()
        setLocalization()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)) , name: UIResponder.keyboardWillHideNotification, object: nil)
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    //MARK: -other methods
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
        } else {
            textFieldOldPassword.superview?.isHidden = true
        }
    }
    func setLocalization() {
        lblChangePassword.text = "ChangePassword_lblChangePassword".Localized()
        textFieldOldPassword.placeholder = "ChangePassword_oldPassword_Place".Localized()
        textFieldNewPassword.placeholder = "ChangePassword_newPassword_Place".Localized()
        textFieldConfirmPassword.placeholder = "ChangePassword_confirmPassword_Place".Localized()
        btnSubmit.setTitle(submitButtonText, for: .normal)
    }
    //MARK: -IBActions
    @IBAction func btnsubmitAction(_ sender: Any) {
        if let click = self.btnSubmitClosure {
            click()
        }
    }
    
    //MARK: -API Calls
    
    
    
    

}
