//
//  CreditCardCell.swift
//  PickARide User
//
//  Created by Gaurang on 21/09/22.
//  Copyright © 2022 EWW071. All rights reserved.
//

import UIKit

class CreditCardCell: UITableViewCell {
    
    @IBOutlet weak var vWMain: PaymentView!
    @IBOutlet weak var selectPaymentMethodButton: UIButton!
    @IBOutlet weak var paymentMethodImageView: UIImageView!
    @IBOutlet weak var lblExpiresDate: addPaymentlable!
    @IBOutlet weak var lblcardDetails: addPaymentlable!

    override func awakeFromNib() {
        super.awakeFromNib()
        vWMain.layer.borderColor = colors.submitButtonColor.value.cgColor
    }
    
    func configCell(_ info: CardDetailModel, isSelected: Bool) {
        manageTableSelection(isSelected)
        self.paymentMethodImageView.image = getCardTypeImage(type: info.cardType ??  "")
        self.lblcardDetails.text = info.formatedCardNo ?? ""
        self.lblExpiresDate.text = "\(UrlConstant.Expiry) \(info.expiryMonth ?? "")/\(info.expiryYear ?? "")"
    }
    
    func manageTableSelection(_ isSelected: Bool) {
        vWMain.layer.borderWidth = isSelected ? 1 : 0
        let scale: CGFloat = isSelected ? 1 : 0
        selectPaymentMethodButton.transform = .init(scaleX: scale, y: scale)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension UITableView {
    func registerNibWithCellType(_ classType: UITableViewCell.Type) {
        self.register(UINib(nibName: classType.className, bundle: nil), forCellReuseIdentifier: classType.className)
    }
}
