//
//  chatVC.swift
//  PickARide User
//
//  Created by Apple on 19/01/21.
//  Copyright © 2021 EWW071. All rights reserved.
//

import UIKit

class chatVC: BaseViewController,UITableViewDelegate,UITableViewDataSource {
   
    

    //MARK: -Properties
    var MessageArray = [ChatConversation]()
    //MARK: -IBOutlets
    @IBOutlet weak var tblChat: UITableView!
    
    //MARK: -View Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLocalization()
        setValue()
        MessageArray.append(ChatConversation(date: "Today at 5:03 PM", Data: [MessageAllData(fromSender: true, message: "Hello, are you nearby?", lastMessage: false),
                                                                              MessageAllData(fromSender: false, message: "I'll be there in a few mins", lastMessage: true),
                                                                              MessageAllData(fromSender: true, message: "OK, I'm in front of the bus stop", lastMessage: true)
                                                                        ]))
        MessageArray.append(ChatConversation(date: "5:33 PM", Data: [MessageAllData(fromSender: false, message: "Sorry , I'm stuck in traffic. Please give me a moment.", lastMessage: true)
                                                                        ]))
       
        setNavigationBarInViewController(controller: self, naviColor: colors.appColor.value, naviTitle: "Connor Chavez\nST3751 - Toyota Vios", leftImage: NavItemsLeft.back.value, rightImages: [NavItemsRight.userProfile.value], isTranslucent: true, CommonViewTitles: [], isTwoLabels: true)
        
        tblChat.reloadData()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    //MARK: -other methods
    func setLocalization() {
        
    }
    func setValue() {
    }
    
    //MARK: -tableviewDelegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageArray[section].MessageData!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if MessageArray[indexPath.section].MessageData![indexPath.row].isFromSender == true {
            let SenderCell = tblChat.dequeueReusableCell(withIdentifier: chatSenderCell.reuseIdentifier, for: indexPath) as! chatSenderCell
            SenderCell.lblSenderMessage.text = MessageArray[indexPath.section].MessageData![indexPath.row].chatMessage
            SenderCell.lblBottomView.isHidden = false
            
//            if indexPath.row != 0 {
//                if indexPath.row != MessageArray[indexPath.section].MessageDate!.count - 1 {
//                    if (MessageArray[indexPath.section].MessageData![indexPath.row].isFromSender!) && (MessageArray[indexPath.section].MessageData![indexPath.row - 1].isFromSender!)   {
//                        SenderCell.lblBottomView.isHidden = false
//                    } else {
//                        SenderCell.lblBottomView.isHidden = true
//                    }
//                } else {
//                    SenderCell.lblBottomView.isHidden = false
//                }
//
//
//            } else {
//                if indexPath.row != MessageArray[indexPath.section].MessageDate!.count - 1 {
//                    if (MessageArray[indexPath.section].MessageData![indexPath.row].isFromSender!) && (MessageArray[indexPath.section].MessageData![indexPath.row + 1].isFromSender!)   {
//                        SenderCell.lblBottomView.isHidden = true
//                    } else {
//                        SenderCell.lblBottomView.isHidden = false
//                    }
//                } else {
//                    SenderCell.lblBottomView.isHidden = false
//                }
//            }
            
           
            
//            if MessageArray[indexPath.section].MessageData![indexPath.row].isLastMessage != true {
//
//            }
            cell = SenderCell
            
        } else {
            let ReciverCell = tblChat.dequeueReusableCell(withIdentifier: chatReciverCell.reuseIdentifier, for: indexPath) as! chatReciverCell
            ReciverCell.lblReciverMessage.text = MessageArray[indexPath.section].MessageData![indexPath.row].chatMessage
            ReciverCell.lblBottomView.isHidden = false
//            if indexPath.row != 0 {
//                if indexPath.row != MessageArray[indexPath.section].MessageDate?.count {
//                    if (MessageArray[indexPath.section].MessageData![indexPath.row].isFromSender!) && (MessageArray[indexPath.section].MessageData![indexPath.row - 1].isFromSender!)   {
//                        ReciverCell.lblBottomView.isHidden = false
//                    } else {
//                        ReciverCell.lblBottomView.isHidden = true
//                    }
//                } else {
//                    ReciverCell.lblBottomView.isHidden = false
//                }
//
//
//            } else {
//                if indexPath.row != MessageArray[indexPath.section].MessageDate?.count {
//                    if (MessageArray[indexPath.section].MessageData![indexPath.row].isFromSender!) && (MessageArray[indexPath.section].MessageData![indexPath.row + 1].isFromSender!)   {
//                        ReciverCell.lblBottomView.isHidden = true
//                    } else {
//                        ReciverCell.lblBottomView.isHidden = false
//                    }
//                } else {
//                    ReciverCell.lblBottomView.isHidden = false
//                }
//            }
            
            cell = ReciverCell
        }
       
        return cell
       
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return MessageArray.count
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tblChat.dequeueReusableCell(withIdentifier: chatHeaderCell.reuseIdentifier) as! chatHeaderCell
        cell.lblDateTime.text = MessageArray[section].MessageDate
        return cell
    }
    
    //MARK: -IBActions
    
    
    //MARK: -API Calls
    
    
    
    

}
class chatSenderCell : UITableViewCell {
    
    @IBOutlet weak var lblBottomView: UIView!
    @IBOutlet weak var lblSenderView: chatScreenView!
    @IBOutlet weak var lblSenderMessage: chatScreenLabel!
}
class chatReciverCell : UITableViewCell {
    @IBOutlet weak var lblBottomView: UIView!
    @IBOutlet weak var lblReciverView: chatScreenView!
    @IBOutlet weak var lblReciverMessage: chatScreenLabel!
}
class chatHeaderCell : UITableViewCell {
    
    @IBOutlet weak var lblDateTime: chatScreenLabel!
}
class ChatConversation {
    var MessageDate : String?
    var MessageData : [MessageAllData]?
    init(date:String,Data:[MessageAllData]) {
        self.MessageDate = date
        self.MessageData = Data
    }
}
class MessageAllData {
    var isFromSender : Bool?
    var chatMessage : String?
    var isLastMessage : Bool?
    init(fromSender:Bool,message:String,lastMessage:Bool) {
        self.isLastMessage = lastMessage
        self.isFromSender = fromSender
        self.chatMessage = message
    }
}

