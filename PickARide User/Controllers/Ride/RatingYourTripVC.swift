//
//  RatingYourTripVC.swift
//  PickARide User
//
//  Created by baps on 30/12/20.
//  Copyright © 2020 EWW071. All rights reserved.
//

import UIKit

class RatingYourTripVC: BaseViewController {

    @IBOutlet weak var DotedLine: UIView!
    @IBOutlet weak var btnSkip: loginScreenButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //Set DotedLine
        self.DotedLine.createDottedLine(width: 1.0, color: UIColor.cyan.cgColor)
    }
    
    @IBAction func btnSubmitReviewClicked(_ sender: Any) {
        appDel.navigateToMain()
    }
    
    @IBAction func btnSkip(_ sender: Any) {
        appDel.navigateToMain()
    }
}

//MARK:- Set Up UI
extension RatingYourTripVC{
    func setUpUI(){
        //Set Navigation View
        self.setNavigationBarInViewController(controller: self, naviColor: colors.submitButtonColor.value, naviTitle: NavTitles.rating.value, leftImage: NavItemsLeft.cancelWhite.value, rightImages: [NavItemsRight.none.value], isTranslucent: true, CommonViewTitles: [], isTwoLabels: false)
    }
}
