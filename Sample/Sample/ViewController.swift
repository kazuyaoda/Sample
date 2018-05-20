//
//  ViewController.swift
//  Sample
//
//  Created by 小田和哉 on 2018/05/17.
//  Copyright © 2018年 K.oda. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {

    var webView: WKWebView!
    var forwardButton: UIButton!
    var backButton: UIButton!
    private var _observer = [NSKeyValueObservation]()
    
    override func loadView() {
        super.loadView()

        let webConfiguration = WKWebViewConfiguration()
        webConfiguration.applicationNameForUserAgent = "test-app"
        
        webView = WKWebView(frame: view.frame, configuration: webConfiguration)
        webView.navigationDelegate = self
        webView.uiDelegate = self
        
        self.view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var request = URLRequest(url: URL(string: "https://www.google.co.jp")!)
        request.httpMethod = "GET"
        
//        let bodyData = "terminal_id" + UIDevice.current.identifierForVendor!.uuidString
//        request.httpBody = bodyData.data(using: .utf8)
        self.webView.load(request)
        self.createControlParts()
        
        _observer.append(webView.observe(\.estimatedProgress, options: .new) { _, change in
            print("Progress: \(String(describing: change.newValue))")
        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func createControlParts() {
        let buttonSize = CGSize(width: 40, height: 40)
        let offseetUnderBottom: CGFloat = 60
        let yPos = (view.frame.height - offseetUnderBottom)
        let buttonPadding: CGFloat = 10
        
        let backButtonPos = CGPoint(x: buttonPadding, y: yPos)
        let forwardButtonPos = CGPoint(x: (buttonPadding + buttonSize.width + buttonPadding), y: yPos)
        
        backButton = UIButton(frame: CGRect(origin: backButtonPos, size: buttonSize))
        forwardButton = UIButton(frame: CGRect(origin: forwardButtonPos, size: buttonSize))
        
        backButton.setTitle("<", for: .normal)
        backButton.setTitle("< ", for: .highlighted)
        backButton.setTitleColor(.white, for: .normal)
        backButton.layer.backgroundColor = UIColor.black.cgColor
        backButton.layer.opacity = 0.6
        backButton.layer.cornerRadius = 5.0
        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        backButton.isHidden = true
        webView.addSubview(backButton)
        print("\(webView.frame.size)")
        print("\(backButton.frame)")
        
        forwardButton.setTitle(">", for: .normal)
        forwardButton.setTitle(" >", for: .highlighted)
        forwardButton.setTitleColor(.white, for: .normal)
        forwardButton.layer.backgroundColor = UIColor.black.cgColor
        forwardButton.layer.opacity = 0.6
        forwardButton.layer.cornerRadius = 5.0
        forwardButton.addTarget(self, action: #selector(goForward), for: .touchUpInside)
        forwardButton.isHidden = true
        view.addSubview(forwardButton)

    }
    
    @objc private func goBack() {
        webView.goBack()
    }
    
    @objc private func goForward() {
        webView.goForward()
    }
}

extension ViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        backButton.isHidden = webView.canGoBack ? false : true
        forwardButton.isHidden = webView.canGoForward ? false : true
    }
}

extension ViewController: WKUIDelegate {
    func webView(_ webView: WKWebView,
                 createWebViewWith configuration: WKWebViewConfiguration,
                 for navigationAction: WKNavigationAction,
                 windowFeatures: WKWindowFeatures) -> WKWebView? {
        if navigationAction.targetFrame == nil {
            webView.load(navigationAction.request)
        }
        return nil
    }
}
