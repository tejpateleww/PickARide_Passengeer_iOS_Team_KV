//
//  HomeViewController.swift
//  PickARide User
//
//  Created by Apple on 17/12/20.
//  Copyright © 2020 EWW071. All rights reserved.
//

import UIKit
import GoogleMaps

class HomeViewController: BaseViewController,UITextFieldDelegate {

    //MARK: - Properties
   
    //MARK: - IBOutlets
    @IBOutlet weak var mapVw: GMSMapView!
    @IBOutlet weak var TextFieldWhereAreYouGoing: leftSideImageTextField!
    
    //MARK: -View Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setLocalization()
        TextFieldWhereAreYouGoing.delegate = self
        setNavigationBarInViewController(controller: self, naviColor: colors.appColor.value, naviTitle: NavTitles.none.value, leftImage: NavItemsLeft.menu.value, rightImages: [NavItemsRight.userProfile.value], isTranslucent: true, CommonViewTitles: [], isTwoLabels: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    //MARK: - Other Methods
    func setLocalization() {
        TextFieldWhereAreYouGoing.placeholder = "home_Whereareyougoing_place".Localized()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
        let controller = AppStoryboard.Main.instance.instantiateViewController(withIdentifier: chooseDestinationViewController.storyboardID)
        self.navigationController?.pushViewController(controller, animated: true)
//        self.navigationController?.popToRootViewController(animated: true)
    }
    
    //MARK: -IBActions
    
    
    //MARK: -API Calls
    
    
    
    
}
