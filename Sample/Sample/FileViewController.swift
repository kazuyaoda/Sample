import UIKit
import WebKit

class FileViewController: UIViewController {

    var webView: WKWebView!
    @IBOutlet weak var backButton: UIButton!
    
    override func loadView() {
        super.loadView()
        /*
        let webConfiguration = WKWebViewConfiguration()
        webConfiguration.applicationNameForUserAgent = "test-app"
        
        let frame = CGRect(x: 0, y: 65, width: view.frame.size.width, height: view.frame.size.height - CGFloat(65))
        webView = WKWebView(frame: frame, configuration: webConfiguration)
        webView.navigationDelegate = self
        webView.uiDelegate = self
        self.view.addSubview(webView)
 */
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*
        var request = URLRequest(url: URL(string: "https://www.google.co.jp")!)
        request.httpMethod = "GET"

        self.webView.load(request)
        */
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}

extension FileViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
    }
    
}

extension FileViewController: WKUIDelegate {
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
