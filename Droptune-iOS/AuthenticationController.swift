//
//  ScriptMessage.swift
//  Droptune-iOS
//
//  Created by Daniel Westendorf on 12/29/19.
//  Copyright © 2019 Daniel Westendorf. All rights reserved.
//

import UIKit
import WebKit

protocol AuthenticationControllerDelegate: class {
    func authenticationControllerDidAuthenticate(_ authenticationController: AuthenticationController)
}

class AuthenticationController: UIViewController {
    fileprivate let loginSuccessUrl = URL(string: "https://droptune.co/")!
    
    var url: URL?
    var webViewConfiguration: WKWebViewConfiguration?
    weak var delegate: AuthenticationControllerDelegate?
    
    lazy var webView: WKWebView = {
        let configuration = self.webViewConfiguration ?? WKWebViewConfiguration()
        let webView = WKWebView(frame: CGRect.zero, configuration: configuration)
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.navigationDelegate = self
        return webView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(webView)
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|", options: [], metrics: nil, views: [ "view": webView ]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[view]|", options: [], metrics: nil, views: [ "view": webView ]))
        
        if let url = self.url {
            webView.load(URLRequest(url: url))
        }
    }
}

extension AuthenticationController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        guard let url = navigationAction.request.url else { return }
        
        NSLog("Auth URL is: %@", url.absoluteString)
        
        if url == loginSuccessUrl {
            decisionHandler(.cancel)
            delegate?.authenticationControllerDidAuthenticate(self)
            return
        }
        
        decisionHandler(.allow)
    }
}

