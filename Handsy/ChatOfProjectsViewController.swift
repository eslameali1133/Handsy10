//
//  ChatOfProjectsViewController.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 7/5/18.
//  Copyright © 2018 Ahmed Wahdan. All rights reserved.
//

import UIKit
import MobileCoreServices
import Alamofire
import SwiftyJSON
import MapKit
import Haneke

protocol shareLocationDelegate {
    func shareLocationDelegate(lat: String, Long: String)
}

class ChatOfProjectsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIDocumentMenuDelegate, UIDocumentPickerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate, MessageByProjectIdDelegate,UIScrollViewDelegate {
    
    
    
    var dictionaryImages = [Int:UIImage]()
    
    
    @IBOutlet weak var uiScrloerview: UIScrollView!
    @IBOutlet weak var navImage: AMCircleImageView!
    @IBOutlet weak var navProjectLabel: UILabel!
    
    @IBOutlet weak var navCustLabel: UILabel!
    
    @IBOutlet weak var chatTableView: UITableView!
    @IBOutlet weak var chatView: UIView!
    
    @IBOutlet weak var messageTV: KMPlaceholderTextView!
    
    @IBOutlet weak var messageTVConstriant: NSLayoutConstraint!
    @IBOutlet weak var chatBottomconst: NSLayoutConstraint!
    @IBOutlet weak var progressUpload: UIProgressView!
    @IBOutlet weak var sendBtn: UIButton!{
        didSet {
            self.sendBtn.layer.cornerRadius = 18
        }
    }
    
    @IBOutlet var attachesBtns: UIView!
    @IBOutlet weak var galleryBtnOut: UIButton!{
        didSet {
            self.galleryBtnOut.layer.cornerRadius = self.galleryBtnOut.frame.width / 2
        }
    }
    @IBOutlet weak var cameraBtnOut: UIButton!{
        didSet {
            self.cameraBtnOut.layer.cornerRadius = self.cameraBtnOut.frame.width / 2
        }
    }
    @IBOutlet weak var fileBtnOut: UIButton!{
        didSet {
            self.fileBtnOut.layer.cornerRadius = self.fileBtnOut.frame.width / 2
        }
    }
    @IBOutlet weak var locationBtnOut: UIButton!{
        didSet {
            self.locationBtnOut.layer.cornerRadius = self.locationBtnOut.frame.width / 2
        }
    }
    
    
    var messagesList = [MessageByProjectId]()
    var messagesModel = MessageByProjectIdModel()
    var ProjectId = ""
    var engName = ""
    var engImage = ""
    var ProjectTitle = ""
    var CompanyLogo = ""
    var isCompany: String = ""
    var CompanyInfoID: String = ""
    var LatBranch: Double = 0.0
    var LngBranch: Double = 0.0
    var AddItemPhotos: [UIImage] = []
    var resultArray: [String] = []
    var NotiProjectCount = 0
    var NotiMessageCount = 0
    var NotiTotalCount = 0
    let applicationl = UIApplication.shared
    var backCondition = ""
    
       var AlertController: UIAlertController!
   
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
      return  self.ImageViewSelecteed
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uiScrloerview.delegate = self
        uiScrloerview.maximumZoomScale = 6.0
            uiScrloerview.minimumZoomScale = 1.0
         sendBtn.isHidden = true
        
        SelectImageView.isHidden = true
        DispatchQueue.main.async {
            self.SelectImageView.frame = CGRect.init(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
            self.SelectImageView.center = self.view.center
            self.view.addSubview(self.SelectImageView)
        }
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        CountCustomerNotification()
        attachesBtns.isHidden = true
        DispatchQueue.main.async {
            self.attachesBtns.frame = CGRect.init(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
            self.attachesBtns.center = self.view.center
            self.view.addSubview(self.attachesBtns)
        }
        ReadAllMessageForCust(ProjectId: ProjectId)
        progressUpload.isHidden = true
        //        UINavigationBar.appearance().barTintColor = #colorLiteral(red: 0.2, green: 0.5647058824, blue: 0.3882352941, alpha: 1)
        addBackBarButtonItem()
        messageTV.delegate = self
        messagesModel.delegate = self
        messagesModel.messageByProjectId(view: self.view, VC: self, projectId: ProjectId)
        chatTableView.delegate = self
        chatTableView.dataSource = self
        //        NotificationCenter.default.addObserver(self, selector: #selector(setToPeru(notification:)), name: .peru, object: nil)
        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        // *** Hide keyboard when tapping outside ***
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureHandler))
        view.addGestureRecognizer(tapGesture)
        
        AlertController = UIAlertController(title:"" , message: "اختر الخريطة", preferredStyle: UIAlertControllerStyle.actionSheet)
        
        let Google = UIAlertAction(title: "جوجل ماب", style: UIAlertActionStyle.default, handler: { (action) in
            self.openMapsForLocationgoogle(Lat:self.LatBranch, Lng:self.LngBranch)
        })
        let MapKit = UIAlertAction(title: "الخرائط", style: UIAlertActionStyle.default, handler: { (action) in
            self.openMapsForLocation(Lat:self.LatBranch, Lng:self.LngBranch)
        })
        
