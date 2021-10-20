//
//  chooseDestinationViewController.swift
//  PickARide User
//
//  Created by Apple on 17/12/20.
//  Copyright © 2020 EWW071. All rights reserved.
//

import UIKit
import GooglePlaces
import CoreLocation


class ChooseDestinationVC: BaseViewController {
    
    @IBOutlet weak var tblPlacePicker: UITableView!
    @IBOutlet weak var textFieldStartLocation: chooseLocationTextField!
    @IBOutlet weak var tblPlacePickerBottom: NSLayoutConstraint!
    @IBOutlet weak var textFieldDestinationLocation: chooseLocationTextField!
    
    var arrayForSavedPlaces : [PlaceData] = [PlaceData]()
    var arrPickupPlace : [placePickerData] = [placePickerData]()
    var arrDestinationPlace : [placePickerData] = [placePickerData]()
    var arrImage = [SettingImages.SettingHomeGray,SettingImages.SettingWorkGray]
    var tableData = [placePickerData]()
    var tableDataFetecher : GMSAutocompleteFetcher!
    var selectedTextField = 0
    let placesClient = GMSPlacesClient.shared()
    var selectedIndex = 0
    var selectedData : placePickerData!
    var viewModelPlaces = AddPlaceViewModel()
    var openSelectTexiVC : ((placePickerData, placePickerData)->())?
    var locationManager:CLLocationManager!
    var isFromSelectedLocation = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()

            if CLLocationManager.locationServicesEnabled(){
                locationManager.startUpdatingLocation()
            }
        
        
       
//        let location  = CLLocationCoordinate2D(latitude: Singleton.sharedInstance.userCurrentLocation?.latitude ?? 0.0, longitude: Singleton.sharedInstance.userCurrentLocation?.longitude ?? 0.0)
//
//        let strAddress = Utilities.getAddressFromLatLon(pdblLatitude: "\(location.latitude)", withLongitude: "\(location.longitude)")
//
//
//
//
//
        //Utilities.getAddressFromLatLon(pdblLatitude: "\(Singleton.sharedInstance.userCurrentLocation?.latitude ?? 0.0)", withLongitude: "\(Singleton.sharedInstance.userCurrentLocation?.longitude ?? 0.0)")
       
        self.setUpUI()
        self.setLocalization()
        self.callApi()
        var size = CGRect.zero
        size.size.height = .leastNormalMagnitude
        tblPlacePicker.tableHeaderView = UIView(frame: size)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)) , name: UIResponder.keyboardWillHideNotification, object: nil)
        self.setNavigationBarInViewController(controller: self, naviColor: colors.appColor.value, naviTitle: NavTitles.none.value, leftImage: NavItemsLeft.cancel.value, rightImages: [NavItemsRight.Done.value], isTranslucent: true, CommonViewTitles: [], isTwoLabels: false)
          doneBtnTapped()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
        if isFromSelectedLocation == true {
            
            textFieldStartLocation.text = arrPickupPlace[0].location
            textFieldDestinationLocation.text = arrDestinationPlace[0].location
        }

    }
    
    func doneBtnTapped(){
        self.navBtnDone.addTarget(self, action: #selector(addTapped(sender:)), for: .touchUpInside)
    }
    
    
    
    @objc func addTapped(sender: UIButton) {
        if validation() {
            if arrPickupPlace.count != 0 && arrDestinationPlace.count != 0 {
                self.navigationController?.popViewController(animated: true)
                if let selectedDropStart = openSelectTexiVC{
                    selectedDropStart(arrPickupPlace[0],arrDestinationPlace[0])
                }
            }
            
        }
        
    }
    
    func validation()->Bool{
        var strTitle : String?
        let startLocation = textFieldStartLocation.validatedText(validationType:.Location(field: textFieldStartLocation.placeholder?.lowercased() ?? ""))
        let destinationLocation = textFieldDestinationLocation.validatedText(validationType: .Location(field: textFieldDestinationLocation.placeholder?.lowercased() ?? ""))
        
        if !startLocation.0{
            strTitle = startLocation.1
        }else if !destinationLocation.0{
            strTitle = destinationLocation.1
        }
        else if arrPickupPlace.count != 0 && arrDestinationPlace.count != 0 , arrPickupPlace[0].location == arrDestinationPlace[0].location {
            strTitle = "Please select another location pickup and destination location should not same"
        }
        
        if let str = strTitle{
            Toast.show(title: UrlConstant.Required, message: str, state: .failure)
            return false
        }
        
        return true
    }

}

