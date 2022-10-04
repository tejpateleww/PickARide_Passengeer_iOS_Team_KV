//
//  addPaymentVC.swift
//  Adelante
//
//  Created by Apple on 07/12/20.
//  Copyright © 2020 EWW071. All rights reserved.
//

import UIKit

class AddPaymentVC: BaseViewController{
    
    static var newInstance: AddPaymentVC {
        AddPaymentVC.instantiate(fromAppStoryboard: .Payment)
    }
    
    //MARK:- ===== Outlets =======
    @IBOutlet weak var tblPaymentMethod: UITableView!
    @IBOutlet weak var btnAddCard: submitButton!
    @IBOutlet weak var lblTitle: TitleLabel!
    @IBOutlet weak var lblNoDataFound: themeLabel!
    
    
    //MARK:- ===== Variables =======
    var cardDetails : [String] = []
    var isFromSideMenu = false
    var selectedPaymentMethods = NSNotFound
    var selectCard = NSNotFound
    var isFromSchedulled : Bool = false
    var selectedTaxiType : EstimateFare!
    var addPaymentUserModel = CardUserModel()
    var bookingReqModel = BookingReqModel()
    var bookingAdded : (()->())?
    
    
    
    //MARK:- ===== View Controller Life Cycle =======
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setLocalization()
        
        if Singleton.sharedInstance.CardList.count == 0{
            self.callCardListApi()
        }
        tblPaymentMethod.registerNibWithCellType(CreditCardCell.self)
        tblPaymentMethod.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tblPaymentMethod.reloadData()
        setNavigationBarInViewController(controller: self, naviColor: colors.appColor.value, naviTitle: NavTitles.payment.value, leftImage: isFromSideMenu ? NavItemsLeft.back.value : NavItemsLeft.cancel.value, rightImages: [isFromSideMenu ? NavItemsRight.none.value : NavItemsRight.addCard.value], isTranslucent: false, CommonViewTitles: [], isTwoLabels: false)
            navBtnDone.addTarget(self, action: #selector(btnDonePaymentClicked(_:)), for: .touchUpInside)
    }
    
    func setLocalization() {
        lblTitle.text = "AddCardVC_lblPaymentMethod".Localized()
        lblNoDataFound.text = "Title_NoDataFound".Localized()
        btnAddCard.setTitle(self.isFromSideMenu ? "AddCardVC_lblAddCard".Localized().uppercased() : "PaymentVC_btnBookNow".Localized(), for: .normal)
    }
    
    //MARK: -btnAction
    @IBAction func placeOrderBtn(_ sender: submitButton) {
        if isFromSideMenu{
            let controller = AddCardVC.instantiate(fromAppStoryboard: .Payment)
            
            controller.addCardClosure = { [unowned self] in
                self.tblPaymentMethod.reloadData()
            }
            
            self.navigationController?.pushViewController(controller, animated: true)
        }else{
            guard selectedPaymentMethods == 0 || selectedPaymentMethods == 1 else {
                Toast.show(title: UrlConstant.Required, message: "Please select payment option", state: .failure)
                return
            }
            bookingReqModel.distance = "\(selectedTaxiType.distance ?? 0)"
            bookingReqModel.estimatedFare = "\(selectedTaxiType.estimateTripFare ?? 0)"
            bookingReqModel.noOfPassenger = selectedTaxiType.capacity
            bookingReqModel.vehicleTypeId =  selectedTaxiType.vehicleTypeId
           
            let Time = "\(selectedTaxiType.durationInMinute ?? 0):\(selectedTaxiType.durationInSecond ?? 0)"
            let newString = Time.replacingOccurrences(of: ":", with: ".", options: .literal, range: nil)
            
            bookingReqModel.tripDuration = String((Double(newString)?.round(to: 2))!)
            if selectedPaymentMethods == 1 {
                if selectCard == NSNotFound {
                    Toast.show(title: UrlConstant.Required, message: "Please select card", state: .failure)
                    return
                } else {
                    bookingReqModel.cardId = Singleton.sharedInstance.CardList[selectCard - 1].id
                }
            }
            bookingReqModel.paymentType = selectedPaymentMethods == 0 ? "wallet": "card"
            BookingRequestWebservice()
        }
    }
    
