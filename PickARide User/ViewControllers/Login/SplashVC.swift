//
//  SplashVC.swift
//  PickARide User
//
//  Created by Apple on 14/12/20.
//  Copyright © 2020 EWW071. All rights reserved.
//

import UIKit

class SplashVC: UIViewController {

    //MARK: -Properties
    
    //MARK: -IBOutlets
    
    //MARK: -View Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
            let controller = AppStoryboard.Login.instance.instantiateViewController(withIdentifier: LoginViewController.storyboardID)
            self.navigationController?.pushViewController(controller, animated: true)
        })
    }
    //MARK: -IBActions
    
    
    //MARK: -API Calls
    
    

}
