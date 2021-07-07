//
//  NotificationVC.swift
//  Adelante
//
//  Created by baps on 03/12/20.
//  Copyright © 2020 EWW071. All rights reserved.
//

import UIKit

class NotificationVC: BaseViewController {
    
    @IBOutlet weak var lblNotificationTitle: NotificationLabel!
    @IBOutlet weak var tbvNotification: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
        self.setUpLocalization()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarInViewController(controller: self, naviColor: colors.appColor.value, naviTitle: NavTitles.none.value, leftImage: NavItemsLeft.back.value, rightImages: [NavItemsRight.none.value], isTranslucent: true, CommonViewTitles: [], isTwoLabels: false)
    }
}

//MARK:- Methods
extension NotificationVC{
    func setUpUI() {
        addNavBarImage(isLeft: true, isRight: true)
    }
    
    func setUpLocalization() {
        lblNotificationTitle.text = "Notification_lblTitle".Localized()
    }
}

//MARK:- Methods
extension NotificationVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:NotificationCell = tbvNotification.dequeueReusableCell(withIdentifier: "NotificationCell", for: indexPath)as! NotificationCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }
}

class NotificationCell: UITableViewCell{
    
}
