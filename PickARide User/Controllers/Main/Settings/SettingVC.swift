//
//  SettingViewController.swift
//  PickARide User
//
//  Created by Apple on 21/12/20.
//  Copyright © 2020 EWW071. All rights reserved.
//

import UIKit

class SettingVC: BaseViewController{
   
    //MARK: -Properties
    var SettingList = [SettingData]()
    //MARK: -IBOutlets
    
    @IBOutlet weak var lblSettingsTitle: TitleLabel!
    @IBOutlet weak var tblSettings: UITableView!
    //MARK: -View Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLocalization()
        setNavigationBarInViewController(controller: self, naviColor: colors.submitButtonColor.value, naviTitle: NavTitles.none.value, leftImage: NavItemsLeft.back.value, rightImages: [NavItemsRight.none.value], isTranslucent: true, CommonViewTitles: [], isTwoLabels: false)
        addValuesInSettingList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    //MARK: -other methods
    @objc func settingsButton(_ sender : UIButton) {
        if sender.titleLabel?.text == "SettingsVC_btnAdd".Localized() {
            let vc : AddNewDestinationVC = AddNewDestinationVC.instantiate(fromAppStoryboard: .Main)
            self.navigationController?.pushViewController(vc, animated: true)
        } else if sender.titleLabel?.text == "SettingsVC_btnMoreSavedPlaces".Localized() {
            let controller = AppStoryboard.Main.instance.instantiateViewController(withIdentifier: SavedPlaceVC.storyboardID)
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    func setLocalization() {
        lblSettingsTitle.text = "SettingsVC_lblTitle".Localized()
    }
}

//MARK:- Tableview Delegate
extension  SettingVC: UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return SettingData.SettingList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
            case 0: return 1
            case 1,2,3: return SettingList[section].subsettings?.count ?? 0
            default:  return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        switch section {
        case 0:
            let headerView = UIView.init(frame: CGRect(x: 0, y: 0, width: tblSettings.frame.size.width, height: 0))
            return headerView
            
        case 1,2,3:
           return setHeaderView(sectionNumber: section)
            
        default:
            let headerView = UIView.init(frame: CGRect(x: 0, y: 0, width: tblSettings.frame.size.width, height: 0))
            return headerView
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
            case 0: return 0
            case 1,2,3: return 49
            default: return 0
        }
    }
    
    func setHeaderView(sectionNumber : Int) -> UIView {
        let headerView = UIView.init(frame: CGRect(x: 0, y: 0, width: tblSettings.frame.size.width, height: 49))
        if SettingList[sectionNumber].TitleName == ""
        {
            let button = UIButton()
            button.frame = CGRect(x: 21, y: 0, width: tblSettings.frame.size.width, height: headerView.frame.size.height)
            button.setTitle(SettingList[sectionNumber].titleButton, for: .normal)
            button.addTarget(self, action: #selector(settingsButton(_:)), for: .touchUpInside)
            button.titleLabel?.textColor = colors.submitButtonColor.value
            button.contentHorizontalAlignment = .left
            button.titleLabel?.font =  CustomFont.medium.returnFont(17)
            button.setTitleColor(colors.submitButtonColor.value, for: .normal)
            headerView.addSubview(button)
            
        } else if SettingList[sectionNumber].titleButton == "" {
            let label = UILabel()
            label.frame = CGRect(x: 21, y: 0, width: tblSettings.frame.size.width, height: headerView.frame.size.height)
            label.text = SettingList[sectionNumber].TitleName
            label.font = CustomFont.medium.returnFont(17)
            label.textColor = colors.loginPlaceHolderColor.value
            headerView.addSubview(label)
            
        } else {
            let label = UILabel()
            label.frame = CGRect(x: 21, y: 0, width: tblSettings.frame.size.width - 99, height: headerView.frame.size.height)
            label.text = SettingList[sectionNumber].TitleName
            label.font = CustomFont.medium.returnFont(17)
            label.textColor = colors.loginPlaceHolderColor.value
            headerView.addSubview(label)
            
            let button = UIButton()
            button.frame = CGRect(x: tblSettings.frame.size.width - 18 - 50, y: 0, width: 50, height: headerView.frame.size.height)
            button.setTitle(SettingList[sectionNumber].titleButton, for: .normal)
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
        case 1,2,3:
            let cell = tblSettings.dequeueReusableCell(withIdentifier: SettingCell2.reuseIdentifier, for: indexPath) as? SettingCell2 ?? SettingCell2()
            cell.backgroundColor = ThemeColorEnum.SettingsCell.rawValue
            
            cell.CategoryImageView.image = SettingList[indexPath.section].subsettings?[indexPath.row].subTitleImage
            cell.CategoryImageView.superview?.isHidden = SettingList[indexPath.section].subsettings?[indexPath.row].subTitleImage == UIImage()
            
            let isForLanguage = SettingList[indexPath.section].subsettings?[indexPath.row].subSettingIsLanguage ?? Bool()
            cell.btnNext.superview?.isHidden = isForLanguage
            
            cell.categoryName.text = SettingList[indexPath.section].subsettings?[indexPath.row].subTitleName ?? ""
            
            if indexPath.row == (SettingList[indexPath.section].subsettings?.count ?? 0) - 1 {
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
            let controller = AppStoryboard.Main.instance.instantiateViewController(withIdentifier: ProfileVC.storyboardID) as! ProfileVC
            self.navigationController?.pushViewController(controller, animated: true)
            break
        case 1:
            NotificationCenter.default.post(name: NotificationRefreshSideMenu, object: nil)
            let controller = AppStoryboard.Main.instance.instantiateViewController(withIdentifier: HomeVC.storyboardID) as! HomeVC
            self.navigationController?.pushViewController(controller, animated: true)
           break
        case 2:
            let controller = AppStoryboard.Main.instance.instantiateViewController(withIdentifier: CommonWebViewVC.storyboardID) as! CommonWebViewVC
            controller.strNavTitle = "SettingsVC_privacyPolicy".Localized()
            self.navigationController?.pushViewController(controller, animated: true)
            break
        case 3:
            break
        default:
           break
        }
    }
}


