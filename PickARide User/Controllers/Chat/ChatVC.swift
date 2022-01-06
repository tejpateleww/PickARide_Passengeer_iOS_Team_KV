//
//  chatVC.swift
//  PickARide User
//
//  Created by Apple on 19/01/21.
//  Copyright © 2021 EWW071. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import SDWebImage

class ChatVC: BaseViewController {
    
    @IBOutlet weak var tblChat: UITableView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblInfo: UILabel!
    @IBOutlet var vwNavBar: UIView!
    @IBOutlet weak var sendMessageOuterView: UIView!
    @IBOutlet weak var sendMessageOuterVWBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var txtSendMessage: UITextField!
    @IBOutlet weak var btnSendMessage: UIButton!
    
    
    //MARK: -Properties
    var chatViewModel = ChatViewModel()
    var objCurrentBooking : CurrentBookingData!
    var currentBookingModel : BookingInfoData?
    var arrayChatHistory = [chatHistoryData]()
    var filterListArr : [String: [chatHistoryData]] = [String(): [chatHistoryData]()]
    var filterKeysArr : [Date] = [Date]()
    var oldChatSectionTitle = Date()
    var oldChatId = String()
    var MessageArray = [ChatConversation]()
    var isFromApi = false

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerNIB()
        self.callChatHistoryAPI()
        self.setValue()
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.ChatSocketOnMethods()

