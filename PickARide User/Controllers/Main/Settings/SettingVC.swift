//
//  SettingViewController.swift
//  PickARide User
//
//  Created by Apple on 21/12/20.
//  Copyright © 2020 EWW071. All rights reserved.
//

import UIKit

class SettingVC: BaseViewController{
    
    @IBOutlet weak var lblSettingsTitle: TitleLabel!
    @IBOutlet weak var tblSettings: UITableView!
    @IBOutlet weak var lblLanguageTitle: themeLabel!
    @IBOutlet weak var txtLanguage: UITextField!
    @IBOutlet weak var lblLanguage: themeLabel!
    @IBOutlet weak var tblHeightConstraint: NSLayoutConstraint!
    
    var pickerView = UIPickerView()
    var selectedIndexOfPicker = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setLocalization()
        self.setUpValue()
        addValuesInSettingList()
        self.tblSettings.reloadData()
        self.tblSettings.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.setNavigationBarInViewController(controller: self, naviColor: colors.submitButtonColor.value, naviTitle: NavTitles.setting.value, leftImage: NavItemsLeft.back.value, rightImages: [NavItemsRight.none.value], isTranslucent: true, CommonViewTitles: [], isTwoLabels: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.view.endEditing(true)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?){
        if(keyPath == "contentSize"){
            self.tblHeightConstraint.constant = self.tblSettings.contentSize.height < 40 ? 40: self.tblSettings.contentSize.height
        }
    }
}

