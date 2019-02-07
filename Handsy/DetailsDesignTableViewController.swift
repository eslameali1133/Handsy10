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

protocol AccepEditDesgin {
      func refresh()
}

class DetailsDesignTableViewController: UITableViewController {
    
    
    @IBOutlet weak var EditRecordHeightConstrin: NSLayoutConstraint!
    @IBOutlet weak var EditRecordNotesEngConstrain: NSLayoutConstraint!
    
    @IBOutlet var detialsBtnView: UIView!
     var searchResu:[DesignByProjectIdArray] = [DesignByProjectIdArray]()
    @IBOutlet var loderview: UIView!
    @IBOutlet weak var projectDetialsBtnOut: UIButton!{
        didSet {
            DispatchQueue.main.async {
                self.projectDetialsBtnOut.layer.cornerRadius = 7.0
                self.projectDetialsBtnOut.layer.masksToBounds = true
            }
        }
    }
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
    @IBOutlet weak var messageCountLabel: UILabel!{
        didSet {
            DispatchQueue.main.async {
                self.messageCountLabel.layer.cornerRadius = self.messageCountLabel.frame.width/2
                self.messageCountLabel.layer.masksToBounds = true
            }
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
    @IBOutlet weak var StatsView: UIView!
    @IBOutlet weak var StatusLa: UILabel!
    @IBOutlet weak var TitleDesign: UILabel!
    @IBOutlet weak var StagesDe: UILabel!
//    @IBOutlet weak var stackDetialsDes: UIStackView!
    
    @IBOutlet weak var sakNumber: UILabel!
    @IBOutlet weak var DetailsDes: UITextView!
    @IBOutlet weak var InformationDetiView: UIView!
    
    @IBOutlet weak var NotesCus: UITextView!
    @IBOutlet weak var NotesEng: UITextView!
    @IBOutlet weak var MyDetials: UIView!
    @IBOutlet weak var DetailsEngView: UIView!
    
   
    @IBOutlet weak var JopNameLabel: UILabel!
    @IBOutlet weak var companyNameLabel: UILabel!
     @IBOutlet weak var EngNameLabel: UILabel!
    @IBOutlet weak var engbootn_cons: NSLayoutConstraint!
    
    @IBOutlet weak var Eng_note_title: UILabel!
    @IBOutlet weak var cus_note_title: UILabel!
    @IBOutlet weak var companyImageOut: UIImageView!{
        didSet {
            DispatchQueue.main.async {
                self.companyImageOut.layer.cornerRadius = 7.0
                self.companyImageOut.layer.masksToBounds = true
            }
        }
    }
    
    
    @IBOutlet weak var EditRecordBtn: UIButton!{
        didSet {
        DispatchQueue.main.async {
            self.EditRecordBtn.layer.cornerRadius = 8.0
            self.EditRecordBtn.layer.masksToBounds = true
        }
    }
}
    
    @IBOutlet weak var EditReordTopConstrin: NSLayoutConstraint!
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        cus_note_title.tex
        DetailsDes.textContainerInset = UIEdgeInsetsMake(-1, 0, 0, 0)
        NotesCus.textContainerInset = UIEdgeInsetsMake(-1, 0, 0, 10)
        NotesEng.textContainerInset = UIEdgeInsetsMake(-1, 0, 0, 10)
        loderview.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        self.view.addSubview(loderview)
        loderview.isHidden = true
        detialsBtnView.isHidden = true
        BtnOutLet.isHidden = true
        if isScroll == false {
            
        }else {
            let indexPath = IndexPath(row: 1, section: 0)
            print(indexPath)
            self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
        }
        
        if Reachability.isConnectedToNetwork(){
            print("Internet Connection Available!")
            self.messageCountLabel.isHidden = true
            GetDesignsByDesignStagesID()
              CountCustomerNotification()
        }else{
             self.messageCountLabel.isHidden = true
            designsDetialsModel.loadItems()
            print("Internet Connection not Available!")
            if designsDetialsModel.returnProjectDetials(at: designStagesID) != nil {
                let designsDetials = designsDetialsModel.returnProjectDetials(at: designStagesID)
                self.designsDetialsOfResult = [designsDetials!]
                self.ComapnyNameFunc(companyName: designsDetialsOfResult[0].ComapnyName!, companyLogo: designsDetialsOfResult[0].Logo!, JobName: designsDetialsOfResult[0].JobName!)
                self.setData(condition: "offline")
            }
        }
        DispatchQueue.main.async {
            self.detialsBtnView.frame = CGRect.init(x: 0, y: self.tableView.contentOffset.y + (self.view.frame.height-57), width: self.view.frame.width, height: 57)
            if #available(iOS 11, *) {
                self.tableView.contentInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 47, right: 0)
            }else{
                self.tableView.contentInset = UIEdgeInsets.init(top: 52, left: 0, bottom: 47, right: 0)
            }
            self.tableView.bringSubview(toFront: self.detialsBtnView)
            self.tableView.addSubview(self.detialsBtnView)
        }
        InformationDetiView.isHidden = false
        NotesEng.isHidden = false
        NotesCus.isHidden = false
        BtnOutLet.isHidden = true
        OK.isHidden = true
        Cancel.isHidden = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        viewDidLoad()
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView){
        if scrollView == tableView {
            var frame: CGRect = self.detialsBtnView.frame
            frame.origin.y = scrollView.contentOffset.y + self.view.frame.height - 57
            detialsBtnView.frame = frame
        }
    }
    
    var DesignHistoryCount: String = ""
    func GetDesignsByDesignStagesID(){
//          let sv = UIViewController.displaySpinner(onView: view)
        loderview.isHidden = false

detialsBtnView.isHidden = true
        let parameters: Parameters = [
            "designStagesID": designStagesID
        ]
        
        Alamofire.request("http://smusers.promit2030.com/Service1.svc/GetDesignsByDesignStagesID", method: .get, parameters: parameters, encoding: URLEncoding.default).responseJSON { response in
            debugPrint(response)
            let json = JSON(response.result.value!)
            let requestProjectObj = DesignsDetialsArray(CreateDate: json["CreateDate"].stringValue, DesignFile: json["DesignFile"].stringValue, DesignStagesID: json["DesignStagesID"].stringValue, Details: json["Details"].stringValue, EmpName: json["EmpName"].stringValue, mobileStr: json["Mobile"].stringValue, ProjectBildTypeName: json["ProjectBildTypeName"].stringValue, ProjectStatusID: json["ProjectStatusID"].stringValue, SakNum: json["SakNum"].stringValue, StagesDetailsName: json["StagesDetailsName"].stringValue, Status: json["Status"].stringValue, ClientReply: json["ClientReply"].stringValue, EmpReply: json["EmpReply"].stringValue, ComapnyName: json["ComapnyName"].stringValue, LatBranch: json["LatBranch"].doubleValue, LngBranch: json["LngBranch"].doubleValue, JobName: json["JobName"].stringValue, Address: json["Address"].stringValue, Logo: json["Logo"].stringValue, ProjectId: json["ProjectId"].stringValue, CompanyInfoID: json["CompanyInfoID"].stringValue, IsCompany: json["IsCompany"].stringValue)
            
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
            self.ProjectId = json["ProjectId"].stringValue
            self.CompanyInfoID = json["CompanyInfoID"].stringValue
            self.IsCompany = json["IsCompany"].stringValue
            self.DesignHistoryCount = json["DesignHistoryCount"].stringValue
            self.GetCountMessageUnReaded()
            self.designsDetialsOfResult.append(requestProjectObj)
            for i in self.designsDetialsOfResult {
                self.designsDetialsModel.append(i)
            }
            
            self.ComapnyNameFunc(companyName: self.ComapnyName, companyLogo: self.Logo, JobName: self.JobName)
            self.setData(condition: "online")
            self.tableView.reloadData()
//             UIViewController.removeSpinner(spinner: sv)
            self.loderview.isHidden = true
            self.detialsBtnView.isHidden = false
        }
        
    }
    
    func ComapnyNameFunc(companyName: String, companyLogo: String, JobName: String){
        EngNameLabel.text = EmpName
        companyNameLabel.text = ComapnyName
//        JopNameLabel.text = JobName
        let trimmedString = companyLogo.trimmingCharacters(in: .whitespaces)


        tableView.reloadData()
    }
    
    func setData(condition: String) {
        if condition == "online" {
            adjustUITextViewHeight(arg: NotesCus)
            adjustUITextViewHeight(arg: NotesEng)
            adjustUITextViewHeight(arg: DetailsDes)
          
            NotesCus.clipsToBounds = true
            NotesCus.layer.cornerRadius = 10
            if #available(iOS 11.0, *) {
                NotesCus.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
            } else {
                // Fallback on earlier versions
            }
          
            NotesEng.clipsToBounds = true
            NotesEng.layer.cornerRadius = 10
            if #available(iOS 11.0, *) {
                NotesEng.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
            } else {
                // Fallback on earlier versions
            }
            
              if ClientReply == "" &&  EmpReply == ""
              {
                DetailsEngView.isHidden = true
            }
            
            if ClientReply == ""{
                cus_note_title.isHidden = true
                MyDetials.isHidden = true
                NotesCus.isHidden = true
            } else {
                 cus_note_title.isHidden = false
                MyDetials.isHidden = false
                NotesCus.isHidden = false
                 DetailsEngView.isHidden = false
            }
            
            if EmpReply == "" {
                EditReordTopConstrin.isActive = true
              EditRecordNotesEngConstrain = nil
                
                 Eng_note_title.isHidden = true
                NotesEng.isHidden = true
                 MyDetials.isHidden = true
            } else {
                 EditReordTopConstrin = nil
                EditRecordNotesEngConstrain.isActive = true
                DetailsEngView.isHidden = false
                NotesEng.isHidden = false
                  Eng_note_title.isHidden = false
                  DetailsEngView.isHidden = false
            }
            
         
            DateOul.text = CreateDate
            TitleDesign.text = ProjectBildTypeName
            if SakNum != ""
            {
                sakNumber.text = SakNum
            }
            else
            {
                sakNumber.text = ProjectId
            }
