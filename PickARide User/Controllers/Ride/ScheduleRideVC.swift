//
//  ScheduleRideVC.swift
//  PickARide User
//
//  Created by Apple on 18/01/21.
//  Copyright © 2021 EWW071. All rights reserved.
//

import UIKit

class ScheduleRideVC: BaseViewController {

    //MARK: -Properties
    var setClosour : ((String , Int) -> ())?
    var selectedDate = ""
    var selectedTaxi = NSNotFound
    //MARK: -IBOutlets
    
    @IBOutlet weak var btnSet: submitButton!
    @IBOutlet weak var btnCancel: scheduleRideButton!
    @IBOutlet weak var lblSeheduleRide: ScheduleARide!
    @IBOutlet weak var scheduleDatePicker: UIDatePicker!
    
    //MARK:- Variables And Properties
    
    //MARK: -View Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLocalization()
        setValue()
       
        if #available(iOS 13.4, *) {
            scheduleDatePicker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        scheduleDatePicker.minimumDate = Date()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    //MARK: -other methods
    func setLocalization() {
        btnSet.setTitle("ScheduleRideVC_btnSet".Localized(), for: .normal)
        btnCancel.setTitle("ScheduleRideVC_btnCancel".Localized(), for: .normal)
        lblSeheduleRide.text = "ScheduleRideVC_title".Localized()
    }
    func setValue() {
    }
    //MARK: -IBActions
    
    @IBAction func btnCencelClick(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func btnSetClick(_ sender: Any) {
        self.dismiss(animated: true, completion: {
//            if let obj = self.onButtonSetTap{
//                obj()
//            }
        })
        let dateFormatter = DateFormatter()

           dateFormatter.dateStyle = DateFormatter.Style.short
           dateFormatter.timeStyle = DateFormatter.Style.short

           selectedDate = dateFormatter.string(from: scheduleDatePicker.date)
        if let click = self.setClosour {
            click(selectedDate, selectedTaxi)
        }
    }
    
    //MARK: -API Calls
    
    
    
    
}

//MARK:- Picker
extension ScheduleRideVC{
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {

        let label = UILabel(frame: CGRect(x: 0, y: 0, width: pickerView.frame.size.width, height: 44))
        label.textColor = UIColor.green
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.text = " \(row)"
        return label
    }
}

