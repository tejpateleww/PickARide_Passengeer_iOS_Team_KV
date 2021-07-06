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
    @IBOutlet weak var TextFieldName : FormTextField!
    @IBOutlet weak var TextFieldCreditCardNumber : FormTextField!
    @IBOutlet weak var TextFieldExpires : FormTextField!
    @IBOutlet weak var TextFieldCVV : FormTextField!
    @IBOutlet weak var TextFieldCountry : addCarddetailsTextField!
    @IBOutlet weak var btnSave : submitButton!

    var creditCardValidator: CreditCardValidator!
    var validation = Validation()
    var inputValidator = InputValidator()
    let monthPicker = MonthYearPickerView()
    
    var isCreditCardValid = false
    var cardTypeLabel = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
        self.setLocalization()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setGeneralFormatting(for: self.TextFieldName)
        self.setUpNameTextField()
        
        self.setGeneralFormatting(for: self.TextFieldCreditCardNumber)
        self.setUpCardNumTextField()
        
        self.setGeneralFormatting(for: self.TextFieldExpires)
        self.setUpCardExpiryTextField()
        
        self.setGeneralFormatting(for: self.TextFieldCVV)
        self.setUpCardCVVTextfield()
    }
    
    @IBAction func placeOrderBtn(_ sender: submitButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

//MARK:- Set Up UI
extension AddCardVC{
    func setUpUI(){
        self.setNavigationBarInViewController(controller: self, naviColor: colors.appColor.value, naviTitle: NavTitles.none.value, leftImage: NavItemsLeft.back.value, rightImages: [NavItemsRight.none.value], isTranslucent: true, CommonViewTitles: [], isTwoLabels: false)
        
        creditCardValidator = CreditCardValidator()
    }
    
    func setLocalization() {
        lblAddCard.text = "AddCardVC_lblAddCard".Localized()
        LblName.text = "AddCardVC_LblName".Localized()
        LblCreditCardNumber.text = "AddCardVC_LblCreditCardNumber".Localized()
        LblExpires.text = "AddCardVC_LblExpires".Localized()
        LblCVV.text = "AddCardVC_LblCVV".Localized()
        LblCountry.text = "AddCardVC_LblCountry".Localized()
        LblDebitCardAreAcceptedDescription.text = "AddCardVC_LblDebitCardAreAcceptedDescription".Localized()
        TextFieldName.placeholder = "AddCardVC_TextFieldName_place".Localized()
        TextFieldCreditCardNumber.placeholder = "AddCardVC_TextFieldCreditCardNumber_place".Localized()
        TextFieldExpires.placeholder = "AddCardVC_TextFieldExpires_place".Localized()
        TextFieldCVV.placeholder = "AddCardVC_TextFieldCVV_place".Localized()
        TextFieldCountry.placeholder = "AddCardVC_TextFieldCountry_place".Localized()
        btnSave.setTitle("AddCardVC_btnSave".Localized(), for: .normal)
    }
    
    func setData() {
        TextFieldName.text = "Shane Mendoza"
        TextFieldCreditCardNumber.text = "**** - **** -  **** - **85"
        TextFieldExpires.text = "10/2030"
        TextFieldCVV.text = "****"
        TextFieldCountry.text = "Germany"
    }
}

extension AddCardVC {
    
    @IBAction func txtCardNumberEditingChange(_ sender: UITextField) {
        if let number = sender.text {
            if number.isEmpty {
                isCreditCardValid = false
                //                   self.btnVisa.isSelected = false
                //                   self.btnMasterCard.isSelected = false
                //                   self.btnAmerican.isSelected = false
                //                   self.btnJCB.isSelected = false
                //                   self.btnDiscover.isSelected = false
                //                   self.btnDiner.isSelected = false
                self.TextFieldCreditCardNumber.textColor = UIColor.black
                self.imgvCardType.image = nil
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
            self.txtCardNumber.textColor =
            self.setUpCardCVVTextfield()
            self.imgvCardType.image = getCardTypeImage(type: self.cardTypeLabel)
        } else {
            isCreditCardValid = false
            self.cardTypeLabel = "Undefined"
            self.imgvCardType.image = nil
        }
    }
    
    func validateCardNumber(number: String) {
        if creditCardValidator.validate(string: number) {
            isCreditCardValid = true
            
        } else {
            isCreditCardValid = false
            self.imgvCardType.image = nil
            
        }
    }
    
    func setGeneralFormatting(for textField: FormTextField) {
        
        //        textField.clearButtonMode = .never
        textField.clearButtonMode = .never
        textField.font = FontBook.
        textField.textColor = .black
        textField.backgroundColor = ThemeColor.textFieldBg
        textField.inactiveBackgroundColor = ThemeColor.textFieldBg
        textField.activeBackgroundColor = ThemeColor.textFieldBg
        
        textField.attributedPlaceholder =
            NSAttributedString(string: textField.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor : ThemeColor.textFieldPlaceholder,NSAttributedString.Key.font : FontBook.Regular.of(size: 15.0)] )
        
        textField.tintColor = UIColor.black
        
        textField.layer.cornerRadius = 6.0
        textField.layer.masksToBounds = true
        
        textField.leftMargin = 10
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.rightView = paddingView
        textField.rightViewMode = .always
        
        //        textField.layer.borderWidth = 1.0
        //        textField.layer.borderColor = ThemeColor.LightGrey.cgColor
        
    }
    
    func setUpNameTextField() {
        txtCardHolderName.inputType = .name
    }
    
    func setUpCardNumTextField() {
        txtCardNumber.inputType = .integer
        txtCardNumber.formatter = CardNumberFormatter()
        
        validation.maximumLength = 19
        validation.minimumLength = 14
        let characterSet = NSMutableCharacterSet.decimalDigit()
        characterSet.addCharacters(in: " ")
        validation.characterSet = characterSet as CharacterSet
        inputValidator = InputValidator(validation: validation)
        txtCardNumber.inputValidator = inputValidator
    }
    
    func setUpCardExpiryTextField() {
        txtExpiryDate.inputType = .integer
        txtExpiryDate.formatter = CardExpirationDateFormatter()
        txtExpiryDate.inputView = monthPicker
        txtExpiryDate.textColor = UIColor.black
        validation.minimumLength = 1
        let inputValidator = CardExpirationDateInputValidator(validation: validation)
        txtExpiryDate.inputValidator = inputValidator
    }
    
    
    func setUpCardCVVTextfield() {
        print("setUpCardCVVTextfield")
        txtCVV.inputType = .integer
        //           txtCVVNumber.setValue(UIColor.black , forKeyPath: "placeholderLabel.textColor")
        //           txtCVVNumber.font = FontBook.Regular.of(size: 14.0)
        //           txtCVVNumber.textColor = UIColor.black
        //        var validation = Validation()
        if self.cardTypeLabel.lowercased() == "amex" {
            print("amex card cv length set to 4")
            self.validation.maximumLength = 4
            //               self.validation.minimumLength = 3
        }
        else {
            print("general card cvv length set to 3")
            self.validation.maximumLength = 3
            //               self.validation.minimumLength = 3
        }
        validation.characterSet = NSCharacterSet.decimalDigits
        let inputValidator = InputValidator(validation: validation)
        txtCVV.inputValidator = inputValidator
        txtCVV.isSecureTextEntry = true
        print("txtCVV.text : \(txtCVV.text ?? "")")
    }
    
    func isValidatePaymentDetail() -> (Bool,String) {
        var isValidate:Bool = true
        var ValidatorMessage:String = ""
        let holder = txtCardHolderName.validatedText(validationType: ValidatorType.requiredField(field: "Card Holder Name"))//ValidatorType.requiredField(field: "first name"))
        
        if (!holder.0) {
            isValidate = false
            ValidatorMessage = holder.1
            
        }else if (txtCardNumber.text!.isEmptyOrWhitespace()) {
            isValidate = false
            ValidatorMessage = "Please enter card number"
            
        }else if !isCreditCardValid {
            isValidate = false
            ValidatorMessage = "Your card number is invalid"
        }
        
        //        else if txtCardNumber.text?.count != 19 {
        //            isValidate = false
        //            ValidatorMessage = "Please enter valid card number."
        //        }
        
        else if txtExpiryDate.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).count == 0 {
            isValidate = false
            ValidatorMessage = "Please enter expiry date"
            
        } else if txtCVV.text!.isEmptyOrWhitespace() {
            isValidate = false
            ValidatorMessage = "Please enter cvv"
        } else if txtCVV.text?.count ?? 0 < 3{
            isValidate = false
            ValidatorMessage = "Please enter valid cvv"
        }
        
        return (isValidate,ValidatorMessage)
    }
}

// MARK: - ======UITextFieldDelegate
extension PaymentVC : UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if(textField == txtExpiryDate) {
            var strMonth = "\(monthPicker.month)" as String
            if(monthPicker.month <= 9)
            {
                strMonth = "0\(monthPicker.month)"
            }
            let yearStr = "\(monthPicker.year)".dropFirst(2)
            txtExpiryDate.text = "\(strMonth)/\(yearStr)"
        }
    }
}