//             sakNumber.text = ProjectId
            StagesDe.text = StagesDetailsName


            DetailsDes.text = Details
             NotesCus.isHidden = false
            print(ClientReply)
            NotesCus.text = ClientReply
            NotesEng.text = EmpReply
            
           
            companyNameLabel.text = ComapnyName
            
            if Status == "1"{
//                StatusIm.image = #imageLiteral(resourceName: "جاري العمل-1")
//                StatsView.b
                StatusLa.text = "انتظار الموافقة"
//                StatusLa.textColor = #colorLiteral(red: 0.8196078431, green: 0.3294117647, blue: 0.09803921569, alpha: 1)
    StatsView.backgroundColor = #colorLiteral(red: 0.8196078431, green: 0.3294117647, blue: 0.09803921569, alpha: 1)
                BtnOutLet.isHidden = false
                OK.isHidden = false
                Cancel.isHidden = false
            }else if Status == "2" {
//                StatusIm.image = #imageLiteral(resourceName: "تم الانجاز-1")
//                StatusLa.textColor = #colorLiteral(red: 0.1882352941, green: 0.6784313725, blue: 0.3882352941, alpha: 1)
                 StatsView.backgroundColor = #colorLiteral(red: 0.1882352941, green: 0.6784313725, blue: 0.3882352941, alpha: 1)
                StatusLa.text = "موافقة"
                BtnOutLet.isHidden = true
            }else if Status == "3" {
//                StatusIm.image = #imageLiteral(resourceName: "مرفوض-1")
//                StatusLa.textColor = #colorLiteral(red: 0.8459660948, green: 0.2274509804, blue: 0.1921568627, alpha: 1)
                StatsView.backgroundColor = #colorLiteral(red: 0.8459660948, green: 0.2274509804, blue: 0.1921568627, alpha: 1)

                StatusLa.text = "طلب التعديل"
                BtnOutLet.isHidden = false
                OK.isHidden = false
                Cancel.isHidden = false
            }else if Status == "5" {
//                StatusIm.image = #imageLiteral(resourceName: "مرفوض-1")
//                StatusLa.textColor = #colorLiteral(red: 0.7450980392, green: 0.2274509804, blue: 0.1921568627, alpha: 1)
                StatsView.backgroundColor = #colorLiteral(red: 0.831372549, green: 0.6862745098, blue: 0.2117647059, alpha: 1)

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
            
            if DesignHistoryCount != "" ||  DesignHistoryCount != "0"
            {
                  EditRecordBtn.isHidden = false 
                
            }else
            {
               
                EditRecordBtn.isHidden = true
                EditRecordHeightConstrin.constant = 0
            }
            
            tableView.reloadData()
        }else {
            adjustUITextViewHeight(arg: NotesCus)
            adjustUITextViewHeight(arg: NotesEng)
            adjustUITextViewHeight(arg: DetailsDes)
            
            NotesCus.clipsToBounds = true
            NotesCus.layer.cornerRadius = 10
            if #available(iOS 11.0, *) {
                NotesCus.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
            } else {
                // Fallback on earlier versions
            }
            
            NotesEng.clipsToBounds = true
            NotesEng.layer.cornerRadius = 10
            if #available(iOS 11.0, *) {
                NotesEng.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
            } else {
                // Fallback on earlier versions
            }
            
          
            if designsDetialsOfResult[0].ClientReply == "" {
                cus_note_title.isHidden = true
                MyDetials.isHidden = true
                NotesCus.isHidden = true
                
            } else {
                
                 cus_note_title.isHidden = false
                MyDetials.isHidden = false
                NotesCus.isHidden = false
            }
            if designsDetialsOfResult[0].ClientReply == "" &&  designsDetialsOfResult[0].EmpReply == ""
            {
                DetailsEngView.isHidden = true
            }
            if designsDetialsOfResult[0].EmpReply == "" {
              
               Eng_note_title.isHidden = true
                NotesEng.isHidden = true
            } else {
                  Eng_note_title.isHidden = false
                DetailsEngView.isHidden = false
                NotesEng.isHidden = false
            }
            print(designsDetialsOfResult[0].ClientReply)
            DateOul.text = designsDetialsOfResult[0].CreateDate
            TitleDesign.text = designsDetialsOfResult[0].ProjectBildTypeName
            if designsDetialsOfResult[0].SakNum != ""
            {
                sakNumber.text = designsDetialsOfResult[0].SakNum
            }
            else
            {
                  sakNumber.text = designsDetialsOfResult[0].ProjectId
            }
