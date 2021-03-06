//
//  VisitsOfProjectsDetialsTableViewController.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 1/15/18.
//  Copyright © 2018 Ahmed Wahdan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import MapKit

class VisitsOfProjectsDetialsTableViewController: UITableViewController {
    @IBOutlet var detialsBtnView: UIView!
    @IBOutlet weak var projectDetialsBtnOut: UIButton!{
        didSet {
            DispatchQueue.main.async {
                self.projectDetialsBtnOut.layer.cornerRadius = 7.0
                self.projectDetialsBtnOut.layer.masksToBounds = true
            }
        }
    }
    @IBOutlet weak var MessageBtn: UIButton! {
        didSet {
            MessageBtn.layer.borderWidth = 1.0
            MessageBtn.layer.borderColor = #colorLiteral(red: 0.2, green: 0.5647058824, blue: 0.3882352941, alpha: 1)
            MessageBtn.layer.cornerRadius = 4.0
        }
    }
    
    @IBOutlet weak var callBtn: UIButton! {
        didSet {
            callBtn.layer.borderWidth = 1.0
            callBtn.layer.borderColor = #colorLiteral(red: 0.2, green: 0.5647058824, blue: 0.3882352941, alpha: 1)
            callBtn.layer.cornerRadius = 4.0
        }
    }
    
    @IBOutlet weak var officeDetialsBtn: UIButton! {
        didSet {
            officeDetialsBtn.layer.borderWidth = 1.0
            officeDetialsBtn.layer.borderColor = #colorLiteral(red: 0.2, green: 0.5647058824, blue: 0.3882352941, alpha: 1)
            officeDetialsBtn.layer.cornerRadius = 4.0
        }
    }
     var AlertController: UIAlertController!
    var visitTitle: String = ""
    var MeetingStatus: String = ""
    var Description: String = ""
    var Notes: String = ""
    var Start: String = ""
    var TimeStartMeeting: String = ""
    var ProjectBildTypeName: String = ""
    var Mobile: String = ""
    var EmpName: String = ""
    var Replay: String = ""
    var DateReply: String = ""
    var StartTime: String = ""
    var EndTime: String = ""
    var Address = ""
    var ComapnyName = ""
    var Logo = ""
    var meetingID = ""
    var CompanyInfoID = ""
    var arrayOfResulr = [GetOfficesArray]()
    var indexi:Int = 0
    var isCompany = ""
    var ProjectId = ""
    var MessageCount = ""
    @IBOutlet weak var DataStart: UILabel!
    @IBOutlet weak var statusImage: UIImageView!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var lastStatus: UILabel!
    @IBOutlet weak var visitsTitle: UILabel!
    @IBOutlet weak var EngReplay: UITextView!
    @IBOutlet weak var dateEngReplay: UILabel!
    @IBOutlet weak var OKVisit: UIButton!{
        didSet {
            OKVisit.layer.cornerRadius = 4.0
        }
    }
    @IBOutlet weak var CancelVisit: UIButton!{
        didSet {
            CancelVisit.layer.cornerRadius = 4.0
        }
    }
    @IBOutlet weak var PauseVisit: UIButton!{
        didSet {
            PauseVisit.layer.cornerRadius = 4.0
        }
    }
    @IBOutlet weak var discrbtion: UITextView!
    @IBOutlet weak var buttonsView: UIView!
    @IBOutlet weak var engDetials: UIView!
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var endTimeLabel: UILabel!
    @IBOutlet weak var NotesLabel: UILabel!
    @IBOutlet weak var ClientReplayView: UIView!
    @IBOutlet weak var ClientReplayTF: UITextView!
    @IBOutlet weak var InformationVisit: UIView!
    @IBOutlet weak var EngNameLabel: UIButton!
    @IBOutlet weak var JopNameLabel: UILabel!
    @IBOutlet weak var companyNameLabel: UILabel!
    
    var JobName = ""
    var ClientReply = ""
    var LatBranch: Double = 0.0
    var LngBranch: Double = 0.0
    
