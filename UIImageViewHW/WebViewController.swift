//
//  WebViewController.swift
//  UIImageViewHW
//
//  Created by Иван on 6/29/21.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    internal var url = ""
    
    @IBOutlet weak var goBackItem: UIBarButtonItem!
    @IBOutlet weak var goForwardItem: UIBarButtonItem!
    @IBOutlet weak var refreshItem: UIBarButtonItem!
    
    
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        request(for: url)
    
    }
    
    private func request(for url: String) {
        guard let myUrl = URL(string: url) else { return }
        let request = URLRequest(url: myUrl)
        webView.load(request)
    }
    
    @IBAction func goBackAction(_ sender: Any) {
        if webView.canGoBack {
            webView.goBack()
        }
    }
    
    @IBAction func goForwardAction(_ sender: Any) {
        if webView.canGoForward {
            webView.goForward()
        }
    }
    
    @IBAction func refreshAction(_ sender: Any) {
        webView.reload()
    }
    
}