//              sakNumber.text = designsDetialsOfResult[0].ProjectId
            StagesDe.text = designsDetialsOfResult[0].StagesDetailsName
            //        Mobile.setTitle(mobileStr, for: .normal)
//            if designsDetialsOfResult[0].Details == "" {
//                stackDetialsDes.isHidden = true
//            }else {
//                stackDetialsDes.isHidden = false
//            }
            DetailsDes.text = designsDetialsOfResult[0].Details
            NotesCus.text = designsDetialsOfResult[0].ClientReply
            NotesEng.text = designsDetialsOfResult[0].EmpReply
            companyNameLabel.text = designsDetialsOfResult[0].ComapnyName
            
            if designsDetialsOfResult[0].Status == "1"{
//                StatusIm.image = #imageLiteral(resourceName: "جاري العمل-1")
                StatusLa.text = "انتظار الموافقة"
//                StatusLa.textColor = #colorLiteral(red: 0.8196078431, green: 0.3294117647, blue: 0.09803921569, alpha: 1)
                 StatsView.backgroundColor = #colorLiteral(red: 0.8196078431, green: 0.3294117647, blue: 0.09803921569, alpha: 1)
                BtnOutLet.isHidden = false
                OK.isHidden = false
                Cancel.isHidden = false
            }else if designsDetialsOfResult[0].Status == "2" {
//                StatusIm.image = #imageLiteral(resourceName: "تم الانجاز-1")
                StatusLa.text = "موافقة"
//                StatusLa.textColor = #colorLiteral(red: 0.1882352941, green: 0.6784313725, blue: 0.3882352941, alpha: 1)
                 StatsView.backgroundColor = #colorLiteral(red: 0.1882352941, green: 0.6784313725, blue: 0.3882352941, alpha: 1)
                BtnOutLet.isHidden = true
            }else if designsDetialsOfResult[0].Status == "3" {
//                StatusIm.image = #imageLiteral(resourceName: "مرفوض-1")
                StatusLa.text = "طلب تعديل"
//                StatusLa.textColor = #colorLiteral(red: 0.8459660948, green: 0.2274509804, blue: 0.1921568627, alpha: 1)
                 StatsView.backgroundColor = #colorLiteral(red: 0.8459660948, green: 0.2274509804, blue: 0.1921568627, alpha: 1)
                BtnOutLet.isHidden = false
                OK.isHidden = false
                Cancel.isHidden = false
            }else if designsDetialsOfResult[0].Status == "5" {
//                StatusIm.image = #imageLiteral(resourceName: "مرفوض-1")
                StatusLa.text = "جاري العمل"
//                StatusLa.textColor = #colorLiteral(red: 0.7450980392, green: 0.2274509804, blue: 0.1921568627, alpha: 1)
                 StatsView.backgroundColor = #colorLiteral(red: 0.831372549, green: 0.6862745098, blue: 0.2117647059, alpha: 1)
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
        let x = DesignByProjectIdArray(CreateDate: CreateDate, DesignFile: DesignFile, DesignStagesID: DesignStagesID, Details: Details, EmpName: EmpName, Mobile: mobileStr, ProjectBildTypeName: ProjectBildTypeName, ProjectStatusID: ProjectStatusID, SakNum: SakNum, StagesDetailsName: StagesDetailsName, Status: Status, ClientReply: ClientReply, EmpReply: EmpReply, ComapnyName: ComapnyName, LatBranch: LatBranch, LngBranch: LngBranch, Address: Address, Logo: Logo)
        searchResu.append(x)
        let openPdf = DesignFile
        let storyBoard : UIStoryboard = UIStoryboard(name: "DesignsAndDetails", bundle:nil)
        let secondView = storyBoard.instantiateViewController(withIdentifier: "openPdfViewController") as! openPdfViewController
        secondView.searchResu = searchResu
        if StatusLa.text == "انتظار الموافقة"{
            secondView.condBottomButtons = "AcceptAndEdit"
            secondView.reloadApi = self
        }else if StatusLa.text == "طلب التعديل" {
            secondView.condBottomButtons = "AcceptAndEdit"
            secondView.reloadApi = self
        }else {
            print("error status")
        }
        secondView.url = openPdf
        self.navigationController?.pushViewController(secondView, animated: true)
        
        //        if let url = URL(string: openPdf) {
        //            UIApplication.shared.open(url)
        //        }
    }
    
    //    @IBAction func downloadPdf(_ sender: UIButton) {
    //        let openPdf = DesignFile
    //        download(url: openPdf)
    //    }
    
    @IBAction func openDetialsViewController(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "NewHome", bundle: nil)
        let secondView = storyBoard.instantiateViewController(withIdentifier: "NewProjectDetialsFilterTableViewController") as! NewProjectDetialsFilterTableViewController
        secondView.ProjectId = self.ProjectId
        secondView.nou = "uu"
        self.navigationController?.pushViewController(secondView, animated: true)
    }
    
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
        secondView.reloadApi = self
        secondView.modalPresentationStyle = .custom
        self.present(secondView, animated: true)
    }
    
    @IBAction func designOk(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "DesignsAndDetails", bundle: nil)
        let secondView = storyBoard.instantiateViewController(withIdentifier: "AlertDetialsDesignOKViewController") as! AlertDetialsDesignOKViewController
        secondView.reloadApi = self
