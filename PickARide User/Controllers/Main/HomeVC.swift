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
    
    var SelectedLocationString : (String,String) = ("Pick Up","Destination")
    
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
            self.setNavigationBarInViewController(controller: self, naviColor: colors.submitButtonColor.value, naviTitle: NavTitles.CommonView.value, leftImage: NavItemsLeft.none.value, rightImages: [NavItemsRight.none.value], isTranslucent: true, CommonViewTitles: [SelectedLocationString.0,SelectedLocationString.1], isTwoLabels: false)
        }
    }
}

//MARK:- Methods
extension HomeVC{
    func setLocalization() {
        txtFieldWhereAreYouGoing.placeholder = "home_Whereareyougoing_place".Localized()
    }
    
    func setProfilePicture(){
        let authUser = Singleton.sharedInstance.UserProfilData
        
        self.navBtnProfile.loadSDImage(imgUrl: authUser?.profileImage ?? "")
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
        
        controller.openSelectTexiVC = { (pickup,dropoff) in
            self.SelectedLocationString = (pickup,dropoff)
            self.selectTexiVCContainerVW.isHidden = false
            self.bottomVWWhereAreYouGoing.isHidden = true
            
        }
        
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
//get_estimate_fare
