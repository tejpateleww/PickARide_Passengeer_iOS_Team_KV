//
//  CancelTripVC.swift
//  PickARide User
//
//  Created by baps on 29/12/20.
//  Copyright © 2020 EWW071. All rights reserved.
//

import UIKit

class CancelTripVC: BaseViewController {
    
    
    //MARK: -Properties
    @IBOutlet weak var viewBGBottom: NSLayoutConstraint!
    @IBOutlet weak var viewDragable: UIView!
    @IBOutlet weak var viewBG: UIView!
    @IBOutlet weak var viewMain: viewWithClearBg!
    @IBOutlet weak var btnNo: cancelButton!
    @IBOutlet weak var lblCancel: UILabel!
    @IBOutlet weak var btnCencel: cancelButton!
    //MARK: -IBOutlets
    
    //MARK: -View Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLocalization()
        setValue()
        setNavigationBarInViewController(controller: self, naviColor: colors.submitButtonColor.value, naviTitle: NavTitles.none.value, leftImage: NavItemsLeft.none.value, rightImages: [NavItemsRight.none.value], isTranslucent: true, CommonViewTitles: [], isTwoLabels: false)
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidAppear(_ animated: Bool) {
        self.viewBGBottom.constant = 0
        UIView.animate(withDuration: 0.5, animations: {
            self.view.layoutIfNeeded()
            //stackView.layoutIfNeeded()
        })
        
    }
    override func viewDidLayoutSubviews() {
        self.viewBG.layer.cornerRadius = 10
        self.viewBG.clipsToBounds = true
        
    }
    //MARK: -other methods
    func setLocalization() {
        
    }
    func setValue() {
    }
    //MARK: -IBActions
    
    @IBAction func btnCancelClick(_ sender: Any) {
        let controller = AppStoryboard.Main.instance.instantiateViewController(withIdentifier: ReasonForCancelVC.storyboardID)
        self.navigationController?.pushViewController(controller, animated: true)
    }
    @IBAction func btnNoClick(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: -API Calls
    
    
}
