//
//  SavedPlaceVC.swift
//  PickARide User
//
//  Created by baps on 17/12/20.
//  Copyright © 2020 EWW071. All rights reserved.
//

import UIKit

class SavedPlaceVC: BaseViewController,UITableViewDelegate,UITableViewDataSource {
    //MARK: -Properties
      var placeArray = ["Home","Work"]
    //MARK: -IBOutlets
    
    
    @IBOutlet weak var lblSavedPlaces: SavedPlacesLabel!
    @IBOutlet weak var btnAddPlace: SavedPlaceButton!
    @IBOutlet weak var tblSavedPlaces: UITableView!
    
    //MARK: -View Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        tblSavedPlaces.delegate = self
        tblSavedPlaces.dataSource = self
        tblSavedPlaces.reloadData()
        
        setNavigationBarInViewController(controller: self, naviColor: colors.submitButtonColor.value, naviTitle: NavTitles.none.value, leftImage: NavItemsLeft.back.value, rightImages: [NavItemsRight.none.value], isTranslucent: true)
    }
    
    //MARK: -Other Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placeArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:SavedPlaceCell = tblSavedPlaces.dequeueReusableCell(withIdentifier: SavedPlaceCell.reuseIdentifier, for: indexPath)as! SavedPlaceCell
        cell.lblPlaceName.text = placeArray[indexPath.row]
        return cell
    }
    func setupLocalization(){
        lblSavedPlaces.text = "SavedPlaceVC_lblSavedPlaces".Localized()
        btnAddPlace.setTitle("SavedPlaceVC_btnAddPlace".Localized(), for: .normal)
    }
    //MARK: -IBActions
    
    @IBAction func btnAddPlaceTap(_ sender: Any) {
        let controller = AppStoryboard.Main.instance.instantiateViewController(withIdentifier: addNewDestinationViewController.storyboardID)
        self.navigationController?.pushViewController(controller, animated: true)
    }
    //MARK: -API Calls
}
class SavedPlaceCell:UITableViewCell{
    
    @IBOutlet weak var imgPlace: UIImageView!
    @IBOutlet weak var lblPlaceName: SavedPlacesLabel!
    override func awakeFromNib() {
        setupLocalization()
    }
    func setupLocalization(){
        lblPlaceName.text = "SavedPlaceVC_lblPlaceName".Localized()
    }
}
