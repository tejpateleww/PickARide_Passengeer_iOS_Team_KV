//
//  ReasonForCancelVC.swift
//  PickARide User
//
//  Created by baps on 17/12/20.
//  Copyright © 2020 EWW071. All rights reserved.
//

import UIKit

class ReasonForCancelVC: BaseViewController,UITableViewDelegate,UITableViewDataSource {

    //MARK: -Properties
      var reasonArray = ["Driver isn't here","Driver declined to come","Driver asking for more money"]
    let footerView = UIView()

    var isselected = true    //MARK: -IBOutlets
    var selectIndex = 0
    @IBOutlet weak var btnDone: submitButton!
    @IBOutlet weak var tblReasonforCancel: UITableView!
    //MARK: -View Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        tblReasonforCancel.delegate = self
        tblReasonforCancel.dataSource = self
        tblReasonforCancel.reloadData()
        setupLocalization()
        footerView.backgroundColor = .white
        self.tblReasonforCancel.tableFooterView = footerView
        
        setNavigationBarInViewController(controller: self, naviColor: colors.appColor.value, naviTitle: NavTitles.reasonForCancle.value, leftImage: NavItemsLeft.cancel.value, rightImages: [NavItemsRight.none.value], isTranslucent: true, CommonViewTitles: [], isTwoLabels: false)
    }
    //MARK: -Other Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reasonArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:reasonCell = tblReasonforCancel.dequeueReusableCell(withIdentifier: reasonCell.reuseIdentifier, for: indexPath)as! reasonCell
        if indexPath.row == selectIndex {
           cell.imgQuestion.image = #imageLiteral(resourceName: "ImgRightArrow")
            cell.lblReasonforcancel.textColor = UIColor(hexString: "#282F39")
        } else {
            cell.imgQuestion.image = #imageLiteral(resourceName: "deselectReason")
                           cell.lblReasonforcancel.textColor = UIColor(hexString: "#7F7F7F")
        }
        cell.lblReasonforcancel.text = reasonArray[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectIndex = indexPath.row
        tblReasonforCancel.reloadData()
    }
    func setupLocalization(){
        btnDone.setTitle("ReasonForCancleVC_btnDone".Localized(), for: .normal)
    }
    //MARK: -IBActions
    @IBAction func btnDoneClick(_ sender: Any) {
        let controller = AppStoryboard.Main.instance.instantiateViewController(withIdentifier: RatingYourTripVC.storyboardID)
        self.navigationController?.pushViewController(controller, animated: true)
    }
    //MARK: -API Calls
}
class reasonCell:UITableViewCell{
    @IBOutlet weak var imgQuestion: UIImageView!
    @IBOutlet weak var lblReasonforcancel: ReasonforLabel!
       
}
