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
    
    @IBOutlet weak var vwWebMain: UIView!
    
    var strUrl = ""
    private let webView = WKWebView(frame: .zero)
    var strNavTitle = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.navigationController?.navigationBar.showNavBarSeparator()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.post(name: NotificationRefreshSideMenu, object: nil)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func setUp() {
        setNavigationBarInViewController(controller: self, naviColor: .white, naviTitle: strNavTitle, leftImage: NavItemsLeft.back.value, rightImages: [NavItemsRight.none.value], isTranslucent: true, CommonViewTitles: [], isTwoLabels: false)
        webView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.webView)
        NSLayoutConstraint.activate([
            self.webView.leftAnchor.constraint(equalTo: self.vwWebMain.leftAnchor),
            self.webView.bottomAnchor.constraint(equalTo: self.vwWebMain.bottomAnchor),
            self.webView.rightAnchor.constraint(equalTo: self.vwWebMain.rightAnchor),
            self.webView.topAnchor.constraint(equalTo: self.vwWebMain.topAnchor),
        ])
        
        self.view.setNeedsLayout()
        
        if let url = URL(string: strUrl){
            let request = URLRequest(url: url)
            self.webView.navigationDelegate = self
            self.webView.load(request)
        }
    }
    
}
