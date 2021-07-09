//
//  addPaymentVC.swift
//  Adelante
//
//  Created by Apple on 07/12/20.
//  Copyright © 2020 EWW071. All rights reserved.
//

import UIKit

class AddPaymentVC: BaseViewController{
    
    @IBOutlet weak var tblPaymentMethod: UITableView!
    @IBOutlet weak var btnAddCard: submitButton!
    @IBOutlet weak var lblTitle: TitleLabel!
    
    var cardDetails : [String] = []
    var isFromSideMenu = false
    var selectedPaymentMethods = 1
    var isFromSchedulled : Bool = false
    
    var addPaymentUserModel = CardUserModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setLocalization()
        
        if Singleton.sharedInstance.CardList.count == 0{
            self.callCardListApi()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBarInViewController(controller: self, naviColor: colors.appColor.value, naviTitle: NavTitles.none.value, leftImage: isFromSideMenu ? NavItemsLeft.back.value : NavItemsLeft.cancel.value, rightImages: [isFromSideMenu ? NavItemsRight.Done.value : NavItemsRight.none.value], isTranslucent: true, CommonViewTitles: [], isTwoLabels: false)
        navBtnDone.addTarget(self, action: #selector(btnDonePaymentClicked(_:)), for: .touchUpInside)
    }
    
    func setLocalization() {
        lblTitle.text = "AddCardVC_lblPaymentMethod".Localized()
        btnAddCard.setTitle(self.isFromSideMenu ? "AddCardVC_lblAddCard".Localized().uppercased() : "SuggestedTaxiVC_btnBookNow".Localized(), for: .normal)
    }
    
    //MARK: -btnAction
    @IBAction func placeOrderBtn(_ sender: submitButton) {
        if isFromSchedulled{
            let controller = PaymentSucessFullyVC.instantiate(fromAppStoryboard: .Main)
            controller.dismissedClosour = {
                let controller = MyRidesVC.instantiate(fromAppStoryboard: .Main)
                self.navigationController?.pushViewController(controller, animated: true)
            }
            controller.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
            let navigationController = UINavigationController(rootViewController: controller)
            navigationController.modalPresentationStyle = .overCurrentContext
            navigationController.modalTransitionStyle = .crossDissolve
            navigationController.navigationBar.isHidden = true
            self.navigationController?.pushViewController(controller, animated: true)
        }else{
            let controller = PaymentSucessFullyVC.instantiate(fromAppStoryboard: .Main)
            
            controller.dismissedClosour = {
                self.navigationController?.popViewController(animated: false)
                NotificationCenter.default.post(name: .OpenCurrentRideDriverInfoVC, object: nil)
            }
            
            controller.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
            let navigationController = UINavigationController(rootViewController: controller)
            navigationController.modalPresentationStyle = .overCurrentContext
            navigationController.modalTransitionStyle = .crossDissolve
            navigationController.navigationBar.isHidden = true
            self.present(navigationController, animated: true, completion: nil)
        }
    }
    
    @IBAction func btnDonePaymentClicked(_ sender: submitButton) {
        if isFromSideMenu{
            let controller = AddCardVC.instantiate(fromAppStoryboard: .Main)
            self.navigationController?.pushViewController(controller, animated: true)
        }
        
    }
}

//MARK:- Apis
extension AddPaymentVC{
    func callCardListApi(){
        self.addPaymentUserModel.addPaymentVC = self
        self.addPaymentUserModel.webserviceCardListApi()
    }
    