extension ChooseDestinationVC {
    func callApi(){
        self.viewModelPlaces.chooseDestinationVC = self
        self.viewModelPlaces.webserviceCallFavPlacesList()
    }
}


//MARK:- Methods
extension ChooseDestinationVC{
    func setUpUI(){
        self.tableDataFetecher = GMSAutocompleteFetcher()
//        let filter = GMSAutocompleteFilter()
//        filter.type = .geocode  //suitable filter type
//        filter.country = "UK"
//            //"US|UK|IN|SA|FR"
            
//            ""
//        filter.country = "UK"
//        filter.country = "IN"
//        filter.country = "SA"
//        filter.country = "FR"
    
       // tableDataFetecher.autocompleteFilter = filter

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
            cell.savedPlaceName.text = arrayForSavedPlaces[indexPath.row].placeName
           // cell.imgLocationType.image = arrImage[indexPath.row].i
            
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
                arrPickupPlace.removeAll()
                textFieldStartLocation.text = tableData[indexPath.row].location
                self.arrPickupPlace.append(placePickerData(PlaceName:tableData[indexPath.row].placeName, Location: tableData[indexPath.row].location, primary: tableData[indexPath.row].primaryText, secondary: tableData[indexPath.row].secondaryText, Lat: tableData[indexPath.row].lat, Lng:tableData[indexPath.row].lng))
            } else {
                arrDestinationPlace.removeAll()
                textFieldDestinationLocation.text = tableData[indexPath.row].location
                self.arrDestinationPlace.append(placePickerData(PlaceName:tableData[indexPath.row].placeName, Location: tableData[indexPath.row].location, primary: tableData[indexPath.row].primaryText, secondary: tableData[indexPath.row].secondaryText, Lat: tableData[indexPath.row].lat, Lng:tableData[indexPath.row].lng))
            }
           
