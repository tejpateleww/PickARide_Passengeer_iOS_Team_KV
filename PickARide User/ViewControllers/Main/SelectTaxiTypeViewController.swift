//
//  SelectTaxiTypeViewController.swift
//  PickARide User
//
//  Created by Apple on 21/12/20.
//  Copyright © 2020 EWW071. All rights reserved.
//

import UIKit

class SelectTaxiTypeViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource {
   
    

    //MARK: -Properties
    var taxiData = [suggestRide]()
    var selectedTaxi = 0
    //MARK: -IBOutlets
    @IBOutlet weak var lblStartRideAddress: suggestedRidesLabel!
    @IBOutlet weak var lblEndRideAddress: suggestedRidesLabel!
    @IBOutlet weak var lblCardPayment: suggestedRidesLabel!
    @IBOutlet weak var lblSuggestedRide: suggestedRidesLabel!
    @IBOutlet weak var btnCardPayment: UIButton!
    @IBOutlet weak var btnOffer: UIButton!
    @IBOutlet weak var btnBookNow: submitButton!
    @IBOutlet weak var tblSuggestedRidesHeight: NSLayoutConstraint!
    @IBOutlet weak var tblSuggestedRides: UITableView!
    //MARK: -View Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        self.navigationController?.navigationBar.isHidden = true
        setLocalization()
        setValue()
        taxiData.append(suggestRide(name: "Taxi/Cab", capacity: "4 Seats", price: "$25.50", Time: "1-4 min", img: UIImage(named: "ic_dummyTexi1")!))
        taxiData.append(suggestRide(name: "Basic", capacity: "4 Seats", price: "$35.00", Time: "1-5 min", img: UIImage(named: "ic_dummyTexi2")!))
        tblSuggestedRides.reloadData()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        
    }
  
    //MARK: -other methods
    func setLocalization() {
        lblSuggestedRide.text = "SuggestedTaxiVC_lblTitle".Localized()
        lblCardPayment.text = "SuggestedTaxiVC_lblCardPayment".Localized()
        
        btnBookNow.setTitle("SuggestedTaxiVC_btnBookNow".Localized(), for: .normal)
        btnOffer.setunderline(title: "SuggestedTaxiVC_lblOffer".Localized(), color: colors.loginPlaceHolderColor, font: CustomFont.regular.returnFont(15))
    }
    func setValue() {
        lblStartRideAddress.text = "Destination 1"
        lblEndRideAddress.text = "Destination 2"
    }
    //MARK: -tblViewMethods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taxiData.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblSuggestedRides.dequeueReusableCell(withIdentifier: suggestedVisitCell.reuseIdentifier, for: indexPath) as! suggestedVisitCell
        if indexPath.row == selectedTaxi {
            cell.suggestTaxiBackgroundView.backgroundColor = colors.white.value
            cell.suggestTaxiBackgroundView.layer.borderWidth = 1
            cell.TaxiType.textColor = colors.submitButtonColor.value
            
            
        } else {
            cell.suggestTaxiBackgroundView.backgroundColor = UIColor(hexString: "#000000").withAlphaComponent(0.03)
            cell.suggestTaxiBackgroundView.layer.borderWidth = 0
            cell.TaxiType.textColor = colors.loginPlaceHolderColor.value
        }
        if taxiData.count > 2 || taxiData.count == 2 {
            tblSuggestedRidesHeight.constant = cell.frame.size.height * 2
        } else {
            tblSuggestedRidesHeight.constant = cell.frame.size.height * 1
        }
        cell.TaxiType.text = taxiData[indexPath.row].taxiName
        cell.TotalSeat.text = taxiData[indexPath.row].taxiTotalCapacity
        cell.SuggestedMoney.text = taxiData[indexPath.row].taxiPrice
        cell.SuggestedTime.text = taxiData[indexPath.row].taxiComingTime
        cell.TaxiImage.image = taxiData[indexPath.row].taxiImage
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedTaxi = indexPath.row
        tblSuggestedRides.reloadData()
    }
    //MARK: -IBActions
    
   
    @IBAction func btnScheduleClick(_ sender: Any) {
        let controller = AppStoryboard.Main.instance.instantiateViewController(withIdentifier: CurrentRideDetailsViewController.storyboardID)
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
    //MARK: -API Calls
    
    
    
    
}
class suggestedVisitCell : UITableViewCell {
    
    @IBOutlet weak var suggestTaxiBackgroundView: suggestedTaxiView!
    @IBOutlet weak var TaxiType: suggestedRidesLabel!
    @IBOutlet weak var TotalSeat: suggestedRidesLabel!
    @IBOutlet weak var SuggestedMoney: suggestedRidesLabel!
    @IBOutlet weak var SuggestedTime: suggestedRidesLabel!
    @IBOutlet weak var TaxiImage: UIImageView!
}
class suggestRide {
    var taxiName : String?
    var taxiTotalCapacity : String?
    var taxiPrice : String?
    var taxiComingTime : String?
    var taxiImage : UIImage?
    init(name:String,capacity:String,price:String,Time:String,img:UIImage) {
        self.taxiName = name
        self.taxiTotalCapacity = capacity
        self.taxiPrice = price
        self.taxiComingTime = Time
        self.taxiImage = img
    }
}
