//
//  NoDataViewCell.swift
//  Oppera
//
//  Created by EWW077 on 03/05/1941 Saka.
//  Copyright © 1941 eww090. All rights reserved.
//

import UIKit

class NoDataViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    @IBOutlet weak var lblText: UILabel!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    
    
    
}
