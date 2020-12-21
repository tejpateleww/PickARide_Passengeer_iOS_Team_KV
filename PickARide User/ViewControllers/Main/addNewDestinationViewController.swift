//
//  addNewDestinationViewController.swift
//  PickARide User
//
//  Created by Apple on 21/12/20.
//  Copyright © 2020 EWW071. All rights reserved.
//

import UIKit
import GooglePlaces
class addNewDestinationViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate, GMSAutocompleteFetcherDelegate {
   
    

    //MARK: -Properties
    var tableData=[placePickerData]()
    var tableDataFetecher : GMSAutocompleteFetcher!
    //MARK: -IBOutlets
    @IBOutlet weak var tblPlacePicker: UITableView!
    @IBOutlet weak var tblPlacePickerBottom: NSLayoutConstraint!
    @IBOutlet weak var textFieldDestinationLocation: addNewDestinationTextField!
    //MARK: -View Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLocalization()
        setString()
        setNavigationBarInViewController(controller: self, naviColor: colors.submitButtonColor.value, naviTitle: NavTitles.none.value, leftImage: NavItemsLeft.cancel.value, rightImages: [NavItemsRight.none.value], isTranslucent: true)
        
        
        tableDataFetecher = GMSAutocompleteFetcher()
        tableDataFetecher.delegate = self
     
        
        tblPlacePicker.delegate = self
        tblPlacePicker.dataSource = self
     textFieldDestinationLocation.delegate = self
    
     NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
     NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)) , name: UIResponder.keyboardWillHideNotification, object: nil)
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    //MARK: -other methods
    func setLocalization() {
        textFieldDestinationLocation.placeholder = "AddNewDestinationVC_PlaceName_place".Localized()
    }
    func setString() {
        textFieldDestinationLocation.text = "Home"
    }
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            self.tblPlacePickerBottom.constant = keyboardSize.height
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        self.tblPlacePickerBottom.constant = 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return tableData.count
        default:
            return 0
            
        }
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tblPlacePicker.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as! SearchCell
            cell.searchPlaceTitle.text = tableData[indexPath.row].primaryText
            cell.searchSubPlaceTitle.text = tableData[indexPath.row].secondaryText
            return cell
      
        default:
            return UITableViewCell()
            
        }
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
      

    }
    func textFieldDidChangeSelection(_ textField: UITextField) {
        tableDataFetecher.sourceTextHasChanged(textField.text)
    }
    func numberOfSections(in tableView: UITableView) -> Int {
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
