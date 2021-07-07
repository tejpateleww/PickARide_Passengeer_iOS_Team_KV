//
//  ProfileVC.swift
//  PickARide User
//
//  Created by baps on 17/12/20.
//  Copyright © 2020 EWW071. All rights reserved.
//

import UIKit

class ProfileVC: BaseViewController {
    //MARK: -IBOutlets
    
    @IBOutlet weak var imgProfile: ProfileView!
    @IBOutlet weak var btnProfile: UIButton!
    @IBOutlet weak var lblTitle: ProfileLabel!
    @IBOutlet weak var lblFirstName: ProfileLabel!
    @IBOutlet weak var textFieldFirstName: ProfileTextField!
    @IBOutlet weak var lblLastName: ProfileLabel!
    @IBOutlet weak var textFieldLastName: MyOfferTextField!
    @IBOutlet weak var lblEmail: ProfileLabel!
    @IBOutlet weak var textFieldEmail: ProfileTextField!
    @IBOutlet weak var lblPhoneNumber: ProfileLabel!
    @IBOutlet weak var textFieldPhoneNumber: ProfileTextField!
    @IBOutlet weak var lblPassword: ProfileLabel!
    @IBOutlet weak var textFieldPassword: ProfileTextField!
    @IBOutlet weak var btnCamera: UIButton!
    @IBOutlet weak var btnSave: submitButton!
    @IBOutlet var textFieldCollection: [ProfileTextField]!
    @IBOutlet weak var btnPasword: UIButton!
    
    var currentEditStatus = false
    var imagePicker : ImagePicker?
    var selectedImage : UIImage?
    
    //MARK: -View Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
        self.setupLocalization()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarInViewController(controller: self, naviColor: colors.submitButtonColor.value, naviTitle: NavTitles.none.value, leftImage: NavItemsLeft.back.value, rightImages: [NavItemsRight.EditProfile.value], isTranslucent: true, CommonViewTitles: [], isTwoLabels: false)
    }
    
    @IBAction func btnProfile(_ sender: Any) {
        self.view.endEditing(true)
        self.imagePicker?.present(from: self.imgProfile, image: self.imgProfile.image ?? UIImage())
    }
    
    @IBAction func btnEditProfileClicked(_ sender: Any) {
        appDel.navigateToMain()
    }
    
    @IBAction func btnPasswordClicked(_ sender: Any) {
        let controller = ChangePasswordVC.instantiate(fromAppStoryboard: .Login)
        controller.submitButtonText = "ChangePassword_btnChangePassword".Localized()
        controller.isChangePassword = true
        controller.btnSubmitClosure = {
            userDefaults.setValue(false, forKey: UserDefaultsKey.isUserLogin.rawValue)
            self.dismiss(animated: true, completion: {
                self.navigationController?.popViewController(animated: true)
            })
        }
        controller.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        let navigationController = UINavigationController(rootViewController: controller)
        navigationController.modalPresentationStyle = .overCurrentContext
        navigationController.modalTransitionStyle = .crossDissolve
        navigationController.navigationBar.isHidden = true
        self.present(navigationController, animated: true, completion: nil)
    }
    
    @IBAction func btnSave(_ sender: Any) {
    }
}

//MARK: Other Methods
extension ProfileVC{
    func setUpUI(){
        navBtnProfile.isSelected = true
        navBtnProfile.addTarget(self, action: #selector(makeEditableTrue), for: .touchUpInside)
        self.makeEditableTrue(navBtnProfile)
        self.imgProfile.image = UserPlaceHolder
        self.imagePicker = ImagePicker(presentationController: self, delegate: self, allowsEditing: false)
    }
    
    @objc func makeEditableTrue(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        self.currentEditStatus = sender.isSelected
        for i in textFieldCollection {
            i.isUserInteractionEnabled = sender.isSelected
        }
        self.btnPasword.isUserInteractionEnabled = sender.isSelected
        self.btnProfile.isUserInteractionEnabled = sender.isSelected
        self.btnCamera.isHidden = !sender.isSelected
        self.btnSave.isHidden = !sender.isSelected
        if sender.isSelected{
            self.navigationItem.rightBarButtonItem = nil
        }
    }
    func setupLocalization(){
        lblTitle.text = "ProfileVC_lblTitle".Localized()
        lblFirstName.text = "ProfileVC_lblFirstName".Localized()
        textFieldFirstName.placeholder = "ProfileVC_textFieldFirstName".Localized()
        lblLastName.text = "ProfileVC_lblLastName".Localized()
        textFieldLastName.placeholder = "ProfileVC_textFieldLastName".Localized()
        lblEmail.text = "ProfileVC_lblEmail".Localized()
        textFieldEmail.placeholder = "ProfileVC_textFieldEmail".Localized()
        lblPhoneNumber.text = "ProfileVC_lblPhoneNumber".Localized()
        textFieldPhoneNumber.placeholder = "ProfileVC_textFieldPhoneNumber".Localized()
        lblPassword.text = "ProfileVC_lblPassword".Localized()
        textFieldPassword.placeholder = "ProfileVC_textFieldPassword".Localized()
    }
}

extension ProfileVC:ImagePickerDelegate {
    
    func didSelect(image: UIImage?, button SelectedTag:Int) {
        if(image == nil && SelectedTag == 101){
            self.selectedImage = UIImage()
            self.imgProfile.image = UserPlaceHolder
        }else if let img = image{
            self.imgProfile.image = img
            self.selectedImage = self.imgProfile.image
        }else{
            return
        }
    }
}
