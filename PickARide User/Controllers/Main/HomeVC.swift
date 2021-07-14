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

    @IBOutlet weak var mainVW: UIView!
    @IBOutlet weak var mapVw: GMSMapView!
    @IBOutlet weak var txtFieldWhereAreYouGoing: leftSideImageTextField!
    @IBOutlet weak var bottomVWWhereAreYouGoing: UIView!
    @IBOutlet weak var selectTexiVCContainerVW: UIView!
    @IBOutlet weak var currentRideDetailContainerVW: UIView!
    @IBOutlet weak var currentRideDriverInfoContainerVW: UIView!
    
    //MARK: -View Life Cycle Method
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setLocalization()
        self.addObserver()
        self.txtFieldWhereAreYouGoing.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        if self.selectTexiVCContainerVW.isHidden{
            self.setNavigationBarInViewController(controller: self, naviColor: colors.appColor.value, naviTitle: NavTitles.none.value, leftImage: NavItemsLeft.menu.value, rightImages: [NavItemsRight.userProfile.value], isTranslucent: true, CommonViewTitles: [], isTwoLabels: false)
            self.setProfilePicture()
        }else{
            self.setNavigationBarInViewController(controller: self, naviColor: colors.submitButtonColor.value, naviTitle: NavTitles.CommonView.value, leftImage: NavItemsLeft.none.value, rightImages: [NavItemsRight.none.value], isTranslucent: true, CommonViewTitles: ["Destination 1","Destination 2"], isTwoLabels: false)
        }
    }
}

//MARK:- Methods
extension HomeVC{
    func setLocalization() {
        txtFieldWhereAreYouGoing.placeholder = "home_Whereareyougoing_place".Localized()
    }
    
    func setProfilePicture(){
        self.navBtnProfile.setImage(UserPlaceHolder, for: .normal)
        self.navBtnProfile.addTarget(self, action: #selector(EditUserProfile(_:)), for: .touchUpInside)
    }
    
    func addObserver(){
        NotificationCenter.default.addObserver(self, selector: #selector(self.openCurrentRideDriverInfoVC), name: .OpenCurrentRideDriverInfoVC, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.openCurrentRideDetailsVC), name: .OpenCurrentRideDetailsVC, object: nil)
    }
    
    @objc func openCurrentRideDriverInfoVC(){
        self.bottomVWWhereAreYouGoing.isHidden = true
        self.selectTexiVCContainerVW.isHidden = true
        self.currentRideDriverInfoContainerVW.isHidden = false
    }
    
    @objc func openCurrentRideDetailsVC(){
        self.bottomVWWhereAreYouGoing.isHidden = true
        self.selectTexiVCContainerVW.isHidden = true
        self.currentRideDriverInfoContainerVW.isHidden = true
        self.currentRideDetailContainerVW.isHidden = false
    }
}


//MARK:- UITextFiled Delegate
extension HomeVC: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
        let controller = ChooseDestinationVC.instantiate(fromAppStoryboard: .Main)
        
        controller.openSelectTexiVC = {
            self.selectTexiVCContainerVW.isHidden = false
            self.bottomVWWhereAreYouGoing.isHidden = true
        }
        
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
