//
//  walletHistoryViewController.swift
//  PickARide User
//
//  Created by Apple on 18/12/20.
//  Copyright © 2020 EWW071. All rights reserved.
//

import UIKit

class WalletHistoryVC: BaseViewController{
    @IBOutlet weak var lblTotalMoney: walletHistoryLabel!
    @IBOutlet weak var lblAvailableBalance: walletHistoryLabel!
    @IBOutlet weak var lblPaymentMethod: TitleLabel!
    @IBOutlet weak var tblWalletHistory: UITableView!
    @IBOutlet weak var lblNoDataFound: themeLabel!

    var walletObj : WalletHistoryModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setLocalization()
        self.callApi()
    }
    
    lazy var addWalletButton = UIButton(type: .system)
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarInViewController(controller: self, naviColor: colors.appColor.value, naviTitle: NavTitles.wallet.value, leftImage: NavItemsLeft.back.value, rightImages: [NavItemsRight.none.value], isTranslucent: true, CommonViewTitles: [], isTwoLabels: false)
        addWalletButton.addTarget(self, action: #selector(self.addWalletTapped), for: .touchUpInside)
        addWalletButton.setTitle("Add Wallet", for: .normal)
        addWalletButton.setTitleColor(ThemeColorEnum.Theme.rawValue, for: .normal)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: addWalletButton)
        self.lblTotalMoney.text = Singleton.sharedInstance.availableWalletBalance?.toCurrencyString()
    }
    
    @objc private func addWalletTapped() {
        let vc = AddWalletVC.instantiate(fromAppStoryboard: .Payment)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK:- Methods
extension WalletHistoryVC{
    func setLocalization() {
        lblAvailableBalance.text = "WalletHistory_lblAvailableBalance".Localized()
//        lblPaymentMethod.text = "WalletHistory_lblPayment".Localized()
        lblNoDataFound.text = "Title_NoDataFound".Localized()
    }
}

//MARK:- Apis
extension WalletHistoryVC{
    
    func callApi(){
        self.webserviceWalletHistory(reqModel: WalletHistoryRequestModel())
    }
    
    func webserviceWalletHistory(reqModel: WalletHistoryRequestModel){
        Utilities.showHud()
        WebServiceSubClass.WalletHistoryApi(reqModel: reqModel) { (status, apiMessage, response, error) in
            Utilities.hideHud()
            if status{
                self.walletObj = response
                self.lblTotalMoney.text = response?.walletBalance?.toCurrencyString()
                Singleton.sharedInstance.availableWalletBalance = response?.walletBalance
                Singleton.sharedInstance.UserProfilData?.walletBalance = response?.walletBalance
                self.tblWalletHistory.reloadData()
            }
            
            self.lblNoDataFound.isHidden = response?.data?.count != 0
        }
    }
    
    func webserviceAddMoneyA(reqModel: AddMoneyRequestModel){
        Utilities.showHud()
    }
}

//MARK:- TableView Delegate
extension WalletHistoryVC: UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.walletObj?.data?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tblWalletHistory.dequeueReusableCell(withIdentifier: WalletHistoryCell.reuseIdentifier, for: indexPath) as? WalletHistoryCell ?? WalletHistoryCell()

        let obj = self.walletObj?.data?[indexPath.row]
        let isAdd = obj?.type == plus
        cell.lblmoneyFrom.text = obj?.datumDescription ?? ""
        cell.lblDate.text = obj?.createdDate?.getDateTimeFromTimeStamp()
        cell.lblPrice.text = (isAdd ? plus : minus) + (obj?.amount ?? "")
        cell.lblPrice.textColor = isAdd ? ThemeColorEnum.ThemeGreen.rawValue : ThemeColorEnum.ThemeRed.rawValue
        cell.selectionStyle = .none

        return cell
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 34
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 34))
        let label = UILabel()
        label.frame = CGRect.init(x: 32, y: 0, width: headerView.frame.width, height: 20)
        label.text = "WalletHistory_lblRecentHistory".Localized()
        label.font = CustomFont.bold.returnFont(18)
        label.textColor = colors.loginPlaceHolderColor.value// colors.black.value
        headerView.backgroundColor = colors.white.value
        headerView.addSubview(label)
        return headerView
    }
}

class WalletHistoryCell : UITableViewCell {
    @IBOutlet weak var lblmoneyFrom : walletHistoryLabel!
    @IBOutlet weak var lblDate : walletHistoryLabel!
    @IBOutlet weak var lblPrice : walletHistoryLabel!
}
