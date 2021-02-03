//
//  MyOfferVC.swift
//  PickARide User
//
//  Created by baps on 15/12/20.
//  Copyright © 2020 EWW071. All rights reserved.
//

import UIKit

class MyOfferVC: BaseViewController,UITableViewDelegate,UITableViewDataSource {
    
    //MARK: -Properties
      
    //MARK: -IBOutlets
    
    
    @IBOutlet weak var lblMyOffers: myofferLabel!
    @IBOutlet weak var textFieldOfferCode: MyOfferTextField!
    @IBOutlet weak var btnApply: MyofferScreenButton!
    @IBOutlet weak var tblMyOffers: UITableView!
    
    //MARK: -View Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        tblMyOffers.delegate = self
        tblMyOffers.dataSource = self
        tblMyOffers.reloadData()
        setupLocalization()
        
        setNavigationBarInViewController(controller: self, naviColor: colors.appColor.value, naviTitle: NavTitles.none.value, leftImage: NavItemsLeft.back.value, rightImages: [NavItemsRight.none.value], isTranslucent: true, CommonViewTitles: [])
    }
    
    //MARK: -Other Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:myOfferCell = tblMyOffers.dequeueReusableCell(withIdentifier: myOfferCell.reuseIdentifier, for: indexPath) as! myOfferCell
        return cell
    }
    func setupLocalization(){
        lblMyOffers.text = "MyOfferVC_lblMyOffers".Localized()
        textFieldOfferCode.placeholder = "MyOfferVC_textFieldOfferCode".Localized()
        btnApply.setTitle("MyOfferVC_btnApply".Localized(), for: .normal)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = AppStoryboard.Main.instance.instantiateViewController(withIdentifier: MyRidesVC.storyboardID)
        self.navigationController?.pushViewController(controller, animated: true)
    }
    //MARK: -IBActions
    
    //MARK: -API Calls
}
class myOfferCell:UITableViewCell{
    @IBOutlet weak var lblOffers: myofferLabel!
    @IBOutlet weak var lblValidto: myofferLabel!
    @IBOutlet weak var btnUsenow: MyofferScreenButton!
    override func awakeFromNib() {
        setupLocalization()
    }
    func setupLocalization(){
        lblOffers.text = "MyOfferVC_lblOffers".Localized()
        lblValidto.text = "MyOfferVC_lblValidto".Localized()
        btnUsenow.setTitle("MyOfferVC_btnUsenow".Localized(), for: .normal)
    }
}
