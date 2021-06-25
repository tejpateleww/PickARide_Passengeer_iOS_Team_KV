//
//  SelectTaxiTypeViewController.swift
//  PickARide User
//
//  Created by Apple on 21/12/20.
//  Copyright © 2020 EWW071. All rights reserved.
//

import UIKit
import GoogleMaps

class SelectTaxiTypeVC: BaseViewController{
   
    @IBOutlet weak var showRouteMapView: GMSMapView!
    @IBOutlet weak var lblCardPayment: suggestedRidesLabel!
    @IBOutlet weak var lblSuggestedRide: suggestedRidesLabel!
    @IBOutlet weak var btnCardPayment: UIButton!
    @IBOutlet weak var btnOffer: UIButton!
    @IBOutlet weak var btnBookNow: submitButton!
    @IBOutlet weak var tblSuggestedRidesHeight: NSLayoutConstraint!
    @IBOutlet weak var tblSuggestedRides: UITableView!
    @IBOutlet weak var mapVw: GMSMapView!
    @IBOutlet weak var btnPromo: UIButton!
    @IBOutlet weak var btnCancelPromo: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    
    var taxiData = [suggestRide]()
    var selectedTaxi = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.setLocalization()
        taxiData.append(suggestRide(name: "TAXI/CAB", capacity: "4 Seats", price: "$25.50", Time: "1-4 min", img: UIImage(named: "ic_dummyTexi1")!))
        taxiData.append(suggestRide(name: "Basic", capacity: "4 Seats", price: "$35.00", Time: "1-5 min", img: UIImage(named: "ic_dummyTexi2")!))
        
        taxiData.append(suggestRide(name: "Basic", capacity: "4 Seats", price: "$35.00", Time: "1-5 min", img: UIImage(named: "ic_dummyTexi2")!))
        
        taxiData.append(suggestRide(name: "Basic", capacity: "4 Seats", price: "$35.00", Time: "1-5 min", img: UIImage(named: "ic_dummyTexi2")!))
        
        taxiData.append(suggestRide(name: "Basic", capacity: "4 Seats", price: "$35.00", Time: "1-5 min", img: UIImage(named: "ic_dummyTexi2")!))
        tblSuggestedRides.reloadData()
        DispatchQueue.main.async { [self] in
            if taxiData.count > 2 {
                tblSuggestedRidesHeight.constant = (tblSuggestedRides.contentSize.height / CGFloat(taxiData.count)) * 2
            } else {
                tblSuggestedRidesHeight.constant = tblSuggestedRides.contentSize.height
            }
        }
        setNavigationBarInViewController(controller: self, naviColor: colors.submitButtonColor.value, naviTitle: NavTitles.CommonView.value, leftImage: NavItemsLeft.none.value, rightImages: [NavItemsRight.none.value], isTranslucent: true, CommonViewTitles: ["Destination 1","Destination 2"], isTwoLabels: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    @IBAction func btnCancel(_ sender: Any) {
        appDel.navigateToMain()
    }
    
    func setLocalization() {
        lblSuggestedRide.text = "SuggestedTaxiVC_lblTitle".Localized()
        lblCardPayment.text = "SuggestedTaxiVC_lblCardPayment".Localized()
        
        btnBookNow.setTitle("SuggestedTaxiVC_btnBookNow".Localized(), for: .normal)
        btnOffer.setunderline(title: "SuggestedTaxiVC_lblOffer".Localized(), color: colors.loginPlaceHolderColor.value, font: CustomFont.regular.returnFont(15))
        btnPromo.setTitle("SuggestedTaxiVC_btnPromo".Localized(), for: .normal)
    }
    
    @IBAction func btnPromo(_ sender: Any) {
    }
   
    @IBAction func btnScheduleClick(_ sender: Any) {
        
        let controller = AppStoryboard.Main.instance.instantiateViewController(withIdentifier: ScheduleRideVC.storyboardID) as!
            ScheduleRideVC
        controller.setClosour = {
            let vc : AddPaymentVC = AddPaymentVC.instantiate(fromAppStoryboard: .Main)
            vc.isFromSchedulled = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        controller.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        let navigationController = UINavigationController(rootViewController: controller)
        navigationController.modalPresentationStyle = .overCurrentContext
        navigationController.modalTransitionStyle = .crossDissolve
        navigationController.navigationBar.isHidden = true
        self.present(navigationController, animated: true, completion: nil)
        
        
    }
    @IBAction func btnBookNowClick(_ sender: Any) {
        let controller = AppStoryboard.Main.instance.instantiateViewController(withIdentifier: AddPaymentVC.storyboardID) as! AddPaymentVC
        controller.isFromSideMenu = false
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func btnOfferClick(_ sender: Any) {
        let controller = AppStoryboard.Main.instance.instantiateViewController(withIdentifier: MyOfferVC.storyboardID)
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func btnCardPaymentClick(_ sender: Any) {
        
    }
    
}

//MARK:- TableView Delegate
extension SelectTaxiTypeVC: UITableViewDelegate,UITableViewDataSource {
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
       
        cell.TaxiType.text = taxiData[indexPath.row].taxiName?.uppercased()
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
