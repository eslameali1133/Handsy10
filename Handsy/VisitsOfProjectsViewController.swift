//
//  VisitsOfProjectsViewController.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 12/31/17.
//  Copyright © 2017 Ahmed Wahdan. All rights reserved.
//

import UIKit
import MapKit
import Alamofire
import SwiftyJSON

class VisitsOfProjectsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, VisitsByProjectIdModelDelegate {
    
    var visitsByProjectIdArr:[VisitsByProjectIdArray] = [VisitsByProjectIdArray]()
    
    let model: VisitsByProjectIdModel = VisitsByProjectIdModel()
    
    let visitsModel: VisitsProjectIdModel = VisitsProjectIdModel()
    
    @IBOutlet weak var FIlterView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    var ProjectId: String = ""
    var projectTitleView: String = ""
    var ProjectFilesTitle: String = ""
    var ComapnyName: String = ""
    var EmpName = ""
    var EmpMobile = ""
    var Logo = ""
    var LatBranch: Double = 0.0
    var LngBranch: Double = 0.0
    var CompanyInfoID = ""
    var arrayOfResulr = [GetOfficesArray]()
    var indexi:Int = 0
    var isCompany = ""
    var MessageCount = ""
    var ProjectOfResult: [ProjectDetialsArray] = [ProjectDetialsArray]()

    
    @IBOutlet weak var lbl_ChatCounter: UILabel!{
        didSet {
            DispatchQueue.main.async {
                self.lbl_ChatCounter.layer.cornerRadius = self.lbl_ChatCounter.frame.width/2
                self.lbl_ChatCounter.layer.masksToBounds = true
            }
        }
    }
    @IBOutlet weak var companyCallBtn: UIButton! {
        didSet {
            companyCallBtn.layer.borderWidth = 1.0
            companyCallBtn.layer.borderColor = #colorLiteral(red: 0.2, green: 0.5647058824, blue: 0.3882352941, alpha: 1)
            companyCallBtn.layer.cornerRadius = 4.0
        }
    }
    @IBOutlet weak var btnchat: UIButton!{
        didSet {
            btnchat.layer.borderWidth = 1.0
            btnchat.layer.borderColor = #colorLiteral(red: 0.2, green: 0.5647058824, blue: 0.3882352941, alpha: 1)
            btnchat.layer.cornerRadius = 4.0
        }
    }
    
    @IBOutlet weak var NothingLabel: UIStackView!
    @IBOutlet weak var AlertImage: UIImageView!
    @IBOutlet weak var statusNameBtn: UIButton!
    @IBOutlet weak var cancelStatusBtn: UIButton!
    var StatusId = ""
    @IBOutlet weak var statusName: UILabel!
    @IBOutlet weak var statusImage: AMCircleImageView!
    
    
    @IBOutlet weak var mobileNumber: UIButton!
    
    @IBOutlet weak var officeDetialsBtn: UIButton! {
        didSet {
            officeDetialsBtn.layer.borderWidth = 1.0
            officeDetialsBtn.layer.borderColor = #colorLiteral(red: 0.2, green: 0.5647058824, blue: 0.3882352941, alpha: 1)
            officeDetialsBtn.layer.cornerRadius = 4.0
        }
    }
    
    @IBOutlet weak var arciveVisits: UIButton! {
        didSet {
            arciveVisits.layer.borderWidth = 1.0
            arciveVisits.layer.borderColor = #colorLiteral(red: 0.2, green: 0.5647058824, blue: 0.3882352941, alpha: 1)
            arciveVisits.layer.cornerRadius = 4.0
        }
    }
    