            textFieldDestinationLocation.resignFirstResponder()
            textFieldStartLocation.resignFirstResponder()
            
        }
        else {
            if selectedTextField == 0 {
                arrPickupPlace.removeAll()
                textFieldStartLocation.text = arrayForSavedPlaces[indexPath.row].placeName
                self.arrPickupPlace.append(placePickerData(PlaceName:arrayForSavedPlaces[indexPath.row].location ?? "", Location: arrayForSavedPlaces[indexPath.row].placeName ?? "", primary: "", secondary: "", Lat:(arrayForSavedPlaces[indexPath.row].lat! as NSString).doubleValue, Lng:(arrayForSavedPlaces[indexPath.row].lng! as NSString).doubleValue))
            } else {
                arrDestinationPlace.removeAll()
                textFieldDestinationLocation.text = arrayForSavedPlaces[indexPath.row].placeName
                self.arrDestinationPlace.append(placePickerData(PlaceName:arrayForSavedPlaces[indexPath.row].location ?? "", Location: arrayForSavedPlaces[indexPath.row].placeName ?? "", primary: "", secondary: "", Lat:(arrayForSavedPlaces[indexPath.row].lat! as NSString).doubleValue, Lng:(arrayForSavedPlaces[indexPath.row].lng! as NSString).doubleValue))
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
//        if textFieldStartLocation.text != "" && textFieldDestinationLocation.text != "" {
//            self.navigationController?.popViewController(animated: false)
//            if let obj = openSelectTexiVC{
//                obj(textFieldStartLocation.text ?? "",textFieldDestinationLocation.text ?? "")
//            }
//        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
//    func getLocation() -> Bool {
//        if Singleton.sharedInstance.userCurrentLocation == nil{
//            self.locationManager = LocationService()
//            self.locationManager?.startUpdatingLocation()
//            return false
//        }else{
//            return true
//        }
//    }
}

//MARK:- Google AutoComplete Delegate
extension ChooseDestinationVC: GMSAutocompleteFetcherDelegate{
    
    func didAutocomplete(with predictions: [GMSAutocompletePrediction]) {
        tableData.removeAll()
        for prediction in predictions {
            let place = prediction.placeID
            GetPlaceDataByPlaceID(PlaceObj: prediction, pPlaceID: place)
            
        }

        tblPlacePicker.reloadData()
    }
    
   
    func GetPlaceDataByPlaceID(PlaceObj:GMSAutocompletePrediction,pPlaceID: String)
       {
         
           self.placesClient.lookUpPlaceID(pPlaceID, callback: { (place, error) -> Void in

               if let error = error {
                   print("lookup place id query error: \(error.localizedDescription)")
                   return
               }

           
               if let place = place {
                print("Place name \(String(describing: place.name))")
                   print("Place address \(place.formattedAddress!)")
                print("Place placeID \(String(describing: place.placeID))")
                print("Place attributions \(String(describing: place.attributions))")
                   print("\(place.coordinate.latitude)")
                   print("\(place.coordinate.longitude)")
                
                self.tableData.append(placePickerData(PlaceName: place.name ?? "", Location: place.formattedAddress ?? "", primary:PlaceObj.attributedPrimaryText.string , secondary: PlaceObj.attributedSecondaryText?.string ?? "", Lat: place.coordinate.latitude, Lng: place.coordinate.longitude))
                self.tblPlacePicker.reloadData()
                
               } else {
                   print("No place details for \(pPlaceID)")
               }
           })
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
    var placeName = ""
    var location = ""
    var lat = Double()
    var lng = Double()
    
    init(PlaceName : String , Location : String ,primary:String,secondary:String,Lat:Double,Lng:Double) {
        self.placeName = PlaceName
        self.location = Location
        self.lat = Lat
        self.lng = Lng
        self.primaryText = primary
        self.secondaryText = secondary
    }
}

extension ChooseDestinationVC : CLLocationManagerDelegate {
    
    
    //MARK: - location delegate methods
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation :CLLocation = locations[0] as CLLocation

        print("user latitude = \(userLocation.coordinate.latitude)")
        print("user longitude = \(userLocation.coordinate.longitude)")

        //self.labelLat.text = "\(userLocation.coordinate.latitude)"
        //self.labelLongi.text = "\(userLocation.coordinate.longitude)"

        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(userLocation) { (placemarks, error) in
            if (error != nil){
                print("error in reverseGeocode")
            }
            let placemark = placemarks! as [CLPlacemark]
            if placemark.count>0{
                let placemark = placemarks![0]
                print(placemark.locality!)
                print(placemark.administrativeArea!)
                print(placemark.country!)
               
                self.textFieldStartLocation.text = "\(placemark.name ?? ""), \(placemark.thoroughfare ?? ""), \(placemark.subThoroughfare ?? ""), \(placemark.subLocality ?? ""), \(placemark.locality ?? ""), \(placemark.postalCode ?? ""), \(placemark.country ?? "")"
                self.arrPickupPlace.removeAll()
                self.arrPickupPlace.append(placePickerData(PlaceName: self.textFieldStartLocation.text ??
                                        "", Location: self.textFieldStartLocation.text ??
                                            "", primary: "", secondary: "", Lat: userLocation.coordinate.latitude, Lng: userLocation.coordinate.longitude))
            }
            
        }

        locationManager.stopUpdatingLocation()
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error \(error)")
    }
    
    
}
