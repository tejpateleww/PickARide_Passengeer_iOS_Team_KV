//
//  AddCardVC.swift
//  Adelante
//
//  Created by Apple on 07/12/20.
//  Copyright © 2020 EWW071. All rights reserved.
//

import UIKit
import FormTextField

class AddCardVC: BaseViewController {
    
    @IBOutlet weak var lblAddCard : TitleLabel!
    @IBOutlet weak var LblName : addCardLabel!
    @IBOutlet weak var LblCreditCardNumber : addCardLabel!
    @IBOutlet weak var LblExpires : addCardLabel!
    @IBOutlet weak var LblCVV : addCardLabel!
    @IBOutlet weak var LblCountry : addCardLabel!
    @IBOutlet weak var LblDebitCardAreAcceptedDescription : addCardLabel!
    @IBOutlet weak var txtName : FormTextField!
    @IBOutlet weak var txtCardNumber : FormTextField!
    @IBOutlet weak var txtExpires : FormTextField!
    @IBOutlet weak var txtCVV : FormTextField!
    @IBOutlet weak var txtCountry : UITextField!
    @IBOutlet weak var btnSave : submitButton!
    @IBOutlet weak var imgCardType: UIImageView!

    var creditCardValidator: CreditCardValidator!
    var validation = Validation()
    var inputValidator = InputValidator()
    let monthPicker = MonthYearPickerView()
    
    var cardTypeLabel = String()
    var isCreditCardValid = Bool()
    
    var pickerView = UIPickerView()
    var selectedIndexOfPicker = Int()
    
    var monthYearTuple : (month: String?, year: String?) = (nil,nil)
    var addCardUserModel = CardUserModel()
    
    var addCardClosure : (()->())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
        self.setLocalization()
        
        if Singleton.sharedInstance.CountryList.count == 0{
            WebServiceSubClass.GetCountryList {_, _, _, _ in}
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarInViewController(controller: self, naviColor: colors.appColor.value, naviTitle: NavTitles.addCard.value, leftImage: NavItemsLeft.back.value, rightImages: [NavItemsRight.none.value], isTranslucent: true, CommonViewTitles: [], isTwoLabels: false)
    }
    
    @IBAction func placeOrderBtn(_ sender: submitButton) {
        if !isValidatePaymentDetail().0{
            Toast.show(title: UrlConstant.Required, message: isValidatePaymentDetail().1, state: .failure)
            return
        }
        if isCreditCardValid{
            self.callApi()
        }
    }
}

//MARK:- Set Up UI
extension AddCardVC{
    func setUpUI(){
        self.txtExpires.delegate = self
        self.creditCardValidator = CreditCardValidator()
        self.setValidation()
        
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        self.pickerView.showsSelectionIndicator = true
        
        self.txtCountry.delegate = self
        self.txtCountry.inputView = pickerView
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.barTintColor = .black
        toolBar.barTintColor = .white
        toolBar.tintColor = themeColor
        toolBar.sizeToFit()
        let done = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneAction))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelAction))
        toolBar.setItems([cancel,space,done], animated: false)
        
        self.txtCountry.inputAccessoryView = toolBar
    }
    
    func setLocalization() {
        lblAddCard.text = "AddCardVC_lblAddCard".Localized()
        LblName.text = "AddCardVC_LblName".Localized()
        LblCreditCardNumber.text = "AddCardVC_LblCreditCardNumber".Localized()
        LblExpires.text = "AddCardVC_LblExpires".Localized()
        LblCVV.text = "AddCardVC_LblCVV".Localized()
        LblCountry.text = "AddCardVC_LblCountry".Localized()
        LblDebitCardAreAcceptedDescription.text = "AddCardVC_LblDebitCardAreAcceptedDescription".Localized()
        txtName.placeholder = "AddCardVC_TextFieldName_place".Localized()
        txtCardNumber.placeholder = "AddCardVC_TextFieldCreditCardNumber_place".Localized()
        txtExpires.placeholder = "AddCardVC_TextFieldExpires_place".Localized()
        txtCVV.placeholder = "AddCardVC_TextFieldCVV_place".Localized()
        txtCountry.placeholder = "AddCardVC_TextFieldCountry_place".Localized()
        btnSave.setTitle("AddCardVC_btnSave".Localized(), for: .normal)
    }
    
    @objc func cancelAction(_ sender: UIBarButtonItem) {
        self.txtCountry.endEditing(true)
    }
    
    @objc func doneAction(_ sender: UIBarButtonItem) {
        self.txtCountry.text = Singleton.sharedInstance.CountryList[self.selectedIndexOfPicker].name
        self.txtCountry.endEditing(true)
    }
}

//MARK:- Api
extension AddCardVC{
    func callApi(){
        if !isValidatePaymentDetail().0{
            Toast.show(title: UrlConstant.Required, message: isValidatePaymentDetail().1, state: .failure)
            return
        }
        if isCreditCardValid{
            self.addCardUserModel.addCardVC = self
            
            let reqModel = AddCardReqModel()
            reqModel.cardNo = (self.txtCardNumber.text ?? "").replacingOccurrences(of: " ", with: "")
            reqModel.cardHolderName = self.txtName.text ?? ""
            reqModel.cvv = self.txtCVV.text ?? ""
            reqModel.expiryYear = self.monthYearTuple.year
            reqModel.expiryMonth = self.monthYearTuple.month
            
            self.addCardUserModel.webserviceAddCardApi(reqModel: reqModel)
        }else{
            
        }
    }
}