    @IBOutlet weak var companyImageOut: UIImageView!{
        didSet {
            companyImageOut.layer.cornerRadius = 14.0
        }
    }
    @IBOutlet weak var Saknumber: UILabel!
    @IBOutlet weak var projectTitleLabel: UILabel!
    @IBOutlet weak var companyNameLabel: UILabel!
//    @IBOutlet weak var addressLabel: UILabel!
    var AlertController: UIAlertController!
    override func viewDidLoad() {
        super.viewDidLoad()
        ComapnyNameFunc()
        cancelStatusBtn.isHidden = true
        DispatchQueue.main.async {
            self.NothingLabel.isHidden = true
            self.AlertImage.isHidden = true
        }
        tableView.delegate = self
        tableView.dataSource = self
        
        model.delegate = self
        
        
     
        DispatchQueue.main.async {
            self.NothingLabel.isHidden = true
        }
        // Do any additional setup after loading the view.
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
    @IBOutlet weak var btn_direction: UIButton!{
        didSet {
            btn_direction.layer.borderWidth = 1.0
            btn_direction.layer.borderColor = #colorLiteral(red: 0.2, green: 0.5647058824, blue: 0.3882352941, alpha: 1)
            btn_direction.layer.cornerRadius = 4.0
        }
    }
    @IBAction func directionBtn(_ sender: UIButton) {
        let location = CLLocation(latitude: LatBranch, longitude: LngBranch)
        
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
//        self.present(AlertController, animated: true, completion: nil)
        
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
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        if Reachability.isConnectedToNetwork(){
            print("Internet Connection Available!")
            GetCountMessageUnReaded()
            model.GetMeetingByCustId(view: self.view, projectId: ProjectId, condtion: "first", type: "1", StatusId: "")
        }else{
            print("Internet Connection not Available!")
            visitsModel.loadItems()
            if visitsModel.returnProjectDetials(at: ProjectId) != nil {
                let visitsDetials = visitsModel.returnProjectDetials(at: ProjectId)
                self.visitsByProjectIdArr = visitsDetials!
                if visitsByProjectIdArr.count == 0 {
                    NothingLabel.isHidden = false
                    AlertImage.isHidden = false
                } else {
                    NothingLabel.isHidden = true
                    AlertImage.isHidden = true
                }
            }
            tableView.reloadData()
        }
        
        viewDidLoad()
    }
    
    
    // function which is triggered when handleTap is called
  
    
    
    
    func ComapnyNameFunc(){
        companyNameLabel.text = ProjectOfResult[0].ComapnyName!
        projectTitleLabel.text = ProjectOfResult[0].ProjectTitle
        
        if ProjectOfResult[0].SakNum != ""
        {
            Saknumber.text = ProjectOfResult[0].SakNum
        }else
        {
            Saknumber.text = ProjectOfResult[0].ProjectId
        }
//        Saknumber.text = ProjectOfResult[0].ProjectId
        
        
        if MessageCount == "" || MessageCount == "0" {
            lbl_ChatCounter.isHidden = true
        }else {
           lbl_ChatCounter.isHidden = false
            lbl_ChatCounter.text = MessageCount
        }
//        addressLabel.text = ProjectOfResult[0].CompanyAddress
//        mobileNumber.setTitle(ProjectOfResult[0].EmpMobile, for: .normal)
//        let status = ProjectOfResult[0].ProjectStatusID!
//        let statusName = ProjectOfResult[0].ProjectStatusName!
//        if status == "5"{
//            self.statusName.text = statusName
//            statusImage.backgroundColor = #colorLiteral(red: 0.9921568627, green: 0.4274509804, blue: 0.337254902, alpha: 1)
//        }else if status == "4"{
//            self.statusName.text = statusName
//            statusImage.backgroundColor = #colorLiteral(red: 0.1176470588, green: 0.368627451, blue: 0.4666666667, alpha: 1)
//        }else if status == "3"{
//            self.statusName.text = statusName
//            statusImage.backgroundColor = #colorLiteral(red: 0.1764705882, green: 0.4745098039, blue: 0.8862745098, alpha: 1)
//        }else if status == "1"{
//            self.statusName.text = statusName
//            statusImage.backgroundColor = #colorLiteral(red: 0.831372549, green: 0.6862745098, blue: 0.2117647059, alpha: 1)
//        }else if status == "2"{
//            self.statusName.text = statusName
//            statusImage.backgroundColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
//        }else if status == "6"{
//            self.statusName.text = statusName
//            statusImage.backgroundColor = #colorLiteral(red: 0.2588235294, green: 0.8666666667, blue: 0.1764705882, alpha: 1)
//        }else if status == "7"{
//            self.statusName.text = statusName
//            statusImage.backgroundColor = #colorLiteral(red: 0.2, green: 0.5647058824, blue: 0.3882352941, alpha: 1)
//        }else {
//            print("error status \(status)")
//        }
//        let img = ProjectOfResult[0].Logo!
//        let trimmedString = img.trimmingCharacters(in: .whitespaces)
//        if let url = URL.init(string: trimmedString) {
//            companyImageOut.hnk_setImageFromURL(url, placeholder: #imageLiteral(resourceName: "officePlaceholder"))
//        } else{
//            print("nil")
//            companyImageOut.image = #imageLiteral(resourceName: "officePlaceholder")
//        }
    }
    
    func dataReady() {
        // Access the video objects that have been downloaded
        self.visitsByProjectIdArr = self.model.resultArray
        if visitsByProjectIdArr.count == 0 && statusNameBtn.titleLabel?.text == "تصفية بحالة الزيارة" {
            NothingLabel.isHidden = true
            AlertImage.isHidden = true
            let storyBoard : UIStoryboard = UIStoryboard(name: "NewHome", bundle: nil)
            let secondView = storyBoard.instantiateViewController(withIdentifier: "VisitsOfProjectsArchiveViewController") as! VisitsOfProjectsArchiveViewController
            secondView.ProjectId = ProjectId
            secondView.projectTitleView = projectTitleView
            secondView.ComapnyName = ComapnyName
            secondView.Logo = Logo
            secondView.EmpMobile = EmpMobile
            secondView.EmpName = EmpName
            secondView.LatBranch = LatBranch
            secondView.LngBranch = LngBranch
            secondView.CompanyInfoID = CompanyInfoID
            secondView.ProjectOfResult = ProjectOfResult
            self.navigationController?.pushViewController(secondView, animated: true)
        }else if visitsByProjectIdArr.count == 0 && statusNameBtn.titleLabel?.text != "تصفية بحالة الزيارة"{
            NothingLabel.isHidden = false
            AlertImage.isHidden = true
        }else {
            NothingLabel.isHidden = true
            AlertImage.isHidden = true
        }
        self.visitsModel.append(self.model.resultArray, index: ProjectId)
        // Tell the tableview to reload
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 6
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 6
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }
    
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 145
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return visitsByProjectIdArr.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VisitsOfProjectsTableViewCell", for: indexPath) as! VisitsOfProjectsTableViewCell
        
        cell.titleVisit.text = visitsByProjectIdArr[indexPath.section].Title
        cell.dateOfVisit.text = visitsByProjectIdArr[indexPath.section].Start
        cell.startTime.text = visitsByProjectIdArr[indexPath.section].StartTime
        cell.endTime.text = visitsByProjectIdArr[indexPath.section].EndTime
        cell.EmpNameLabel.setTitle(visitsByProjectIdArr[indexPath.section].EmpName, for: .normal)
        
        let status = visitsByProjectIdArr[indexPath.section].MeetingStatus!
        print(status)
        cell.statusNameLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        cell.circleStatusImage.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        if status == "0"{
            cell.Status.backgroundColor = #colorLiteral(red: 0.9459478259, green: 0.7699176669, blue: 0.05561546981, alpha: 1)
            cell.statusNameLabel.text = "انتظار الموافقة"
        }else if status == "1"{
            cell.Status.backgroundColor = #colorLiteral(red: 0.1812162697, green: 0.7981202602, blue: 0.4416504204, alpha: 1)
            cell.statusNameLabel.text = "تمت المقابلة"
        }else if status == "2"{
            cell.Status.backgroundColor = #colorLiteral(red: 0.9019555449, green: 0.4952987432, blue: 0.1308369637, alpha: 1)
            cell.statusNameLabel.text = "ملغية"
        }else if status == "3"{
            cell.Status.backgroundColor = #colorLiteral(red: 0.9074795842, green: 0.2969527543, blue: 0.2355833948, alpha: 1)
            cell.statusNameLabel.text = "فائتة"
        }else if status == "4"{
            cell.Status.backgroundColor = #colorLiteral(red: 0.2022456229, green: 0.5951007605, blue: 0.8569586277, alpha: 1)
            cell.statusNameLabel.text = "مؤجلة"
        }else if status == "5"{
            cell.Status.backgroundColor = #colorLiteral(red: 0.1521916687, green: 0.6835762858, blue: 0.376893878, alpha: 1)
            cell.statusNameLabel.text = "انتظار المقابلة" 
        }else {
            print("error status")
        }
//        if MessageCount == "" || MessageCount == "0" {
//            cell.messageCountLabel.isHidden = true
//        }else {
//            cell.messageCountLabel.isHidden = false
//            cell.messageCountLabel.text = MessageCount
//        }
        DispatchQueue.main.async {
            cell.Status.roundCorners(.bottomRight, radius: 10.0)
            cell.roundCorners([.bottomLeft,.bottomRight,.topRight], radius: 10)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "VisitsAndDetails", bundle:nil)
        let cont = storyBoard.instantiateViewController(withIdentifier: "VisitsDetialsTableViewController") as! VisitsDetialsTableViewController
        
        //let cont = segue.destination as! VisitsDetialsTableViewController
        cont.visitTitle = visitsByProjectIdArr[indexPath.section].Title!
        MeetingID = visitsByProjectIdArr[indexPath.section].MeetingID!
        cont.Description = visitsByProjectIdArr[indexPath.section].Description!
        cont.Mobile = visitsByProjectIdArr[indexPath.section].Mobile!
        cont.EmpName = visitsByProjectIdArr[indexPath.section].EmpName!
        cont.MeetingStatus = visitsByProjectIdArr[indexPath.section].MeetingStatus!
        cont.DateReply = visitsByProjectIdArr[indexPath.section].DateReply!
        cont.Notes = visitsByProjectIdArr[indexPath.section].Notes!
        cont.ProjectBildTypeName = visitsByProjectIdArr[indexPath.section].ProjectBildTypeName!
        cont.Replay = visitsByProjectIdArr[indexPath.section].Replay!
        cont.Start = visitsByProjectIdArr[indexPath.section].Start!
        cont.TimeStartMeeting = visitsByProjectIdArr[indexPath.section].TimeStartMeeting!
        cont.StartTime = visitsByProjectIdArr[indexPath.section].StartTime!
        cont.EndTime = visitsByProjectIdArr[indexPath.section].EndTime!
        cont.ComapnyName = visitsByProjectIdArr[indexPath.section].ComapnyName!
        cont.Address = visitsByProjectIdArr[indexPath.section].Address!
        cont.Logo = visitsByProjectIdArr[indexPath.section].Logo!

        self.navigationController?.pushViewController(cont, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetia" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let cont = segue.destination as! VisitsOfProjectsDetialsTableViewController
                cont.visitTitle = visitsByProjectIdArr[indexPath.section].Title!
                cont.meetingID = visitsByProjectIdArr[indexPath.section].MeetingID!
                MeetingID = visitsByProjectIdArr[indexPath.section].MeetingID!
                cont.Description = visitsByProjectIdArr[indexPath.section].Description!
                cont.Mobile = visitsByProjectIdArr[indexPath.section].Mobile!
                cont.EmpName = visitsByProjectIdArr[indexPath.section].EmpName!
                cont.MeetingStatus = visitsByProjectIdArr[indexPath.section].MeetingStatus!
                cont.DateReply = visitsByProjectIdArr[indexPath.section].DateReply!
                cont.Notes = visitsByProjectIdArr[indexPath.section].Notes!
                cont.ProjectBildTypeName = visitsByProjectIdArr[indexPath.section].ProjectBildTypeName!
                cont.Replay = visitsByProjectIdArr[indexPath.section].Replay!
                cont.Start = visitsByProjectIdArr[indexPath.section].Start!
                cont.TimeStartMeeting = visitsByProjectIdArr[indexPath.section].TimeStartMeeting!
                cont.StartTime = visitsByProjectIdArr[indexPath.section].StartTime!
                cont.EndTime = visitsByProjectIdArr[indexPath.section].EndTime!
                cont.ComapnyName = visitsByProjectIdArr[indexPath.section].ComapnyName!
                cont.Address = visitsByProjectIdArr[indexPath.section].Address!
                cont.Logo = visitsByProjectIdArr[indexPath.section].Logo!
                cont.LatBranch = LatBranch
                cont.LngBranch = LngBranch
                cont.CompanyInfoID = CompanyInfoID
                cont.ProjectId = ProjectId
            }
        }
    }
    
    @IBAction func openVisitDetials(_ sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: tableView)
        let index = tableView.indexPathForRow(at: point)?.section
        let storyBoard : UIStoryboard = UIStoryboard(name: "VisitsAndDetails", bundle:nil)
        let cont = storyBoard.instantiateViewController(withIdentifier: "VisitsDetialsTableViewController") as! VisitsDetialsTableViewController
        
        //let cont = segue.destination as! VisitsDetialsTableViewController
        cont.visitTitle = visitsByProjectIdArr[index!].Title!
        MeetingID = visitsByProjectIdArr[index!].MeetingID!
        cont.Description = visitsByProjectIdArr[index!].Description!
        cont.Mobile = visitsByProjectIdArr[index!].Mobile!
        cont.EmpName = visitsByProjectIdArr[index!].EmpName!
        cont.MeetingStatus = visitsByProjectIdArr[index!].MeetingStatus!
        cont.DateReply = visitsByProjectIdArr[index!].DateReply!
        cont.Notes = visitsByProjectIdArr[index!].Notes!
        cont.ProjectBildTypeName = visitsByProjectIdArr[index!].ProjectBildTypeName!
        cont.Replay = visitsByProjectIdArr[index!].Replay!
        cont.Start = visitsByProjectIdArr[index!].Start!
        cont.TimeStartMeeting = visitsByProjectIdArr[index!].TimeStartMeeting!
        cont.StartTime = visitsByProjectIdArr[index!].StartTime!
        cont.EndTime = visitsByProjectIdArr[index!].EndTime!
        cont.ComapnyName = visitsByProjectIdArr[index!].ComapnyName!
        cont.Address = visitsByProjectIdArr[index!].Address!
        cont.Logo = visitsByProjectIdArr[index!].Logo!
        
        self.navigationController?.pushViewController(cont, animated: true)
    }
    
    @IBAction func ArchiveBtnAction(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "NewHome", bundle: nil)
        let secondView = storyBoard.instantiateViewController(withIdentifier: "VisitsOfProjectsArchiveViewController") as! VisitsOfProjectsArchiveViewController
        secondView.ProjectId = ProjectId
        secondView.projectTitleView = projectTitleView
        secondView.ComapnyName = ComapnyName
        secondView.Logo = Logo
        secondView.EmpMobile = EmpMobile
        secondView.EmpName = EmpName
        secondView.LatBranch = LatBranch
        secondView.LngBranch = LngBranch
        secondView.CompanyInfoID = CompanyInfoID
        secondView.ProjectOfResult = ProjectOfResult
        self.navigationController?.pushViewController(secondView, animated: true)
    }
    
    @IBAction func goToNotfication(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "NewHome", bundle:nil)
        let secondView = storyBoard.instantiateViewController(withIdentifier: "MyProjectNotficationViewController") as! MyProjectNotficationViewController
        secondView.projectId = self.ProjectOfResult[0].ProjectId!
        self.navigationController?.pushViewController(secondView, animated: true)
    }
    
