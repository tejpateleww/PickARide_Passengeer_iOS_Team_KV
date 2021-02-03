//
//  AddCardVC.swift
//  Adelante
//
//  Created by Apple on 07/12/20.
//  Copyright © 2020 EWW071. All rights reserved.
//

import UIKit

class AddCardVC: BaseViewController {

    
    //MARK: -Properties
    
    //MARK: -IBOutlets
    
    @IBOutlet weak var lblAddCard : TitleLabel!
    @IBOutlet weak var LblName : addCardLabel!
    @IBOutlet weak var LblCreditCardNumber : addCardLabel!
    @IBOutlet weak var LblExpires : addCardLabel!
    @IBOutlet weak var LblCVV : addCardLabel!
    @IBOutlet weak var LblCountry : addCardLabel!
    @IBOutlet weak var LblDebitCardAreAcceptedDescription : addCardLabel!
    @IBOutlet weak var TextFieldName : addCarddetailsTextField!
    @IBOutlet weak var TextFieldCreditCardNumber : addCarddetailsTextField!
    @IBOutlet weak var TextFieldExpires : addCarddetailsTextField!
    @IBOutlet weak var TextFieldCVV : addCarddetailsTextField!
    @IBOutlet weak var TextFieldCountry : addCarddetailsTextField!
    @IBOutlet weak var btnSave : submitButton!

    //MARK: -View Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLocalization()
        setData()
        setNavigationBarInViewController(controller: self, naviColor: colors.appColor.value, naviTitle: NavTitles.none.value, leftImage: NavItemsLeft.back.value, rightImages: [NavItemsRight.none.value], isTranslucent: true, CommonViewTitles: [])
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    //MARK: -other methods
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
        TextFieldExpires.text = "10/27/2030"
        TextFieldCVV.text = "****"
        TextFieldCountry.text = "Germany"
    }
    //MARK: -IBActions
    
    
    @IBAction func placeOrderBtn(_ sender: submitButton) {
        //             let controller = AppStoryboard.Main.instance.instantiateViewController(withIdentifier: BffComboVC.storyboardID)
        //             self.navigationController?.pushViewController(controller, animated: true)
      self.navigationController?.popViewController(animated: true)

           }
    //MARK: -API Calls
    
    
    
    
    
   
    


}
