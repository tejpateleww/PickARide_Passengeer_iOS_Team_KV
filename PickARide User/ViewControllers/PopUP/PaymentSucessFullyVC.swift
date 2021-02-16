//
//  PaymentSucessFullyVC.swift
//  PickARide User
//
//  Created by Apple on 18/01/21.
//  Copyright © 2021 EWW071. All rights reserved.
//

import UIKit

class PaymentSucessFullyVC: BaseViewController {

    //MARK: -Properties
    var dismissedClosour : (() -> ())?
    //MARK: -IBOutlets
    
    //MARK: -View Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLocalization()
        setValue()
        setNavigationBarInViewController(controller: self, naviColor: colors.submitButtonColor.value, naviTitle: NavTitles.none.value, leftImage: NavItemsLeft.none.value, rightImages: [NavItemsRight.none.value], isTranslucent: true, CommonViewTitles: [], isTwoLabels: false)
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
            if let click = self.dismissedClosour {
                click()
            }
            self.dismiss(animated: true, completion: nil)
        })
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.dismiss(animated: true, completion: nil)
    }
   
    //MARK: -other methods
    func setLocalization() {
        
    }
    func setValue() {
    }
    //MARK: -IBActions
    
    
    //MARK: -API Calls
    
    
    
    

}