    @IBOutlet weak var companyImageOut: UIImageView!{
        didSet {
            DispatchQueue.main.async {
                self.companyImageOut.layer.cornerRadius = 7.0
                self.companyImageOut.layer.masksToBounds = true
            }
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
    
    var visitsDetialsArray = [VisitsDetialsArray]()
    var visitsDetialsModel: VisitsDetialsModel = VisitsDetialsModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonsView.isHidden = true
        self.messageCountLabel.isHidden = true
        //        assignbackground()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        if Reachability.isConnectedToNetwork(){
            print("Internet Connection Available!")
            GetMeetingWaitingByMeetingID()
        }else{
            visitsDetialsModel.loadItems()
            print("Internet Connection not Available!")
            if visitsDetialsModel.returnProjectDetials(at: MeetingID) != nil {
                let visitsDetials = visitsDetialsModel.returnProjectDetials(at: MeetingID)
                self.visitsDetialsArray = [visitsDetials!]
                self.ComapnyNameFunc(EmpName: visitsDetialsArray[0].EmpName!, companyName: visitsDetialsArray[0].ComapnyName!, companyLogo: visitsDetialsArray[0].Logo!, JobName: visitsDetialsArray[0].JobName!)
                self.setDetiales(condition: "offline")
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
    
    func GetMeetingWaitingByMeetingID(){
        let parameters: Parameters = [
            "meetingID": MeetingID
        ]
        
        Alamofire.request("http://smusers.promit2030.com/Service1.svc/GetMeetingWaitingByMeetingID", method: .get, parameters: parameters, encoding: URLEncoding.default).responseJSON { response in
            debugPrint(response)
            
            let json = JSON(response.result.value!)
            let requestProjectObj = VisitsDetialsArray(Address: json["Address"].stringValue, ComapnyName: json["ComapnyName"].stringValue, Logo: json["Logo"].stringValue, visitTitle: json["Title"].stringValue, MeetingStatus: json["MeetingStatus"].stringValue, Description: json["Description"].stringValue, Notes: json["Notes"].stringValue, Start: json["Start"].stringValue, TimeStartMeeting: json["TimeStartMeeting"].stringValue, StartTime: json["StartTime"].stringValue, ProjectBildTypeName: json["ProjectBildTypeName"].stringValue, Mobile: json["Mobile"].stringValue, EmpName: json["EmpName"].stringValue, Replay: json["Replay"].stringValue, DateReply: json["DateReply"].stringValue, EndTime: json["EndTime"].stringValue, LatBranch: json["LatBranch"].doubleValue, LngBranch: json["LngBranch"].doubleValue, JobName: json["JobName"].stringValue, ClientReply: json["ClientReply"].stringValue, MeetingID: json["MeetingID"].stringValue, ProjectId: json["ProjectId"].stringValue, CompanyInfoID: json["CompanyInfoID"].stringValue, IsCompany: json["IsCompany"].stringValue,SakNum: json["SakNum"].stringValue)
            self.Address = json["Address"].stringValue
            self.ComapnyName = json["ComapnyName"].stringValue
            self.Logo = json["Logo"].stringValue
            MeetingID = json["MeetingID"].stringValue
            self.visitTitle = json["Title"].stringValue
            self.MeetingStatus = json["MeetingStatus"].stringValue
            self.Description = json["Description"].stringValue
            self.Notes = json["Notes"].stringValue
            self.Start = json["Start"].stringValue
            self.TimeStartMeeting = json["TimeStartMeeting"].stringValue
            self.StartTime = json["StartTime"].stringValue
            self.ProjectBildTypeName = json["ProjectBildTypeName"].stringValue
            self.Mobile = json["Mobile"].stringValue
            self.EmpName = json["EmpName"].stringValue
            self.Replay = json["Replay"].stringValue
            self.DateReply = json["DateReply"].stringValue
            self.EndTime = json["EndTime"].stringValue
            self.LatBranch = json["LatBranch"].doubleValue
            self.LngBranch = json["LngBranch"].doubleValue
            self.JobName = json["JobName"].stringValue
            self.ClientReply = json["ClientReply"].stringValue
            self.ProjectId = json["ProjectId"].stringValue
            self.visitsDetialsArray.append(requestProjectObj)
            self.GetCountMessageUnReaded()
            for i in self.visitsDetialsArray {
                self.visitsDetialsModel.append(i)
            }
            self.ComapnyNameFunc(EmpName: self.EmpName, companyName: self.ComapnyName, companyLogo: self.Logo, JobName: self.JobName)
            self.setDetiales(condition: "online")

        }
        
    }
    
    func ComapnyNameFunc(EmpName: String, companyName: String, companyLogo: String, JobName: String){
        EngNameLabel.setTitle(EmpName, for: .normal)
        companyNameLabel.text = companyName
        JopNameLabel.text = JobName
        let trimmedString = companyLogo.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        if let url = URL.init(string: trimmedString!) {
            companyImageOut.hnk_setImageFromURL(url, placeholder: #imageLiteral(resourceName: "officePlaceholder"))
        } else{
            print("nil")
            companyImageOut.image = #imageLiteral(resourceName: "officePlaceholder")
        }
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView){
        if scrollView == tableView {
            var frame: CGRect = self.detialsBtnView.frame
            frame.origin.y = scrollView.contentOffset.y + self.view.frame.height - 57
            detialsBtnView.frame = frame
        }
    }
    
    @IBAction func openDetialsViewController(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "NewHome", bundle: nil)
        let secondView = storyBoard.instantiateViewController(withIdentifier: "NewProjectDetialsFilterTableViewController") as! NewProjectDetialsFilterTableViewController
        secondView.ProjectId = self.ProjectId
        secondView.nou = "uu"
        self.navigationController?.pushViewController(secondView, animated: true)
    }
    
    func setDetiales(condition: String) {
        if condition == "online" {
            DataStart.text = Start
            if MeetingStatus == "0"{
                status.text = "قيد المقابلة"
                statusImage.image = #imageLiteral(resourceName: "Yellow")
                status.textColor = #colorLiteral(red: 0.9411764706, green: 0.7647058824, blue: 0.1882352941, alpha: 1)
                OKVisit.isEnabled = true
                CancelVisit.isEnabled = true
                PauseVisit.isEnabled = true
                buttonsView.isHidden = false
            }else if MeetingStatus == "1"{
                status.text = "تمت المقابلة"
                statusImage.image = #imageLiteral(resourceName: "Green")
                status.textColor = #colorLiteral(red: 0.2235294118, green: 0.7921568627, blue: 0.4549019608, alpha: 1)
                OKVisit.isEnabled = false
                CancelVisit.isEnabled = false
                PauseVisit.isEnabled = false
                buttonsView.isHidden = true
            }else if MeetingStatus == "2"{
                status.text = "ملغية"
                statusImage.image = #imageLiteral(resourceName: "Orange")
                status.textColor = #colorLiteral(red: 0.8941176471, green: 0.4941176471, blue: 0.1882352941, alpha: 1)
                OKVisit.isEnabled = false
                CancelVisit.isEnabled = false
                PauseVisit.isEnabled = false
                buttonsView.isHidden = true
            }else if MeetingStatus == "3"{
                status.text = "فائته"
                statusImage.image = #imageLiteral(resourceName: "Red")
                status.textColor = #colorLiteral(red: 0.8980392157, green: 0.3019607843, blue: 0.2588235294, alpha: 1)
                OKVisit.isEnabled = false
                CancelVisit.isEnabled = false
                PauseVisit.isEnabled = false
                buttonsView.isHidden = true
            }else if MeetingStatus == "4"{
                status.text = "مؤجلة"
                statusImage.image = #imageLiteral(resourceName: "Blue")
                status.textColor = #colorLiteral(red: 0.2274509804, green: 0.6, blue: 0.8470588235, alpha: 1)
                OKVisit.isEnabled = false
                CancelVisit.isEnabled = false
                PauseVisit.isEnabled = false
                buttonsView.isHidden = true
            }else if MeetingStatus == "5"{
                status.text = "موافقة و قيد المقابلة"
                statusImage.image = #imageLiteral(resourceName: "تم الانجاز-1")
                status.textColor = #colorLiteral(red: 0.1882352941, green: 0.6784313725, blue: 0.3882352941, alpha: 1)
                OKVisit.isEnabled = false
                CancelVisit.isEnabled = false
                PauseVisit.isEnabled = false
                buttonsView.isHidden = true
            }else {
                print("error status")
            }
            lastStatus.text = ProjectBildTypeName
            visitsTitle.text = visitTitle
            //        empMobile.setTitle(Mobile, for: .normal)
            EngReplay.text = Replay
            dateEngReplay.text = DateReply
            DataStart.text = Start
            startTimeLabel.text = StartTime
            endTimeLabel.text = EndTime
            if Description != "" {
                discrbtion.isHidden = false
                discrbtion.text = Description
            }else {
                discrbtion.isHidden = true
            }
            
            adjustUITextViewHeight(arg: discrbtion)
            adjustUITextViewHeight(arg: EngReplay)
            ClientReplayTF.text = ClientReply
            adjustUITextViewHeight(arg: ClientReplayTF)
            if Replay == "" {
                engDetials.isHidden = true
            } else {
                engDetials.isHidden = false
            }
            if ClientReply == "" {
                ClientReplayView.isHidden = true
            }else {
                ClientReplayView.isHidden = false
            }
            tableView.reloadData()
        }else {
            DataStart.text = visitsDetialsArray[0].Start
            if visitsDetialsArray[0].MeetingStatus == "0"{
                status.text = "قيد المقابلة"
                statusImage.image = #imageLiteral(resourceName: "Yellow")
                OKVisit.isEnabled = true
                CancelVisit.isEnabled = true
                PauseVisit.isEnabled = true
                buttonsView.isHidden = false
            }else if visitsDetialsArray[0].MeetingStatus == "1"{
                status.text = "تمت المقابلة"
                statusImage.image = #imageLiteral(resourceName: "Green")
                OKVisit.isEnabled = false
                CancelVisit.isEnabled = false
                PauseVisit.isEnabled = false
                buttonsView.isHidden = true
            }else if visitsDetialsArray[0].MeetingStatus == "2"{
                status.text = "ملغية"
                statusImage.image = #imageLiteral(resourceName: "Orange")
                OKVisit.isEnabled = false
                CancelVisit.isEnabled = false
                PauseVisit.isEnabled = false
                buttonsView.isHidden = true
            }else if visitsDetialsArray[0].MeetingStatus == "3"{
                status.text = "فائته"
                statusImage.image = #imageLiteral(resourceName: "Red")
                OKVisit.isEnabled = false
                CancelVisit.isEnabled = false
                PauseVisit.isEnabled = false
                buttonsView.isHidden = true
            }else if visitsDetialsArray[0].MeetingStatus == "4"{
                status.text = "مؤجلة"
                statusImage.image = #imageLiteral(resourceName: "Blue")
                OKVisit.isEnabled = false
                CancelVisit.isEnabled = false
                PauseVisit.isEnabled = false
                buttonsView.isHidden = true
            }else if visitsDetialsArray[0].MeetingStatus == "5"{
                status.text = "موافقة و قيد المقابلة"
                statusImage.image = #imageLiteral(resourceName: "تم الانجاز-1")
                OKVisit.isEnabled = false
                CancelVisit.isEnabled = false
                PauseVisit.isEnabled = false
                buttonsView.isHidden = true
            }else {
                print("error status")
            }
            lastStatus.text = visitsDetialsArray[0].ProjectBildTypeName
            visitsTitle.text = visitsDetialsArray[0].visitTitle
            //        empMobile.setTitle(Mobile, for: .normal)
            EngReplay.text = visitsDetialsArray[0].Replay
            dateEngReplay.text = visitsDetialsArray[0].DateReply
            DataStart.text = visitsDetialsArray[0].Start
            startTimeLabel.text = visitsDetialsArray[0].StartTime
            endTimeLabel.text = visitsDetialsArray[0].EndTime
            discrbtion.text = visitsDetialsArray[0].Description
            adjustUITextViewHeight(arg: discrbtion)
            adjustUITextViewHeight(arg: EngReplay)
            ClientReplayTF.text = visitsDetialsArray[0].ClientReply
            adjustUITextViewHeight(arg: ClientReplayTF)
            if visitsDetialsArray[0].Replay == "" {
                engDetials.isHidden = true
            } else {
                engDetials.isHidden = false
            }
            if visitsDetialsArray[0].ClientReply == "" {
                ClientReplayView.isHidden = true
            }else {
                ClientReplayView.isHidden = false
            }
            tableView.reloadData()
        }
    }
    
    func adjustUITextViewHeight(arg : UITextView)
    {
        //        arg.translatesAutoresizingMaskIntoConstraints = true
        //        arg.sizeToFit()
        arg.isScrollEnabled = false
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 210
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    
    
    @IBAction func visitCancel(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "VisitsAndDetails", bundle: nil)
        let secondView = storyBoard.instantiateViewController(withIdentifier: "AlertVisitCancelViewController") as! AlertVisitCancelViewController
        secondView.modalPresentationStyle = .custom
        self.present(secondView, animated: true)
    }
    
    @IBAction func pauseVisit(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "VisitsAndDetails", bundle: nil)
        let secondView = storyBoard.instantiateViewController(withIdentifier: "AlertVisitPauseViewController") as! AlertVisitPauseViewController
        secondView.reloadApi = self
        secondView.modalPresentationStyle = .custom
        self.present(secondView, animated: true)
    }
    
    
    @IBAction func visitOk(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "VisitsAndDetails", bundle: nil)
        let secondView = storyBoard.instantiateViewController(withIdentifier: "AlertVisitOkViewController") as! AlertVisitOkViewController
        secondView.reloadApi = self
        secondView.modalPresentationStyle = .custom
        self.present(secondView, animated: true)
    }
    
    @IBAction func directionBtn(_ sender: UIButton) {
        if Helper.isDeviceiPad() {
            
            if let popoverController = AlertController.popoverPresentationController {
                popoverController.sourceView = sender
            }
        }
        
        self.present(AlertController, animated: true, completion: nil)
        
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
//        alertAction.addAction(UIAlertAction(title: "الخرائط", style: .default, handler: { action in
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
    
    @IBAction func goOfficeDetials(_ sender: UIButton) {
        GetOfficesByProvincesID()
    }
    
    func GetOfficesByProvincesID(){
        let sv = UIViewController.displaySpinner(onView: self.view)
        //        let id = UserDefaults.standard.string(forKey: "account_id")!
        //        let account_type = UserDefaults.standard.string(forKey: "account_type")!
        
        
        let Parameters: Parameters = [
            "companyInfoID": CompanyInfoID
        ]
        
        Alamofire.request("http://smusers.promit2030.com/Service1.svc/GetOfficeByCompanyInfoID", method: .get, parameters: Parameters, encoding: URLEncoding.default).responseJSON { response in
            debugPrint(response)
            
            let json = JSON(response.result.value!)
            let requestProjectObj = GetOfficesArray()
            requestProjectObj.CompanyInfoID = json["CompanyInfoID"].stringValue
            requestProjectObj.ComapnyName = json["ComapnyName"].stringValue
            requestProjectObj.CompanyMobile = json["CompanyMobile"].stringValue
            requestProjectObj.Street = json["Street"].stringValue
            requestProjectObj.BiuldNumber = json["BiuldNumber"].stringValue
            requestProjectObj.PostNumber = json["PostNumber"].stringValue
            requestProjectObj.PostSymbol = json["PostSymbol"].stringValue
            requestProjectObj.PostNumberWasl = json["PostNumberWasl"].stringValue
            requestProjectObj.Phone = json["Phone"].stringValue
            requestProjectObj.Fax = json["Fax"].stringValue
            requestProjectObj.Long = json["Long"].doubleValue
            requestProjectObj.Lat = json["Lat"].doubleValue
            requestProjectObj.Zoom = json["Zoom"].stringValue
            requestProjectObj.LicenceNumber = json["LicenceNumber"].stringValue
            requestProjectObj.CommercialNumber = json["CommercialNumber"].stringValue
            requestProjectObj.CompanyEmail = json["CompanyEmail"].stringValue
            requestProjectObj.IsCompany = json["IsCompany"].stringValue
            requestProjectObj.Specialty = json["Specialty"].stringValue
            requestProjectObj.IsSCE = json["IsSCE"].stringValue
            requestProjectObj.Logo = json["Logo"].stringValue
            requestProjectObj.BranchFB = json["BranchFB"].stringValue
            requestProjectObj.BranchID = json["BranchID"].stringValue
            requestProjectObj.Address = json["Address"].stringValue
            
            self.arrayOfResulr.append(requestProjectObj)
            UIViewController.removeSpinner(spinner: sv)
            self.goH()
        }
    }
    
    func goH(){
        let storyBoard : UIStoryboard = UIStoryboard(name: "NewProject", bundle:nil)
        let secondView = storyBoard.instantiateViewController(withIdentifier: "DetailsOfOfficeTableViewController") as! DetailsOfOfficeTableViewController
        secondView.arrayOfResulr = self.arrayOfResulr
        print("arrr: \(self.arrayOfResulr.count)")
        secondView.CompanyInfoID = self.CompanyInfoID
        secondView.conditionService = "condition"
        secondView.LatBranch = LatBranch
        secondView.LngBranch = LngBranch
        self.navigationController?.pushViewController(secondView, animated: true)
    }
    
    @IBAction func openChatBtn(_ sender: UIButton) {
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
    
    @IBAction func CallMe(_ sender: UIButton) {
        var mobile: String = Mobile
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
extension VisitsOfProjectsDetialsTableViewController: reloadApi {
    func reload() {
        viewDidLoad()
    }
}
