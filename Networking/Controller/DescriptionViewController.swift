//
//  DescriptionViewController.swift
//  Networking
//
//  Created by Eugene Kiselev on 28.09.2020.
//

import UIKit
import WebKit

class DescriptionViewController: UIViewController, WKNavigationDelegate {
    
    @IBOutlet weak var webView: WKWebView!
    
    var selectedCourse: String?
    var courseURL = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = selectedCourse
        
        guard let url = URL(string: courseURL) else { return }
        let request = URLRequest(url: url)
        
        webView.load(request)
        webView.allowsBackForwardNavigationGestures = true
        webView.navigationDelegate = self
    }
}

