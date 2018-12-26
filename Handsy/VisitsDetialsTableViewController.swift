//
//  VisitsDetialsTableViewController.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 8/22/17.
//  Copyright © 2017 Ahmed Wahdan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import MapKit


protocol reloadApi {
    func reload()
}

class VisitsDetialsTableViewController: UITableViewController {
    @IBOutlet var detialsBtnView: UIView!
    @IBOutlet weak var projectDetialsBtnOut: UIButton!{
        didSet {
            DispatchQueue.main.async {
                self.projectDetialsBtnOut.layer.cornerRadius = 7.0
                self.projectDetialsBtnOut.layer.masksToBounds = true
            }
        }
    }
    @IBOutlet var loderview: UIView!
    @IBOutlet weak var MessageBtn: UIButton! {
        didSet {
            MessageBtn.layer.borderWidth = 1.0
            MessageBtn.layer.borderColor = #colorLiteral(red: 0.2, green: 0.5647058824, blue: 0.3882352941, alpha: 1)
            MessageBtn.layer.cornerRadius = 4.0
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
    
    @IBOutlet weak var StatusView: UIView!
    
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
    var SakNum = ""
    
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
    
    @IBOutlet weak var Dis_view: AMUIView!
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
    
    @IBOutlet weak var SakNumber: UILabel!
    @IBOutlet weak var ClientReplayView: UIView!
    
    @IBOutlet weak var ClientReplayTF: UITextView!
    
    
    @IBOutlet weak var InformationVisit: UIView!
    @IBOutlet weak var EngNameLabel: UILabel!
    @IBOutlet weak var JopNameLabel: UILabel!
    
    @IBOutlet weak var companyNameLabel: UILabel!
    
    var JobName = ""
    var ClientReply = ""
    var LatBranch: Double = 0.0
    var LngBranch: Double = 0.0
    var ProjectId = ""
    var CompanyInfoID = ""
    var IsCompany = ""
    
    var visitsDetialsArray = [VisitsDetialsArray]()
    var visitsDetialsModel: VisitsDetialsModel = VisitsDetialsModel()
    
    @IBOutlet weak var companyImageOut: UIImageView!{
        didSet {
            DispatchQueue.main.async {
                self.companyImageOut.layer.cornerRadius = 7.0
                self.companyImageOut.layer.masksToBounds = true
            }
        }
    }
    
       var AlertController: UIAlertController!
    override func viewDidLoad() {
        super.viewDidLoad()
         CountCustomerNotification()
         discrbtion.textContainerInset = UIEdgeInsetsMake(-3, 0, 0, 0)
        ClientReplayTF.textContainerInset = UIEdgeInsetsMake(-3, 0, 0, 0)
        loderview.isHidden = true
             detialsBtnView.isHidden = true
        loderview.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        self.view.addSubview(loderview)
        
        buttonsView.isHidden = true
        self.messageCountLabel.isHidden = true
        //        assignbackground()
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
    
    override func viewWillAppear(_ animated: Bool) {
         CountCustomerNotification()
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
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView){
        if scrollView == tableView {
            var frame: CGRect = self.detialsBtnView.frame
            frame.origin.y = scrollView.contentOffset.y + self.view.frame.height - 57
            detialsBtnView.frame = frame
        }
    }
    
    func GetMeetingWaitingByMeetingID(){
        loderview.isHidden = false
        detialsBtnView.isHidden = true
           let sv = UIViewController.displaySpinner(onView: view)
        let parameters: Parameters = [
            "meetingID": MeetingID
        ]
        
        Alamofire.request("http://smusers.promit2030.co/Service1.svc/GetMeetingWaitingByMeetingID", method: .get, parameters: parameters, encoding: URLEncoding.default).responseJSON { response in
            debugPrint(response)
            
            let json = JSON(response.result.value!)
            let requestProjectObj = VisitsDetialsArray(Address: json["Address"].stringValue, ComapnyName: json["ComapnyName"].stringValue, Logo: json["Logo"].stringValue, visitTitle: json["Title"].stringValue, MeetingStatus: json["MeetingStatus"].stringValue, Description: json["Description"].stringValue, Notes: json["Notes"].stringValue, Start: json["Start"].stringValue, TimeStartMeeting: json["TimeStartMeeting"].stringValue, StartTime: json["StartTime"].stringValue, ProjectBildTypeName: json["ProjectBildTypeName"].stringValue, Mobile: json["Mobile"].stringValue, EmpName: json["EmpName"].stringValue, Replay: json["Replay"].stringValue, DateReply: json["DateReply"].stringValue, EndTime: json["EndTime"].stringValue, LatBranch: json["LatBranch"].doubleValue, LngBranch: json["LngBranch"].doubleValue, JobName: json["JobName"].stringValue, ClientReply: json["ClientReply"].stringValue, MeetingID: json["MeetingID"].stringValue, ProjectId: json["ProjectId"].stringValue, CompanyInfoID: json["CompanyInfoID"].stringValue, IsCompany: json["IsCompany"].stringValue)
            
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
            self.CompanyInfoID = json["CompanyInfoID"].stringValue
            self.IsCompany = json["IsCompany"].stringValue
            self.SakNum = json["SakNum"].stringValue
            if self.ProjectId != ""
            {
                 self.GetCountMessageUnReaded()
            }
           
            self.visitsDetialsArray.append(requestProjectObj)
            for i in self.visitsDetialsArray {
                self.visitsDetialsModel.append(i)
            }
            UIViewController.removeSpinner(spinner: sv)
            self.loderview.isHidden = true
            self.detialsBtnView.isHidden = false
            
            self.ComapnyNameFunc(EmpName: self.EmpName, companyName: self.ComapnyName, companyLogo: self.Logo, JobName: self.JobName)
            self.setDetiales(condition: "online")
        }
        
    }
    
    func ComapnyNameFunc(EmpName: String ,companyName: String, companyLogo: String, JobName: String){
        EngNameLabel.text = EmpName
        companyNameLabel.text = companyName
//        JopNameLabel.text = JobName
        let trimmedString = companyLogo.trimmingCharacters(in: .whitespaces)
//        if let url = URL.init(string: trimmedString) {
//            companyImageOut.hnk_setImageFromURL(url, placeholder: #imageLiteral(resourceName: "officePlaceholder"))
//        } else{
//            print("nil")
//        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func setDetiales(condition: String) {
        if condition == "online" {
            if (SakNum != "")
            {
                 SakNumber.text = SakNum
            }else
            {
            SakNumber.text = ProjectId
            }
            DataStart.text = Start
            if MeetingStatus == "0"{
                status.text = "انتظار الموافقة"
               StatusView.backgroundColor = #colorLiteral(red: 0.9459478259, green: 0.7699176669, blue: 0.05561546981, alpha: 1)
                //status.textColor = #colorLiteral(red: 0.9411764706, green: 0.7647058824, blue: 0.1882352941, alpha: 1)
                OKVisit.isEnabled = true
                CancelVisit.isEnabled = true
                PauseVisit.isEnabled = true
                buttonsView.isHidden = false
            }else if MeetingStatus == "1"{
                status.text = "تمت المقابلة"
//                statusImage.image = #imageLiteral(resourceName: "Green")
//                //status.textColor = #colorLiteral(red: 0.2235294118, green: 0.7921568627, blue: 0.4549019608, alpha: 1)
                StatusView.backgroundColor = #colorLiteral(red: 0.1812162697, green: 0.7981202602, blue: 0.4416504204, alpha: 1)
                OKVisit.isEnabled = false
                CancelVisit.isEnabled = false
                PauseVisit.isEnabled = false
                buttonsView.isHidden = true
            }else if MeetingStatus == "2"{
                status.text = "ملغية"
//                statusImage.image = #imageLiteral(resourceName: "Orange")
                //status.textColor = #colorLiteral(red: 0.8941176471, green: 0.4941176471, blue: 0.1882352941, alpha: 1)
                 StatusView.backgroundColor = #colorLiteral(red: 0.8941176471, green: 0.4941176471, blue: 0.1882352941, alpha: 1)
                OKVisit.isEnabled = false
                CancelVisit.isEnabled = false
                PauseVisit.isEnabled = false
                buttonsView.isHidden = true
            }else if MeetingStatus == "3"{
                status.text = "فائته"
//                statusImage.image = #imageLiteral(resourceName: "Red")
                //status.textColor = #colorLiteral(red: 0.8980392157, green: 0.3019607843, blue: 0.2588235294, alpha: 1)
                 StatusView.backgroundColor =  #colorLiteral(red: 0.8980392157, green: 0.3019607843, blue: 0.2588235294, alpha: 1)
                OKVisit.isEnabled = false
                CancelVisit.isEnabled = false
                PauseVisit.isEnabled = false
                buttonsView.isHidden = true
            }else if MeetingStatus == "4"{
                status.text = "مؤجلة"
//                statusImage.image = #imageLiteral(resourceName: "Blue")
                //status.textColor = #colorLiteral(red: 0.2274509804, green: 0.6, blue: 0.8470588235, alpha: 1)
                 StatusView.backgroundColor =  #colorLiteral(red: 0.2274509804, green: 0.6, blue: 0.8470588235, alpha: 1)
                OKVisit.isEnabled = false
                CancelVisit.isEnabled = false
                PauseVisit.isEnabled = false
                buttonsView.isHidden = true
            }else if MeetingStatus == "5"{
                status.text = "انتظار المقابلة"
//                statusImage.image = #imageLiteral(resourceName: "تم الانجاز-1")
                //status.textColor = #colorLiteral(red: 0.1882352941, green: 0.6784313725, blue: 0.3882352941, alpha: 1)
                 StatusView.backgroundColor = #colorLiteral(red: 0.1812162697, green: 0.7981202602, blue: 0.4416504204, alpha: 1)
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
                Dis_view.isHidden = false
                discrbtion.text = Description
            } else {
                Dis_view.isHidden = true
            }
            
//            discrbtion.text = Description
            
            
            adjustUITextViewHeight(arg: discrbtion)
            adjustUITextViewHeight(arg: EngReplay)
            ClientReplayTF.text = ClientReply
            adjustUITextViewHeight(arg: ClientReplayTF)
            if Replay == "" {
                engDetials.isHidden = true
            } else {
                engDetials.isHidden = false
            }
            print(ClientReply)
            if ClientReply == "" {
                ClientReplayView.isHidden = true
            }else {
                ClientReplayView.isHidden = false
            }
            tableView.reloadData()
        }else {
            DataStart.text = visitsDetialsArray[0].Start
            if visitsDetialsArray[0].MeetingStatus == "0"{
                status.text = "انتظار الموافقة"
//                statusImage.image = #imageLiteral(resourceName: "Yellow")
                  StatusView.backgroundColor = #colorLiteral(red: 0.9459478259, green: 0.7699176669, blue: 0.05561546981, alpha: 1)
                //status.textColor = #colorLiteral(red: 0.9411764706, green: 0.7647058824, blue: 0.1882352941, alpha: 1)
                OKVisit.isEnabled = true
                CancelVisit.isEnabled = true
                PauseVisit.isEnabled = true
                buttonsView.isHidden = false
            }else if visitsDetialsArray[0].MeetingStatus == "1"{
                status.text = "تمت المقابلة"
//                statusImage.image = #imageLiteral(resourceName: "Green")
                  StatusView.backgroundColor = #colorLiteral(red: 0.2235294118, green: 0.7921568627, blue: 0.4549019608, alpha: 1)
                //status.textColor = #colorLiteral(red: 0.2235294118, green: 0.7921568627, blue: 0.4549019608, alpha: 1)
                OKVisit.isEnabled = false
                CancelVisit.isEnabled = false
                PauseVisit.isEnabled = false
                buttonsView.isHidden = true
            }else if visitsDetialsArray[0].MeetingStatus == "2"{
                status.text = "ملغية"
//                statusImage.image = #imageLiteral(resourceName: "Orange")
                  StatusView.backgroundColor =  #colorLiteral(red: 0.8941176471, green: 0.4941176471, blue: 0.1882352941, alpha: 1)
                //status.textColor = #colorLiteral(red: 0.8941176471, green: 0.4941176471, blue: 0.1882352941, alpha: 1)
                OKVisit.isEnabled = false
                CancelVisit.isEnabled = false
                PauseVisit.isEnabled = false
                buttonsView.isHidden = true
            }else if visitsDetialsArray[0].MeetingStatus == "3"{
                status.text = "فائته"
//                statusImage.image = #imageLiteral(resourceName: "Red")
                  StatusView.backgroundColor = #colorLiteral(red: 0.8980392157, green: 0.3019607843, blue: 0.2588235294, alpha: 1)
                //status.textColor = #colorLiteral(red: 0.8980392157, green: 0.3019607843, blue: 0.2588235294, alpha: 1)
                OKVisit.isEnabled = false
                CancelVisit.isEnabled = false
                PauseVisit.isEnabled = false
                buttonsView.isHidden = true
            }else if visitsDetialsArray[0].MeetingStatus == "4"{
                status.text = "مؤجلة"
//                statusImage.image = #imageLiteral(resourceName: "Blue")
                  StatusView.backgroundColor = #colorLiteral(red: 0.2274509804, green: 0.6, blue: 0.8470588235, alpha: 1)
                //status.textColor = #colorLiteral(red: 0.2274509804, green: 0.6, blue: 0.8470588235, alpha: 1)
                OKVisit.isEnabled = false
                CancelVisit.isEnabled = false
                PauseVisit.isEnabled = false
                buttonsView.isHidden = true
            }else if visitsDetialsArray[0].MeetingStatus == "5"{
                status.text = "انتظار المقابلة"
//                statusImage.image = #imageLiteral(resourceName: "تم الانجاز-1")
                  StatusView.backgroundColor =  #colorLiteral(red: 0.1882352941, green: 0.6784313725, blue: 0.3882352941, alpha: 1)
                //status.textColor = #colorLiteral(red: 0.1882352941, green: 0.6784313725, blue: 0.3882352941, alpha: 1)
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
            if visitsDetialsArray[0].Description != "" {
                discrbtion.isHidden = false
                discrbtion.text = visitsDetialsArray[0].Description
            } else {
                discrbtion.isHidden = true
            }
              SakNumber.text = visitsDetialsArray[0].ProjectId
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
        return 60
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

    @IBAction func visitCancel(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "VisitsAndDetails", bundle: nil)
        let secondView = storyBoard.instantiateViewController(withIdentifier: "AlertVisitCancelViewController") as! AlertVisitCancelViewController
        secondView.reloadApi = self
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
    
    @IBAction func openDetialsViewController(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "NewHome", bundle: nil)
        let secondView = storyBoard.instantiateViewController(withIdentifier: "NewProjectDetialsFilterTableViewController") as! NewProjectDetialsFilterTableViewController
        secondView.ProjectId = self.ProjectId
        secondView.nou = "uu"
        self.navigationController?.pushViewController(secondView, animated: true)
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
        
        
        let dLati = self.LatBranch
        let dLang = self.LngBranch
        
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
        
    }
    
    func openMapsForLocation() {
        let dLati = self.LatBranch
        let dLang = self.LngBranch
        let location = CLLocation(latitude: dLati, longitude: dLang)
        print(location.coordinate)
        MKMapView.openMapsWith(location) { (error) in
            if error != nil {
                print("Could not open maps" + error!.localizedDescription)
            }
        }
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
        
        Alamofire.request("http://smusers.promit2030.co/api/ApiService/GetCountMessageUnReaded", method: .get, parameters: parameters, encoding: URLEncoding.default).responseJSON { response in
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
extension VisitsDetialsTableViewController: reloadApi {
    func reload() {
        viewWillAppear(false)
//        viewDidLoad()
    }
}
extension VisitsDetialsTableViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}
