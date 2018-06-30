//
//  DetailsDesignTableViewController.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 8/16/17.
//  Copyright © 2017 Ahmed Wahdan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import MapKit

class DetailsDesignTableViewController: UITableViewController {
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
    
    @IBOutlet weak var PDF: UIButton!{
        didSet {
            PDF.layer.cornerRadius = 4.0
        }
    }
    @IBOutlet weak var messageChat: UIButton!{
        didSet {
            messageChat.layer.borderWidth = 1.0
            messageChat.layer.borderColor = #colorLiteral(red: 0.2, green: 0.5647058824, blue: 0.3882352941, alpha: 1)
            messageChat.layer.cornerRadius = 4.0
        }
    }
    @IBOutlet weak var officeLocation: UIButton!{
        didSet {
            officeLocation.layer.borderWidth = 1.0
            officeLocation.layer.borderColor = #colorLiteral(red: 0.2, green: 0.5647058824, blue: 0.3882352941, alpha: 1)
            officeLocation.layer.cornerRadius = 4.0
        }
    }
    
    
    @IBOutlet weak var DateOul: UILabel!
    @IBOutlet weak var BtnOutLet: UIStackView!
    @IBOutlet weak var StatusIm: UIImageView!
    @IBOutlet weak var StatusLa: UILabel!
    @IBOutlet weak var TitleDesign: UILabel!
    @IBOutlet weak var StagesDe: UILabel!
    @IBOutlet weak var stackDetialsDes: UIStackView!
    
    @IBOutlet weak var DetailsDes: UITextView!
    @IBOutlet weak var InformationDetiView: UIView!
    
    @IBOutlet weak var NotesCus: UITextView!
    @IBOutlet weak var NotesEng: UITextView!
    @IBOutlet weak var MyDetials: UIView!
    @IBOutlet weak var DetailsEngView: UIView!
    
    @IBOutlet weak var EngNameLabel: UIButton!
    @IBOutlet weak var JopNameLabel: UILabel!
    @IBOutlet weak var companyNameLabel: UILabel!
    
    @IBOutlet weak var companyImageOut: UIImageView!{
        didSet {
            DispatchQueue.main.async {
                self.companyImageOut.layer.cornerRadius = 7.0
                self.companyImageOut.layer.masksToBounds = true
            }
        }
    }
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if isScroll == false {
            
        }else {
            let indexPath = IndexPath(row: 1, section: 0)
            self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
        }
        
        if Reachability.isConnectedToNetwork(){
            print("Internet Connection Available!")
            GetDesignsByDesignStagesID()
        }else{
            designsDetialsModel.loadItems()
            print("Internet Connection not Available!")
            if designsDetialsModel.returnProjectDetials(at: designStagesID) != nil {
                let designsDetials = designsDetialsModel.returnProjectDetials(at: designStagesID)
                self.designsDetialsOfResult = [designsDetials!]
                self.ComapnyNameFunc(companyName: designsDetialsOfResult[0].ComapnyName!, companyLogo: designsDetialsOfResult[0].Logo!, JobName: designsDetialsOfResult[0].JobName!)
                self.setData(condition: "offline")
            }
        }
        
