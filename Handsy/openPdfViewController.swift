//
//  openPdfViewController.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 8/15/17.
//  Copyright © 2017 Ahmed Wahdan. All rights reserved.
//

import UIKit
import Alamofire


class openPdfViewController: UIViewController, UIWebViewDelegate {
    @IBOutlet weak var WebViewPdf: UIWebView!
    @IBOutlet weak var OK: UIButton!{
        didSet {
            OK.layer.cornerRadius = 4.0
        }
    }
    @IBOutlet weak var Cancel: UIButton!{
        didSet {
            Cancel.layer.cornerRadius = 4.0
        }
    }
    @IBOutlet weak var BtnOutLet: UIStackView!
    
    var reloadApi: reloadApi?
    var url: String = ""
    var Webtitle: String = "التصميم المقترح"
    var condBottomButtons = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = Webtitle
        WebViewPdf.delegate = self
        if condBottomButtons == "AcceptAndEdit" {
            BtnOutLet.isHidden = false
            OK.isHidden = false
            Cancel.isHidden = false
        }else if condBottomButtons == "Edit" {
            BtnOutLet.isHidden = false
            OK.isHidden = true
            Cancel.isHidden = false
        }else {
            BtnOutLet.isHidden = true
            OK.isHidden = true
            Cancel.isHidden = true
        }
        if let urlPdf = URL(string: url) {
            let request = URLRequest(url: urlPdf)
            WebViewPdf.loadRequest(request)
        }
    }
    
    @IBAction func designCancel(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "DesignsAndDetails", bundle: nil)
        let secondView = storyBoard.instantiateViewController(withIdentifier: "AlertDetialsDesignCancelViewController") as! AlertDetialsDesignCancelViewController
        secondView.reloadApi = reloadApi!
        secondView.modalPresentationStyle = .custom
        self.present(secondView, animated: true)
    }
    
    @IBAction func designOk(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "DesignsAndDetails", bundle: nil)
        let secondView = storyBoard.instantiateViewController(withIdentifier: "AlertDetialsDesignOKViewController") as! AlertDetialsDesignOKViewController
        secondView.reloadApi = reloadApi!
        secondView.modalPresentationStyle = .custom
        self.present(secondView, animated: true)
    }
    
    @IBAction func downloadPdf(_ sender: UIBarButtonItem) {
        download(url: url)
    }

    func download(url: String){
        let destination: DownloadRequest.DownloadFileDestination = { _, _ in
            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let date = Date(timeIntervalSinceNow: 0)
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .medium
            dateFormatter.string(from: date)
            if url.range(of:"pdf") != nil {
                print("Yes it contains 'pdf'")
                let fileURL = documentsURL.appendingPathComponent("file\(date).pdf")
                return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
            } else if url.range(of:"jpeg") != nil {
                let fileURL = documentsURL.appendingPathComponent("file\(date).jpeg")
                print("Yes it contains 'jpeg'")
                return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
            } else {
                let fileURL = documentsURL.appendingPathComponent("file\(date).png")
                print("Yes it contains 'png'")
                return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
            }
        }
        
        Alamofire.download(url, to: destination).response { response in
            print(response)
        }
    }

}