//    @IBAction func directionBtn(_ sender: UIButton) {
//        let location = CLLocation(latitude: LatBranch, longitude: LngBranch)
//        print(location.coordinate)
//        MKMapView.openMapsWith(location) { (error) in
//            if error != nil {
//                print("Could not open maps" + error!.localizedDescription)
//            }
//        }
//    }
//
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
        
        Alamofire.request("http://smusers.promit2030.co/Service1.svc/GetOfficeByCompanyInfoID", method: .get, parameters: Parameters, encoding: URLEncoding.default).responseJSON { response in
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
//        secondView.index = self.indexi
//        secondView.isCompany = self.isCompany
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
        
        Alamofire.request("http://smusers.promit2030.co/api/ApiService/GetCountMessageUnReaded", method: .get, parameters: parameters, encoding: URLEncoding.default).responseJSON { response in
            debugPrint(response)
            let json = JSON(response.result.value!)
            self.MessageCount = json["MessageCount"].stringValue
            print(json)
        }
        
    }
    
    @IBAction func CallMe(_ sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: tableView)
        let index = tableView.indexPathForRow(at: point)?.section
        var mobile: String = EmpMobile
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
    
    @IBAction func CallCompany(_ sender: UIButton) {
        let mobileNum = ProjectOfResult[0].EmpMobile
        var mobile: String = (mobileNum)!
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
    
    @IBAction func directionOfficeBtn(_ sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: tableView)
        let index = tableView.indexPathForRow(at: point)?.row
        let location = CLLocation(latitude: visitsByProjectIdArr[index!].LatBranch!, longitude: visitsByProjectIdArr[index!].LngBranch!)
        print(location.coordinate)
        MKMapView.openMapsWith(location) { (error) in
            if error != nil {
                print("Could not open maps" + error!.localizedDescription)
            }
        }
    }

    @IBAction func filtetByStatusName(_ sender: UIButton) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "VisitsAndDetails", bundle: nil)
        let dvc = storyBoard.instantiateViewController(withIdentifier: "MeetingStatusFilterTableViewController") as! MeetingStatusFilterTableViewController
        dvc.filterVisitsDelegate = self
        dvc.type = "3"
        dvc.statusId = StatusId
        dvc.modalPresentationStyle = .popover
        dvc.popoverPresentationController?.sourceView = sender
        dvc.popoverPresentationController?.sourceRect = CGRect(x: sender.frame.maxX, y: sender.frame.maxY, width: 0, height: 0)
        dvc.popoverPresentationController?.delegate = self
        dvc.preferredContentSize = CGSize(width: 200, height: 280)
        dvc.popoverPresentationController?.permittedArrowDirections = [.up]
        self.present(dvc, animated: true, completion: nil)
    }
    
    
   
    @IBAction func cancelFilterStatus(_ sender: UIButton) {
        cancelStatusBtn.isHidden = true
        StatusId = ""
        statusNameBtn.setTitle("تصفية بحالة الزيارة", for: .normal)
        model.GetMeetingByCustId(view: self.view, projectId: ProjectId, condtion: "first", type: "1", StatusId: "")
    }
}

extension VisitsOfProjectsViewController: FilterVisitsDelegate {
    func filterVisitsByStatusId(StatusId: String, StatusName: String){
        model.GetMeetingByCustId(view: self.view, projectId: ProjectId, condtion: "first", type: "2", StatusId: StatusId)
        self.StatusId = StatusId
        statusNameBtn.setTitle(StatusName, for: .normal)
        cancelStatusBtn.isHidden = false
    }
}
extension VisitsOfProjectsViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}

