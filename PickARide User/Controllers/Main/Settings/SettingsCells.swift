//
//  SettingsCells.swift
//  PickARide User
//
//  Created by apple on 7/6/21.
//  Copyright © 2021 EWW071. All rights reserved.
//

import Foundation
import UIKit

class SettingCell1 : UITableViewCell {
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var btnShowProfile: UIButton!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblUserEmail: UILabel!
    @IBOutlet weak var lblUserPhoneNumber: UILabel!
}

class SettingCell2 : UITableViewCell {
    
    @IBOutlet weak var Seperator1: seperatorView!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var CategoryImageView: UIImageView!
    @IBOutlet weak var categoryName: UILabel!
}
