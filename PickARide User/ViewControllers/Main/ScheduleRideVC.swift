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
    var setClosour : (() -> ())?
    var selectedDate = ""
    //MARK: -IBOutlets
    
    @IBOutlet weak var btnSet: submitButton!
    @IBOutlet weak var btnCancel: scheduleRideButton!
    @IBOutlet weak var lblSeheduleRide: ScheduleARide!
    @IBOutlet weak var scheduleDatePicker: UIDatePicker!
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
        self.dismiss(animated: true, completion: nil)
        let dateFormatter = DateFormatter()

           dateFormatter.dateStyle = DateFormatter.Style.short
           dateFormatter.timeStyle = DateFormatter.Style.short

           selectedDate = dateFormatter.string(from: scheduleDatePicker.date)
        if let click = self.setClosour {
            click()
        }
    }
    
    //MARK: -API Calls
    
    
    
    
}
