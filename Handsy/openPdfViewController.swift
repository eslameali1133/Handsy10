//
//  openPdfViewController.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 8/15/17.
//  Copyright © 2017 Ahmed Wahdan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

protocol DismissDelegate {
     func Dismisview()
}

extension openPdfViewController: DismissDelegate{
    func Dismisview() {
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
class openPdfViewController: UIViewController, UIWebViewDelegate {
     var searchResu:[DesignByProjectIdArray] = [DesignByProjectIdArray]()
    
      var sv = UIView()
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
    
    var reloadApi: AccepEditDesgin?
   
    var url: String = ""
    var Webtitle: String = "التصميم المقترح"
    var condBottomButtons = ""
    var documentInteractionController = UIDocumentInteractionController()
    
    var CreateDate: String = ""
    var DesignFile: String = ""
    var DesignStagesID: String = ""
    var Details: String = ""
    var EmpName: String = ""
    var mobileStr: String = ""
    var ProjectBildTypeName: String = ""
    var ProjectStatusID: String = ""
    var SakNum: String = ""
    var StagesDetailsName: String = ""
    var Status: String = ""
    var ClientReply: String = ""
    var EmpReply: String = ""
    var ComapnyName: String = ""
    var LatBranch: Double = 0.0
    var LngBranch: Double = 0.0
    var JobName = ""
    var Address = ""
    var Logo = ""
    var designsDetialsOfResult = [DesignsDetialsArray]()
    var designsDetialsModel: DesignsDetialsModel = DesignsDetialsModel()
    var isScroll = false
    var ProjectId = ""
    var CompanyInfoID = ""
    var IsCompany = ""
    
    var tmpURL:URL?
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        customDownload()
        print(url.encodeUrl())
        sv = UIViewController.displaySpinner(onView: self.view)
        view.bringSubview(toFront: sv)
        if let urlPdf = URL(string: url.encodeUrl()) {
            
            let request = URLRequest(url: urlPdf)
            WebViewPdf.loadRequest(request)
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
            CountCustomerNotification()
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
        }else if condBottomButtons == "chat" {
            BtnOutLet.isHidden = true
            OK.isHidden = true
            Cancel.isHidden = true
            self.navigationController?.setNavigationBarHidden(false, animated: true)
            addBackBarButtonItem()
           
        }
        else {
            BtnOutLet.isHidden = true
            OK.isHidden = true
            Cancel.isHidden = true
        }
        
        
        

       downloadPdf()
       
    }

    
    func addBackBarButtonItem() {
        let shareButton = UIButton(type: .system)
        shareButton.setTitle("عودة", for: .normal)
 shareButton.setImage(UIImage(named: "DBackBtn"), for: .normal)
        shareButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        shareButton.sizeToFit()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: shareButton)
    }
    
    @objc func backButtonPressed(){
        self.navigationController!.popViewController(animated: true)
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
    if condBottomButtons == "chat" {
        if let range = self.url.range(of: "Images/") {
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
        
        download.widthAnchor.constraint(equalToConstant: 30).isActive = true
        download.heightAnchor.constraint(equalToConstant: 30).isActive = true
        download.frame = CGRect(x: 0.0, y: 0.0, width: 35.0, height: 35.0)
        download.isHidden = true
        download.addTarget(self, action:#selector(downloadPdfButton), for: .touchUpInside)
        
        let barButtonItem2 = UIBarButtonItem(customView: download)
        barButtonItem2.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItems = [ barButtonItem2]
    }

    @objc func downloadPdfButton(sender: UIButton) {
        DispatchQueue.main.async {
            self.share(url: self.tmpURL!)
        }
    }
    
    @IBAction func designCancel(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "DesignsAndDetails", bundle: nil)
        let secondView = storyBoard.instantiateViewController(withIdentifier: "AlertDetialsDesignCancelViewController") as! AlertDetialsDesignCancelViewController
        secondView.searchResu = self.searchResu
        secondView.reloadApi = reloadApi!
    secondView.dismiss = self
        secondView.comefrom = 3
        secondView.modalPresentationStyle = .custom
        self.present(secondView, animated: true)
    }
    
    @IBAction func designOk(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "DesignsAndDetails", bundle: nil)
        let secondView = storyBoard.instantiateViewController(withIdentifier: "AlertDetialsDesignOKViewController") as! AlertDetialsDesignOKViewController
        secondView.reloadApi = reloadApi!
        secondView.dismiss = self
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
    
    
}

extension URL {
    var typeIdentifier: String? {
        return (try? resourceValues(forKeys: [.typeIdentifierKey]))?.typeIdentifier
    }
    var localizedName: String? {
        return (try? resourceValues(forKeys: [.localizedNameKey]))?.localizedName
    }
}
extension String
{
    func encodeUrl() -> String
    {
        return self.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed)!
    }
    func decodeUrl() -> String
    {
        return self.removingPercentEncoding!
    }
    
}