//MARK:- Card Validation
extension AddCardVC{
    func validateCardNumber(number: String) {
        if creditCardValidator.validate(string: number) {
            isCreditCardValid = true
        } else {
            isCreditCardValid = false
        }
    }
    
    func CvvValidation() {
        
        txtCVV.inputType = .integer
        if self.cardTypeLabel == "amex" {
            self.validation.maximumLength = 4
            self.validation.minimumLength = 4
        }
        else {
            self.validation.maximumLength = 3
            self.validation.minimumLength = 3
        }
        validation.characterSet = NSCharacterSet.decimalDigits
        let inputValidator = InputValidator(validation: validation)
        txtCVV.inputValidator = inputValidator
    }
    
    func isValidatePaymentDetail() -> (Bool,String) {
        var ValidatorMessage : String?
        
        let cardHolderName = self.txtName.validatedText(validationType: .username(field: txtName.placeholder?.lowercased() ?? ""))
        let cardNumber = self.txtCardNumber.validatedText(validationType: .requiredField(field: txtCardNumber.placeholder?.lowercased() ?? ""))
        let expiryDt = self.txtExpires.validatedText(validationType: .requiredField(field: txtExpires.placeholder?.lowercased() ?? ""))
        let cvv = self.txtCVV.validatedText(validationType: .requiredField(field: txtCVV.placeholder?.lowercased() ?? ""))
        let country = self.txtCountry.validatedText(validationType: .requiredField(field: txtCountry.placeholder?.lowercased() ?? ""))
        
        if !cardHolderName.0 {
            ValidatorMessage = cardHolderName.1
            
        }else if !cardNumber.0 {
            ValidatorMessage = cardNumber.1
            
        }else if !isCreditCardValid {
            ValidatorMessage = UrlConstant.InvalidCardNumber
        }
        else if !expiryDt.0 {
            ValidatorMessage = expiryDt.1
        }
        else if !cvv.0 {
            ValidatorMessage = cvv.1
        }
        else if !country.0 {
            ValidatorMessage = country.1
        }
        
        if let str = ValidatorMessage{
            return(false, str)
        }
        return (true,"")
    }
    
    func setValidation () {
        //Card Name
        txtName.inputType = .name
        
        //Card Number
        txtCardNumber.inputType = .integer
        txtCardNumber.formatter = CardNumberFormatter()
        validation.maximumLength = 19
        validation.minimumLength = 14
        let characterSet = NSMutableCharacterSet.decimalDigit()
        characterSet.addCharacters(in: " ")
        validation.characterSet = characterSet as CharacterSet
        inputValidator = InputValidator(validation: validation)
        txtCardNumber.inputValidator = inputValidator
        txtExpires.inputView = monthPicker
        
        // Expiry Date
        txtExpires.inputType = .integer
        txtExpires.formatter = CardExpirationDateFormatter()
        
        validation.minimumLength = 1
        
        // CVV
        self.CvvValidation()
    }
    
    @IBAction func txtCardNumberEditingChange(_ sender: UITextField) {
        if let number = sender.text {
            if number.isEmpty {
                isCreditCardValid = false
                self.txtCardNumber.textColor = UIColor.black
//                self.imgvCardType.image = nil
            } else {
                validateCardNumber(number: number)
                detectCardNumberType(number: number)
            }
        }
    }
    
    func detectCardNumberType(number: String) {
        if let type = creditCardValidator.type(from: number) {
            isCreditCardValid = true
            self.cardTypeLabel = type.name.lowercased()
            print(type.name.lowercased())
            
            switch type.name.lowercased() {
            case "visa":
                imgCardType.image = UIImage(assetIdentifier: .visa)
            case "amex":
                imgCardType.image = UIImage(assetIdentifier: .amex)
            case "diners club":
                imgCardType.image = UIImage(assetIdentifier: .dinersClub)
            case "discover":
                imgCardType.image = UIImage(assetIdentifier: .discover)
            case "jcb":
                imgCardType.image = UIImage(assetIdentifier: .jcb)
            case "maestro" :
                imgCardType.image = UIImage(assetIdentifier: .maestro)
            case "mastercard":
                imgCardType.image = UIImage(assetIdentifier: .master)
            default:
                imgCardType.image = UIImage(assetIdentifier: .none)
            }
            self.txtCardNumber.textColor = ThemeColorEnum.Theme.rawValue
            self.CvvValidation()
        } else {
            isCreditCardValid = false
            self.cardTypeLabel = "Undefined"
        }
    }
}

// MARK:- UITextFieldDelegate
extension AddCardVC : UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if(textField == self.txtExpires) {
            var strMonth = "\(monthPicker.month)" as String
            if(monthPicker.month <= 9)
            {
                strMonth = "0\(monthPicker.month)"
            }

            let yearStr = "\(monthPicker.year)".dropFirst(2)
            monthYearTuple = (strMonth,"\(yearStr)")
            self.txtExpires.text = "\(strMonth)/\(yearStr)"
        }
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == self.txtCountry{
            if Singleton.sharedInstance.CountryList.count == 0{
                DispatchQueue.global(qos: .background).async {
                    WebServiceSubClass.GetCountryList {_, _, _, _ in}
                }
            }
            return Singleton.sharedInstance.CountryList.count != 0
        }
        return true
    }
}

//MARK:- Language Picker Set Up
extension AddCardVC : UIPickerViewDelegate,UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Singleton.sharedInstance.CountryList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Singleton.sharedInstance.CountryList[row].name
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedIndexOfPicker = row
    }
}
