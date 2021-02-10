//
//  chooseDestinationViewController.swift
//  PickARide User
//
//  Created by Apple on 17/12/20.
//  Copyright © 2020 EWW071. All rights reserved.
//

import UIKit
import GooglePlaces
class chooseDestinationViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate, GMSAutocompleteFetcherDelegate {

    //MARK: -Properties
    var arrayForSavedPlaces : [String] = ["Home","Work"]
    var tableData=[placePickerData]()
    var tableDataFetecher : GMSAutocompleteFetcher!
    var selectedTextField = 0
    //MARK: -IBOutlets
    @IBOutlet weak var tblPlacePicker: UITableView!
    @IBOutlet weak var textFieldStartLocation: chooseLocationTextField!
    
    @IBOutlet weak var tblPlacePickerBottom: NSLayoutConstraint!
    @IBOutlet weak var textFieldDestinationLocation: chooseLocationTextField!
    //MARK: -View Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
           tableDataFetecher = GMSAutocompleteFetcher()
           tableDataFetecher.delegate = self
        
           
           tblPlacePicker.delegate = self
           tblPlacePicker.dataSource = self
        textFieldStartLocation.delegate = self
        textFieldDestinationLocation.delegate = self
        
        textFieldStartLocation.becomeFirstResponder()
        
        setNavigationBarInViewController(controller: self, naviColor: colors.appColor.value, naviTitle: NavTitles.none.value, leftImage: NavItemsLeft.cancel.value, rightImages: [NavItemsRight.none.value], isTranslucent: true, CommonViewTitles: [], isTwoLabels: false)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)) , name: UIResponder.keyboardWillHideNotification, object: nil)
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        setLocalization()
    }
    func setLocalization() {
        textFieldStartLocation.placeholder = "ChooseDestination_startLocation_place".Localized()
        textFieldDestinationLocation.placeholder = "ChooseDestination_DestinationLocation_place".Localized()
    }
    //MARK: -other methods
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            self.tblPlacePickerBottom.constant = keyboardSize.height
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        self.tblPlacePickerBottom.constant = 0
    }
    //MARK: -tableView Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return arrayForSavedPlaces.count
        case 1:
            return tableData.count
        default:
            return 0
            
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 0
        case 1:
            return 10.5
        default:
            return 0
        }
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
            let cell = tblPlacePicker.dequeueReusableCell(withIdentifier: "SavedCell", for: indexPath) as! SavedCell
            cell.savedPlaceName.text = arrayForSavedPlaces[indexPath.row]
            if indexPath.row == 0 {
                cell.imgLocationType.image = UIImage.init(named: "ic_HomeTemp")
            } else {
                cell.imgLocationType.image = UIImage.init(named: "ic_WorkTemp")
            }
            if indexPath.row == arrayForSavedPlaces.count - 1 {
                cell.Seperator1.isHidden = true
            }
            return cell
        case 1:
            let cell = tblPlacePicker.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as! SearchCell
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
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == textFieldStartLocation {
            selectedTextField = 0
        } else {
            selectedTextField = 1
        }
       

    }
    func textFieldDidChangeSelection(_ textField: UITextField) {
        tableDataFetecher.sourceTextHasChanged(textField.text)
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textFieldStartLocation.text != "" && textFieldDestinationLocation.text != "" {
            let controller = AppStoryboard.Main.instance.instantiateViewController(withIdentifier: SelectTaxiTypeViewController.storyboardID)
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableData.count != 0 {
            return 2
        }
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return UITableView.automaticDimension
        case 1:
            return UITableView.automaticDimension
        default:
            return 0
        }
    }
    
    
    //MARK: -googleMaps Methods
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
    
    //MARK: -IBActions
    
    
    //MARK: -API Calls
    
    
    
    

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
