//
//  TaxiTypeCell.swift
//  PickARide User
//
//  Created by Admin on 03/01/22.
//  Copyright © 2022 EWW071. All rights reserved.
//

import UIKit

class TaxiTypeCell: UITableViewCell {
    
    @IBOutlet weak var suggestTaxiBackgroundView: suggestedTaxiView!
    @IBOutlet weak var TaxiType: suggestedRidesLabel!
    @IBOutlet weak var TotalSeat: suggestedRidesLabel!
    @IBOutlet weak var SuggestedMoney: suggestedRidesLabel!
    @IBOutlet weak var SuggestedTime: suggestedRidesLabel!
    @IBOutlet weak var TaxiImage: UIImageView!
    @IBOutlet weak var vwBottom: UIView!
    @IBOutlet weak var vWBottomHeight: NSLayoutConstraint!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

//class suggestRide {
//    var taxiName : String?
//    var taxiTotalCapacity : String?
//    var taxiPrice : String?
//    var taxiComingTime : String?
//    var taxiImage : UIImage?
//    init(name:String,capacity:String,price:String,Time:String,img:UIImage) {
//        self.taxiName = name
//        self.taxiTotalCapacity = capacity
//        self.taxiPrice = price
//        self.taxiComingTime = Time
//        self.taxiImage = img
//    }
//}
//
