//
//  ReasonForCancelVC.swift
//  PickARide User
//
//  Created by baps on 17/12/20.
//  Copyright © 2020 EWW071. All rights reserved.
//

import UIKit

class ReasonForCancelVC: BaseViewController {

    @IBOutlet weak var btnDone: submitButton!
    @IBOutlet weak var tblReasonforCancel: UITableView!
    
    //MARK: -Properties
    var reasonArray = ["Driver isn't here","Driver declined to come","Driver asking for more money"]
    let footerView = UIView()

    var isselected = true
    var selectIndex = 0
    
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
    
    //MARK: -IBActions
    @IBAction func btnDoneClick(_ sender: Any) {
        appDel.navigateToMain()
    }
}

//MARK: Other Methods
extension ReasonForCancelVC{
    func setupLocalization(){
        btnDone.setTitle("ReasonForCancleVC_btnDone".Localized(), for: .normal)
    }
}

extension ReasonForCancelVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reasonArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:reasonCell = tblReasonforCancel.dequeueReusableCell(withIdentifier: reasonCell.reuseIdentifier, for: indexPath) as? reasonCell ?? reasonCell()
        cell.imgQuestion.image = indexPath.row == selectIndex ? RadioCheckImg : RadioUncheckImg
        cell.imgQuestion.tintColor = indexPath.row == selectIndex ? ThemeColorEnum.Theme.rawValue : ThemeColorEnum.ThemeGray.rawValue
        cell.lblReasonforcancel.textColor = indexPath.row == selectIndex ? ThemeColorEnum.Theme.rawValue : ThemeColorEnum.ThemeGray.rawValue
       
        cell.lblReasonforcancel.text = reasonArray[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectIndex = indexPath.row
        tblReasonforCancel.reloadData()
    }
}

class reasonCell: UITableViewCell{
    @IBOutlet weak var imgQuestion: UIImageView!
    @IBOutlet weak var lblReasonforcancel: ReasonforLabel!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
        
    }
}