        self.setNavigationBarInViewController(controller: self, naviColor: colors.white.value, naviTitle: "", leftImage: NavItemsLeft.back.value, rightImages: [NavItemsRight.userProfile.value], isTranslucent: true, CommonViewTitles: [], isTwoLabels: false)
        self.setSenderProfileInfo()
        self.setupKeyboard(false)
        self.hideKeyboard()
        self.registerForKeyboardNotifications()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.navigationController?.navigationBar.showNavBarSeparator()
    }
    
    func registerNIB(){
        tblChat.register(UINib(nibName:NoDataTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: NoDataTableViewCell.reuseIdentifier)
    }
    
   
    
    
    //MARK: - Button Action Methods
    @IBAction func btnSendMsgAction(_ sender: Any) {
        if validation() {
            
            let reqModel = sendMessageReqModel()
            reqModel.message = self.txtSendMessage.text ?? ""
            reqModel.sender_id = Singleton.sharedInstance.UserId
            reqModel.sender_type = "customer"
            reqModel.receiver_id = isFromApi == true ? objCurrentBooking.driverInfo?.id ?? "0" : "\(currentBookingModel?.driverInfo.id ?? 0)"
            reqModel.receiver_type = "driver"
            reqModel.booking_id = isFromApi == true ? objCurrentBooking.id ?? "" : self.currentBookingModel?.id ?? ""
            
            let param = reqModel.generatPostParams()
            if SocketIOManager.shared.socket.status == .connected {
                self.emitSocket_SendMessage(param: param)
            }
//            appendMessage()
            self.txtSendMessage.text = ""
            
        }
    }
    
    func emitSocket_SendMessage(param: [String : Any]) {
        SocketIOManager.shared.socketEmit(for: socketApikeys.KSendMsg, with: param)
    }
    
    
    
    func appendMessage(){
        
        let chatObj : chatHistoryData = chatHistoryData()
        
        chatObj.id = String(Int.random(in: 1...9999999))
        chatObj.bookingId = isFromApi == true ? objCurrentBooking.id ?? "" : self.currentBookingModel?.id ?? ""
        chatObj.message =  self.txtSendMessage.text ?? ""
        chatObj.receiverId =  isFromApi == true ? objCurrentBooking.driverInfo?.id ?? "0" : "\(currentBookingModel?.driverInfo.id ?? 0)"
        chatObj.receiverType = "driver"
        chatObj.senderId =  Singleton.sharedInstance.UserId
        chatObj.senderType = "customer"
      
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        chatObj.createdAt = dateFormatter.string(from: date)
        
        self.arrayChatHistory.append(chatObj)
        self.filterArrayData(isFromDidLoad: true)
        
    }
    
    func validation() -> Bool{
        
        if self.txtSendMessage.text?.trimmingCharacters(in: .whitespacesAndNewlines).count == 0 {
            self.txtSendMessage.text = ""
            //Utilities.showAlertAction(message: "Please enter message", vc: self)
            return false
        }
        return true
    }
    
    
    func filterArrayData(isFromDidLoad: Bool){
        self.filterListArr.removeAll()
        self.filterKeysArr.removeAll()
        self.arrayChatHistory.sort(by: {$0.createdAt!.compare($1.createdAt!) == .orderedAscending})
        for each in self.arrayChatHistory{
            let dateField = each.createdAt?.serverDateStringToDateType1?.Date_In_DD_MM_YYYY_FORMAT ?? String ()
            if filterListArr.keys.contains(dateField){
                filterListArr[dateField]?.append(each)
            }else{
                filterListArr[dateField] = [each]
                self.filterKeysArr.append(each.createdAt?.serverDateStringToDateType1 ?? Date())
            }
        }
        self.filterKeysArr.sort(by: <)
        isFromDidLoad ? self.scrollToBottom() : self.scrollAt()
    }
    
    func scrollToBottom(){
        DispatchQueue.main.async {
            if self.arrayChatHistory.count > 0 {
                let list = self.filterListArr[self.filterKeysArr.last?.Date_In_DD_MM_YYYY_FORMAT ?? String ()]
                
                let rowIndex = list?.count == 0 ? 0 : ((list?.count ?? 0) - 1)
                let indexPath = IndexPath(row: rowIndex, section: self.filterKeysArr.count - 1)
                self.tblChat.reloadData()
                self.tblChat.scrollToRow(at: indexPath, at: .bottom, animated: false)
            }
        }
    }
    
    func scrollAt(){
        if self.arrayChatHistory.count > 0 {
            let list = self.filterListArr[oldChatSectionTitle.Date_In_DD_MM_YYYY_FORMAT ?? ""]
            let row = list?.firstIndex(where: {$0.id == oldChatId}) ?? 0
            let section = self.filterKeysArr.firstIndex(where: {$0.Date_In_DD_MM_YYYY_FORMAT == oldChatSectionTitle.Date_In_DD_MM_YYYY_FORMAT}) ?? 0
            let indexPath = IndexPath(row: row, section: section)
            self.tblChat.reloadData()
            self.tblChat.scrollToRow(at: indexPath, at: .top, animated: false)
        }
    }
    
    func scrollToFirstRow() {
        self.tblChat.layoutIfNeeded()
        let indexPath = NSIndexPath(row: 0, section: 0)
        self.tblChat.scrollToRow(at: indexPath as IndexPath, at: .top, animated: false)
    }
    
    func onSocket_SendMessage(){
        SocketIOManager.shared.socketCall(for: socketApikeys.KSendMsg) { (json) in
            print(#function, "\n ", json)
            let dict = json[0]
            print(dict)
            
            let chatObj : chatHistoryData = chatHistoryData()
            chatObj.id = dict["id"].stringValue
            chatObj.bookingId = dict["booking_id"].stringValue
            chatObj.message =  dict["message"].stringValue
            chatObj.receiverId =  dict["receiver_id"].stringValue
            chatObj.receiverType = dict["receiver_type"].stringValue
            chatObj.senderId =  dict["sender_id"].stringValue
            chatObj.senderType = dict["sender_type"].stringValue
            chatObj.createdAt = dict["created_at"].stringValue
            
            self.arrayChatHistory.append(chatObj)
            self.filterArrayData(isFromDidLoad: true)
        }
    }
    
    func onSocket_ReceiveMessage(){
        SocketIOManager.shared.socketCall(for: socketApikeys.KReceiveMsg) { (json) in
            print(#function, "\n ", json)
            let dict = json[0]
            print(dict)
            
            let chatObj : chatHistoryData = chatHistoryData()
            chatObj.id = dict["id"].stringValue
            chatObj.bookingId = dict["booking_id"].stringValue
            chatObj.message =  dict["message"].stringValue
            chatObj.receiverId =  dict["receiver_id"].stringValue
            chatObj.receiverType = dict["receiver_type"].stringValue
            chatObj.senderId =  dict["sender_id"].stringValue
            chatObj.senderType = dict["sender_type"].stringValue
            chatObj.createdAt = dict["created_at"].stringValue
            
            self.arrayChatHistory.append(chatObj)
            self.filterArrayData(isFromDidLoad: true)
        }
    }
    
    
    
    
    
}

//MARK:- Api Calls
extension ChatVC{
    
    func callChatHistoryAPI(){
        self.chatViewModel.ChatCV = self
        let Id = isFromApi == true ? objCurrentBooking.id ?? "" : self.currentBookingModel?.id ?? ""
        self.chatViewModel.webserviceGetChatHistoryAPI(strBookingID: Id)
    }
    
}



//MARK: Other methods
extension ChatVC{
    func setValue() {
        MessageArray.append(ChatConversation(date: "Today at 5:03 PM", Data: [MessageAllData(fromSender: true, message: "Hello, are you nearby?", lastMessage: false), MessageAllData(fromSender: false, message: "I'll be there in a few mins", lastMessage: true), MessageAllData(fromSender: true, message: "OK, I'm in front of the bus stop", lastMessage: true) ]))
        MessageArray.append(ChatConversation(date: "5:33 PM", Data: [MessageAllData(fromSender: false, message: "Sorry , I'm stuck in traffic. Please give me a moment.", lastMessage: true) ]))
        
        self.tblChat.reloadData()
    }
    
    
    func setSenderProfileInfo(){
        self.navigationItem.titleView = vwNavBar
        
        let custName = isFromApi == true ? (self.objCurrentBooking?.driverInfo?.firstName)! + " " + (self.objCurrentBooking?.driverInfo?.lastName)! :
            (self.currentBookingModel?.driverInfo?.firstName)! + " " + (self.currentBookingModel?.driverInfo?.lastName)!
        self.lblName.text = custName
        let NumberPlate = isFromApi == true ?  "\(self.objCurrentBooking?.driverVehicleInfo?.plateNumber ?? "") - \(self.objCurrentBooking?.driverVehicleInfo?.vehicleTypeManufacturerName ?? "") \(self.objCurrentBooking?.driverVehicleInfo?.vehicleTypeModelName ?? "")" :
            
             "\(self.currentBookingModel?.driverVehicleInfo?.plateNumber ?? "") - \(self.currentBookingModel?.driverVehicleInfo?.vehicleTypeManufacturerName ?? "") \(self.currentBookingModel?.driverVehicleInfo?.vehicleTypeModelName ?? "")"
        self.lblInfo.text = NumberPlate
        
        
        let strUrl = isFromApi == true ? "\(APIEnvironment.Profilebu.rawValue)" + "\(self.objCurrentBooking.driverInfo?.profileImage ?? "")" :  "\(APIEnvironment.Profilebu.rawValue)" + "\(self.currentBookingModel?.driverInfo.profileImage ?? "")"
        let strURl = URL(string: strUrl)
        self.navBtnProfile.sd_setImage(with: strURl, for: .normal, placeholderImage:UIImage(named: "user_placeholder") , options: [], context: nil)
//        self.imgProfilw.sd_imageIndicator = SDWebImageActivityIndicator.gray
        
    }
    
    
    @objc func backClick(){
        self.view.endEditing(true)
        self.navigationController?.popViewController(animated: true)
    }
}

//MARK:- TableView Methods
extension ChatVC: UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if self.arrayChatHistory.count > 0 {
            return self.filterKeysArr.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.arrayChatHistory.count > 0 {
            let strDate = self.filterKeysArr[section].Date_In_DD_MM_YYYY_FORMAT ?? ""
            return self.filterListArr[strDate]?.count ?? 0
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height:30.0))
        if(self.arrayChatHistory.count > 0){
        
            let lblDate = UILabel(frame: CGRect(x: 0, y: 0, width: 150, height: 30))
            lblDate.backgroundColor = UIColor.lightGray
            lblDate.textColor = UIColor.white
            lblDate.layer.cornerRadius = lblDate.frame.height/2.0
            lblDate.layer.masksToBounds = true
            
            let obj = self.filterKeysArr[section]
            lblDate.text = obj.timeAgoSinceDate(isForNotification: true)
            
            lblDate.textAlignment = .center
            lblDate.font = CustomFont.regular.returnFont(12.0)
            
            headerView.addSubview(lblDate)
            lblDate.center = headerView.center
        
        }
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(self.arrayChatHistory.count > 0){
            let strDateTitle = self.filterKeysArr[indexPath.section].Date_In_DD_MM_YYYY_FORMAT ?? ""
            let obj = self.filterListArr[strDateTitle]?[indexPath.row]
            
            let isDriver = obj?.receiverType ?? "" == "driver"
            if(isDriver){
                let cell = tblChat.dequeueReusableCell(withIdentifier: chatSenderCell.reuseIdentifier) as! chatSenderCell
                cell.selectionStyle = .none
                cell.lblSenderMessage.text = obj?.message ?? ""
                return cell
            }else{
                let cell = tblChat.dequeueReusableCell(withIdentifier: chatReciverCell.reuseIdentifier) as! chatReciverCell
                cell.selectionStyle = .none
                cell.lblReciverMessage.text = obj?.message ?? ""
                return cell
            }
        }else{
            let NoDatacell = self.tblChat.dequeueReusableCell(withIdentifier: "NoDataTableViewCell", for: indexPath) as! NoDataTableViewCell
            return NoDatacell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.arrayChatHistory.count != 0 {
            return UITableView.automaticDimension
        }else{
            return tableView.frame.height
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

//MARK: KEYBOARD SETUP FOR CHATBOX
extension ChatVC {
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func hideKeyboard()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissKeyboards))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboards()
    {
        view.endEditing(true)
    }
    
    func setupKeyboard(_ enable: Bool) {
        IQKeyboardManager.shared.enable = enable
        IQKeyboardManager.shared.enableAutoToolbar = enable
        IQKeyboardManager.shared.shouldShowToolbarPlaceholder = !enable
        IQKeyboardManager.shared.previousNextDisplayMode = .alwaysShow
    }
    
    @objc func keyboardWillBeHidden(notification: NSNotification){
        sendMessageOuterVWBottomConstraint.constant = 10
        self.animateConstraintWithDuration()
    }
    
    @objc func keyboardWasShown(notification: NSNotification){
        
        let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size
        
        if #available(iOS 11.0, *) {
            
//            DispatchQueue.main.async {
//                if self.arrayChatHistory.count != 0 {
//                    self.scrollToBottom()
//                }
//            }
            sendMessageOuterVWBottomConstraint.constant = keyboardSize!.height - view.safeAreaInsets.bottom
        
        } else {
            
//            DispatchQueue.main.async {
//                if self.arrayChatHistory.count != 0 {
//                    self.scrollToBottom()
//                }
//            }
            sendMessageOuterVWBottomConstraint.constant = keyboardSize!.height - 10
            
        }
        self.animateConstraintWithDuration()
    }
    
    func deregisterFromKeyboardNotifications(){
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func animateConstraintWithDuration(duration: TimeInterval = 0.5) {
        UIView.animate(withDuration: duration, animations: { [weak self] in
            self?.loadViewIfNeeded() ?? ()
        })
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
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


extension ChatVC{
    
    //MARK:- Socket On All
    func ChatSocketOnMethods() {
        
        SocketIOManager.shared.socket.on(clientEvent: .disconnect) { (data, ack) in
            print ("socket is disconnected please reconnect")
            SocketIOManager.shared.isSocketOn = false
        }
        
        SocketIOManager.shared.socket.on(clientEvent: .reconnect) { (data, ack) in
            print ("socket is reconnected")
            SocketIOManager.shared.isSocketOn = true
        }
        
        print("===========\(SocketIOManager.shared.socket.status)========================",SocketIOManager.shared.socket.status.active)
        SocketIOManager.shared.socket.on(clientEvent: .connect) {data, ack in
            print ("socket connected")
            SocketIOManager.shared.isSocketOn = true
            self.ChatSocketOffMethods()
            self.emitSocket_UserConnect()
            self.allChatSocketOnMethods()
        }
        
        if(SocketIOManager.shared.socket.status == .connected){
            self.ChatSocketOffMethods()
            self.emitSocket_UserConnect()
            self.allChatSocketOnMethods()
        }
        
        SocketIOManager.shared.establishConnection()
        print("==============\(SocketIOManager.shared.socket.status)=====================",SocketIOManager.shared.socket.status.active)
    }
    
    //MARK:- Active Socket Methods
    func allChatSocketOnMethods() {
        onSocketConnectUser()
        onSocket_SendMessage()
        onSocket_ReceiveMessage()
    }
    
    //MARK:- Deactive Socket Methods
    func ChatSocketOffMethods() {
        SocketIOManager.shared.socket.off(socketApikeys.KConnectCustomer)
        SocketIOManager.shared.socket.off(socketApikeys.KSendMsg)
        SocketIOManager.shared.socket.off(socketApikeys.KReceiveMsg)
    }
    
    //MARK:- On Methods
    func onSocketConnectUser(){
        SocketIOManager.shared.socketCall(for:socketApikeys.KConnectCustomer) { (json) in
            print(#function, "\n ", json)
        }
    }
    
    
    //MARK:- Emit Methods
    // Socket Emit Connect user
    func emitSocket_UserConnect(){
        let param = [
            
            socketApikeys.KCustomerID : Singleton.sharedInstance.UserId
            
            
            ] as [String : Any]
        SocketIOManager.shared.socketEmit(for: socketApikeys.KConnectCustomer, with: param)
    }
    
    
    
    
}
