//
//  ShowContractViewController.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 2/20/18.
//  Copyright © 2018 Ahmed Wahdan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import NVActivityIndicatorView

class ShowContractViewController: UIViewController, UIWebViewDelegate {
     var documentInteractionController = UIDocumentInteractionController()
    
    @IBOutlet var viewConfimAccept: UIView!
    var tmpURL:URL?
    
    @IBAction func ConfirmYes(_ sender: Any) {
         AcceptContract()
    }
    @IBAction func ConfirmNo(_ sender: Any) {
        viewConfimAccept.isHidden = true
    }
    var sv = UIView()
    @IBOutlet weak var WebViewContract: UIWebView!
    @IBOutlet weak var AcceptViewOut: UIView!
    @IBOutlet weak var AcceptBtnOut: UIButton!{
        didSet {
            DispatchQueue.main.async {
                self.AcceptBtnOut.layer.cornerRadius = 7.0
                self.AcceptBtnOut.layer.masksToBounds = true
            }
        }
    }
    @IBOutlet weak var editBtnOut: UIButton!{
        didSet {
            DispatchQueue.main.async {
                self.editBtnOut.layer.cornerRadius = 7.0
                self.editBtnOut.layer.masksToBounds = true
            }
        }
    }
    
    var url: String = ""
    var Webtitle: String = "العقد المقترح"
    var ProjectId: String = ""
    
    override func viewDidLoad() {
       
        super.viewDidLoad()
            CountCustomerNotification()
     
        viewConfimAccept.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        view.addSubview(viewConfimAccept)
           viewConfimAccept.isHidden = true
        self.navigationItem.title = Webtitle
        WebViewContract.delegate = self
         customDownload()
        print(url)
        print(url.encodeUrl())
          sv = UIViewController.displaySpinner(onView: self.view)
        view.bringSubview(toFront: sv)
        if let urlPdf = URL(string: url.encodeUrl()) {
            let request = URLRequest(url: urlPdf)
            WebViewContract.loadRequest(request)
            
        }
        
        // Do any additional setup after loading the view.
          downloadPdf()
    }

    func webViewDidFinishLoad(_ webView: UIWebView) {
       
        if webView.isLoading {
            // still loading
          
            return
        }
         UIViewController.removeSpinner(spinner: sv)
         download.isHidden = false
        print("finished")
        // finish and do something here
    }