        let Cancel = UIAlertAction(title: "رجوع", style: UIAlertActionStyle.cancel, handler: { (action) in
            //
        })
        
        self.AlertController.addAction(Google)
        self.AlertController.addAction(MapKit)
        self.AlertController.addAction(Cancel)
        
        
    }
    
    func openMapsForLocation(Lat: Double, Lng: Double) {
        let location = CLLocation(latitude: Lat, longitude: Lng)
        print(location.coordinate)
        MKMapView.openMapsWith(location) { (error) in
            if error != nil {
                print("Could not open maps" + error!.localizedDescription)
            }
        }
    }
    func openMapsForLocationgoogle(Lat: Double, Lng: Double) {
        let location = CLLocation(latitude: Lat, longitude: Lng)
        if UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!) {
            UIApplication.shared.open(URL(string: "comgooglemaps://?center=\(Lat),\(Lng)&zoom=14&views=traffic&q=\(Lat),\(Lng)")!, options: [:], completionHandler: nil)
        }
        else {
            print("Can't use comgooglemaps://")
            UIApplication.shared.open(URL(string: "http://maps.google.com/maps?q=\(Lat),\(Lng)&zoom=14&views=traffic")!, options: [:], completionHandler: nil)
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
         sendBtn.isHidden = true
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func setNav() {
        navProjectLabel.text = ProjectTitle
        navigationItem.title = ProjectTitle
        navCustLabel.text = engName
        let trimmedString = CompanyLogo.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        if let url = URL.init(string: trimmedString!) {
            print(url)
            navImage.hnk_setImageFromURL(url, placeholder: #imageLiteral(resourceName: "officePlaceholder"))
        } else{
            print("nil")
            navImage.image = #imageLiteral(resourceName: "officePlaceholder")
        }
    }
    // Delegate Method for UIDocumentMenuDelegate.
    func documentMenu(_ documentMenu: UIDocumentMenuViewController, didPickDocumentPicker documentPicker: UIDocumentPickerViewController) {
        documentPicker.delegate = self
        self.present(documentPicker, animated: true, completion: nil)
    }
    
    // Delegate Method for UIDocumentPickerDelegate.
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        print("url: \(url)")
        let fileName = url.lastPathComponent
        print("fileName: \(fileName)")
        if (url.absoluteString.hasSuffix("pdf")) {
            print("pdf")
            addMessage(MessageType: "3", Message: "", ImagePath: url, SenderType: "1", type: "pdf", fileName: fileName, Lat: "", Lng: "")
        }
        else if (url.absoluteString.hasSuffix("doc")) {
            print("doc")
            addMessage(MessageType: "3", Message: "", ImagePath: url, SenderType: "1", type: "doc", fileName: fileName, Lat: "", Lng: "")
        }
        else if (url.absoluteString.hasSuffix("docx")) {
            print("docx")
            addMessage(MessageType: "3", Message: "", ImagePath: url, SenderType: "1", type: "docx", fileName: fileName, Lat: "", Lng: "")
        }
        else if (url.absoluteString.hasSuffix("xlsx")) {
            print("xlsx")
            addMessage(MessageType: "3", Message: "", ImagePath: url, SenderType: "1", type: "xlsx", fileName: fileName, Lat: "", Lng: "")
        }
        else if (url.absoluteString.hasSuffix("xls")) {
            print("xls")
            addMessage(MessageType: "3", Message: "", ImagePath: url, SenderType: "1", type: "xls", fileName: fileName, Lat: "", Lng: "")
        }
        else if (url.absoluteString.hasSuffix("txt")) {
            print("txt")
            addMessage(MessageType: "3", Message: "", ImagePath: url, SenderType: "1", type: "txt", fileName: fileName, Lat: "", Lng: "")
        }
        else if (url.absoluteString.hasSuffix("pptx")) {
            print("pptx")
            addMessage(MessageType: "3", Message: "", ImagePath: url, SenderType: "1", type: "pptx", fileName: fileName, Lat: "", Lng: "")
        }
        else if (url.absoluteString.hasSuffix("PPT")) {
            print("ppt")
            addMessage(MessageType: "3", Message: "", ImagePath: url, SenderType: "1", type: "ppt", fileName: fileName, Lat: "", Lng: "")
        }
        else {
            print("Unknown")
        }
        
    }
    // Method to handle cancel action.
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        //        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var ImageViewSelecteed: customImageView!
    @IBOutlet var SelectImageView: UIView!
    
    var Downloadurlforshare = ""
  
    
    @IBAction func openSelectImage(_ sender: UIButton) {
        ImageViewSelecteed.image = #imageLiteral(resourceName: "officePlaceholder")
    
        SelectImageView.isHidden = false
        let point = sender.convert(CGPoint.zero, to: chatTableView)
        let index = chatTableView.indexPathForRow(at: point)?.row
        let message = messagesList[index!]
        let messagePic = message.ImagePath
        Downloadurlforshare =  messagePic!
        
    ImageViewSelecteed.loadimageUsingUrlString(url: Downloadurlforshare)
        
    
    }
    
    @IBAction func DownloadAndShare(_ sender: UIButton) {

        DownloadandShareSold()
    
    }
    
    func DownloadandShareSold()
    {
        
        let messagePic = Downloadurlforshare
        
        // image to share
        let image =   ImageViewSelecteed.image
        
        // set up activity view controller
        let imageToShare = [image]
        let activityViewController = UIActivityViewController(activityItems: imageToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        
        // exclude some activity types from the list (optional)
        activityViewController.excludedActivityTypes = [ UIActivityType.airDrop, UIActivityType.postToFacebook ]
        
        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
        
//        guard let url = URL(string:self.Downloadurlforshare) else { return }
//        print(url)
//
//        var Filename = ""
//        if let range = messagePic.range(of: "Images/") {
//            Filename = String(messagePic[range.upperBound...])
//            print(Filename.encodeUrl()) // prints "123.456.7891"
//        }
//
//        let FilenameFinal =  Filename
//        //            Filename.replacingOccurrences(of: "-", with: " ", options: .literal, range: nil)
//        print(FilenameFinal)
//
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            guard let data = data, error == nil else { return }
//            let tmpURL = FileManager.default.temporaryDirectory
//                .appendingPathComponent(FilenameFinal ?? "Contract.jpeg")
//            do {
//                try data.write(to: tmpURL)
//            } catch { print(error) }
//            DispatchQueue.main.async {
//                self.share(url: tmpURL)
//            }
//            }.resume()
    }
    
      var documentInteractionController = UIDocumentInteractionController()
    func share(url: URL) {
        print(url)
        documentInteractionController.url = url
        documentInteractionController.uti = url.typeIdentifier ?? "public.data, public.content"
        documentInteractionController.name = url.localizedName ?? url.lastPathComponent
        documentInteractionController.presentOptionsMenu(from: view.frame, in: view, animated: true)
    }
    
    @IBAction func CloseSelectedView(_ sender: Any) {
        SelectImageView.isHidden = true
    }
    
    
    @IBAction func openDcumentPicker(_ sender: UIButton) {
        attachesBtns.isHidden = true
        let pdf = String(kUTTypePDF)
        //        let zip = String(kUTTypeZipArchive)
        let docs = String(kUTTypeCompositeContent)
        //        let archive = String(kUTTypeArchive)
        let number = String(kUTTypeLog)
        let spreadsheet = String(kUTTypeSpreadsheet)
        //        let movie = String(kUTTypeMovie)
        //        let aviMovie = String(kUTTypeAVIMovie)
        let importMenu = UIDocumentMenuViewController(documentTypes: [pdf, docs, number, spreadsheet], in: UIDocumentPickerMode.import)
        importMenu.delegate = self
        self.present(importMenu, animated: true, completion: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messagesList.count
    }
    
  
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messagesList[indexPath.row]
        if message.SenderType == "1" {
            if message.MessageType == "2" {
                let cell = chatTableView.dequeueReusableCell(withIdentifier: "SendimageChatTableViewCell", for: indexPath) as! SendimageChatTableViewCell
                let messagePic = message.ImagePath!
                let trimmedString = messagePic.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
                  cell.recevierMessageImage.image = #imageLiteral(resourceName: "officePlaceholder")
                if let url = URL.init(string: trimmedString!) {
                    cell.recevierMessageImage.loadimageUsingUrlString(url: trimmedString!)
                   
                 
                } else{
                    print("nil")
                }
                cell.messageTimeLabel.text = message.MessageTime
                return cell
            }else if message.MessageType == "3" {
                let cell = chatTableView.dequeueReusableCell(withIdentifier: "SendFileChatTableViewCell", for: indexPath) as! SendFileChatTableViewCell
                let messagePic = message.ImagePath
                let fileName = message.ImageName!
                //                let fileName = messagePic?.replacingOccurrences(of: "http://smusers.promit2030.com/Images/", with: "")
                if let url = URL.init(string: messagePic!) {
                    if (url.absoluteString.hasSuffix("docx")) {
                        print("docx")
                        cell.fileImageExt.image = #imageLiteral(resourceName: "docExt")
                        cell.fileNameLabel.text = "\(fileName).docx"
                    }
                    else if (url.absoluteString.hasSuffix("xls")) {
                        print("xls")
                        cell.fileImageExt.image = #imageLiteral(resourceName: "xlsExt")
                        cell.fileNameLabel.text = "\(fileName).xls"
                    }
                    else if (url.absoluteString.hasSuffix("txt")) {
                        print("txt")
                        cell.fileImageExt.image = #imageLiteral(resourceName: "txtsExt")
                        cell.fileNameLabel.text = "\(fileName).txt"
                    }
                    else if (url.absoluteString.hasSuffix("pdf")) {
                        print("pdf")
                        cell.fileImageExt.image = #imageLiteral(resourceName: "pdfExt")
                        cell.fileNameLabel.text = "\(fileName).pdf"
                    }
                    else if (url.absoluteString.hasSuffix("xlsx")) {
                        print("xlsx")
                        cell.fileImageExt.image = #imageLiteral(resourceName: "xlsxExt")
                        cell.fileNameLabel.text = "\(fileName).xlsx"
                    }
                    else if (url.absoluteString.hasSuffix("ppt")) {
                        print("xlsx")
                        cell.fileImageExt.image = #imageLiteral(resourceName: "pptExt")
                        cell.fileNameLabel.text = "\(fileName).ppt"
                    }
                    else {
                        print("Unknown")
                    }
                }
                cell.messageTimeLabel.text = message.MessageTime
                return cell
            }else if message.MessageType == "4" {
                let cell = chatTableView.dequeueReusableCell(withIdentifier: "SendMapChatTableViewCell", for: indexPath) as! SendMapChatTableViewCell
                let Lat = message.Lat!
                let Lng = message.Lng!
                let staticMapUrl: String = "http://maps.google.com/maps/api/staticmap?markers=color:red|\(Lat),\(Lng)&\("zoom=17&size=\(2 * Int(cell.recevierMessageImage.frame.size.width))x\(2 * Int(cell.recevierMessageImage.frame.size.height))")&sensor=true"
                
                let mapul = "https://maps.google.com/maps/api/staticmap?key=AIzaSyCsqUTyaFGZWyuahXVzjgjT_E3ldB3ECCE&markers=color:red|\(Lat),\(Lng)&\("zoom=17&size=\(2 * Int(cell.recevierMessageImage.frame.size.width))x\(2 * Int(cell.recevierMessageImage.frame.size.height))")&sensor=true&fbclid=IwAR2rsCS0d9D-aow4D3AWs9-fv3EdiSDsFFUU80Gm6oQ7vCZwlXUaPjUOmU8"
                
                let urlI = URL(string: mapul.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
                if let url = urlI {
                    print("map: \(urlI)")
                    cell.recevierMessageImage.hnk_setImageFromURL(url, placeholder: #imageLiteral(resourceName: "officePlaceholder"))
                } else{
                    print("map: \(urlI)")
                    print("nil")
                }
                cell.messageTimeLabel.text = message.MessageTime
                return cell
            }else {
                let cell = chatTableView.dequeueReusableCell(withIdentifier: "SendTextChatTableViewCell", for: indexPath) as! SendTextChatTableViewCell
                DispatchQueue.main.async {
                    cell.recevierMessageView.roundCorners([.bottomLeft, .bottomRight, .topLeft], radius: 10)
                }
                cell.recevierMessageText.text = message.Message
                cell.messageTimeLabel.text = message.MessageTime
                return cell
            }
            
        }else {
            if message.MessageType == "2" {
                let cell = chatTableView.dequeueReusableCell(withIdentifier: "ReceiveImageChatTableViewCell", for: indexPath) as! ReceiveImageChatTableViewCell
                let messagePic = message.ImagePath!
                let trimmedString = messagePic.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
                 cell.senderMessageImage.image = #imageLiteral(resourceName: "officePlaceholder")
                if let url = URL.init(string: trimmedString!) {
                    cell.senderMessageImage.loadimageUsingUrlString(url: trimmedString!)
                } else{
                    print("nil")
                }
                cell.messageTimeLabel.text = message.MessageTime
                cell.senderNameLabel.text = message.SenderName
                return cell
            }else if message.MessageType == "3" {
                let cell = chatTableView.dequeueReusableCell(withIdentifier: "ReceiveFileChatTableViewCell", for: indexPath) as! ReceiveFileChatTableViewCell
                let messagePic = message.ImagePath
                let fileName = message.ImageName!
                //                let fileName = messagePic?.replacingOccurrences(of: "http://smusers.promit2030.com/Images/", with: "")
                if let url = URL.init(string: messagePic!) {
                    if (url.absoluteString.hasSuffix("docx")) {
                        print("docx")
                        cell.fileImageExt.image = #imageLiteral(resourceName: "docExt")
                        cell.fileNameLabel.text = "\(fileName).docx"
                    }
                    else if (url.absoluteString.hasSuffix("xls")) {
                        print("xls")
                        cell.fileImageExt.image = #imageLiteral(resourceName: "xlsExt")
                        cell.fileNameLabel.text = "\(fileName).xls"
                    }
                    else if (url.absoluteString.hasSuffix("txt")) {
                        print("txt")
                        cell.fileImageExt.image = #imageLiteral(resourceName: "txtsExt")
                        cell.fileNameLabel.text = "\(fileName).txt"
                    }
                    else if (url.absoluteString.hasSuffix("pdf")) {
                        print("pdf")
                        cell.fileImageExt.image = #imageLiteral(resourceName: "pdfExt")
                        cell.fileNameLabel.text = "\(fileName).pdf"
                    }
                    else if (url.absoluteString.hasSuffix("xlsx")) {
                        print("xlsx")
                        cell.fileImageExt.image = #imageLiteral(resourceName: "xlsxExt")
                        cell.fileNameLabel.text = "\(fileName).xlsx"
                    }
                    else if (url.absoluteString.hasSuffix("ppt")) {
                        print("xlsx")
                        cell.fileImageExt.image = #imageLiteral(resourceName: "pptExt")
                        cell.fileNameLabel.text = "\(fileName).ppt"
                    }
                    else {
                        print("Unknown")
                    }
                }
                cell.messageTimeLabel.text = message.MessageTime
                cell.senderNameLabel.text = message.SenderName
                return cell
            }else if message.MessageType == "4" {
                let cell = chatTableView.dequeueReusableCell(withIdentifier: "ReceiveMapChatTableViewCell", for: indexPath) as! ReceiveMapChatTableViewCell
                let Lat = message.Lat!
                let Lng = message.Lng!
                let staticMapUrl: String = "http://maps.google.com/maps/api/staticmap?markers=color:red|\(Lat),\(Lng)&\("zoom=17&size=\(2 * Int(cell.senderMessageImage.frame.size.width))x\(2 * Int(cell.senderMessageImage.frame.size.height))")&sensor=true"
                
                 let mapul = "https://maps.google.com/maps/api/staticmap?key=AIzaSyCsqUTyaFGZWyuahXVzjgjT_E3ldB3ECCE&markers=color:red|\(Lat),\(Lng)&\("zoom=17&size=\(2 * Int(cell.senderMessageImage.frame.size.width))x\(2 * Int(cell.senderMessageImage.frame.size.height))")&sensor=true&fbclid=IwAR2rsCS0d9D-aow4D3AWs9-fv3EdiSDsFFUU80Gm6oQ7vCZwlXUaPjUOmU8"
                
                let urlI = URL(string: mapul.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
                if let url = urlI {
                    print("map: \(urlI)")
                    cell.senderMessageImage.hnk_setImageFromURL(url, placeholder: #imageLiteral(resourceName: "officePlaceholder"))
                } else{
                    print("map: \(urlI)")
                    print("nil")
                }
                cell.messageTimeLabel.text = message.MessageTime
                cell.senderNameLabel.text = message.SenderName
                return cell
            }else {
                let cell = chatTableView.dequeueReusableCell(withIdentifier: "ReceiveTextChatTableViewCell", for: indexPath) as! ReceiveTextChatTableViewCell
                DispatchQueue.main.async {
                    cell.senderMessageView.roundCorners([.bottomLeft, .bottomRight, .topRight], radius: 10)
                }
                cell.senderMessageText.text = message.Message
                cell.messageTimeLabel.text = message.MessageTime
                cell.senderNameLabel.text = message.SenderName
                return cell
            }
        }
    }
    
    func addBackBarButtonItem() {
        let backButton = UIButton(type: .system)
        backButton.setImage(UIImage(named: "backBtn"), for: .normal)
        backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        backButton.sizeToFit()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }
    
    @objc func backButtonPressed(){
        //        let storyboard = UIStoryboard(name: "ResultsHome", bundle: nil)
        //        let TabController = storyboard.instantiateViewController(withIdentifier: "mainTabBar") as! UITabBarController
        //        TabController.selectedIndex = 0
        //        self.present(TabController, animated: false, completion: nil)
        self.dismiss(animated: false, completion: nil)
    }
    func textViewDidChange(_ textView: UITextView) {
        
        guard let text = textView.text,!text.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty else {
              sendBtn.isHidden = true
               return
        }
        sendBtn.isHidden = false
        
        let sizeThatFitsTextView = textView.sizeThatFits(CGSize(width: textView.frame.size.width, height: textView.frame.size.height))
        if sizeThatFitsTextView.height <= 100.0 {
            messageTVConstriant.constant = sizeThatFitsTextView.height
        }else {
            messageTVConstriant.constant = 100.0
        }
        
    }
    
    @IBOutlet weak var Botomconstrian: NSLayoutConstraint!
    func textViewDidBeginEditing(_ textView: UITextView) {
//       Botomconstrian.constant = 
    }
    @objc func tapGestureHandler() {
        view.endEditing(true)
    }
    
    @objc func handleKeyboardNotification(notification: NSNotification) {
        
        if let userInfo = notification.userInfo {
            
            let keyboardFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as AnyObject).cgRectValue
            print(keyboardFrame)
            
            let isKeyboardShowing = notification.name == NSNotification.Name.UIKeyboardWillShow
            
            chatBottomconst?.constant = isKeyboardShowing ? -keyboardFrame!.height + 40 : 0
            
            UIView.animate(withDuration: 0, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
                
                self.view.layoutIfNeeded()
                
            }, completion: { (completed) in
                
                if isKeyboardShowing {
                    if self.messagesList.count == 0 {
                        
                    }else {
                        let indexPath = IndexPath(row: self.messagesList.count-1, section: 0)
                        self.chatTableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
                    }
                }
                
            })
        }
    }
    
    func scrollToBottom(){
        print("count: \(self.messagesList.count)")
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: self.messagesList.count-1, section: 0)
            self.chatTableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
        }
    }
    
    func messageByProjectIdData() {
        self.messagesList = self.messagesModel.messageByProjectId
        self.engName = self.messagesModel.CompanyName
        self.CompanyLogo = self.messagesModel.CompanyLogo
        self.ProjectTitle = self.messagesModel.ProjectTitle
        self.isCompany = self.messagesModel.isCompany
        self.CompanyInfoID = self.messagesModel.CompanyInfoID
        self.LatBranch = self.messagesModel.LatBranch
        self.LngBranch = self.messagesModel.LngBranch
        if self.messagesModel.messageByProjectId.count > 0 {
            scrollToBottom()
        }
        setNav()
        self.chatTableView.reloadData()
    }
    
    @IBAction func openFile(_ sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: chatTableView)
        let index = chatTableView.indexPathForRow(at: point)?.row
        guard let url = URL(string: messagesList[index!].ImagePath!) else {
            return //be safe
        }
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
    @IBAction func openGalleryImagePicker(_ sender: UIButton) {
        attachesBtns.isHidden = true
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        picker.modalPresentationStyle = .fullScreen
        self.present(picker, animated: true)
    }
    
    @IBAction func openCameraImagePicker(_ sender: UIButton) {
        attachesBtns.isHidden = true
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = false
        picker.sourceType = .camera
        picker.modalPresentationStyle = .fullScreen
        self.present(picker, animated: true)
    }
    
    // MARK: - UIImagePickerControllerDelegate Methods
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [AnyHashable: Any]!) {
        //        imageProfile.contentMode = .scaleAspectFit
        print("image: \(image)")
        dismiss(animated: true, completion: nil)
    }
    let sendImg = UIImageView()
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        //        let assetPath = info[UIImagePickerControllerReferenceURL] as! URL
        //        let imgName = assetPath.lastPathComponent
        
        if #available(iOS 11.0, *) {
            if let assetPath = info[UIImagePickerControllerImageURL] as? URL{
                let imgName = assetPath.lastPathComponent
                print(imgName)
                if (assetPath.absoluteString.hasSuffix("jpg")) {
                    print("jpg")
                    if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
                        print("image: \(pickedImage)")
                        addMessage(MessageType: "2", Message: "", ImagePath: assetPath as URL, SenderType: "1", type: "jpg", fileName: imgName, Lat: "", Lng: "")
                    }
                }else if (assetPath.absoluteString.hasSuffix("jpeg")) {
                    print("jpeg")
                    addMessage(MessageType: "2", Message: "", ImagePath: assetPath as URL, SenderType: "1", type: "jpeg", fileName: imgName, Lat: "", Lng: "")
                }
                else if (assetPath.absoluteString.hasSuffix("png")) {
                    print("png")
                    addMessage(MessageType: "2", Message: "", ImagePath: assetPath as URL, SenderType: "1", type: "png", fileName: imgName, Lat: "", Lng: "")
                }
                else if (assetPath.absoluteString.hasSuffix("gif")) {
                    print("gif")
                    addMessage(MessageType: "2", Message: "", ImagePath: assetPath as URL, SenderType: "1", type: "gif", fileName: imgName, Lat: "", Lng: "")
                }
                else {
                    print("Unknown")
                }
                
            }else {
                if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
                    sendImg.image = pickedImage
                    let imagePath = URL(fileURLWithPath: "")
                    addMessage(MessageType: "2", Message: "jk", ImagePath: imagePath, SenderType: "1", type: "jpeg", fileName: "\(randomString(len: 20)).jpeg", Lat: "", Lng: "")
                }
            }
        } else {
            // Fallback on earlier versions
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func openMapLocationMsg(_ sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: chatTableView)
        let index = chatTableView.indexPathForRow(at: point)?.row
        let message = messagesList[index!]
         LatBranch = Double(message.Lat!)!
         LngBranch = Double(message.Lng!)!
        let dLati =  LatBranch
        let dLang = LngBranch
        
        
//        let alertAction = UIAlertController(title: "اختر الخريطة", message: "", preferredStyle: .alert)
//
//        alertAction.addAction(UIAlertAction(title: "جوجل ماب", style: .default, handler: { action in
//            if UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!) {
//                UIApplication.shared.open(URL(string: "comgooglemaps://?center=\(dLati),\(dLang)&zoom=14&views=traffic&q=\(dLati),\(dLang)")!, options: [:], completionHandler: nil)
//            } else {
//                print("Can't use comgooglemaps://")
//                UIApplication.shared.open(URL(string: "http://maps.google.com/maps?q=\(dLati),\(dLang)&zoom=14&views=traffic")!, options: [:], completionHandler: nil)
//            }
//        }))
//
//        alertAction.addAction(UIAlertAction(title: "الخرائط", style: .default, handler: { action in
//            self.openMapsForLocation()
//        }))
//
//        alertAction.addAction(UIAlertAction(title: "رجوع", style: .cancel, handler: { action in
//        }))
//        self.present(alertAction, animated: true, completion: nil)
        
        if Helper.isDeviceiPad() {
            
            if let popoverController = AlertController.popoverPresentationController {
                popoverController.sourceView = sender
            }
        }
        
        self.present(AlertController, animated: true, completion: nil)
        
    }
    func openMapsForLocation() {
        let dLati = LatBranch
        let dLang = LngBranch
        let location = CLLocation(latitude: dLati, longitude: dLang)
        print(location.coordinate)
        MKMapView.openMapsWith(location) { (error) in
            if error != nil {
                print("Could not open maps" + error!.localizedDescription)
            }
        }
    }
    
    func openMapsForLocationas(Lat: Double, Lng: Double) {
        let location = CLLocation(latitude: Lat, longitude: Lng)
        print(location.coordinate)
        MKMapView.openMapsWith(location) { (error) in
            if error != nil {
                print("Could not open maps" + error!.localizedDescription)
            }
        }
    }
    
    @IBAction func openMapToShareLocation(_ sender: UIButton) {
        attachesBtns.isHidden = true
        let storyboard = UIStoryboard(name: "Chat", bundle: nil)
        let NavController = storyboard.instantiateViewController(withIdentifier: "NavChooseLocation") as! UINavigationController
        let FirstViewController = NavController.viewControllers.first as! ChooseLocationToShareViewController
        FirstViewController.shareLocationDelegate = self
        self.present(NavController, animated: false, completion: nil)
    }
    
    @IBAction func sendMessageBtn(_ sender: UIButton) {
        let imagePath = URL(fileURLWithPath: "")
        addMessage(MessageType: "1", Message: messageTV.text, ImagePath: imagePath, SenderType: "1", type: "", fileName: "", Lat: "", Lng: "")
        messageTV.text = ""
    }
    
    @IBAction func openAttachBtns(_ sender: UIButton) {
        attachesBtns.isHidden = false
        view.endEditing(true)
    }
    
    @IBAction func closeAttachBtns(_ sender: UIButton) {
        attachesBtns.isHidden = true
    }
    
    func addMessage(MessageType: String, Message: String, ImagePath: URL, SenderType: String, type: String, fileName: String, Lat: String, Lng: String) {
        let sv = UIViewController.displaySpinner(onView: self.view)
        let UserId = UserDefaults.standard.string(forKey: "UserId")!
        var parameters: Parameters = [:]
      
        if type != "" {
            if type == "jpeg" {
                if Message == "jk" {
                      let data = UIImageJPEGRepresentation(sendImg.image!, 0.5)
                    parameters = [
                        "UserId" : UserId,
                        "ProjectId": ProjectId,
                        "MessageType": MessageType,
                        "Message": "",
                        "ImagePath": data!,
                        "SenderType": SenderType,
                        "Lat": Lat,
                        "Lng": Lng
                    ]
                }else {
                    parameters = [
                        "UserId" : UserId,
                        "ProjectId": ProjectId,
                        "MessageType": MessageType,
                        "Message": Message,
                        "ImagePath": ImagePath,
                        "SenderType": SenderType,
                        "Lat": Lat,
                        "Lng": Lng
                    ]
                }
            }else {
                parameters = [
                    "UserId" : UserId,
                    "ProjectId": ProjectId,
                    "MessageType": MessageType,
                    "Message": Message,
                    "ImagePath": ImagePath,
                    "SenderType": SenderType,
                    "Lat": Lat,
                    "Lng": Lng
                ]
            }
        }else {
            parameters = [
                "UserId" : UserId,
                "ProjectId": ProjectId,
                "MessageType": MessageType,
                "Message": Message,
                "ImagePath": ImagePath,
                "SenderType": SenderType,
                "Lat": Lat,
                "Lng": Lng
            ]
        }
        print(Lat,Lng)
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                
                for (key,value) in parameters {
                    if let value = value as? String {
                        multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
                    }
                }
                if type != "" {
                    if type == "jpeg" {
                        if Message == "jk" {
                            let data = UIImageJPEGRepresentation(self.sendImg.image!, 0.5)
                            multipartFormData.append(data!, withName: "ImagePath", fileName: fileName, mimeType: "image/\(type)")
                        }else {
                            multipartFormData.append(ImagePath, withName: "ImagePath", fileName: fileName, mimeType: "image/\(type)")
                        }
                    }else {
                        multipartFormData.append(ImagePath, withName: "ImagePath", fileName: fileName, mimeType: "image/\(type)")
                    }
                }
        },
            usingThreshold:UInt64.init(),
            to: "http://smusers.promit2030.com/api/ApiService/AddMessage",
            method: .post,
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    
                    upload.uploadProgress(closure: { (progress) in
                        self.progressUpload.progress = 0.0
                        self.progressUpload.setProgress(Float(progress.fractionCompleted), animated: true)
                        print(progress)
                    })
                    upload.responseJSON { response in
                        // If the request to get activities is succesfull, store them
                        if response.result.isSuccess{
                            print(response.debugDescription)
                            
                            let json = JSON(response.result.value!)
                            print(json)
                            let status = json["SenderId"].stringValue
                            
                            if status != "" {
                                let messageByProjectIdObj = MessageByProjectId()
                                messageByProjectIdObj.ImageName = json["ImageName"].stringValue
                                messageByProjectIdObj.ImagePath = json["ImagePath"].stringValue
                                messageByProjectIdObj.Message = json["Message"].stringValue
                                messageByProjectIdObj.MessageTime = json["MessageTime"].stringValue
                                messageByProjectIdObj.MessageType = json["MessageType"].stringValue
                                messageByProjectIdObj.SenderId = json["SenderId"].stringValue
                                messageByProjectIdObj.SenderImage = json["SenderImage"].stringValue
                                messageByProjectIdObj.SenderName = json["SenderName"].stringValue
                                messageByProjectIdObj.SenderType = json["SenderType"].stringValue
                                messageByProjectIdObj.Lat = json["Lat"].stringValue
                                messageByProjectIdObj.Lng = json["Lng"].stringValue
                                self.messagesList.append(messageByProjectIdObj)
                                self.scrollToBottom()
                                self.chatTableView.reloadData()
                            }else {
                                let Message = json["Message"].stringValue
                                let alertController = UIAlertController(title: "الملف غير مدعوم", message: Message, preferredStyle: .alert)
                                alertController.addAction(UIAlertAction(title: "انهاء", style: .cancel, handler: { action in
                                }))
                                self.present(alertController, animated: true, completion: nil)
                            }
                            UIViewController.removeSpinner(spinner: sv)
                        } else {
                            var errorMessage = "ERROR MESSAGE: "
                            if let data = response.data {
                                // Print message
                                let responseJSON = try? JSON(data: data)
                                let alertController = UIAlertController(title: "خطأ في الاتصال!", message: "لم يتم ارسال الطلب\n برجاء المحاولة مرة اخرى", preferredStyle: .alert)
                                alertController.addAction(UIAlertAction(title: "اعادة المحاولة", style: .cancel, handler: { action in
                                    self.addMessage(MessageType: MessageType, Message: Message, ImagePath: ImagePath, SenderType: SenderType, type: type, fileName: fileName, Lat: Lat, Lng: Lng)
                                    UIViewController.removeSpinner(spinner: sv)
                                }))
                                self.present(alertController, animated: true, completion: nil)
                                
                            }
                            print(errorMessage) //Contains General error message or specific.
                            print(response.debugDescription)
                        }
                        
                        
                    }
                case .failure(let encodingError):
                    print("FALLE ------------")
                    print(encodingError)
                    let alertController = UIAlertController(title: "خطأ في الاتصال!", message: "لم يتم ارسال الطلب\n برجاء المحاولة مرة اخرى", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "اعادة المحاولة", style: .cancel, handler: { action in
                        self.addMessage(MessageType: MessageType, Message: Message, ImagePath: ImagePath, SenderType: SenderType, type: type, fileName: fileName, Lat: Lat, Lng: Lng)
                        UIViewController.removeSpinner(spinner: sv)
                    }))
                    self.present(alertController, animated: true, completion: nil)
                }
        }
        )
    }
    
    func ReadAllMessageForCust(ProjectId: String) {
        Alamofire.request("http://smusers.promit2030.co/api/ApiService/ReadAllMessageForCust?ProjectId=\(ProjectId)", method: .post, encoding: URLEncoding.default).responseJSON { response in
            debugPrint(response)
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
    func setAppBadge() {
        let count = NotiTotalCount
        let CustmoerId = UserDefaults.standard.string(forKey: "CustmoerId")!
        if CustmoerId != nil || CustmoerId != ""
        {
            applicationl.applicationIconBadgeNumber = count
        }else
        {
            applicationl.applicationIconBadgeNumber = 0
        }
       
    }
    
    @IBAction func DetialsBtnAction(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "NewProject", bundle:nil)
        let secondView = storyBoard.instantiateViewController(withIdentifier: "DetailsOfOfficeTableViewController") as! DetailsOfOfficeTableViewController
        if isCompany == "true" {
            secondView.isCompany = "1"
        } else {
            secondView.isCompany = "0"
        }
        secondView.CompanyInfoID = CompanyInfoID
        secondView.conditionService = "condition"
        secondView.LatBranch = LatBranch
        secondView.LngBranch = LngBranch
        if backCondition == "" {
            self.navigationController?.pushViewController(secondView, animated: true)
        }else {
            self.show(secondView, sender: nil)
        }
    }
    
    @IBAction func DetialsProjectBtnAction(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "NewHome", bundle: nil)
        let secondView = storyBoard.instantiateViewController(withIdentifier: "NewProjectDetialsFilterTableViewController") as! NewProjectDetialsFilterTableViewController
        secondView.ProjectId = ProjectId
        secondView.norma = "LOl"
        if backCondition == "" {
            self.navigationController?.pushViewController(secondView, animated: true)
        }else {
            self.show(secondView, sender: nil)
        }
    }
    
    @IBAction func backBtn(_ sender: UIButton) {
        if backCondition == "" {
           self.navigationController!.popViewController(animated: true)
        }else {
            self.dismiss(animated: false, completion: nil)
        }
//        self.dismiss(animated: false, completion: nil)
    }
}

extension ChatOfProjectsViewController: shareLocationDelegate {
    func shareLocationDelegate(lat: String, Long: String){
        let imagePath = URL(fileURLWithPath: "")
        print(lat,Long)
        addMessage(MessageType: "4", Message: "", ImagePath: imagePath, SenderType: "1", type: "", fileName: "", Lat: lat, Lng: Long)
    }
}
func randomString(len:Int) -> String {
    let charSet = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    var c = Array(charSet)
    var s:String = ""
    for n in (1...10) {
        s.append(c[Int(arc4random()) % c.count])
    }
    return s
}
