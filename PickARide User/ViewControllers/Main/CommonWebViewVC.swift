//
//  CommonWebViewVC.swift
//  PickARide User
//
//  Created by apple on 04/02/21.
//  Copyright © 2021 EWW071. All rights reserved.
//

import UIKit
import WebKit

class CommonWebViewVC: BaseViewController, WKNavigationDelegate {
    
    //MARK: - Properties
    var strUrl = ""
    private let webView = WKWebView(frame: .zero)
    var strNavTitle = ""
    
    // MARK: - IBOutlets
    @IBOutlet weak var vwWebMain: UIView!
    
    // MARK: - ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.post(name: NotificationRefreshSideMenu, object: nil)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: - Other Methods
    func setUp() {
        setNavigationBarInViewController(controller: self, naviColor: colors.appColor.value, naviTitle: strNavTitle, leftImage: NavItemsLeft.back.value, rightImages: [NavItemsRight.none.value], isTranslucent: true, CommonViewTitles: [])
        webView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.webView)
        NSLayoutConstraint.activate([
            self.webView.leftAnchor.constraint(equalTo: self.vwWebMain.leftAnchor),
            self.webView.bottomAnchor.constraint(equalTo: self.vwWebMain.bottomAnchor),
            self.webView.rightAnchor.constraint(equalTo: self.vwWebMain.rightAnchor),
            self.webView.topAnchor.constraint(equalTo: self.vwWebMain.topAnchor),
        ])
        self.view.setNeedsLayout()
        if strUrl != "" {
        let request = URLRequest(url: URL.init(string: strUrl)!)
        self.webView.navigationDelegate = self
        self.webView.load(request)
        } else {
        strUrl = "https://www.google.com"
        let request = URLRequest(url: URL.init(string: strUrl)!)
        self.webView.navigationDelegate = self
        self.webView.load(request)
        }
//        Utilities.showHud()
    }
    
    // MARK: - IBActions
    
    // MARK: - Api Calls
}
