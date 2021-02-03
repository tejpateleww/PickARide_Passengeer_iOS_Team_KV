//
//  SettingViewController.swift
//  PickARide User
//
//  Created by Apple on 21/12/20.
//  Copyright © 2020 EWW071. All rights reserved.
//

import UIKit

class SettingViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource {
   
    

    //MARK: -Properties
    var settings = [settingData]()
    //MARK: -IBOutlets
    
    @IBOutlet weak var lblSettingsTitle: TitleLabel!
    @IBOutlet weak var tblSettings: UITableView!
    //MARK: -View Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLocalization()
        setNavigationBarInViewController(controller: self, naviColor: colors.submitButtonColor.value, naviTitle: NavTitles.none.value, leftImage: NavItemsLeft.back.value, rightImages: [NavItemsRight.none.value], isTranslucent: true, CommonViewTitles: [])
        
        settings.append(settingData(name: "", button: "", subsetting: []))
        settings.append(settingData(name: "SettingsVC_Favourites".Localized(), button: "SettingsVC_btnAdd".Localized(), subsetting: [subSettingsData(img: UIImage(named: "ic_settingsHome")!, name: "SettingsVC_Home".Localized(), isLanguage: false),subSettingsData(img: UIImage(named: "ic_SettingWork")!, name: "SettingsVC_Work".Localized(), isLanguage: false)]))
        settings.append(settingData(name: "", button: "SettingsVC_btnMoreSavedPlaces".Localized(), subsetting: [subSettingsData(img: UIImage(), name: "SettingsVC_privacyPolicy".Localized(), isLanguage: false)]))
        settings.append(settingData(name: "SettingsVC_Language".Localized(), button: "", subsetting: [subSettingsData(img: UIImage(), name: "SettingsVC_English".Localized(), isLanguage: true),subSettingsData(img: UIImage(), name: "SettingsVC_German".Localized(), isLanguage: true)]))
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    //MARK: -other methods
    @objc func settingsButton(_ sender : UIButton) {
        if sender.titleLabel?.text == "SettingsVC_btnAdd".Localized() {
            
        } else if sender.titleLabel?.text == "SettingsVC_btnMoreSavedPlaces".Localized() {
            let controller = AppStoryboard.Main.instance.instantiateViewController(withIdentifier: SavedPlaceVC.storyboardID)
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    
    func setLocalization() {
        lblSettingsTitle.text = "SettingsVC_lblTitle".Localized()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return settings[section].subsettings!.count
        case 2:
            return settings[section].subsettings!.count
        case 3:
            return settings[section].subsettings!.count
        default:
            return 0
        }
      
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tblSettings.dequeueReusableCell(withIdentifier: settingCell1.reuseIdentifier, for: indexPath) as! settingCell1
            cell.lblUserName.text = "Abdullah Amir"
            cell.lblUserPhoneNumber.text = "+49 9564 656 6555"
            cell.lblUserEmail.text = "abdullahamir@gmail.com"
            return cell
        case 1:
            let cell = tblSettings.dequeueReusableCell(withIdentifier: settingCell2.reuseIdentifier, for: indexPath) as! settingCell2
            cell.backgroundColor = UIColor(hexString: "#F4F4F6")
            cell.CategoryImageView.image = settings[indexPath.section].subsettings![indexPath.row].subTitleImage
            cell.btnNext.superview?.isHidden = settings[indexPath.section].subsettings![indexPath.row].subSettingIsLanguage! ? true : false
            cell.btnLanguageSelected.superview?.isHidden = settings[indexPath.section].subsettings![indexPath.row].subSettingIsLanguage! ? false : true
            cell.CategoryImageView.superview?.isHidden = (settings[indexPath.section].subsettings![indexPath.row].subTitleImage == nil) ? true : false
            
            
            cell.categoryName.text = settings[indexPath.section].subsettings![indexPath.row].subTitleName
            if indexPath.row == settings[indexPath.section].subsettings!.count - 1 {
                cell.Seperator1.isHidden = true
            }
            return cell
        case 2:
            let cell = tblSettings.dequeueReusableCell(withIdentifier: settingCell2.reuseIdentifier, for: indexPath) as! settingCell2
            cell.backgroundColor = UIColor(hexString: "#F4F4F6")
            cell.CategoryImageView.image = settings[indexPath.section].subsettings![indexPath.row].subTitleImage
            cell.btnNext.superview?.isHidden = settings[indexPath.section].subsettings![indexPath.row].subSettingIsLanguage! ? true : false
            cell.btnLanguageSelected.superview?.isHidden = settings[indexPath.section].subsettings![indexPath.row].subSettingIsLanguage! ? false : true
            cell.CategoryImageView.superview?.isHidden = true
            cell.Seperator1.isHidden = true
            cell.categoryName.text = settings[indexPath.section].subsettings![indexPath.row].subTitleName
            return cell
        case 3:
            let cell = tblSettings.dequeueReusableCell(withIdentifier: settingCell2.reuseIdentifier, for: indexPath) as! settingCell2
            cell.backgroundColor = UIColor(hexString: "#F4F4F6")
            cell.CategoryImageView.image = settings[indexPath.section].subsettings![indexPath.row].subTitleImage
            cell.btnNext.superview?.isHidden = settings[indexPath.section].subsettings![indexPath.row].subSettingIsLanguage! ? true : false
            cell.btnLanguageSelected.superview?.isHidden = settings[indexPath.section].subsettings![indexPath.row].subSettingIsLanguage! ? false : true
            cell.CategoryImageView.superview?.isHidden = true
            cell.Seperator1.isHidden = true
            cell.categoryName.text = settings[indexPath.section].subsettings![indexPath.row].subTitleName
            return cell
        default:
            return UITableViewCell()
            
        }
    }
  
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        switch section {
        case 0:
            let headerView = UIView.init(frame: CGRect(x: 0, y: 0, width: tblSettings.frame.size.width, height: 0))
            return headerView
        case 1:
            
           return setHeaderView(sectionNumber: section)
              
        case 2:
            return setHeaderView(sectionNumber: section)
        case 3:
            return setHeaderView(sectionNumber: section)
        default:
            let headerView = UIView.init(frame: CGRect(x: 0, y: 0, width: tblSettings.frame.size.width, height: 0))
            return headerView
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
        return 0
        case 1:
            return 49
        case 2:
            return 49
        case 3:
            return 49
        default:
        return 0
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func setHeaderView(sectionNumber : Int) -> UIView {
        let headerView = UIView.init(frame: CGRect(x: 0, y: 0, width: tblSettings.frame.size.width, height: 49))
        if settings[sectionNumber].TitleName == ""
        {
            let button = UIButton()
            button.frame = CGRect(x: 21, y: 0, width: tblSettings.frame.size.width, height: headerView.frame.size.height)
            button.setTitle(settings[sectionNumber].titleButton, for: .normal)
            button.addTarget(self, action: #selector(settingsButton(_:)), for: .touchUpInside)
            button.titleLabel?.textColor = colors.submitButtonColor.value
            button.contentHorizontalAlignment = .left
            button.titleLabel?.font =  CustomFont.medium.returnFont(17)
            button.setTitleColor(colors.submitButtonColor.value, for: .normal)
            headerView.addSubview(button)
        } else if settings[sectionNumber].titleButton == "" {
            let label = UILabel()
            label.frame = CGRect(x: 21, y: 0, width: tblSettings.frame.size.width, height: headerView.frame.size.height)
            label.text = settings[sectionNumber].TitleName
            label.font = CustomFont.medium.returnFont(17)
            label.textColor = colors.loginPlaceHolderColor.value
            headerView.addSubview(label)
            
        } else {
            let label = UILabel()
            label.frame = CGRect(x: 21, y: 0, width: tblSettings.frame.size.width - 99, height: headerView.frame.size.height)
            label.text = settings[sectionNumber].TitleName
            label.font = CustomFont.medium.returnFont(17)
            label.textColor = colors.loginPlaceHolderColor.value
            headerView.addSubview(label)
            
            let button = UIButton()
            button.frame = CGRect(x: tblSettings.frame.size.width - 18 - 50, y: 0, width: 50, height: headerView.frame.size.height)
            button.setTitle(settings[sectionNumber].titleButton, for: .normal)
            button.titleLabel?.textColor = colors.submitButtonColor.value
            button.addTarget(self, action: #selector(settingsButton(_:)), for: .touchUpInside)
            button.contentHorizontalAlignment = .right
            button.titleLabel?.font =  CustomFont.medium.returnFont(17)
            button.setTitleColor(colors.submitButtonColor.value, for: .normal)
            headerView.addSubview(button)
        }
        return headerView
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            let controller = AppStoryboard.Main.instance.instantiateViewController(withIdentifier: ProfileVC.storyboardID) as! ProfileVC
            self.navigationController?.pushViewController(controller, animated: true)
            break
        case 1:
           break
        case 2:
            break
        case 3:
            break
        default:
           break
        }
    }
    
    
    //MARK: -IBActions
    
    
    //MARK: -API Calls
    
    
    
    
}
class settingCell1 : UITableViewCell {
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var btnShowProfile: UIButton!
    @IBOutlet weak var lblUserName: UILabel!
    
    @IBOutlet weak var lblUserEmail: UILabel!
    @IBOutlet weak var lblUserPhoneNumber: UILabel!
}
class settingCell2 : UITableViewCell {
    @IBOutlet weak var Seperator1: seperatorView!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var CategoryImageView: UIImageView!
    
    @IBOutlet weak var btnLanguageSelected: UIButton!
    @IBOutlet weak var categoryName: UILabel!
    
    override func awakeFromNib() {
        btnLanguageSelected.addTarget(self, action: #selector(btnLanguageClick(sender:)), for: .touchUpInside)
        
    }
    @objc func btnLanguageClick(sender:UIButton) {
        if sender.isSelected {
            sender.isSelected = false
        } else {
            sender.isSelected = true
        }
    }
}
//switch indexPath.section {
//case 0:
//
//case 1:
//
//default:
//
//}

class settingData {
    var TitleName : String?
    var titleButton : String?
    var subsettings : [subSettingsData]?
    init(name:String,button:String,subsetting:[subSettingsData]) {
        self.TitleName = name
        self.titleButton = button
        self.subsettings = subsetting
    }
}
class subSettingsData {
    var subTitleImage : UIImage?
    var subTitleName : String?
    var subSettingIsLanguage : Bool?
    init(img:UIImage,name:String,isLanguage:Bool) {
        self.subTitleName = name
        self.subTitleImage = img
        self.subSettingIsLanguage = isLanguage
    }
}