    func callRemoveCardListApi(id: String){
        self.addPaymentUserModel.addPaymentVC = self
        
        let reqModel = CardListReqModel()
        reqModel.cardId = id
        
        self.addPaymentUserModel.webserviceRemoveCardApi(reqModel: reqModel)
    }
}

//MARK:- TableView Delegate
extension AddPaymentVC: UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 3 : 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? 100 : 0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 31 : 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            let headerView = UIView.init(frame: CGRect(x: 0, y: 0, width: tblPaymentMethod.frame.size.width, height: 31))
            headerView.backgroundColor = colors.white.value
            let label = UILabel()
            label.frame = CGRect(x: 16, y: 0, width:  headerView .frame.size.width, height: 19)
            // let label = UILabel.init(frame: )
            label.center.y = headerView.frame.size.height / 2
            label.text = "AddCardVC_lblChoosedesired".Localized()
            label.font = CustomFont.regular.returnFont(15)
            label.textColor = colors.loginPlaceHolderColor.value
            label.textAlignment = .left
            headerView.addSubview(label)
            return headerView
        default:
            let headerView = UIView.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
            
            return headerView
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            var cell = UITableViewCell()
            if indexPath.row == 0 {
                let cell1 = tblPaymentMethod.dequeueReusableCell(withIdentifier: paymentMethodCell1.reuseIdentifier, for: indexPath) as! paymentMethodCell1
                
                cell1.paymentImageView.image = UIImage(named: "ic_wallet")
                cell1.lblWallet.text = "AddCardVC_lblWallet".Localized()
                cell1.lblwalletBalance.text = "250.00"
                cell1.vWMain.layer.borderColor = colors.submitButtonColor.value.cgColor
                if indexPath.row == selectedPaymentMethods {
                    cell1.vWMain.layer.borderWidth = 1
                    //                    cell1.selectPaymentMethodButton.isHidden = false
                } else {
                    cell1.vWMain.layer.borderWidth = 0
                    //                    cell1.selectPaymentMethodButton.isHidden = true
                }
                cell = cell1
            } else {
                let cell2 = tblPaymentMethod.dequeueReusableCell(withIdentifier: paymentMethodCell2.reuseIdentifier, for: indexPath) as! paymentMethodCell2
                cell2.vWMain.layer.borderColor = colors.submitButtonColor.value.cgColor
                if indexPath.row == selectedPaymentMethods {
                    cell2.vWMain.layer.borderWidth = 1
                    cell2.selectPaymentMethodButton.isHidden = false
                } else {
                    cell2.vWMain.layer.borderWidth = 0
                    cell2.selectPaymentMethodButton.isHidden = true
                }
                if indexPath.row == 1
                {
                    cell2.paymentMethodImageView.image = UIImage(named: "ic_masterCard")
                    cell2.lblcardDetails.text = "**** **** **** 5967"
                    cell2.lblExpiresDate.text = "Expires 09/25"
                    
                } else if indexPath.row == 2 {
                    cell2.paymentMethodImageView.image = UIImage(named: "ic_visa")
                    cell2.lblcardDetails.text = "**** **** **** 3802"
                    cell2.lblExpiresDate.text = "Expires 10/27"
                    
                }
                cell = cell2
            }
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            if isFromSideMenu{
                if indexPath.row == 0 {
                    let controller = WalletHistoryVC.instantiate(fromAppStoryboard: .Main)
                    self.navigationController?.pushViewController(controller, animated: true)
                }
            }
            selectedPaymentMethods = indexPath.row
            tblPaymentMethod.reloadData()
        default:
            break
        }
    }
}

class paymentMethodCell1 : UITableViewCell {
    @IBOutlet weak var vWMain: PaymentView!
    @IBOutlet weak var lblWallet: addPaymentlable!
    @IBOutlet weak var lblwalletBalance: addPaymentlable!
    @IBOutlet weak var paymentImageView: UIImageView!
}

class paymentMethodCell2 : UITableViewCell {
    @IBOutlet weak var vWMain: PaymentView!
    @IBOutlet weak var selectPaymentMethodButton: UIButton!
    @IBOutlet weak var paymentMethodImageView: UIImageView!
    @IBOutlet weak var lblExpiresDate: addPaymentlable!
    @IBOutlet weak var lblcardDetails: addPaymentlable!
}
