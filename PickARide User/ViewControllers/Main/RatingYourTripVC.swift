//
//  RatingYourTripVC.swift
//  PickARide User
//
//  Created by baps on 30/12/20.
//  Copyright © 2020 EWW071. All rights reserved.
//

import UIKit

class RatingYourTripVC: BaseViewController {

    
    //MARK: -Properties
    
    //MARK: -IBOutlets
    @IBOutlet weak var DotedLine: UIView!
    //MARK: -View Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLocalization()
        setValue()
        self.DotedLine.createDottedLine(width: 1.0, color: UIColor.cyan.cgColor)
        
        setNavigationBarInViewController(controller: self, naviColor: colors.submitButtonColor.value, naviTitle: NavTitles.rating.value, leftImage: NavItemsLeft.cancelWhite.value, rightImages: [NavItemsRight.none.value], isTranslucent: true)
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    //MARK: -other methods
    func setLocalization() {
        
    }
    func setValue() {
    }
    //MARK: -IBActions
    
    
    //MARK: -API Calls
    
    
    
    
    
  
}