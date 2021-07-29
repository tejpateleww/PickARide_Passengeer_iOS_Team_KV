//
//  SavedPlaceVC.swift
//  PickARide User
//
//  Created by baps on 17/12/20.
//  Copyright © 2020 EWW071. All rights reserved.
//

import UIKit

class SavedPlaceVC: BaseViewController {
    //MARK: -Properties
      var placeArray = [SettingsTitle.Home, SettingsTitle.Work]
    var placeImages = [SettingImages.SettingHome, SettingImages.SettingWork]
    //MARK: -IBOutlets
    
    
    @IBOutlet weak var lblSavedPlaces: SavedPlacesLabel!
    @IBOutlet weak var btnAddPlace: SavedPlaceButton!
    @IBOutlet weak var tblSavedPlaces: UITableView!
    
    //MARK: -View Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
        self.setupLocalization()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarInViewController(controller: self, naviColor: colors.submitButtonColor.value, naviTitle: NavTitles.savedPlaces.value, leftImage: NavItemsLeft.cancel.value, rightImages: [NavItemsRight.none.value], isTranslucent: true, CommonViewTitles: [], isTwoLabels: false)
    }
    
    @IBAction func btnAddPlaceTap(_ sender: Any) {
        let controller = AddNewDestinationVC.instantiate(fromAppStoryboard: .Main)
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

//MARK:- Methods
extension SavedPlaceVC{
    func setUpUI(){
        self.tblSavedPlaces.delegate = self
        self.tblSavedPlaces.dataSource = self
        self.tblSavedPlaces.reloadData()
    }
    
    func setupLocalization(){
        lblSavedPlaces.text = "SavedPlaceVC_lblSavedPlaces".Localized()
        btnAddPlace.setTitle("SavedPlaceVC_btnAddPlace".Localized(), for: .normal)
    }
}

//MARK:- TableView Delegate
extension SavedPlaceVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placeArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:SavedPlaceCell = tblSavedPlaces.dequeueReusableCell(withIdentifier: SavedPlaceCell.reuseIdentifier, for: indexPath)as! SavedPlaceCell
        cell.lblPlaceName.text = placeArray[indexPath.row]
        cell.imgPlace.image = placeImages[indexPath.row]
        return cell
    }
}

class SavedPlaceCell: UITableViewCell{
    
    @IBOutlet weak var imgPlace: UIImageView!
    @IBOutlet weak var lblPlaceName: SavedPlacesLabel!
    
    override func awakeFromNib() {
        setupLocalization()
    }
    
    func setupLocalization(){
        lblPlaceName.text = "SavedPlaceVC_lblPlaceName".Localized()
    }
}
