//
//  MyOfferVC.swift
//  PickARide User
//
//  Created by baps on 15/12/20.
//  Copyright © 2020 EWW071. All rights reserved.
//

import UIKit

class MyOfferVC: BaseViewController {
    
    @IBOutlet weak var lblMyOffers: myofferLabel!
    @IBOutlet weak var textFieldOfferCode: MyOfferTextField!
    @IBOutlet weak var btnApply: MyofferScreenButton!
    @IBOutlet weak var tblMyOffers: UITableView!
    
    var promoCodeUserModel = PromoViewModel()
    var promoCodeList = [PromoDetailsModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
        self.setupLocalization()
        self.callApi()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarInViewController(controller: self, naviColor: colors.appColor.value, naviTitle: NavTitles.myOffers.value, leftImage: NavItemsLeft.back.value, rightImages: [NavItemsRight.none.value], isTranslucent: true, CommonViewTitles: [], isTwoLabels: false)
    }
}

//MARK:- Methods
extension MyOfferVC{
    func setUpUI(){
        tblMyOffers.delegate = self
        tblMyOffers.dataSource = self
        tblMyOffers.reloadData()
    }
    
    func setupLocalization(){
        lblMyOffers.text = "MyOfferVC_lblMyOffers".Localized()
        textFieldOfferCode.placeholder = "MyOfferVC_textFieldOfferCode".Localized()
        btnApply.setTitle("MyOfferVC_btnApply".Localized(), for: .normal)
    }
}

//MARK:- Apis
extension MyOfferVC{
    func callApi(){
        self.promoCodeUserModel.promoVC = self
        self.promoCodeUserModel.webservicePromoListApi()
    }
}

//MARK:- TableView Delegate
extension MyOfferVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.promoCodeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: myOfferCell = tblMyOffers.dequeueReusableCell(withIdentifier: myOfferCell.reuseIdentifier, for: indexPath) as? myOfferCell ?? myOfferCell()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.popViewController(animated: true)
    }
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
