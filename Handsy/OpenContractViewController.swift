//
//  OpenContractViewController.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 9/18/17.
//  Copyright © 2017 Ahmed Wahdan. All rights reserved.
//

import UIKit

class OpenContractViewController: UIViewController, UIWebViewDelegate {
    @IBOutlet weak var WebViewContract: UIWebView!
    var url: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        WebViewContract.delegate = self
        if let urlContract = URL(string: url) {
            let request = URLRequest(url: urlContract)
            WebViewContract.loadRequest(request)
        }
        
        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
