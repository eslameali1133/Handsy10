//
//  VisitsOfProjectsArchiveViewController.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 1/24/18.
//  Copyright © 2018 Ahmed Wahdan. All rights reserved.
//

import UIKit
import MapKit
import Alamofire
import SwiftyJSON

class VisitsOfProjectsArchiveViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, VisitsByProjectIdModelDelegate {
    
    var visitsByProjectIdArr:[VisitsByProjectIdArray] = [VisitsByProjectIdArray]()
    
    let model: VisitsByProjectIdModel = VisitsByProjectIdModel()
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var companyCallBtn: UIButton! {
        didSet {
            companyCallBtn.layer.borderWidth = 1.0
            companyCallBtn.layer.borderColor = #colorLiteral(red: 0.2, green: 0.5647058824, blue: 0.3882352941, alpha: 1)
            companyCallBtn.layer.cornerRadius = 4.0
        }
    }
    
    @IBOutlet weak var officeDetialsBtn: UIButton! {
        didSet {
            officeDetialsBtn.layer.borderWidth = 1.0
            officeDetialsBtn.layer.borderColor = #colorLiteral(red: 0.2, green: 0.5647058824, blue: 0.3882352941, alpha: 1)
            officeDetialsBtn.layer.cornerRadius = 4.0
        }
    }
    
   
    
    @IBOutlet weak var companyImageOut: UIImageView!{
        didSet {
            companyImageOut.layer.cornerRadius = 14.0
        }
    }
    @IBOutlet weak var projectTitleLabel: UILabel!
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    var ProjectOfResult: [ProjectDetialsArray] = [ProjectDetialsArray]()
    
    
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
    
    let visitsModel: ArcVisitsProjectIdModel = ArcVisitsProjectIdModel()
    
    @IBOutlet weak var NothingLabel: UILabel!
    @IBOutlet weak var AlertImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ComapnyNameFunc()
        DispatchQueue.main.async {
            self.NothingLabel.isHidden = true
            self.AlertImage.isHidden = true
        }
        tableView.delegate = self
        tableView.dataSource = self
        
