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
    private var _observer = [NSKeyValueObservation]()
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        self.view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _observer.append(webView.observe(\.estimatedProgress, options: .new) { _, change in
            print("Progress: \(String(describing: change.newValue))")
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
