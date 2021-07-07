//
//  PaymentSucessFullyVC.swift
//  PickARide User
//
//  Created by Apple on 18/01/21.
//  Copyright © 2021 EWW071. All rights reserved.
//

import UIKit

class PaymentSucessFullyVC: BaseViewController {

    var dismissedClosour : (() -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarInViewController(controller: self, naviColor: colors.submitButtonColor.value, naviTitle: NavTitles.none.value, leftImage: NavItemsLeft.none.value, rightImages: [NavItemsRight.none.value], isTranslucent: true, CommonViewTitles: [], isTwoLabels: false)
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
}
