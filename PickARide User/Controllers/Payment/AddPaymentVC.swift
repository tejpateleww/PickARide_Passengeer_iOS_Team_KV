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
    @IBOutlet weak var lblNoDataFound: themeLabel!
    
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
        
        self.tblPaymentMethod.reloadData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBarInViewController(controller: self, naviColor: colors.appColor.value, naviTitle: NavTitles.none.value, leftImage: isFromSideMenu ? NavItemsLeft.back.value : NavItemsLeft.cancel.value, rightImages: [isFromSideMenu ? NavItemsRight.none.value : NavItemsRight.addCard.value], isTranslucent: true, CommonViewTitles: [], isTwoLabels: false)
        navBtnDone.addTarget(self, action: #selector(btnDonePaymentClicked(_:)), for: .touchUpInside)
    }
    
    func setLocalization() {
        lblTitle.text = "AddCardVC_lblPaymentMethod".Localized()
        lblNoDataFound.text = "Title_NoDataFound".Localized()
        btnAddCard.setTitle(self.isFromSideMenu ? "AddCardVC_lblAddCard".Localized().uppercased() : "SuggestedTaxiVC_btnBookNow".Localized(), for: .normal)
    }
    
    //MARK: -btnAction
    @IBAction func placeOrderBtn(_ sender: submitButton) {
        if isFromSideMenu{
            let controller = AddCardVC.instantiate(fromAppStoryboard: .Main)
            
            controller.addCardClosure = {
                self.tblPaymentMethod.reloadData()
            }
            
            self.navigationController?.pushViewController(controller, animated: true)
        }else{
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
    }
    
    @IBAction func btnDonePaymentClicked(_ sender: submitButton) {
        if !isFromSideMenu{
            let controller = AddCardVC.instantiate(fromAppStoryboard: .Main)
            
            controller.addCardClosure = {
                self.tblPaymentMethod.reloadData()
            }
            
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Singleton.sharedInstance.CardList.count + 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 31
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
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
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        var cell = UITableViewCell()
        if indexPath.row == 0 {
            let cell1 = tblPaymentMethod.dequeueReusableCell(withIdentifier: paymentMethodCell1.reuseIdentifier, for: indexPath) as? paymentMethodCell1 ?? paymentMethodCell1()
            
            cell1.paymentImageView.image = getCardTypeImage(type: PaymentsCardsTypesName.wallet.rawValue)
            cell1.lblWallet.text = "AddCardVC_lblWallet".Localized()
            cell1.lblwalletBalance.text = Singleton.sharedInstance.UserProfilData?.walletBalance ?? "0"
            cell1.vWMain.layer.borderColor = colors.submitButtonColor.value.cgColor
            cell1.vWMain.layer.borderWidth = indexPath.row == selectedPaymentMethods ? 1 : 0
            cell = cell1
        } else {
            let obj = Singleton.sharedInstance.CardList[indexPath.row - 1]
            
            let cell2 = tblPaymentMethod.dequeueReusableCell(withIdentifier: paymentMethodCell2.reuseIdentifier, for: indexPath) as? paymentMethodCell2 ?? paymentMethodCell2()
            
            let isSelect = indexPath.row == selectedPaymentMethods
            cell2.vWMain.layer.borderColor = colors.submitButtonColor.value.cgColor
            cell2.vWMain.layer.borderWidth = isSelect ? 1 : 0
            cell2.selectPaymentMethodButton.isHidden = !isSelect
            
            cell2.paymentMethodImageView.image = getCardTypeImage(type: obj.cardType ?? "")
            cell2.lblcardDetails.text = obj.formatedCardNo ?? ""
            cell2.lblExpiresDate.text = "\(UrlConstant.Expiry) \(obj.expiryMonth ?? "")/\(obj.expiryYear ?? "")"
            
            cell = cell2
        }
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isFromSideMenu{
            if indexPath.row == 0 {
                let controller = WalletHistoryVC.instantiate(fromAppStoryboard: .Main)
                self.navigationController?.pushViewController(controller, animated: true)
            }
        }
        selectedPaymentMethods = indexPath.row
        tblPaymentMethod.reloadData()
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
