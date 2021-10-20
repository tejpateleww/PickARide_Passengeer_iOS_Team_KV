//
//  Notifications.swift
//  PickARide User
//
//  Created by apple on 7/8/21.
//  Copyright © 2021 EWW071. All rights reserved.
//

import Foundation

extension Notification.Name {
    static let OpenCurrentRideDriverInfoVC = NSNotification.Name("OpenCurrentRideDriverInfoVC")
    static let OpenCurrentRideDetailsVC = NSNotification.Name("OpenCurrentRideDetailsVC")
    static let OpenLocationSelectionVC = NSNotification.Name("OpenLocationSelection")
    static let CancelCompleteTRip = NSNotification.Name("CancelCompleteTRip")
}
