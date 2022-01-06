//
//  UIView+Extension.swift
//  CoreSound
//
//  Created by EWW083 on 04/02/20.
//  Copyright © 2020 EWW083. All rights reserved.
//
import Foundation
import UIKit

extension UIView {
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    func setUpAutomaticRadius(){
        layer.cornerRadius = layer.frame.height/2
    }
    
    public func setGradientView(topGradientColor: UIColor?, bottomGradientColor: UIColor?) {
        let gradientLayer = CAGradientLayer()
        if let topGradientColor = topGradientColor, let bottomGradientColor = bottomGradientColor {
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
            gradientLayer.frame = bounds
            gradientLayer.colors = [topGradientColor.cgColor, bottomGradientColor.cgColor]
            gradientLayer.borderColor = layer.borderColor
            gradientLayer.borderWidth = layer.borderWidth
            gradientLayer.cornerRadius = self.frame.height/2
            layer.insertSublayer(gradientLayer, at: 0)
        } else {
            gradientLayer.removeFromSuperlayer()
        }
    }
    
    func setBorderColor(bcolor:colors){
        self.layer.borderColor  = bcolor.value.cgColor
        self.layer.borderWidth = 1
    }
    
    @IBInspectable var shadow: Bool {
        get {
            return layer.shadowOpacity > 0.0
        }
        set {
            self.addShadow()
            if newValue == true {
                self.addShadow()
            }else{
                self.layer.shadowOpacity = 0.0
            }
        }
    }
    
    @IBInspectable var AddBorder: Bool {
        get {
            return layer.borderWidth == 0
        }
        set {
            self.addBorder()
            if newValue == true {
                self.addBorder()
            }else{
                self.layer.borderWidth = 0.0
            }
        }
    }
    
    func addBorder(){
        layer.borderWidth = 1.5
        layer.cornerRadius = self.frame.height / 2
        layer.backgroundColor = ThemeColorEnum.ThemeWhite.rawValue.cgColor
        layer.borderColor = ThemeColorEnum.ImageBorder.rawValue.cgColor
    }
    
    func addShadow(shadowColor: CGColor = UIColor.black.withAlphaComponent(0.7).cgColor,
                   shadowOffset: CGSize = CGSize(width: 1.0, height: 2.0),
                   shadowOpacity: Float = 0.4,
                   shadowRadius: CGFloat = 3.0) {
        layer.shadowColor = shadowColor
        layer.shadowOffset = shadowOffset
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
    }
    
}

extension UIView{
    //-------------------------------------
    // MARK:- Instantiate View
    //-------------------------------------
    
    class func fromNib<T: UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
    
    //-------------------------------------------
    // MARK:- identifier Variable for View, Cells
    //-------------------------------------------
    
    static var identifier: String{
        return String(describing: self)
    }
    
    //-------------------------------------
    // MARK:- Remove All Subviews
    //-------------------------------------
    
    func removeAllSubviews(){
        self.subviews.forEach({
            $0.removeFromSuperview()
        })
    }
    
    //-------------------------------------
    // MARK:- Add Subview with animation
    //-------------------------------------
    func customAddSubview(_ view: UIView){
        self.isHidden = false
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.autoresizingMask = [.flexibleHeight]
        self.bounds.size = view.frame.size
        view.frame = self.bounds
        
        UIView.transition(with: self,
                          duration: 0.4,
                          options: .curveEaseInOut,
                          animations: {
                            self.removeAllSubviews()
                            self.addSubview(view)
        }, completion: nil)
        
    }
    func addSubviewWithTransition(_ view: UIView, mainView: UIView){
       
        self.isHidden = false
        let xOffset: CGFloat = self.frame.minX
        
        self.autoresizingMask = [.flexibleLeftMargin,.flexibleRightMargin,.flexibleWidth, .flexibleHeight]
        view.autoresizingMask = [.flexibleLeftMargin,.flexibleRightMargin,.flexibleWidth, .flexibleHeight]
        view.bounds.size.width = self.bounds.width
        self.bounds.size.height = max(self.bounds.height, view.bounds.height)

        let tempView = UIView(frame: CGRect(x: xOffset + self.bounds.width, y: 62,
                                            width: self.bounds.width, height: view.frame.height))
        
        view.frame.origin.x = 0
        tempView.frame.origin.x = xOffset
        self.frame.origin.x = -xOffset - self.bounds.width
        tempView.addSubview(view)
        mainView.addSubview(tempView)
      
        UIView.animate(withDuration: 0.7, animations: {
          self.layoutIfNeeded()
        }) { (_) in
            tempView.removeFromSuperview()
            self.removeAllSubviews()
            self.bounds.size.height = view.bounds.height
            self.frame.origin.x = xOffset
            self.addSubview(view)
        }
        
    }
    
