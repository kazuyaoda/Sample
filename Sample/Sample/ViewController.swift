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
//        backButton.isHidden = true
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
        let viewController = SampleViewController()
        present(viewController, animated: true, completion: nil)
    }
    
    @objc private func goForward() {
        webView.goForward()
    }
}

extension ViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
//        backButton.isHidden = webView.canGoBack ? false : true
//        forwardButton.isHidden = webView.canGoForward ? false : true
    }
    
    func webView(_ webView: WKWebView,
                 decidePolicyFor navigationAction: WKNavigationAction,
                 decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        guard let url = navigationAction.request.url else {
            decisionHandler(.cancel)
            return
        }
        
        print(url)
        
        if url.absoluteString.range(of: "//itunes.apple.com/") != nil {
            if UIApplication.shared.responds(to: #selector(UIApplication.open(_:options:completionHandler:))) {
                UIApplication.shared.open(url,
                                          options: [UIApplicationOpenURLOptionUniversalLinksOnly: false],
                                          completionHandler: { (finished: Bool) in
                                            print(finished)
                })
            } else {
                // iOS 10 で deprecated 必要なら以降のopenURLも振り分ける
                // iOS 10以降は UIApplication.shared.open(url, options: [:], completionHandler: nil)
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
            decisionHandler(.cancel)
            return
        } else if !url.absoluteString.hasPrefix("http://")
            && !url.absoluteString.hasPrefix("https://") {
            // URL Schemeをinfo.plistで公開しているアプリか確認
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
                decisionHandler(.cancel)
                return
            }
            //                // 確認せずとりあえず開く
            //                UIApplication.shared.openURL(url)
            //                decisionHandler(.cancel)
            //                return
        }
        
        switch navigationAction.navigationType {
        case .linkActivated:
            if navigationAction.targetFrame == nil
                || !navigationAction.targetFrame!.isMainFrame {
                // <a href="..." target="_blank"> が押されたとき
                webView.load(URLRequest(url: url))
                decisionHandler(.cancel)
                return
            }
        case .backForward:
            break
        case .formResubmitted:
            break
        case .formSubmitted:
            break
        case .other:
            break
        case .reload:
            break
        } // 全要素列挙した場合はdefault不要 (足りない要素が追加されたときにエラーを吐かせる目的)
        
        decisionHandler(.allow)
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