//MARK:- Set Up UI
extension SettingVC{
    func setUpValue(){
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        self.pickerView.showsSelectionIndicator = true
        
        self.txtLanguage.tintColor = .white
        self.txtLanguage.delegate = self
        self.txtLanguage.inputView = pickerView
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.barTintColor = .black
        toolBar.barTintColor = .white
        toolBar.tintColor = themeColor
        toolBar.sizeToFit()
        let done = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneAction))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelAction))
        toolBar.setItems([cancel,space,done], animated: false)
        
        self.txtLanguage.inputAccessoryView = toolBar
        self.lblLanguage.text = SettingData.LanguageList[self.selectedIndexOfPicker]
    }
    
    func setLocalization() {
        lblSettingsTitle.text = "SettingsVC_lblTitle".Localized()
        lblLanguageTitle.text = "SettingsVC_Language".Localized()
    }
    
    @objc func settingsButton(_ sender : UIButton) {
        if sender.titleLabel?.text == SettingsTitle.Add{
            let vc  = AddNewDestinationVC.instantiate(fromAppStoryboard: .Main)
            self.navigationController?.pushViewController(vc, animated: true)
        } else if sender.titleLabel?.text == "SettingsVC_btnMoreSavedPlaces".Localized() {
            let controller = SavedPlaceVC.instantiate(fromAppStoryboard: .Main)
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    @objc func cancelAction(_ sender: UIBarButtonItem) {
        self.txtLanguage.endEditing(true)
    }
    
    @objc func doneAction(_ sender: UIBarButtonItem) {
        self.lblLanguage.text = SettingData.LanguageList[self.selectedIndexOfPicker]
        self.txtLanguage.endEditing(true)
    }
}

//MARK:- TextField Delegate
extension SettingVC: UITextFieldDelegate{
    
}

//MARK:- Tableview Delegate
extension SettingVC: UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return SettingData.SettingList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
            case 0 : return 1
        case 1,2,3 : return SettingData.SettingList[section].subData?.count ?? 0
            default : return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        switch section {
        case 0:
            let headerView = UIView.init(frame: CGRect(x: 0, y: 0, width: tblSettings.frame.size.width, height: 0))
            return headerView
            
        case 1,2:
           return setHeaderView(sectionNumber: section)
            
        default:
            let headerView = UIView.init(frame: CGRect(x: 0, y: 0, width: tblSettings.frame.size.width, height: 0))
            return headerView
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
            case 0: return 0
            case 1,2: return 49
            default: return 0
        }
    }
    
    func setHeaderView(sectionNumber : Int) -> UIView {
        let headerView = UIView.init(frame: CGRect(x: 0, y: 0, width: tblSettings.frame.size.width, height: 49))
        
        let settingObj = SettingData.SettingList[sectionNumber]
        
        if settingObj.titleName == ""
        {
            let button = UIButton()
            button.frame = CGRect(x: 21, y: 0, width: tblSettings.frame.size.width, height: headerView.frame.size.height)
            button.setTitle(settingObj.titleButton, for: .normal)
            button.addTarget(self, action: #selector(settingsButton(_:)), for: .touchUpInside)
            button.titleLabel?.textColor = colors.submitButtonColor.value
            button.contentHorizontalAlignment = .left
            button.titleLabel?.font =  CustomFont.medium.returnFont(17)
            button.setTitleColor(colors.submitButtonColor.value, for: .normal)
            headerView.addSubview(button)
            
        } else if settingObj.titleButton == "" {
            let label = UILabel()
            label.frame = CGRect(x: 21, y: 0, width: tblSettings.frame.size.width, height: headerView.frame.size.height)
            label.text = settingObj.titleName
            label.font = CustomFont.medium.returnFont(17)
            label.textColor = colors.loginPlaceHolderColor.value
            headerView.addSubview(label)
            
        } else {
            let label = UILabel()
            label.frame = CGRect(x: 21, y: 0, width: tblSettings.frame.size.width - 99, height: headerView.frame.size.height)
            label.text = settingObj.titleName
            label.font = CustomFont.medium.returnFont(17)
            label.textColor = colors.loginPlaceHolderColor.value
            headerView.addSubview(label)
            
            let button = UIButton()
            button.frame = CGRect(x: tblSettings.frame.size.width - 18 - 50, y: 0, width: 50, height: headerView.frame.size.height)
            button.setTitle(settingObj.titleButton, for: .normal)
            button.titleLabel?.textColor = colors.submitButtonColor.value
            button.addTarget(self, action: #selector(settingsButton(_:)), for: .touchUpInside)
            button.contentHorizontalAlignment = .right
            button.titleLabel?.font =  CustomFont.medium.returnFont(17)
            button.setTitleColor(colors.submitButtonColor.value, for: .normal)
            headerView.addSubview(button)
        }
        return headerView
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tblSettings.dequeueReusableCell(withIdentifier: SettingCell1.reuseIdentifier, for: indexPath) as? SettingCell1 ?? SettingCell1()
            cell.lblUserName.text = "Abdullah Amir"
            cell.lblUserPhoneNumber.text = "+49 9564 656 6555"
            cell.lblUserEmail.text = "abdullahamir@gmail.com"
            return cell
        case 1,2:
            let cell = tblSettings.dequeueReusableCell(withIdentifier: SettingCell2.reuseIdentifier, for: indexPath) as? SettingCell2 ?? SettingCell2()
            cell.backgroundColor = ThemeColorEnum.SettingsCell.rawValue
            
            let settingObj = SettingData.SettingList[indexPath.section]
            let subSettingDataObj = settingObj.subData?[indexPath.row]
            
            cell.CategoryImageView.image = subSettingDataObj?.titleImage
            cell.CategoryImageView.superview?.isHidden = subSettingDataObj?.titleImage == nil
            
            cell.categoryName.text = subSettingDataObj?.titleName ?? ""
            
            if indexPath.row == (settingObj.subData?.count ?? 0) - 1 {
                cell.Seperator1.isHidden = true
            }
            
            return cell
        
        default:
            return UITableViewCell()
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            let controller = ProfileVC.instantiate(fromAppStoryboard: .Main)
            self.navigationController?.pushViewController(controller, animated: true)
            break
        case 1:
            NotificationCenter.default.post(name: NotificationRefreshSideMenu, object: nil)
            let controller = HomeVC.instantiate(fromAppStoryboard: .Main)
            self.navigationController?.pushViewController(controller, animated: true)
           break
        case 2:
            let controller = CommonWebViewVC.instantiate(fromAppStoryboard: .Main)
            controller.strNavTitle = SettingsTitle.PrivacyPolicy
            self.navigationController?.pushViewController(controller, animated: true)
            break
        default:
           break
        }
    }
}

//MARK:- Language Picker Set Up
extension SettingVC : UIPickerViewDelegate,UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return SettingData.LanguageList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
       return SettingData.LanguageList[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedIndexOfPicker = row
    }
}

