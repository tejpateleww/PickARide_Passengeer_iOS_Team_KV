//
//  LoginViewController.swift
//  ApiStructureModule
//
//  Created by EWW071 on 14/03/20.
//  Copyright © 2020 EWW071. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    //MARK: -Properties
    
    //MARK: -IBOutlets
    
  
    @IBOutlet weak var lblSignIN: loginScreenLabel!
    @IBOutlet weak var lblWelcomeBack: loginScreenLabel!
    
    @IBOutlet weak var textFieldPassword: emailPasswordTextField!
    @IBOutlet weak var textFieldEmailID: emailPasswordTextField!
    
    @IBOutlet weak var btnForgotPassword: loginScreenButton!
    
    @IBOutlet weak var btnSignIN: submitButton!
    
    @IBOutlet weak var lblOR: loginScreenLabel!
    
    @IBOutlet weak var lblDontHaveanAccount: loginScreenLabel!
    
    @IBOutlet weak var btnSIgnUP: loginScreenButton!
    //MARK: -View Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocalization()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    //MARK: -Other Methods
    
    func setupLocalization() {
        lblSignIN.text = "lblSignIN".Localized()
        lblWelcomeBack.text = "lblWelcomeBack".Localized()
        
        textFieldEmailID.placeholder = "textFieldEmailID".Localized()
        textFieldPassword.placeholder = "textFieldPassword".Localized()
        
        btnForgotPassword.setTitle("btnForgotPassword".Localized(), for: .normal)
        
        btnSignIN.setTitle("btnSignIN".Localized(), for: .normal)
        
        lblOR.text = "lblOR".Localized()
        
        lblDontHaveanAccount.text = "lblDontHaveanAccount".Localized()
        
        btnSIgnUP.setTitle("btnSIgnUP".Localized(), for: .normal)
    }
    
    //MARK: -IBActions
    
    @IBAction func signUP(_ sender: Any) {
        let controller = AppStoryboard.Login.instance.instantiateViewController(withIdentifier: RegisterViewController.storyboardID)
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    
    //MARK: -API Calls
    
    
  
}
