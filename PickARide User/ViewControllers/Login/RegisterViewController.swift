//
//  RegisterViewController.swift
//  ApiStructureModule
//
//  Created by EWW071 on 14/03/20.
//  Copyright © 2020 EWW071. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController, UITextViewDelegate {
  
    //MARK: -Properties
    
    //MARK: -IBOutlets
    @IBOutlet weak var textView: UITextView!
   
    //MARK: -View Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAttributeText()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    //MARK: -other methods
    func setAttributeText()
    {//""  as well as our privacy policy
        let text = NSMutableAttributedString(string: "By clicking \"Sign Up\" you agree to our ")
        text.addAttribute(NSAttributedString.Key.font, value: CustomFont.regular.returnFont(13), range: NSMakeRange(0, text.length))

                let selectablePart = NSMutableAttributedString(string: "terms and conditions")
                selectablePart.addAttribute(NSAttributedString.Key.font, value: CustomFont.regular.returnFont(13), range: NSMakeRange(0, selectablePart.length))
                // Add an underline to indicate this portion of text is selectable (optional)
                selectablePart.addAttribute(NSAttributedString.Key.underlineStyle, value: 1, range: NSMakeRange(0,selectablePart.length))
        selectablePart.addAttribute(NSAttributedString.Key.underlineColor, value: colors.loginPlaceHolderColor.value, range: NSMakeRange(0, selectablePart.length))
                // Add an NSLinkAttributeName with a value of an url or anything else
                selectablePart.addAttribute(NSAttributedString.Key.link, value: "termsAndConditions", range: NSMakeRange(0,selectablePart.length))

                // Combine the non-selectable string with the selectable string
                text.append(selectablePart)

                // Center the text (optional)
                let paragraphStyle = NSMutableParagraphStyle()
                paragraphStyle.alignment = NSTextAlignment.left
                text.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, text.length))
       
                // To set the link text color (optional)
        textView.linkTextAttributes = [NSAttributedString.Key.foregroundColor:colors.loginPlaceHolderColor.value, NSAttributedString.Key.font: CustomFont.regular.returnFont(13)]
                // Set the text view to contain the attributed text
                textView.attributedText = text
                // Disable editing, but enable selectable so that the link can be selected
                textView.isEditable = false
                textView.isSelectable = true
                // Set the delegate in order to use textView(_:shouldInteractWithURL:inRange)
                textView.delegate = self
    }
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {

            // **Perform sign in action here**
        print(URL)

            return false
        }
    //MARK: -IBActions
    
    
    //MARK: -API Calls
    
    
    
    
    
   
    
}
