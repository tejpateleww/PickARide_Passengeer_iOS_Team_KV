//
//  walletHistoryViewController.swift
//  PickARide User
//
//  Created by Apple on 18/12/20.
//  Copyright © 2020 EWW071. All rights reserved.
//

import UIKit

class WalletHistoryVC: BaseViewController,UITableViewDelegate,UITableViewDataSource {
    //MARK: -Properties
    
    //MARK: -IBOutlets
    
    @IBOutlet weak var lblTotalMoney: walletHistoryLabel!
    @IBOutlet weak var lblAvailableBalance: walletHistoryLabel!
    @IBOutlet weak var lblPaymentMethod: TitleLabel!
    @IBOutlet weak var tblWalletHistory: UITableView!
    //MARK: -View Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLocalization()
        
        setNavigationBarInViewController(controller: self, naviColor: colors.appColor.value, naviTitle: NavTitles.none.value, leftImage: NavItemsLeft.back.value, rightImages: [NavItemsRight.none.value], isTranslucent: true, CommonViewTitles: [], isTwoLabels: false)
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    //MARK: -other methods
    func setLocalization() {
        lblAvailableBalance.text = "WalletHistory_lblAvailableBalance".Localized()
        lblPaymentMethod.text = "WalletHistory_lblPayment".Localized()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
            return 3
       
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
            let cell = tblWalletHistory.dequeueReusableCell(withIdentifier: WalletHistoryCell.reuseIdentifier, for: indexPath) as! WalletHistoryCell
            cell.lblmoneyFrom.text = "Refund from Order #15421"
            cell.lblDate.text = "12/10/2020  01:55PM"
            cell.lblPrice.text = "+52.00"
            cell.selectionStyle = .none
            if indexPath.row == 1
            {
                cell.lblmoneyFrom.text = "Payment Done"
                cell.lblPrice.text = "- 30.00"
                cell.lblPrice.textColor = UIColor(hexString: "#E24444")
            }
       
        
        
        
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
  
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    //MARK: -IBActions
    
    
    //MARK: -API Calls
    
    
    
    
    
    

}
class WalletHistoryCell : UITableViewCell {
    @IBOutlet weak var lblmoneyFrom : walletHistoryLabel!
    @IBOutlet weak var lblDate : walletHistoryLabel!
    @IBOutlet weak var lblPrice : walletHistoryLabel!
}