        InformationDetiView.isHidden = false
        NotesEng.isHidden = false
        NotesCus.isHidden = false
        BtnOutLet.isHidden = true
        OK.isHidden = true
        Cancel.isHidden = true
        
    }
    
    func GetDesignsByDesignStagesID(){
        let parameters: Parameters = [
            "designStagesID": designStagesID
        ]
        
        Alamofire.request("http://smusers.promit2030.com/Service1.svc/GetDesignsByDesignStagesID", method: .get, parameters: parameters, encoding: URLEncoding.default).responseJSON { response in
            debugPrint(response)
            let json = JSON(response.result.value!)
            let requestProjectObj = DesignsDetialsArray(CreateDate: json["CreateDate"].stringValue, DesignFile: json["DesignFile"].stringValue, DesignStagesID: json["DesignStagesID"].stringValue, Details: json["Details"].stringValue, EmpName: json["EmpName"].stringValue, mobileStr: json["Mobile"].stringValue, ProjectBildTypeName: json["ProjectBildTypeName"].stringValue, ProjectStatusID: json["ProjectStatusID"].stringValue, SakNum: json["SakNum"].stringValue, StagesDetailsName: json["StagesDetailsName"].stringValue, Status: json["Status"].stringValue, ClientReply: json["ClientReply"].stringValue, EmpReply: json["EmpReply"].stringValue, ComapnyName: json["ComapnyName"].stringValue, LatBranch: json["LatBranch"].doubleValue, LngBranch: json["LngBranch"].doubleValue, JobName: json["JobName"].stringValue, Address: json["Address"].stringValue, Logo: json["Logo"].stringValue)
            
            self.CreateDate = json["CreateDate"].stringValue
            self.Address = json["Address"].stringValue
            self.ComapnyName = json["ComapnyName"].stringValue
            self.Logo = json["Logo"].stringValue
            self.ClientReply = json["ClientReply"].stringValue
            self.DesignFile = json["DesignFile"].stringValue
            designStagesID = json["DesignStagesID"].stringValue
            self.Details = json["Details"].stringValue
            self.EmpName = json["EmpName"].stringValue
            self.mobileStr = json["Mobile"].stringValue
            self.ProjectBildTypeName = json["ProjectBildTypeName"].stringValue
            self.ProjectStatusID = json["ProjectStatusID"].stringValue
            self.SakNum = json["SakNum"].stringValue
            self.StagesDetailsName = json["StagesDetailsName"].stringValue
            self.Status = json["Status"].stringValue
            self.EmpReply = json["EmpReply"].stringValue
            self.LatBranch = json["LatBranch"].doubleValue
            self.LngBranch = json["LngBranch"].doubleValue
            self.JobName = json["JobName"].stringValue
            
            self.designsDetialsOfResult.append(requestProjectObj)
            for i in self.designsDetialsOfResult {
                self.designsDetialsModel.append(i)
            }
            
            self.ComapnyNameFunc(companyName: self.ComapnyName, companyLogo: self.Logo, JobName: self.JobName)
            self.setData(condition: "online")
            self.tableView.reloadData()
        }
        
    }
    
    func ComapnyNameFunc(companyName: String, companyLogo: String, JobName: String){
        EngNameLabel.setTitle(self.EmpName, for: .normal)
        companyNameLabel.text = companyName
        JopNameLabel.text = JobName
        if let url = URL.init(string: companyLogo) {
            companyImageOut.hnk_setImageFromURL(url, placeholder: #imageLiteral(resourceName: "officePlaceholder"))
        } else{
            print("nil")
            companyImageOut.image = #imageLiteral(resourceName: "officePlaceholder")
        }
        tableView.reloadData()
    }
    
    func setData(condition: String) {
        if condition == "online" {
            adjustUITextViewHeight(arg: NotesCus)
            adjustUITextViewHeight(arg: NotesEng)
            adjustUITextViewHeight(arg: DetailsDes)
            
            if ClientReply == ""{
                MyDetials.isHidden = true
                NotesCus.isHidden = true
            } else {
                
                MyDetials.isHidden = false
                NotesCus.isHidden = false
            }
            if EmpReply == "" {
                DetailsEngView.isHidden = true
                NotesEng.isHidden = true
            } else {
                DetailsEngView.isHidden = false
                NotesEng.isHidden = false
            }
            
            //        if ClientReply == "" && EmpReply == "" {
            //            DetailsEngView.isHidden = true
            //            MyDetials.isHidden = true
            //        }
            
            DateOul.text = CreateDate
            TitleDesign.text = ProjectBildTypeName
            StagesDe.text = StagesDetailsName
            //        Mobile.setTitle(mobileStr, for: .normal)
            if Details == "" {
                stackDetialsDes.isHidden = true
            }else {
                stackDetialsDes.isHidden = false
            }
            DetailsDes.text = Details
            NotesCus.text = ClientReply
            NotesEng.text = EmpReply
            companyNameLabel.text = ComapnyName
            
            if Status == "1"{
                StatusIm.image = #imageLiteral(resourceName: "جاري العمل-1")
                StatusLa.text = "انتظار الموافقة"
                BtnOutLet.isHidden = false
                OK.isHidden = false
                Cancel.isHidden = false
            }else if Status == "2" {
                StatusIm.image = #imageLiteral(resourceName: "تم الانجاز-1")
                StatusLa.text = "موافقة"
                BtnOutLet.isHidden = true
            }else if Status == "3" {
                StatusIm.image = #imageLiteral(resourceName: "مرفوض-1")
                StatusLa.text = "مرفوض"
                BtnOutLet.isHidden = false
                OK.isHidden = true
                Cancel.isHidden = false
            }else if Status == "5" {
                StatusIm.image = #imageLiteral(resourceName: "مرفوض-1")
                StatusLa.text = "جاري العمل"
                BtnOutLet.isHidden = true
            }else {
                print("error status")
            }
            
            if DesignFile == ""{
                PDF.isHidden = true
                //            DownPdf.isHidden = true
            } else {
                PDF.isHidden = false
                //            DownPdf.isHidden = false
            }
            tableView.reloadData()
        }else {
            adjustUITextViewHeight(arg: NotesCus)
            adjustUITextViewHeight(arg: NotesEng)
            adjustUITextViewHeight(arg: DetailsDes)
            
            if designsDetialsOfResult[0].ClientReply == "" {
                
                MyDetials.isHidden = true
                NotesCus.isHidden = true
            } else {
                
                MyDetials.isHidden = false
                NotesCus.isHidden = false
            }
            if designsDetialsOfResult[0].EmpReply == "" {
                
                DetailsEngView.isHidden = true
                NotesEng.isHidden = true
            } else {
                
                DetailsEngView.isHidden = false
                NotesEng.isHidden = false
            }
            
            DateOul.text = designsDetialsOfResult[0].CreateDate
            TitleDesign.text = designsDetialsOfResult[0].ProjectBildTypeName
            StagesDe.text = designsDetialsOfResult[0].StagesDetailsName
            //        Mobile.setTitle(mobileStr, for: .normal)
            if designsDetialsOfResult[0].Details == "" {
                stackDetialsDes.isHidden = true
            }else {
                stackDetialsDes.isHidden = false
            }
            DetailsDes.text = designsDetialsOfResult[0].Details
            NotesCus.text = designsDetialsOfResult[0].ClientReply
            NotesEng.text = designsDetialsOfResult[0].EmpReply
            companyNameLabel.text = designsDetialsOfResult[0].ComapnyName
            
            if designsDetialsOfResult[0].Status == "1"{
                StatusIm.image = #imageLiteral(resourceName: "جاري العمل-1")
                StatusLa.text = "انتظار الموافقة"
                StatusLa.textColor = #colorLiteral(red: 0.8196078431, green: 0.3294117647, blue: 0.09803921569, alpha: 1)
                BtnOutLet.isHidden = false
                OK.isHidden = false
                Cancel.isHidden = false
            }else if designsDetialsOfResult[0].Status == "2" {
                StatusIm.image = #imageLiteral(resourceName: "تم الانجاز-1")
                StatusLa.text = "موافقة"
                StatusLa.textColor = #colorLiteral(red: 0.1882352941, green: 0.6784313725, blue: 0.3882352941, alpha: 1)
                BtnOutLet.isHidden = true
            }else if designsDetialsOfResult[0].Status == "3" {
                StatusIm.image = #imageLiteral(resourceName: "مرفوض-1")
                StatusLa.text = "مرفوض"
                StatusLa.textColor = #colorLiteral(red: 0.7450980392, green: 0.2274509804, blue: 0.1921568627, alpha: 1)
                BtnOutLet.isHidden = false
                OK.isHidden = true
                Cancel.isHidden = false
            }else if designsDetialsOfResult[0].Status == "5" {
                StatusIm.image = #imageLiteral(resourceName: "مرفوض-1")
                StatusLa.text = "جاري العمل"
                StatusLa.textColor = #colorLiteral(red: 0.7450980392, green: 0.2274509804, blue: 0.1921568627, alpha: 1)
                BtnOutLet.isHidden = true
            }else {
                print("error status")
            }
            
            if designsDetialsOfResult[0].DesignFile == ""{
                PDF.isHidden = true
                //            DownPdf.isHidden = true
            } else {
                PDF.isHidden = false
                //            DownPdf.isHidden = false
            }
            tableView.reloadData()
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    
    func adjustUITextViewHeight(arg : UITextView)
    {
        //        arg.translatesAutoresizingMaskIntoConstraints = true
        //        arg.sizeToFit()
        arg.isScrollEnabled = false
    }
    
    @IBAction func openPdf(_ sender: UIButton) {
        let openPdf = DesignFile
        let storyBoard : UIStoryboard = UIStoryboard(name: "DesignsAndDetails", bundle:nil)
        let secondView = storyBoard.instantiateViewController(withIdentifier: "openPdfViewController") as! openPdfViewController
        self.navigationController?.pushViewController(secondView, animated: true)
        secondView.url = openPdf
        
        //        if let url = URL(string: openPdf) {
        //            UIApplication.shared.open(url)
        //        }
    }
    
    //    @IBAction func downloadPdf(_ sender: UIButton) {
    //        let openPdf = DesignFile
    //        download(url: openPdf)
    //    }
    
    func download(url: String){
        let destination: DownloadRequest.DownloadFileDestination = { _, _ in
            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let date = Date(timeIntervalSinceNow: 0)
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .medium
            dateFormatter.string(from: date)
            let fileURL = documentsURL.appendingPathComponent("file\(date).pdf")
            
            return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
        }
        
        Alamofire.download(url, to: destination).response { response in
            print(response)
            
            
        }
    }
    
    @IBAction func designCancel(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "DesignsAndDetails", bundle: nil)
        let secondView = storyBoard.instantiateViewController(withIdentifier: "AlertDetialsDesignCancelViewController") as! AlertDetialsDesignCancelViewController
        secondView.modalPresentationStyle = .custom
        self.present(secondView, animated: true)
    }
    
    @IBAction func designOk(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "DesignsAndDetails", bundle: nil)
        let secondView = storyBoard.instantiateViewController(withIdentifier: "AlertDetialsDesignOKViewController") as! AlertDetialsDesignOKViewController
        secondView.modalPresentationStyle = .custom
        self.present(secondView, animated: true)
    }
    
    
    
    @IBAction func directionBtn(_ sender: UIButton) {
        let location = CLLocation(latitude: LatBranch, longitude: LngBranch)
        print(location.coordinate)
        MKMapView.openMapsWith(location) { (error) in
            if error != nil {
                print("Could not open maps" + error!.localizedDescription)
            }
        }
    }
    @IBAction func CallEng(_ sender: UIButton) {
        var mobile: String = mobileStr
        if mobile.count == 10 {
            if mobile.first! == "0" {
                if mobile[mobile.index(mobile.startIndex, offsetBy: 1)] == "5" {
                    mobile.remove(at: mobile.startIndex)
                    mobile.insert("6", at: mobile.startIndex)
                    mobile.insert("6", at: mobile.startIndex)
                    mobile.insert("9", at: mobile.startIndex)
                    callNumber(phoneNumber: mobile)
                } else {
                    callNumber(phoneNumber: mobile)
                }
            } else {
                callNumber(phoneNumber: mobile)
            }
        } else {
            callNumber(phoneNumber: mobile)
        }
    }
    
    @IBAction func CallMe(_ sender: UIButton) {
        var mobile: String = mobileStr
        if mobile.count == 10 {
            if mobile.first! == "0" {
                if mobile[mobile.index(mobile.startIndex, offsetBy: 1)] == "5" {
                    mobile.remove(at: mobile.startIndex)
                    mobile.insert("6", at: mobile.startIndex)
                    mobile.insert("6", at: mobile.startIndex)
                    mobile.insert("9", at: mobile.startIndex)
                    callNumber(phoneNumber: mobile)
                } else {
                    callNumber(phoneNumber: mobile)
                }
            } else {
                callNumber(phoneNumber: mobile)
            }
        } else {
            callNumber(phoneNumber: mobile)
        }
    }
    private func callNumber(phoneNumber:String) {
        
        if let phoneCallURL = URL(string: "tel://\(phoneNumber)") {
            
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                application.open(phoneCallURL, options: [:], completionHandler: nil)
            }
        }
    }
}
