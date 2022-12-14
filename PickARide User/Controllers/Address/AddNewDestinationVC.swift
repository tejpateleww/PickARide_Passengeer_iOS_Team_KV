//
//  addNewDestinationViewController.swift
//  PickARide User
//
//  Created by Apple on 21/12/20.
//  Copyright © 2020 EWW071. All rights reserved.
//

import UIKit
import GooglePlaces

class AddNewDestinationVC: BaseViewController {
    
    @IBOutlet weak var lblPlaceName: ProfileLabel!
    @IBOutlet weak var lblPlaceAddress: ProfileLabel!
    @IBOutlet weak var tblPlacePicker: UITableView!
    @IBOutlet weak var tblPlacePickerBottom: NSLayoutConstraint!
    @IBOutlet weak var txtPlaceAddress: ProfileTextField!
    @IBOutlet weak var txtPlaceName: ProfileTextField!
    
    var tableData = [placePickerData]()
    var tableDataFetecher : GMSAutocompleteFetcher!
    var viewModelPlaces = AddPlaceViewModel()
    var selectedIndex = Int()
    var selectedData : placePickerData!
    let placesClient = GMSPlacesClient.shared()
    
    
    override func viewDidLoad() {
        let s : String?
        s = "d"
        print(s ?? "")
        super.viewDidLoad()
        self.setUpUI()
        self.setLocalization()
        self.setDelegates()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarInViewController(controller: self, naviColor: colors.submitButtonColor.value, naviTitle: NavTitles.addNewPlace.value, leftImage: NavItemsLeft.cancel.value, rightImages: [NavItemsRight.add.value], isTranslucent: true, CommonViewTitles: [], isTwoLabels: false)
          navBtnDone.addTarget(self, action: #selector(navAddButtonClicked), for: .touchUpInside)
    }
}

extension AddNewDestinationVC {
    func callApi(){
        self.viewModelPlaces.AddPlaceVC = self
        let reqModel = AddPlacesReqModel()
        reqModel.customerId = Singleton.sharedInstance.UserId
        reqModel.placeName = selectedData.primaryText
        reqModel.location = selectedData.location
        reqModel.lat = selectedData.lat
        reqModel.lng = selectedData.lng
        reqModel.cityName = selectedData.cityName
        self.viewModelPlaces.webserviceCallAddPlaces(reqmodel: reqModel)
    }
}

//MARK:- Set Up UI
extension AddNewDestinationVC{
    func setUpUI(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)) , name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func setDelegates(){
        tableDataFetecher = GMSAutocompleteFetcher()
        tableDataFetecher.delegate = self
        
        tblPlacePicker.delegate = self
        tblPlacePicker.dataSource = self
        txtPlaceAddress.delegate = self
    }
    
    func setLocalization() {
        self.lblPlaceName.text = "AddNewDestinationVC_PlaceName".Localized()
        self.txtPlaceName.placeholder = "AddNewDestinationVC_PlaceName".Localized()
        
        self.lblPlaceAddress.text = "AddNewDestinationVC_PlaceAddress".Localized()
        self.txtPlaceAddress.placeholder = "AddNewDestinationVC_PlaceAddress".Localized()
    }
    
    @objc func navAddButtonClicked(_ sender: UIButton) {
        callApi()
        self.view.endEditing(true)
        self.navigationController?.popViewController(animated: true)
    }
    
    func GetPlaceDataByPlaceID(PlaceObj:GMSAutocompletePrediction,pPlaceID: String)
       {
         //  pPlaceID = "ChIJXbmAjccVrjsRlf31U1ZGpDM"
           self.placesClient.lookUpPlaceID(pPlaceID, callback: { (place, error) -> Void in

               if let error = error {
                   print("lookup place id query error: \(error.localizedDescription)")
                   return
               }

               if let place = place {
                   print("Place name \(place.name)")
//                   print("Place address \(place.formattedAddress!)")
//                   print("Place placeID \(place.placeID)")
//                   print("Place attributions \(place.attributions)")
//                   print("\(place.coordinate.latitude)")
//                   print("\(place.coordinate.longitude)")
                   let cityName = place.addressComponents?.first(where: { $0.type == "locality" })?.name ?? ""
                   // Need to put in code in dsiaptch queu
                   DispatchQueue.main.async {
                       self.tableData.removeAll()
                       self.tableData.append(placePickerData(PlaceName: place.name ?? "", Location: place.formattedAddress ?? "", primary:PlaceObj.attributedPrimaryText.string , secondary: PlaceObj.attributedSecondaryText?.string ?? "", Lat: place.coordinate.latitude, Lng: place.coordinate.longitude, cityName: cityName))
                       self.tblPlacePicker.reloadData()
                   }
                 
               } else {
                   print("No place details for \(pPlaceID)")
               }
           })
       }
}

//MARK:- TableView Delegate
extension AddNewDestinationVC: UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
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
            let cell = tblPlacePicker.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as? SearchCell ?? SearchCell()
            cell.searchPlaceTitle.text = tableData[indexPath.row].primaryText
            cell.searchSubPlaceTitle.text = tableData[indexPath.row].secondaryText
            return cell
            
        default:
            return UITableViewCell()
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return UITableView.automaticDimension
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        selectedData = tableData[selectedIndex]
        txtPlaceAddress.text = tableData[selectedIndex].primaryText
        txtPlaceAddress.resignFirstResponder()
    }
}

//MARK:- GMSAutocompleteFetcher Delegate
extension  AddNewDestinationVC: GMSAutocompleteFetcherDelegate{
    func didAutocomplete(with predictions: [GMSAutocompletePrediction]) {
        print("Prediction count: \(predictions.count)")
        if predictions.count > 0 {
            for prediction in predictions {
                GetPlaceDataByPlaceID(PlaceObj: prediction, pPlaceID: prediction.placeID)
            }
        } else {
            print("predictions are 0")
        }
    }
    
    func didFailAutocompleteWithError(_ error: Error) {
        print(error.localizedDescription)
    }
    
}

//MARK:- Textfield Delegate
extension AddNewDestinationVC: UITextFieldDelegate{
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            self.tblPlacePickerBottom.constant = keyboardSize.height
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        self.tblPlacePickerBottom.constant = 0
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {}
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        tableDataFetecher.sourceTextHasChanged(textField.text)
    }
}