//        secondView.pro_id = ProjectId
//        secondView.designStagesID = DesignStagesID
        secondView.modalPresentationStyle = .custom
        self.present(secondView, animated: true)
    }
    
    @IBAction func openChat(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Chat", bundle: nil)
        let FirstViewController = storyboard.instantiateViewController(withIdentifier: "ChatOfProjectsViewController") as! ChatOfProjectsViewController
        FirstViewController.ProjectId = ProjectId
        self.navigationController?.pushViewController(FirstViewController, animated: true)
    }
    
    // func to Get Messages Count UnReaded
    func GetCountMessageUnReaded() {
        // call some api
        
        let parameters: Parameters = ["projectId": ProjectId]
        
        Alamofire.request("http://smusers.promit2030.com/api/ApiService/GetCountMessageUnReaded", method: .get, parameters: parameters, encoding: URLEncoding.default).responseJSON { response in
            debugPrint(response)
            let json = JSON(response.result.value!)
            let MessageCount = json["MessageCount"].stringValue
            if MessageCount == "" || MessageCount == "0" {
                self.messageCountLabel.isHidden = true
            }else {
                self.messageCountLabel.isHidden = false
                self.messageCountLabel.text = MessageCount
            }
            print(json)
        }
        
    }
    
    @IBAction func DetialsBtnAction(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "NewProject", bundle:nil)
        let secondView = storyBoard.instantiateViewController(withIdentifier: "DetailsOfOfficeTableViewController") as! DetailsOfOfficeTableViewController
        secondView.isCompany = IsCompany
        secondView.CompanyInfoID = CompanyInfoID
        secondView.conditionService = "condition"
        secondView.LatBranch = LatBranch
        secondView.LngBranch = LngBranch
        self.navigationController?.pushViewController(secondView, animated: true)
    }
    
    @IBAction func directionBtn(_ sender: UIButton) {
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
//        let alertAction = UIAlertController(title: "اختر الخريطة", message: "", preferredStyle: .alert)
//
//        alertAction.addAction(UIAlertAction(title: "جوجل ماب", style: .default, handler: { action in
//            if UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!) {
//                UIApplication.shared.open(URL(string: "comgooglemaps://?center=\(self.LatBranch),\(self.LngBranch)&zoom=14&views=traffic&q=\(self.LatBranch),\(self.LngBranch)")!, options: [:], completionHandler: nil)
//            } else {
//                print("Can't use comgooglemaps://")
//                UIApplication.shared.open(URL(string: "http://maps.google.com/maps?q=\(self.LatBranch),\(self.LngBranch)&zoom=14&views=traffic")!, options: [:], completionHandler: nil)
//            }
//        }))
//
//        alertAction.addAction(UIAlertAction(title: "الخرئط", style: .default, handler: { action in
//            let location = CLLocation(latitude: self.LatBranch, longitude: self.LngBranch)
//            print(location.coordinate)
//            MKMapView.openMapsWith(location) { (error) in
//                if error != nil {
//                    print("Could not open maps" + error!.localizedDescription)
//                }
//            }
//        }))
//
//        alertAction.addAction(UIAlertAction(title: "رجوع", style: .cancel, handler: { action in
//        }))
//        self.present(alertAction, animated: true, completion: nil)
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
    
    @IBAction func GotoEditRecord(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "DesignsAndDetails", bundle: nil)
        let FirstViewController = storyboard.instantiateViewController(withIdentifier: "EditDesigRecordsVC") as! EditDesigRecordsVC
         FirstViewController.ProjectId = ProjectId
        FirstViewController.Condition = "Design"
          FirstViewController.ProjectTiti = ProjectBildTypeName
          FirstViewController.EngName = EmpName
          FirstViewController.companyName = ComapnyName
        if SakNum != ""
        {
             FirstViewController.sakNum = SakNum
        }
        else
        {
            FirstViewController.sakNum = ProjectId
        }
        
          FirstViewController.mobilestr = mobileStr
        FirstViewController.StatusLa = StatusLa.text!
         FirstViewController.DesignStagesID = designStagesID
       
        self.navigationController?.pushViewController(FirstViewController, animated: true)
        
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
        Alamofire.request("http://smusers.promit2030.com/Service1.svc/CountCustomerNotification", method: .get, parameters: parameters, encoding: URLEncoding.default).responseJSON { response in
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
extension DetailsDesignTableViewController: reloadApi {
    func reload() {
//        viewDidLoad()
        viewWillAppear(false)
    }
}
extension DetailsDesignTableViewController: AccepEditDesgin{
    func refresh() {
    GetDesignsByDesignStagesID()
         NotesCus.isHidden = false
        
    }
    
    
}
