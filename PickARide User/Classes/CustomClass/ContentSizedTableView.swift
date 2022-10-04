//
//  ContentSizedTableView.swift
//  PickARide User
//
//  Created by Gaurang on 21/09/22.
//  Copyright © 2022 EWW071. All rights reserved.
//

import UIKit

final class ContentSizedTableView: UITableView {
    override var contentSize:CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }

    override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
    }
}
