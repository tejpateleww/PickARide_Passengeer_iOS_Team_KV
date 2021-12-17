//
//  MyRideCell.swift
//  PickaRideDriver
//
//  Created by Admin on 10/05/21.
//

import UIKit
//import UIView_Shimmer

class MyRideCell: UITableViewCell{
    
    //MARK: - ====== Outlets ========
    @IBOutlet weak var lblDate: themeLabel!
    @IBOutlet weak var lblAddress: themeLabel!
    @IBOutlet weak var lblAmount: themeLabel!
    @IBOutlet weak var lblRideName: themeLabel!
    @IBOutlet weak var imgMap: UIImageView!
    @IBOutlet weak var impPin: UIImageView!
    @IBOutlet weak var lblPrice: themeLabel!
    @IBOutlet weak var btnAccept: themeButton!
    @IBOutlet weak var btnReject: CancelButton!
    @IBOutlet weak var stackButtons: UIStackView!
    @IBOutlet weak var stackButtonsHeight: NSLayoutConstraint!
    @IBOutlet weak var imgStatus: UIImageView!
    
    //MARK:- ====== Variables =======
    var AcceptTapped : (()->()) = { }
    var RejectTapped : (()->()) = { }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    //MARK:- ===== Btn Action Accept =====
    @IBAction func btnAcceptAction(_ sender: Any) {
        self.AcceptTapped()
    }
    
    //MARK:- ===== Reject Btn Action ======
    @IBAction func btnRejectAction(_ sender: Any) {
        self.RejectTapped()
    }
    
}
