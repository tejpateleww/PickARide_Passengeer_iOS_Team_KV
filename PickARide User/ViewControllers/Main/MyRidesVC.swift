//
//  MyRidesVC.swift
//  PickARide User
//
//  Created by baps on 16/12/20.
//  Copyright © 2020 EWW071. All rights reserved.
//

import UIKit

class MyRidesVC: BaseViewController,UITableViewDelegate,UITableViewDataSource {
    //MARK: -Properties
    var myRideArr = ["UPCOMING","PAST"]
    var selectedMyRideState = 0
    //MARK: -IBOutlets
    
    @IBOutlet weak var btnUpcoming: MyRidesButton!
    
    @IBOutlet weak var viewTblRideType: UIView!
    @IBOutlet weak var lblMyRides: myRidesLabel!
    @IBOutlet weak var tblMyRides: UITableView!
    @IBOutlet weak var tblMyRideType: UITableView!
    
    //MARK: -View Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        tblMyRides.delegate = self
        tblMyRideType.delegate = self
        tblMyRides.dataSource = self
        tblMyRideType.dataSource = self
        tblMyRideType.reloadData()
        tblMyRides.reloadData()
        self.viewTblRideType.isHidden = true
        setupLocalization()
        print(tblMyRideType.contentSize.height)
        
        self.tblMyRideType.frame.origin.y = -8
        self.tblMyRideType.frame.size.height = 0
        setNavigationBarInViewController(controller: self, naviColor: colors.submitButtonColor.value, naviTitle: NavTitles.none.value, leftImage: NavItemsLeft.back.value, rightImages: [NavItemsRight.none.value], isTranslucent: true, CommonViewTitles: [])
        self.btnUpcoming.setTitle(myRideArr[selectedMyRideState], for: .normal)
    }
    //MARK: -Other Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        switch tableView{
        case tblMyRides:
            return 6
        case tblMyRideType:
            return myRideArr.count
        default:
            return 2
        }
     
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        switch tableView{
        case tblMyRides:
            let cell:MyridesCell = tblMyRides.dequeueReusableCell(withIdentifier: MyridesCell.reuseIdentifier, for: indexPath)as! MyridesCell
            if selectedMyRideState == 0 {
              
                cell.btnCalender.superview?.isHidden = false
            } else {
               
                cell.btnCalender.superview?.isHidden = true
            }
            return cell
        case tblMyRideType:
            
            print(cell.frame.size)
            let cell:MyrideCell = tblMyRideType.dequeueReusableCell(withIdentifier: MyrideCell.reuseIdentifier, for: indexPath)as! MyrideCell
            cell.lblMyride.text = myRideArr[indexPath.row]
            cell.imgSelect.isHidden = true
            if indexPath.row == selectedMyRideState {
                cell.imgSelect.isHidden = false
            }
            return cell
        default:
            print("Something is Wrong")
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch tableView {
        case tblMyRides:
            if selectedMyRideState == 0 {
                let controller = AppStoryboard.Main.instance.instantiateViewController(withIdentifier: addPaymentVC.storyboardID) as! addPaymentVC
                self.navigationController?.pushViewController(controller, animated: true)
            } else {
                let controller = AppStoryboard.Main.instance.instantiateViewController(withIdentifier: RideDetailsVC.storyboardID)
                self.navigationController?.pushViewController(controller, animated: true)
            }
            
            break
        case tblMyRideType:
            selectedMyRideState = indexPath.row
            self.btnUpcoming.setTitle(myRideArr[selectedMyRideState], for: .normal)
            tblMyRideType.reloadData()
            setRideTableView()
        default:
            break
        }
       
        
        
    }
    
    
    
    func setupLocalization(){
        btnUpcoming.setTitle("MyRidesVC_btnUpcoming", for: .normal)
        lblMyRides.text = "MyRidesVC_lblMyRides".Localized()
    }
    //MARK: -IBActions
    @IBAction func btnMyRidesTap(_ sender: Any) {
        setRideTableView()
       
    }
    
    func setRideTableView() {
        if viewTblRideType.isHidden {
            
            self.viewTblRideType.isHidden = false
            
            UIView.animate(withDuration: 0.3, animations: {
               
                self.btnUpcoming.imageView?.transform = CGAffineTransform(rotationAngle: .pi)
                self.tblMyRideType.frame.size.height = self.tblMyRideType.contentSize.height * 2
                
            }, completion: {finished in
                
                 self.tblMyRides.reloadData()
            })
        } else {
            
            UIView.animate(withDuration: 0.3, animations: {
                self.btnUpcoming.imageView?.transform = CGAffineTransform(rotationAngle: 0)
                self.tblMyRideType.frame.size.height = 0
            }, completion: {finished in
                self.viewTblRideType.isHidden = true
                
                  self.tblMyRides.reloadData()
            })
        }
    }
    
    
    //MARK: -API Calls
    
}
class MyridesCell:UITableViewCell{
    @IBOutlet weak var lblDate: myRidesLabel!
    @IBOutlet weak var lblName: myRidesLabel!
    @IBOutlet weak var lblAddress: myRidesLabel!
    @IBOutlet weak var lblPrice: myRidesLabel!
    @IBOutlet weak var lblTotal: myRidesLabel!
    @IBOutlet weak var btnCalender: UIButton!
    override func awakeFromNib() {
        setupLocalization()
    }
    func setupLocalization(){
        lblDate.text = "MyRidesVC_lblDate".Localized()
        lblName.text = "MyRidesVC_lblName".Localized()
        lblAddress.text = "MyRidesVC_lblAddress".Localized()
        lblPrice.text = "MyRidesVC_lblPrice".Localized()
        lblTotal.text = "MyRidesVC_lblTotal".Localized()
    }
}
class MyrideCell:UITableViewCell{
    @IBOutlet weak var lblMyride: UILabel!
    @IBOutlet weak var imgSelect: UIImageView!
    override func awakeFromNib() {
        setupLocalization()
    }
    func setupLocalization(){
        lblMyride.text = "MyRidesVC_lblMyride".Localized()
    }
    
}
