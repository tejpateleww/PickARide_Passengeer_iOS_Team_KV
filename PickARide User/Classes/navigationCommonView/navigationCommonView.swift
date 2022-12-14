//
//  navigationCommonView.swift
//  PickARide User
//
//  Created by Apple on 19/01/21.
//  Copyright © 2021 EWW071. All rights reserved.
//

import UIKit

class navigationCommonView: UIView {
    @IBOutlet weak var lblStartRideAddress: themeMarqueeLabel!
    @IBOutlet weak var lblEndRideAddress: themeMarqueeLabel!
    @IBOutlet weak var btnNavigation: UIButton!
    @IBOutlet weak var selectTaxiVW: suggestedTaxiView!
    
    // MARK: - Properties
    var contentView:UIView?
    @IBInspectable var nibName:String?

    
    // MARK: - IBOutlets
    override func awakeFromNib() {
        super.awakeFromNib()
        xibSetup()
       
      
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        selectTaxiVW.addShadow()
        selectTaxiVW.cornerRadius = 8
    }
    
    //MARK:- ====== Btn Action Navigation =====
    @IBAction func btnActionNavigation(_ sender: UIButton) {
        
        NotificationCenter.default.post(name: .OpenLocationSelectionVC, object: nil, userInfo: nil)
    }
    
    
    func xibSetup() {
        guard let view = loadViewFromNib() else { return }
        view.frame = bounds
       // view.autoresizingMask =
         //   [.flexibleWidth, .flexibleHeight]
        addSubview(view)
        contentView = view
        
    }
    
    func loadViewFromNib() -> UIView? {
        guard let nibName = nibName else { return nil }
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(
            withOwner: self,
            options: nil).first as? UIView
    }
    class func instanceFromNib() -> navigationCommonView {
        return UINib(nibName: "navigationCommonView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! navigationCommonView
           }
    
}
public extension UIView
{
    static func loadFromXib<T>(withOwner: Any? = nil, options: [UINib.OptionsKey : Any]? = nil) -> T where T: UIView
    {
        let bundle = Bundle(for: self)
        let nib = UINib(nibName: "\(self)", bundle: bundle)

        guard let view = nib.instantiate(withOwner: withOwner, options: options).first as? T else {
            fatalError("Could not load view from nib file.")
        }
        return view
    }
}
