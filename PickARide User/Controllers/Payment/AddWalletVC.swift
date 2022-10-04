//
//  AddWalletVC.swift
//  PickaRideDriver
//
//  Created by Gaurang on 01/09/22.
//

import UIKit

class AddWalletVC: BaseViewController {
    
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var amountTextfield: UITextField!
    @IBOutlet weak var buttonStack: UIStackView!
    @IBOutlet weak var submitButton: themeButton!
    @IBOutlet weak var cardTableView: ContentSizedTableView!
    
    private var selectedCardIndex: Int {
        self.cardTableView.indexPathForSelectedRow?.row ?? 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setValues()
    }
    
    private func setupUI() {
        setNavigationBarInViewController(controller: self, naviColor: colors.white.value,
                                         naviTitle: "Add Wallet",
                                         leftImage: NavItemsLeft.back.value,
                                         rightImages: [], isTranslucent: false,
                                         CommonViewTitles: [], isTwoLabels: false)
        cardTableView.registerNibWithCellType(CreditCardCell.self)
        balanceLabel.text = Singleton.sharedInstance.availableWalletBalance?.toCurrencyString()
        setupAmountTextField()
        setupAmountButtons()
        DispatchQueue.main.async {
            self.cardTableView.selectRow(at: IndexPath(row: self.selectedCardIndex, section: 0), animated: true, scrollPosition: .none)
        }
    }
    
    private func setupAmountTextField() {
        amountTextfield.font = CustomFont.medium.returnFont(24)
        amountTextfield.layer.cornerRadius = 6
        let label = UILabel(frame: .zero)
        label.text = Singleton.sharedInstance.currencySymbol
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.textColor = .lightGray
        label.textAlignment = .center
        label.sizeToFit()
        amountTextfield.leftView = label
        label.translatesAutoresizingMaskIntoConstraints = false
        label.widthAnchor.constraint(equalToConstant: 50).isActive = true
        amountTextfield.leftViewMode = .always
    }
    
    private func setupAmountButtons() {
        let amounts = [10, 20, 30]
        for amount in amounts {
            let button = UIButton(type: .system)
            button.tag = amount
            button.setTitle("+\(amount)", for: .normal)
            button.titleLabel?.font = CustomFont.medium.returnFont(16)
            button.setTitleColor(themeColor, for: .normal)
            button.layer.borderColor = themeColor.cgColor
            button.layer.borderWidth = 1.5
            button.layer.cornerRadius = 6
            button.translatesAutoresizingMaskIntoConstraints = false
            buttonStack.addArrangedSubview(button)
            button.widthAnchor.constraint(equalToConstant: 80).isActive = true
            button.addTarget(self, action: #selector(amountTapped(_:)), for: .touchUpInside)
            
        }
        buttonStack.addArrangedSubview(UIView())
    }
    
    private func setValues() {
       // balanceLabel.text = SingletonClass.sharedInstance.balance?.toCurrencyString()
    }
    
    @IBAction func submitTapped() {
        let amount = amountTextfield.text ?? ""
        guard amount.isEmpty == false else {
            return
        }
        Utilities.showHud()
        let model = AddMoneyRequestModel(cardId: Singleton.sharedInstance.CardList[selectedCardIndex].id ?? "", amount: amount)
        WebServiceSubClass.AddMoneyApi(reqModel: model) { (status, _, model, _) in
            Utilities.hideHud()
            if status {
                if let balance = model?.walletBalance {
                    Singleton.sharedInstance.availableWalletBalance = String(balance)
                }
                
            }
            let okAction = UIAlertAction(title: "OK", style: .default) {[unowned self] _ in
                if status {
                    self.navigationController?.popViewController(animated: true)
                }
            }
            let alertCtr = UIAlertController(title: AppName, message: model?.message, preferredStyle: .alert)
            alertCtr.addAction(okAction)
            self.present(alertCtr, animated: true)
        }
    }
    
    @objc private func amountTapped(_ sender: UIButton) {
        let amount = Double(sender.tag) 
        let inputAmount = Double(amountTextfield.text ?? "") ?? 0
        amountTextfield.text = String(amount + inputAmount)
    }
    
}

// MARK: - TableView Cell

extension AddWalletVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Singleton.sharedInstance.CardList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let obj = Singleton.sharedInstance.CardList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: CreditCardCell.className, for: indexPath) as! CreditCardCell
        let isSelect = indexPath.row == selectedCardIndex
        cell.configCell(obj, isSelected: isSelect)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? CreditCardCell else {
            return
        }
        UIView.animate(withDuration: 0.3) {
            cell.manageTableSelection(true)
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? CreditCardCell else {
            return
        }
        UIView.animate(withDuration: 0.3) {
            cell.manageTableSelection(false)
        }
    }
}