    //MARK:- ===== Payment btn click =======
    @IBAction func btnDonePaymentClicked(_ sender: submitButton) {
        if !isFromSideMenu{
            let controller = AddCardVC.instantiate(fromAppStoryboard: .Payment)
            
            controller.addCardClosure = { [unowned self] in
                self.tblPaymentMethod.reloadData()
            }
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    
    //MARK:- ====== Booking Request Webservice call =======
    func BookingRequestWebservice(){
        Utilities.showHud()
        WebServiceSubClass.BookingRequestApi(reqModel: bookingReqModel) { status, message, response, Error in
            Utilities.hideHud()
            if status {
                print(response)
                Toast.show(message: message, state: .success)
                if self.isFromSchedulled{
                    let controller = PaymentSucessFullyVC.instantiate(fromAppStoryboard: .Main)
                    controller.dismissedClosour = { [unowned self] in
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
                    
                    self.navigationController?.popViewController(animated: true)
                    if let bookingSuccess = self.bookingAdded {
                        bookingSuccess()
                    }
//                    let controller = PaymentSucessFullyVC.instantiate(fromAppStoryboard: .Main)
//                    controller.dismissedClosour = {
//                        if let bookingSuccess = self.bookingAdded {
//                            bookingSuccess()
//                        }
//                        self.navigationController?.popViewController(animated: false)
//                    }
//                    controller.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
//                    let navigationController = UINavigationController(rootViewController: controller)
//                    navigationController.modalPresentationStyle = .overCurrentContext
//                    navigationController.modalTransitionStyle = .crossDissolve
//                    navigationController.navigationBar.isHidden = true
//                    self.present(navigationController, animated: true, completion: nil)
                }
               
            
            }
            else {
                Toast.show(message: message, state: .failure)
            }
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
            cell1.lblwalletBalance.text = Singleton.sharedInstance.UserProfilData?.walletBalance?.toCurrencyString()
            cell1.vWMain.layer.borderColor = colors.submitButtonColor.value.cgColor
            cell1.vWMain.layer.borderWidth = indexPath.row == selectedPaymentMethods ? 1 : 0
            cell = cell1
        } else {
            let obj = Singleton.sharedInstance.CardList[indexPath.row - 1]
            let cell2 = tblPaymentMethod.dequeueReusableCell(withIdentifier: CreditCardCell.className, for: indexPath) as! CreditCardCell
            let isSelect = indexPath.row == selectCard
            cell2.configCell(obj, isSelected: isSelect)
            cell = cell2
        }
        return cell

    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isFromSideMenu{
            if indexPath.row == 0 {
                let controller = WalletHistoryVC.instantiate(fromAppStoryboard: .Payment)
                self.navigationController?.pushViewController(controller, animated: true)
            }
        }
        if indexPath.row == 0 {
            selectCard = NSNotFound
            selectedPaymentMethods = indexPath.row
        }
        else {
            selectedPaymentMethods = 1
            selectCard = indexPath.row
        }
        tblPaymentMethod.reloadData()
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .normal, title: "UrlConstant_Remove".Localized()) { (action, sourceView, completionHandler)  in
            let obj = Singleton.sharedInstance.CardList[indexPath.row - 1]
            self.callRemoveCardListApi(id: obj.id ?? "")
            completionHandler(true)
        }
        
        deleteAction.backgroundColor = ThemeColorEnum.ThemeRed.rawValue
        
        let cancelAction = UIContextualAction(style: .normal, title: "UrlConstant_Cancel".Localized()) { (action, sourceView, completionHandler)  in
            completionHandler(true)
        }
        
        return indexPath.row == 0 ? nil : UISwipeActionsConfiguration(actions: [deleteAction, cancelAction])
    }
}

extension Double {
    func round(to places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return Darwin.round(self * divisor) / divisor
    }
}



class paymentMethodCell1 : UITableViewCell {
    @IBOutlet weak var vWMain: PaymentView!
    @IBOutlet weak var lblWallet: addPaymentlable!
    @IBOutlet weak var lblwalletBalance: addPaymentlable!
    @IBOutlet weak var paymentImageView: UIImageView!
}
