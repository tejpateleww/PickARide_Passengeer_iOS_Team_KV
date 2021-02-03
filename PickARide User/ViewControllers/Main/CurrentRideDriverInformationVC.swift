//
//  CurrentRideDriverInformationVC.swift
//  PickARide User
//
//  Created by Apple on 18/01/21.
//  Copyright © 2021 EWW071. All rights reserved.
//

import UIKit

class CurrentRideDriverInformationVC: BaseViewController {

    //MARK: -Properties
    var vehicalNumber = "ST3751"
    //MARK: -IBOutlets
    @IBOutlet weak var lblDriverName: currentRideLabel!
    @IBOutlet weak var lblRidego: currentRideLabel!
    @IBOutlet weak var lblVehicalData: currentRideLabel!
  
    //MARK: -View Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLocalization()
        setValue()
        setLabel()
        
        setNavigationBarInViewController(controller: self, naviColor: colors.submitButtonColor.value, naviTitle: NavTitles.CommonView.value, leftImage: NavItemsLeft.none.value, rightImages: [NavItemsRight.none.value], isTranslucent: true, CommonViewTitles: ["Seattle","280 Hemlock Ln"])
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
       // self.navigationController?.navigationBar.isHidden = true
    }
    override func viewDidDisappear(_ animated: Bool) {
      //  self.navigationController?.navigationBar.isHidden = false
    }
    
    //MARK: -other methods
    func setLocalization() {
        
    }
    func setValue() {
       
    }
    func setLabel() {
        let attributedString = NSMutableAttributedString(string: lblVehicalData.text!)
        
        let strNumber : NSString = lblVehicalData.text as! NSString
        let range = (strNumber).range(of: vehicalNumber)
        print(range.location)
        attributedString.addAttribute(NSAttributedString.Key.font, value: CustomFont.medium.returnFont(15), range: NSMakeRange(0, attributedString.length))
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: colors.loginPlaceHolderColor.value, range: NSMakeRange(0, attributedString.length))
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: colors.phoneNumberColor.value , range: range)
        lblVehicalData.attributedText = attributedString
        //
    }
    //MARK: -IBActions
    @IBAction func btnCallClick(_ sender: Any) {
       
       
    }
    @IBAction func btnMessageClick(_ sender: Any) {
        let controller = AppStoryboard.Main.instance.instantiateViewController(withIdentifier: chatVC.storyboardID) as! chatVC
        self.navigationController?.pushViewController(controller, animated: true)
    }
    @IBAction func btnCancelClick(_ sender: Any) {
        let controller = AppStoryboard.Main.instance.instantiateViewController(withIdentifier: CancelTripVC.storyboardID) as! CancelTripVC
                   
       //            controller.textForShow = "Waiting for client to add minutes..."
                   let navigationController = UINavigationController(rootViewController: controller)
        
      //  navigationController.navigationBar.isHidden = true
                   navigationController.modalPresentationStyle = .overCurrentContext
                   navigationController.modalTransitionStyle = .crossDissolve
                   self.present(navigationController, animated: true, completion: nil)
        
       
    }
    
    //MARK: -API Calls
    
    
    
    
    
}
