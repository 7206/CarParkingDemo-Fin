//
//  FAQVC.swift
//  CarParkingDemo
//
//  Created by admin on 27/09/19.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit
import WebKit
class FAQVC: UIViewController,WKNavigationDelegate {
    
    @IBOutlet weak var backbtnoutlet: UIButton!
    @IBOutlet weak var webview: WKWebView!
    @IBOutlet weak var activityindicator: UIActivityIndicatorView!
    
    @IBOutlet weak var titlelbl: UILabel!
    
    @IBAction func backbtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://google.com")!
        webview.load(URLRequest(url: url))
        
        webview.addSubview(activityindicator)
        activityindicator.startAnimating()
        
        webview.navigationDelegate=self
        activityindicator.hidesWhenStopped = true
        backbtnoutlet.contentVerticalAlignment = .fill
        backbtnoutlet.contentHorizontalAlignment = .fill
        backbtnoutlet.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    override func viewWillAppear(_ animated: Bool) {
        activityindicator.startAnimating()
        
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityindicator.stopAnimating()
        title = webView.title
    }
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        activityindicator.stopAnimating()
    }
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        activityindicator.startAnimating()
    }
    
    
    
    
}
