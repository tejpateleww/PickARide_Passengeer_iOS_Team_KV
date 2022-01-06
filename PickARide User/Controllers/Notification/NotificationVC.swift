//
//  NotificationVC.swift
//  Adelante
//
//  Created by baps on 03/12/20.
//  Copyright © 2020 EWW071. All rights reserved.
//

import UIKit

class NotificationCell: UITableViewCell{
    
    @IBOutlet weak var lblTitle: NotificationLabel!
    @IBOutlet weak var lblDescription: NotificationLabel!
    
}

class NotificationVC: BaseViewController {
    
    //MARK:- ===== Outlets =======
    @IBOutlet weak var lblNotificationTitle: NotificationLabel!
    @IBOutlet weak var tbvNotification: UITableView!
    
    //MARK:- ==== Variables ===
    var arrNotification =  [NotificationData]()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNIB()
        self.setUpUI()
        webServiceCallNotification()
        self.setUpLocalization()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarInViewController(controller: self, naviColor: colors.appColor.value, naviTitle: NavTitles.notification.value, leftImage: NavItemsLeft.back.value, rightImages: [NavItemsRight.none.value], isTranslucent: true, CommonViewTitles: [], isTwoLabels: false)
    }
    
    //MARK:- ==== Register NIB =====
    func registerNIB(){
        tbvNotification.register(UINib(nibName:NoDataTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: NoDataTableViewCell.reuseIdentifier)
    }
}

//MARK:- Methods
extension NotificationVC{
    func setUpUI() {
        addNavBarImage(isLeft: true, isRight: true)
        self.tbvNotification.estimatedRowHeight = 80
        self.tbvNotification.rowHeight = UITableView.automaticDimension
    }
    
    func setUpLocalization() {
        lblNotificationTitle.text = "Notification_lblTitle".Localized()
    }
}

//MARK:- Methods
extension NotificationVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrNotification.count != 0 ? arrNotification.count : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if arrNotification.count != 0 {
            let cell:NotificationCell = tbvNotification.dequeueReusableCell(withIdentifier: "NotificationCell", for: indexPath) as? NotificationCell ?? NotificationCell()
            cell.lblTitle.text = arrNotification[indexPath.row].title
            cell.lblDescription.text = arrNotification[indexPath.row].datumDescription
            return cell
        }
        else {
            let noDataCell = tbvNotification.dequeueReusableCell(withIdentifier: NoDataTableViewCell.reuseIdentifier, for: indexPath) as! NoDataTableViewCell
            return noDataCell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return arrNotification.count != 0 ? UITableView.automaticDimension : self.tbvNotification.frame.height
    }
}

//MARK:- ====== Notification Webservice Call ======
extension NotificationVC {
    
    func webServiceCallNotification(){
        Utilities.showHud()
        let reqModel = NotiificationRequestModel()
        reqModel.customerID = Singleton.sharedInstance.UserId
        WebServiceSubClass.notificationList(reqModel:reqModel) { status, message, response, error in
            Utilities.hideHud()
            if status {
                print(response)
                if response?.data?.count != 0 {
                    self.arrNotification = response?.data ?? []
                }
                self.tbvNotification.reloadData()
                
            }
            else {
                
            }
        }
    }
    
}
