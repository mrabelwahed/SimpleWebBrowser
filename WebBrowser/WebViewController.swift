//
//  ViewController.swift
//  WebBrowser
//
//  Created by MahmoudRamadan on 12/8/20.
//  Copyright © 2020 MahmoudRamadan. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    var webView : WKWebView? {
        return view as? WKWebView
    }
    
    lazy var searchController = UISearchController(searchResultsController: nil)
    //toolbar items
    lazy var backButton = UIBarButtonItem(barButtonSystemItem: .rewind, target: webView, action: #selector(WKWebView.goBack))
    
    lazy var forwardButton = UIBarButtonItem(barButtonSystemItem: .fastForward, target: webView, action: #selector(WKWebView.goForward))
    
    lazy var shareButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(openShare(sender:)))
    
    var url :URL? {
        get {
          return webView?.url
        }
        
        set{
            if let url = newValue{
                load(url: url)
            }
        }
    }
    
    func load(url:URL){
        if (UIApplication.shared.canOpenURL(url)){
            let request = URLRequest(url: url)
            webView?.load(request)
            UserDefaults.standard.lastURL = url
        }else{
            print("url is not valid")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        url = UserDefaults.standard.lastURL
    
        toolbarItems = createToolbarItems()
        navigationItem.searchController = self.searchController
        searchController.searchBar.delegate = self
        webView?.navigationDelegate = self
        backButton.isEnabled = false
        forwardButton.isEnabled = false
    }

    func createToolbarItems() -> [UIBarButtonItem]{
        return [backButton ,
                UIBarButtonItem(fixedSpaceWidth: 22),
                forwardButton ,
                UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
                shareButton]
    }
    
    @objc func openShare(sender:UIBarButtonItem){
        if let url = url{
            let sheet = UIActivityViewController(activityItems: [url], applicationActivities: nil)
            present(sheet, animated: true, completion: nil)
        }
        
    }


}

extension WebViewController : UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text,let url = URL(string: text){
            self.url = url
        }
    }
}

extension WebViewController : WKNavigationDelegate{
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        if let url =  url{
            title = url.host
            backButton.isEnabled =  webView.canGoBack
            forwardButton.isEnabled =  webView.canGoForward
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
        }
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
}
