//
//  ProgressPopupVC.swift
//  PickARide User
//
//  Created by Admin on 28/09/21.
//  Copyright © 2021 EWW071. All rights reserved.
//

import UIKit

class ProgressPopupVC: UIViewController {
    
    
    @IBOutlet weak var viewProgess: NVActivityIndicatorView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewProgess.color = themeColor
        viewProgess.type = .ballPulse
        viewProgess.startAnimating()

        // Do any additional setup after loading the view.
    }
    

  
}
