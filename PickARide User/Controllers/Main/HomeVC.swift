//
//  HomeViewController.swift
//  PickARide User
//
//  Created by Apple on 17/12/20.
//  Copyright © 2020 EWW071. All rights reserved.
//

import UIKit
import GoogleMaps

class HomeVC: BaseViewController {

    //MARK: - Properties
   
    //MARK: - IBOutlets
    @IBOutlet weak var mainVW: UIView!
    @IBOutlet weak var mapVw: GMSMapView!
    @IBOutlet weak var txtFieldWhereAreYouGoing: leftSideImageTextField!
    
    //MARK: -View Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setLocalization()
        txtFieldWhereAreYouGoing.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.setNavigationBarInViewController(controller: self, naviColor: colors.appColor.value, naviTitle: NavTitles.none.value, leftImage: NavItemsLeft.menu.value, rightImages: [NavItemsRight.userProfile.value], isTranslucent: true, CommonViewTitles: [], isTwoLabels: false)
        self.setProfilePicture()
    }
}

//MARK:- Methods
extension HomeVC{
    func setLocalization() {
        txtFieldWhereAreYouGoing.placeholder = "home_Whereareyougoing_place".Localized()
    }
    
    func setProfilePicture(){
        //Set User Profile
    }
}


//MARK:- UITextFiled Delegate
extension HomeVC: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
        let controller = ChooseDestinationVC.instantiate(fromAppStoryboard: .Main)
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
