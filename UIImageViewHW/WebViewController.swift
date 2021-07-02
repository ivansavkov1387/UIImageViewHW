//
//  WebViewController.swift
//  UIImageViewHW
//
//  Created by Иван on 6/29/21.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {
    
    internal var url = ""
    
    @IBOutlet weak var goBackItem: UIBarButtonItem!
    @IBOutlet weak var goForwardItem: UIBarButtonItem!
    @IBOutlet weak var refreshItem: UIBarButtonItem!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = .black
        webView.navigationDelegate = self
        request(for: url)
        
    }
    
    private func request(for url: String) {
        guard let myUrl = URL(string: url) else { return }
        let request = URLRequest(url: myUrl)
        webView.load(request)
    }
    
    private func isWorkIndicator(indicator: UIActivityIndicatorView, isAnimated: Bool) {
        if isAnimated {
            indicator.startAnimating()
            activityIndicator.isHidden = false
        } else {
            indicator.stopAnimating()
            activityIndicator.isHidden = true
        }
    }
    
    private func showActivityController() {
        guard let currentUrl = webView.url?.absoluteString else { return }
        let objectsToShare: [Any] = [currentUrl]
        let activityController = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        self.present(activityController, animated: true)
    }
    
    @IBAction func shareAction(_ sender: Any) {
        showActivityController()
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

extension WebViewController {
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        isWorkIndicator(indicator: activityIndicator, isAnimated: true)
        goBackItem.isEnabled = false
        goForwardItem.isEnabled = false
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        isWorkIndicator(indicator: activityIndicator, isAnimated: false)
        if webView.canGoBack {
            goBackItem.isEnabled = true
        } else if webView.canGoForward {
            goForwardItem.isEnabled = true
        }
        
        
    }
    
}