        model.delegate = self
        if Reachability.isConnectedToNetwork(){
            print("Internet Connection Available!")
            model.GetMeetingByCustId(view: self.view, projectId: ProjectId, condtion: "notfirst")
        }else{
            print("Internet Connection not Available!")
            visitsModel.loadItems()
            if visitsModel.returnProjectDetials(at: self.ProjectId) != nil {
                let visitsDetials = visitsModel.returnProjectDetials(at: self.ProjectId)
                self.visitsByProjectIdArr = visitsDetials!
                if visitsByProjectIdArr.count == 0 {
                    NothingLabel.isHidden = false
                    AlertImage.isHidden = false
                    tableView.isHidden = true
                } else {
                    tableView.isHidden = false
                    NothingLabel.isHidden = true
                    AlertImage.isHidden = true
                }
            }
            tableView.reloadData()
        }
        DispatchQueue.main.async {
            self.NothingLabel.isHidden = true
        }
        // Do any additional setup after loading the view.
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func ComapnyNameFunc(){
        companyNameLabel.text = ProjectOfResult[0].ComapnyName!
        projectTitleLabel.text = "( \(ProjectOfResult[0].ProjectTitle!) )"
        addressLabel.text = ProjectOfResult[0].CompanyAddress
        let img = ProjectOfResult[0].Logo
        if let url = URL.init(string: img!) {
            companyImageOut.hnk_setImageFromURL(url, placeholder: #imageLiteral(resourceName: "officePlaceholder"))
        } else{
            print("nil")
            companyImageOut.image = #imageLiteral(resourceName: "officePlaceholder")
        }
    }
    
    func dataReady() {
        // Access the video objects that have been downloaded
        self.visitsByProjectIdArr = self.model.resultArray
        self.visitsModel.append(self.model.resultArray, index: self.ProjectId)
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
        return 60
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if visitsByProjectIdArr.count == 0 {
            NothingLabel.isHidden = false
            AlertImage.isHidden = false
            tableView.isHidden = true
        } else {
            tableView.isHidden = false
            NothingLabel.isHidden = true
            AlertImage.isHidden = true
        }
        return visitsByProjectIdArr.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VisitsOfProjectsArchiveTableViewCell", for: indexPath) as! VisitsOfProjectsArchiveTableViewCell
        
        cell.layer.cornerRadius = 10
        cell.layer.borderColor = UIColor.clear.cgColor // set cell border color here
        cell.layer.masksToBounds = true
        
        cell.titleVisit.text = visitsByProjectIdArr[indexPath.section].Title
        cell.dateOfVisit.text = visitsByProjectIdArr[indexPath.section].Start
        cell.startTime.text = visitsByProjectIdArr[indexPath.section].StartTime
        cell.endTime.text = visitsByProjectIdArr[indexPath.section].EndTime
        cell.EmpNameLabel.setTitle(visitsByProjectIdArr[indexPath.section].EmpName, for: .normal)
        
        let status = visitsByProjectIdArr[indexPath.section].MeetingStatus!
        print(status)
        if status == "0"{
            cell.statusImage.image = #imageLiteral(resourceName: "Yellow")
            cell.statusNameLabel.text = "قيد المقابلة"
            cell.statusNameLabel.textColor = #colorLiteral(red: 0.9459478259, green: 0.7699176669, blue: 0.05561546981, alpha: 1)
        }else if status == "1"{
            cell.statusImage.image = #imageLiteral(resourceName: "Green")
            cell.statusNameLabel.text = "تمت المقابلة"
            cell.statusNameLabel.textColor = #colorLiteral(red: 0.1812162697, green: 0.7981202602, blue: 0.4416504204, alpha: 1)
        }else if status == "2"{
            cell.statusImage.image = #imageLiteral(resourceName: "Orange")
            cell.statusNameLabel.text = "ملغية"
            cell.statusNameLabel.textColor = #colorLiteral(red: 0.9019555449, green: 0.4952987432, blue: 0.1308369637, alpha: 1)
        }else if status == "3"{
            cell.statusImage.image = #imageLiteral(resourceName: "Red")
            cell.statusNameLabel.text = "فائتة"
            cell.statusNameLabel.textColor = #colorLiteral(red: 0.9074795842, green: 0.2969527543, blue: 0.2355833948, alpha: 1)
        }else if status == "4"{
            cell.statusImage.image = #imageLiteral(resourceName: "Blue")
            cell.statusNameLabel.text = "مؤجلة"
            cell.statusNameLabel.textColor = #colorLiteral(red: 0.2022456229, green: 0.5951007605, blue: 0.8569586277, alpha: 1)
        }else if status == "5"{
            cell.statusImage.image = #imageLiteral(resourceName: "تم الانجاز-1")
            cell.statusNameLabel.text = "موافقة وقيد المقابلة"
            cell.statusNameLabel.textColor = #colorLiteral(red: 0.1521916687, green: 0.6835762858, blue: 0.376893878, alpha: 1)
        }else {
            print("error status")
        }
        
        cell.contentView.layer.borderColor = UIColor.clear.cgColor
        cell.contentView.layer.borderWidth = 0
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetil" {
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
            }
        }
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
        //        secondView.index = self.indexi
        //        secondView.isCompany = self.isCompany
        secondView.CompanyInfoID = self.CompanyInfoID
        secondView.conditionService = "condition"
        secondView.LatBranch = LatBranch
        secondView.LngBranch = LngBranch
        self.navigationController?.pushViewController(secondView, animated: true)
    }
    
    @IBAction func goToNotfication(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "NewHome", bundle:nil)
        let secondView = storyBoard.instantiateViewController(withIdentifier: "MyProjectNotficationViewController") as! MyProjectNotficationViewController
        secondView.projectId = self.ProjectOfResult[0].ProjectId!
        self.navigationController?.pushViewController(secondView, animated: true)
    }
    
    @IBAction func CallMe(_ sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: tableView)
        let index = tableView.indexPathForRow(at: point)?.section
        var mobile: String = visitsByProjectIdArr[index!].Mobile!
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
    
}

