//
//  SampleViewController.swift
//  Sample
//
//  Created by 小田和哉 on 2018/05/24.
//  Copyright © 2018年 K.oda. All rights reserved.
//

import UIKit
import WebKit

class SampleViewController: UIViewController, WKNavigationDelegate, WKUIDelegate {

    var webView: WKWebView!
    @IBOutlet weak var mainView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let webConfiguration = WKWebViewConfiguration()
        webConfiguration.applicationNameForUserAgent = "test-app"
        
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        
        let frame = CGRect(x: 0, y: 65 + statusBarHeight,
                           width: UIScreen.main.bounds.width,
                           height: UIScreen.main.bounds.height - statusBarHeight)
        webView = WKWebView(frame: frame, configuration: webConfiguration)
        webView.navigationDelegate = self
        webView.uiDelegate = self
        self.view.addSubview(webView)
        
        var request = URLRequest(url: URL(string: "https://www.google.co.jp")!)
        request.httpMethod = "GET"
        
        self.webView.load(request)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
