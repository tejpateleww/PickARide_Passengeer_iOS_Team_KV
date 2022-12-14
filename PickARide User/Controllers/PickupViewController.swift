//
//  PickupViewController.swift
//  PickARide User
//
//  Created by Apple on 22/10/21.
//  Copyright © 2021 EWW071. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation
import SwiftyJSON
class PickupViewController: BaseViewController,GMSMapViewDelegate {
    
    // ----------------------------------------------------
    // MARK: - --------- Variables ---------
    // ----------------------------------------------------
    var pinnedLocation : CLLocationCoordinate2D?
    var dropOffData : [placePickerData] = [placePickerData]()
    var arrPickupPlace : [placePickerData] = [placePickerData]()
    var openSelectTexiVC : ((placePickerData, placePickerData)->())?
    
    
    // ----------------------------------------------------
    // MARK: - --------- IBOutlets ---------
    // ----------------------------------------------------
    @IBOutlet weak var lblSelectedLocation: themeLabel!
    @IBOutlet weak var mapView: GMSMapView!
    
    // ----------------------------------------------------
    // MARK: - --------- Life-cycle Methods ---------
    // ----------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationBarInViewController(controller: self, naviColor: colors.submitButtonColor.value, naviTitle: NavTitles.none.value, leftImage: NavItemsLeft.back.value, rightImages: [NavItemsRight.none.value], isTranslucent: true, CommonViewTitles: [], isTwoLabels: false)
        
        
        
        let camera = GMSCameraPosition.camera(withLatitude: pinnedLocation?.latitude ?? 0.0, longitude: pinnedLocation?.longitude ?? 0.0, zoom: 16.0)
        mapView.camera = camera
        
        
        self.mapView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    
    // ----------------------------------------------------
    // MARK: - --------- Custom Methods ---------
    // ----------------------------------------------------
    
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        
        let lat = position.target.latitude
        let lng = position.target.longitude
        
        // Create Location
        
        getAddressForLatLng(latitude: "\(lat)", longitude: "\(lng)")
        // Geocode Location
        
    }
    
    // ----------------------------------------------------
    // MARK: - --------- IBAction Methods ---------
    // ----------------------------------------------------
    
    @IBAction func btnSave(_ sender: Any) {
        if arrPickupPlace.count != 0 {
            self.navigationController?.popViewController(animated: true)
            if let selectedDropStart = openSelectTexiVC{
                selectedDropStart(arrPickupPlace[0],dropOffData[0])
            }
        }
        
    }
    
    
    
    // ----------------------------------------------------
    // MARK: - --------- Webservice Methods ---------
    // ----------------------------------------------------
    func getAddressForLatLng(latitude: String, longitude: String)
    {
        let url = NSURL(string: "https://maps.googleapis.com/maps/api/geocode/json?latlng=\(latitude),\(longitude)&key=\(APIEnvironment.GoogleMapKey.rawValue )")
        
        let data = NSData(contentsOf: url! as URL)
        
        let json = try! JSONSerialization.jsonObject(with: data! as Data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
        if let result = json["results"] as? [[String:AnyObject]], result.count > 0 {
            if let address = result.first?["formatted_address"] as? String
            {
                let cityName = getCityNameFromAddressComponents(result: result.first)
                print("city name: \(cityName)")
                arrPickupPlace.removeAll()
                arrPickupPlace.append(placePickerData(PlaceName: address, Location: address, primary: "", secondary: "", Lat: Double(latitude) ?? 0.0, Lng: Double(longitude) ?? 0.0, cityName: cityName))
                lblSelectedLocation.text = address
                print("ATDebug :: \(address)")
            }
        }
    }
    func getCityNameFromAddressComponents(result: [String: Any]?) -> String {
        if let addressComponents = result?["address_components"]! as? [NSDictionary] {
            for component in addressComponents {
                if let temp = component.object(forKey: "types") as? [String] {
                    //                   if (temp[0] == "postal_code") {
                    //                       self.pincode = component["long_name"] as? String
                    //                   }
                    if (temp[0] == "locality") {
                        return component["long_name"] as? String ?? ""
                    }
                    //                   if (temp[0] == "administrative_area_level_1") {
                    //                       self.state = component["long_name"] as? String
                    //                   }
                    //                   if (temp[0] == "country") {
                    //                       self.country = component["long_name"] as? String
                    //                   }
                } // types oif ends here
            } // address componenets for loop ends here
        } // address coponents if else ends here
        return ""
    } // function ends here
}