    func addVisualFormatConstraints(format: String, views: UIView...){
        var viewsDictionary = [String: UIView]()
        
        for (index, view) in views.enumerated(){
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        let constraint = NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDictionary)
        addConstraints(constraint)
    }
    
    @objc func validation() -> Bool{
        /// Override this to validate View
        return true
    }
    @objc func validationWithCompletion(_ completion: @escaping ((Bool) -> ())){
        /// Override this to validate View
        completion(true)
    }
    @objc func setupTextField(){
        /// Override this to Setup TextField
    }
     public func viewContainingController()->UIViewController? {
        
        var nextResponder: UIResponder? = self
        
        repeat {
            nextResponder = nextResponder?.next
            
            if let viewController = nextResponder as? UIViewController {
                return viewController
            }
            
        } while nextResponder != nil
        
        return nil
    }
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
      func parentContainerViewController()->UIViewController? {
        
        var matchController = viewContainingController()
        var parentContainerViewController : UIViewController?
        
        if var navController = matchController?.navigationController {
            
            while let parentNav = navController.navigationController {
                navController = parentNav
            }
            
            var parentController : UIViewController = navController
            
            while let parent = parentController.parent,
                (parent.isKind(of: UINavigationController.self) == false &&
                    parent.isKind(of: UITabBarController.self) == false &&
                    parent.isKind(of: UISplitViewController.self) == false) {
                        
                        parentController = parent
            }
            
            if navController == parentController {
                parentContainerViewController = navController.topViewController
            } else {
                parentContainerViewController = parentController
            }
        }
        else if let tabController = matchController?.tabBarController {
            
            if let navController = tabController.selectedViewController as? UINavigationController {
                parentContainerViewController = navController.topViewController
            } else {
                parentContainerViewController = tabController.selectedViewController
            }
        } else {
            while let parentController = matchController?.parent,
                (parentController.isKind(of: UINavigationController.self) == false &&
                    parentController.isKind(of: UITabBarController.self) == false &&
                    parentController.isKind(of: UISplitViewController.self) == false) {
                        
                        matchController = parentController
            }
            
            parentContainerViewController = matchController
        }
        
        let finalController = parentContainerViewController ?? parentContainerViewController
        
        return finalController
        
    }
    
    func startRotating(duration: Double = 2) {
        let kAnimationKey = "rotation"
        
        if self.layer.animation(forKey: kAnimationKey) == nil {
            let animate = CABasicAnimation(keyPath: "transform.rotation")
            animate.duration = duration
            animate.repeatCount = Float.infinity
            animate.fromValue = 0.0
            animate.toValue = Double.pi * 2
            self.layer.add(animate, forKey: kAnimationKey)
        }
    }
    func stopRotating() {
        let kAnimationKey = "rotation"
        
        if self.layer.animation(forKey: kAnimationKey) != nil {
            self.layer.removeAnimation(forKey: kAnimationKey)
        }
    }
    
    func hideShowViews(hide : Bool, views: [UIView]){
        for view in views{
            if view.isHidden != hide{
                view.isHidden = hide
            }
        }
    }
    

}
