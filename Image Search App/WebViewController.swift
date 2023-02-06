//
//  WebViewController.swift
//  Image Search App
//
//  Created by Николай Стукало on 06.02.2023.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    
    @IBOutlet weak var webView: WKWebView!
    
    var url: URL!

        override func viewDidLoad() {
            super.viewDidLoad()
            webView.load(URLRequest(url: url))
        }
}
