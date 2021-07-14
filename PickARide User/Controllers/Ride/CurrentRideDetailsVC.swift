//
//  CurrentRideDetailsViewController.swift
//  PickARide User
//
//  Created by Apple on 21/12/20.
//  Copyright © 2020 EWW071. All rights reserved.
//

import UIKit
import Cosmos

class CurrentRideDetailsVC: BaseViewController {

    @IBOutlet weak var lblDriverName: currentRideLabel!
    @IBOutlet weak var lblRidego: currentRideLabel!
    @IBOutlet weak var lblVehicalData: currentRideLabel!
    @IBOutlet weak var vwMain: suggestedTaxiView!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var topVW: UIView!
    @IBOutlet weak var mainVW: suggestedTaxiView!
    @IBOutlet weak var mainVWBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var driverProfileOuterVW: UIView!
    @IBOutlet weak var rideDetailsStkVWTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var ratingsView: CosmosView!
    @IBOutlet weak var lblAvgRating: UILabel!
    @IBOutlet weak var btnGoToRatings: UIButton!
    
    var vehicalNumber = "ST3751"
    
    var isExpandCategory:  Bool  = false {
        didSet {
            self.driverProfileOuterVW.isHidden = !isExpandCategory
            mainVWBottomConstraint.constant = isExpandCategory ? 0 : -50
            self.btnCancel.isHidden = !isExpandCategory
            self.btnGoToRatings.isHidden = !isExpandCategory
            self.ratingsView.isHidden = !isExpandCategory
            self.lblAvgRating.isHidden = !isExpandCategory
            self.rideDetailsStkVWTopConstraint.constant = isExpandCategory ? 0 : 10
            self.view.endEditing(true)
            UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [.curveEaseInOut, .allowUserInteraction, .beginFromCurrentState], animations: {
                self.view.layoutIfNeeded()
            }) { (success) in
                
            }
        }
    }
    
    var closeBtnClosure : (()->())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
        self.setupViewCategory()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarInViewController(controller: self, naviColor: colors.submitButtonColor.value, naviTitle: NavTitles.CommonView.value, leftImage: NavItemsLeft.none.value, rightImages: [NavItemsRight.none.value], isTranslucent: true, CommonViewTitles: ["J'Adore Interiors","280 Hemlock Ln"], isTwoLabels: false, isDisableBack: true)
    }
    
    @IBAction func btnCancel(_ sender: Any) {
        appDel.navigateToMain()
    }
    
    @IBAction func btnProfileClicked(_ sender: Any) {
        let controller = RatingYourTripVC.instantiate(fromAppStoryboard: .Main)
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

//MARK:- Set Up UI
extension CurrentRideDetailsVC{
    func setUpUI(){
        self.setLabel()
    }
    
    func setLabel() {
        let attributedString = NSMutableAttributedString(string: lblVehicalData.text!)
        let strNumber : NSString = lblVehicalData.text as NSString? ?? NSString()
        let range = (strNumber).range(of: vehicalNumber)
        print(range.location)
        attributedString.addAttribute(NSAttributedString.Key.font, value: CustomFont.medium.returnFont(15), range: NSMakeRange(0, attributedString.length))
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: colors.loginPlaceHolderColor.value, range: NSMakeRange(0, attributedString.length))
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: colors.phoneNumberColor.value , range: range)
        lblVehicalData.attributedText = attributedString
    } 
    
    func setupViewCategory() {
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture(gesture:)))
        swipeUp.direction = UISwipeGestureRecognizer.Direction.up
        self.topVW.addGestureRecognizer(swipeUp)

        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture(gesture:)))
        swipeDown.direction = UISwipeGestureRecognizer.Direction.down
        self.topVW.addGestureRecognizer(swipeDown)
    }
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizer.Direction.down:
                print("Swiped down")
                self.isExpandCategory = false

            case UISwipeGestureRecognizer.Direction.up:
                print("Swiped up")
                self.isExpandCategory = true

            default:
                break
            }
        }
    }
    
    @objc func setBottomViewOnclickofViewTop(){
        self.isExpandCategory = !self.isExpandCategory
    }
}
