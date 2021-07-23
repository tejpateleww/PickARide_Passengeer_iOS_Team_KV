//
//  chooseDestinationViewController.swift
//  PickARide User
//
//  Created by Apple on 17/12/20.
//  Copyright © 2020 EWW071. All rights reserved.
//

import UIKit
import GooglePlaces
class ChooseDestinationVC: BaseViewController {
    
    @IBOutlet weak var tblPlacePicker: UITableView!
    @IBOutlet weak var textFieldStartLocation: chooseLocationTextField!
    
    @IBOutlet weak var tblPlacePickerBottom: NSLayoutConstraint!
    @IBOutlet weak var textFieldDestinationLocation: chooseLocationTextField!
    
    var arrayForSavedPlaces : [String] = [SettingsTitle.Home,SettingsTitle.Work]
    var arrImage = [SettingImages.SettingHomeGray,SettingImages.SettingWorkGray]
    
    var tableData = [placePickerData]()
    var tableDataFetecher : GMSAutocompleteFetcher!
    var selectedTextField = 0
    
    var openSelectTexiVC : (()->())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
        self.setLocalization()
           
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)) , name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarInViewController(controller: self, naviColor: colors.appColor.value, naviTitle: NavTitles.none.value, leftImage: NavItemsLeft.cancel.value, rightImages: [NavItemsRight.none.value], isTranslucent: true, CommonViewTitles: [], isTwoLabels: false)
    }
}

//MARK:- Methods
extension ChooseDestinationVC{
    func setUpUI(){
        self.tableDataFetecher = GMSAutocompleteFetcher()
        self.tableDataFetecher.delegate = self
        
        self.tblPlacePicker.delegate = self
        self.tblPlacePicker.dataSource = self
        
        self.textFieldDestinationLocation.delegate = self
        
        self.textFieldStartLocation.delegate = self
        self.textFieldStartLocation.becomeFirstResponder()
    }
    
    func setLocalization() {
        textFieldStartLocation.placeholder = "ChooseDestination_startLocation_place".Localized()
        textFieldDestinationLocation.placeholder = "ChooseDestination_DestinationLocation_place".Localized()
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            self.tblPlacePickerBottom.constant = keyboardSize.height
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        self.tblPlacePickerBottom.constant = 0
    }
}

//MARK:- TableView Delegate
extension ChooseDestinationVC: UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.tableData.count != 0 ? 2 : 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? self.arrayForSavedPlaces.count : self.tableData.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0 : 10.5
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            let headerView = UIView.init(frame: CGRect(x: 0, y: 0, width: tblPlacePicker.frame.size.height, height: 0))
            return headerView
        case 1:
            let headerView = UIView.init(frame: CGRect(x: 0, y: 0, width: tblPlacePicker.frame.size.height, height: 10.5))
            headerView.backgroundColor = UIColor(hexString: "#F7F9FC")
            let seperatorView1 = UIView.init(frame: CGRect(x: 0, y: -1, width: 0, height: 1))
            seperatorView1.backgroundColor = colors.seperatorColor.value
            headerView.addSubview(seperatorView1)
            
            let seperatorView2 = UIView.init(frame: CGRect(x: 0, y: 10.5, width: 0, height: 1))
            seperatorView2.backgroundColor = colors.seperatorColor.value
            headerView.addSubview(seperatorView2)
            
            return headerView
        default:
            let headerView = UIView.init(frame: CGRect(x: 0, y: 0, width: tblPlacePicker.frame.size.height, height: 0))
            return headerView
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tblPlacePicker.dequeueReusableCell(withIdentifier: "SavedCell", for: indexPath) as? SavedCell ?? SavedCell()
            cell.savedPlaceName.text = arrayForSavedPlaces[indexPath.row]
            cell.imgLocationType.image = arrImage[indexPath.row]
            
            if indexPath.row == arrayForSavedPlaces.count - 1 {
                cell.Seperator1.isHidden = true
            }
            return cell
        case 1:
            let cell = tblPlacePicker.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as? SearchCell ?? SearchCell()
            cell.searchPlaceTitle.text = tableData[indexPath.row].primaryText
            cell.searchSubPlaceTitle.text = tableData[indexPath.row].secondaryText

            return cell
        default:
            return UITableViewCell()
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section != 0 {
            if selectedTextField == 0 {
                textFieldStartLocation.text = tableData[indexPath.row].primaryText
            } else {
                textFieldDestinationLocation.text = tableData[indexPath.row].primaryText
            }
            textFieldDestinationLocation.resignFirstResponder()
            textFieldStartLocation.resignFirstResponder()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
            case 0,1: return UITableView.automaticDimension
            default: return 0
        }
    }
}

//MARK:- UITextField Delegate
extension ChooseDestinationVC: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        selectedTextField = textField == textFieldStartLocation ? 0 : 1
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        tableDataFetecher.sourceTextHasChanged(textField.text)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textFieldStartLocation.text != "" && textFieldDestinationLocation.text != "" {
            self.navigationController?.popViewController(animated: false)
            if let obj = openSelectTexiVC{
                obj()
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}

//MARK:- Google AutoComplete Delegate
extension ChooseDestinationVC: GMSAutocompleteFetcherDelegate{
    func didAutocomplete(with predictions: [GMSAutocompletePrediction]) {
        tableData.removeAll()
        for prediction in predictions {
            tableData.append(placePickerData(primary: prediction.attributedPrimaryText.string, secondary: prediction.attributedSecondaryText?.string ?? ""))
        }

        tblPlacePicker.reloadData()
    }

    func didFailAutocompleteWithError(_ error: Error) {
        print(error.localizedDescription)
    }
}

class SavedCell : UITableViewCell {
    @IBOutlet weak var savedPlaceName : UILabel!
    @IBOutlet weak var imgLocationType: UIImageView!
    @IBOutlet weak var Seperator1 : seperatorView!
}

class SearchCell : UITableViewCell {
    @IBOutlet weak var searchPlaceTitle : UILabel!
    @IBOutlet weak var searchSubPlaceTitle : UILabel!
}

class placePickerData {
    var primaryText = ""
    var secondaryText = ""
    
    init(primary:String,secondary:String) {
        self.primaryText = primary
        self.secondaryText = secondary
    }
}