    func customDownload()
    {
        guard let url = URL(string: url.encodeUrl()) else { return }
        print(url)
        
        var Filename = ""
        if let range = self.url.range(of: "Designs/") {
            Filename = String(self.url[range.upperBound...])
            print(Filename.encodeUrl()) // prints "123.456.7891"
        }
        
        if Filename == ""
        {
            if let range = self.url.range(of: "photo/") {
                Filename = String(self.url[range.upperBound...])
                print(Filename.encodeUrl()) // prints "123.456.7891"
            }
            
        }
        
        if Filename == ""
        {
            if let range = self.url.range(of: "images/") {
                Filename = String(self.url[range.upperBound...])
                print(Filename.encodeUrl()) // prints "123.456.7891"
            }
            
        }
        
        let FilenameFinal = Filename.replacingOccurrences(of: "-", with: " ", options: .literal, range: nil)
        print(FilenameFinal)
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            self.tmpURL = FileManager.default.temporaryDirectory
                .appendingPathComponent(FilenameFinal ?? "Contract.pdf")
            do {
                try data.write(to: self.tmpURL!)
            } catch { print(error) }
            
            }.resume()
        
    }
    
     let download = UIButton(type: .custom)
    func downloadPdf()  {
       
        download.setImage(UIImage (named: "ShareBtn"), for: .normal)
        download.isHidden = true
        download.widthAnchor.constraint(equalToConstant: 30).isActive = true
        download.heightAnchor.constraint(equalToConstant: 30).isActive = true
        download.frame = CGRect(x: 0.0, y: 0.0, width: 35.0, height: 35.0)
        download.addTarget(self, action:#selector(downloadPdfButton), for: .touchUpInside)
        
        let barButtonItem2 = UIBarButtonItem(customView: download)
        barButtonItem2.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItems = [ barButtonItem2]
    }
    //    response?.suggestedFilename ?? "Contract.pdf"
    @objc func downloadPdfButton(sender: UIButton) {
//        guard let url = URL(string: url.encodeUrl()) else { return }
//        print(url)
//
//        var Filename = ""
//        if let range = self.url.range(of: "Designs/") {
//            Filename = String(self.url[range.upperBound...])
//            print(Filename.encodeUrl()) // prints "123.456.7891"
//        }
//
//        if Filename == ""
//        {
//            if let range = self.url.range(of: "photo/") {
//                Filename = String(self.url[range.upperBound...])
//                print(Filename.encodeUrl()) // prints "123.456.7891"
//            }
//
//        }
//
//        let FilenameFinal = Filename.replacingOccurrences(of: "-", with: " ", options: .literal, range: nil)
//        print(FilenameFinal)
//
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            guard let data = data, error == nil else { return }
//            let tmpURL = FileManager.default.temporaryDirectory
//                .appendingPathComponent(FilenameFinal ?? "Contract.pdf")
//            do {
//                try data.write(to: tmpURL)
//            } catch { print(error) }
            DispatchQueue.main.async {
                self.share(url: self.tmpURL!)
            }
//            }.resume()
    }
    

    
    @IBAction func goEditContactAction(_ sender: UIButton) {
        print(url)
        guard let url = URL(string: url.encodeUrl()) else { return }
        print(url)
        var Filename = ""
        if let range = self.url.range(of: "Designs/") {
            Filename = String(self.url[range.upperBound...])
            print(Filename.encodeUrl()) // prints "123.456.7891"
        }
        
        if Filename == ""
        {
            if let range = self.url.range(of: "photo/") {
                Filename = String(self.url[range.upperBound...])
                print(Filename.encodeUrl()) // prints "123.456.7891"
            }
            
        }
        
        if Filename == ""
        {
            if let range = self.url.range(of: "images/") {
                Filename = String(self.url[range.upperBound...])
                print(Filename.encodeUrl()) // prints "123.456.7891"
            }
            
        }
        
        let FilenameFinal = Filename.replacingOccurrences(of: "-", with: " ", options: .literal, range: nil)
        print(FilenameFinal)
        
        let fileName = FilenameFinal
        
        print(fileName)
        
        print("ProjectId: \(ProjectId)")
        let storyBoard : UIStoryboard = UIStoryboard(name: "ProjectsAndEdit", bundle: nil)
        let secondView = storyBoard.instantiateViewController(withIdentifier: "EditContractViewController") as! EditContractViewController
        secondView.reloadApi = self
        secondView.ProjectId = ProjectId
        secondView.ContractHistoryPath = fileName
        secondView.modalPresentationStyle = .custom
        self.present(secondView, animated: true)
    }
    
    @IBAction func AcceptContactAction(_ sender: UIButton) {
       viewConfimAccept.isHidden = false
    }
    
    func AcceptContract() {
        let sv = UIViewController.displaySpinner(onView: self.view)
        let parameters: Parameters = [
            "projectId": ProjectId
        ]
        
        Alamofire.request("http://smusers.promit2030.co/Service1.svc/AcceptContract", method: .get, parameters: parameters, encoding: URLEncoding.default).responseJSON { response in
            debugPrint(response)
            
            switch response.result {
            case .success:
                let json = JSON(response.result.value!)
                print(json)
                self.AcceptViewOut.isHidden = true
                let storyBoard : UIStoryboard = UIStoryboard(name: "NewHome", bundle: nil)
                let secondView = storyBoard.instantiateViewController(withIdentifier: "NewProjectDetialsFilterTableViewController") as! NewProjectDetialsFilterTableViewController
                secondView.ProjectId = self.ProjectId
                secondView.nou = "LOl"
                secondView.comafterlogin = true
                self.navigationController?.pushViewController(secondView, animated: true)
            case .failure(let error):
                print(error)
                UIViewController.removeSpinner(spinner: sv)
                let alertAction = UIAlertController(title: "خطاء في الاتصال", message: "اعادة المحاولة", preferredStyle: .alert)
                
                alertAction.addAction(UIAlertAction(title: "نعم", style: .default, handler: { action in
                    self.AcceptContract()
                }))
                
                alertAction.addAction(UIAlertAction(title: "رجوع", style: .cancel, handler: { action in
                    
                }))
                
                self.present(alertAction, animated: true, completion: nil)
                
            }
            
        }
        UIViewController.removeSpinner(spinner: sv)
    }
    
    
    
    var NotiProjectCount = 0
    var NotiMessageCount = 0
    var NotiTotalCount = 0
    let applicationl = UIApplication.shared
    
    func setAppBadge() {
        let count = NotiTotalCount
        print(count)
        
        
        if count != 0 {
            let second = tabBarController?.tabBar
            second?.items![1].badgeValue = "\(count)"
            second?.items![1].badgeColor = #colorLiteral(red: 0.3058823529, green: 0.5058823529, blue: 0.5333333333, alpha: 1)
            
        }else
        {
            let second = tabBarController?.tabBar
            second?.items![1].badgeValue = ""
            second?.items![1].badgeColor = UIColor.clear
        }
    }
    func CountCustomerNotification() {
        let CustmoerId = UserDefaults.standard.string(forKey: "CustmoerId")!
        let parameters: Parameters = [
            "CustmoerId":CustmoerId
        ]
        Alamofire.request("http://smusers.promit2030.co/Service1.svc/CountCustomerNotification", method: .get, parameters: parameters, encoding: URLEncoding.default).responseJSON { response in
            switch response.result {
            case .success:
                let json = JSON(response.result.value!)
                print(json)
                self.NotiProjectCount = json["NotiProjectCount"].intValue
                self.NotiMessageCount = json["NotiMessageCount"].intValue
                self.NotiTotalCount = json["NotiTotalCount"].intValue
                self.setAppBadge()
            case .failure(let error):
                print(error)
                let alertAction = UIAlertController(title: "خطاء في الاتصال", message: "اعادة المحاولة", preferredStyle: .alert)
                
                alertAction.addAction(UIAlertAction(title: "نعم", style: .default, handler: { action in
                    self.CountCustomerNotification()
                }))
                
                alertAction.addAction(UIAlertAction(title: "رجوع", style: .cancel, handler: { action in
                }))
                
                self.present(alertAction, animated: true, completion: nil)
                
            }
        }
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
    
    func share(url: URL) {
        documentInteractionController.url = url
        documentInteractionController.uti = url.typeIdentifier ?? "public.data, public.content"
        documentInteractionController.name = url.localizedName ?? url.lastPathComponent
        documentInteractionController.presentOptionsMenu(from: view.frame, in: view, animated: true)
    }
    func shareAction(_ sender: UIButton) {
        guard let url = URL(string: "https://www.ibm.com/support/knowledgecenter/SVU13_7.2.1/com.ibm.ismsaas.doc/reference/AssetsImportCompleteSample.csv?view=kc") else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            let tmpURL = FileManager.default.temporaryDirectory
                .appendingPathComponent(response?.suggestedFilename ?? "fileName.csv")
            do {
                try data.write(to: tmpURL)
            } catch { print(error) }
            DispatchQueue.main.async {
                self.share(url: tmpURL)
            }
            }.resume()
    }
    
    
}
extension ShowContractViewController: reloadApi {
    func reload() {
        self.AcceptViewOut.isHidden = true
        let storyBoard : UIStoryboard = UIStoryboard(name: "NewHome", bundle: nil)
        let secondView = storyBoard.instantiateViewController(withIdentifier: "NewProjectDetialsFilterTableViewController") as! NewProjectDetialsFilterTableViewController
        secondView.ProjectId = self.ProjectId
        secondView.nou = "LOl"
        self.navigationController?.pushViewController(secondView, animated: true)
    }
}

