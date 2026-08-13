//
//  NewsWebKitVc.swift
//  newsApp
//
//  Created by enjay on 23/06/26.
//

import UIKit
import WebKit
class NewsWebKitVc: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!

    var articleURL: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        webView.navigationDelegate = self
               loadNews()
    }
   
    func loadNews() {

        spinner.isHidden = false
        spinner.startAnimating()

        guard let articleURL = articleURL,
              let url = URL(string: articleURL) else {
           
            spinner.stopAnimating()
            spinner.isHidden = true
            return
        }

        webView.load(URLRequest(url: url))
    
    }
    

}

extension NewsWebKitVc: WKNavigationDelegate {

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {

        spinner.stopAnimating()
        spinner.isHidden = true
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {

        spinner.stopAnimating()
        spinner.isHidden = true
    }
}
