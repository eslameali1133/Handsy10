//
//  DesignsOfProjectViewController.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 12/31/17.
//  Copyright © 2017 Ahmed Wahdan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import MapKit

class DesignsOfProjectViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, DesignByProjectIdModelDelegate {
    
    var searchResu:[DesignByProjectIdArray] = [DesignByProjectIdArray]()
    
    let model: DesignByProjectIdModel = DesignByProjectIdModel()
    
    let designProjectIdModel = DesignProjectIdModel()
    
    @IBOutlet weak var tableView: UITableView!
    
    
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
    
    @IBOutlet weak var companyImageOut: UIImageView!
    @IBOutlet weak var projectTitleLabel: UILabel!
    @IBOutlet weak var EngNameLabel: UILabel!
    @IBOutlet weak var engJobName: UILabel!
    @IBOutlet weak var statusView: UIView!{
        didSet{
            DispatchQueue.main.async {
                self.statusView.roundCorners([.topLeft, .topRight], radius: 10)
            }
        }
    }
    @IBOutlet weak var lastStatusLabel: UILabel!
    @IBOutlet weak var statusImgView: UIImageView!
    @IBOutlet weak var statusNameLabel: UILabel!
    @IBOutlet weak var notficationAlertBtnOut: UIButton!
    @IBOutlet weak var notficationCountLabel: UILabel!{
        didSet {
            DispatchQueue.main.async {
                self.notficationCountLabel.layer.cornerRadius = self.notficationCountLabel.frame.width/2
                self.notficationCountLabel.layer.masksToBounds = true
            }
        }
    }
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
        
        if Reachability.isConnectedToNetwork(){
            model.delegate = self
            model.GetDesignsByProjectID(view: self.view, projectId: ProjectId)
        }else{
            designProjectIdModel.loadItems()
            if designProjectIdModel.returnProjectDetials(at: ProjectId) != nil {
                let  designsDetials = designProjectIdModel.returnProjectDetials(at: ProjectId)
                self.searchResu = designsDetials!
                
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
        lastStatusLabel.text = ProjectOfResult[0].ProjectLastComment!
        let NotLabel = ProjectOfResult[0].NotifiCount!
        
        if NotLabel != 0 {
            notficationAlertBtnOut.isHidden = false
            notficationCountLabel.isHidden = false
            notficationCountLabel.text = "\(NotLabel)"
        } else {
            notficationAlertBtnOut.isHidden = false
            notficationCountLabel.isHidden = true
        }
        let status = ProjectOfResult[0].ProjectStatusID!
        let statusName = ProjectOfResult[0].ProjectStatusName!
        if status == "5"{
            statusNameLabel.text = statusName
            statusImgView.backgroundColor = #colorLiteral(red: 0.9921568627, green: 0.4274509804, blue: 0.337254902, alpha: 1)
        }else if status == "4"{
            statusNameLabel.text = statusName
            statusImgView.backgroundColor = #colorLiteral(red: 0.1176470588, green: 0.368627451, blue: 0.4666666667, alpha: 1)
        }else if status == "3"{
            statusNameLabel.text = statusName
            statusImgView.backgroundColor = #colorLiteral(red: 0.1764705882, green: 0.4745098039, blue: 0.8862745098, alpha: 1)
        }else if status == "1"{
            statusNameLabel.text = statusName
            statusImgView.backgroundColor = #colorLiteral(red: 0.831372549, green: 0.6862745098, blue: 0.2117647059, alpha: 1)
        }else if status == "2"{
            statusNameLabel.text = statusName
            statusImgView.backgroundColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
        }else if status == "6"{
            statusNameLabel.text = statusName
            statusImgView.backgroundColor = #colorLiteral(red: 0.2588235294, green: 0.8666666667, blue: 0.1764705882, alpha: 1)
        }else if status == "7"{
            statusNameLabel.text = statusName
            statusImgView.backgroundColor = #colorLiteral(red: 0.2, green: 0.5647058824, blue: 0.3882352941, alpha: 1)
        }else {
            print("error status \(status)")
        }
        //        companyNameLabel.text = ProjectOfResult[0].ComapnyName!
        projectTitleLabel.text = "( \(ProjectOfResult[0].ProjectTitle!) )"
        EngNameLabel.text = ProjectOfResult[0].EmpName
        engJobName.text = ProjectOfResult[0].JobName
        let img = ProjectOfResult[0].EmpImage
        if let url = URL.init(string: img!) {
            companyImageOut.hnk_setImageFromURL(url, placeholder: #imageLiteral(resourceName: "officePlaceholder"))
        } else{
            print("nil")
            companyImageOut.image = #imageLiteral(resourceName: "officePlaceholder")
        }
    }
    
    
    func dataReady() {
        // Access the video objects that have been downloaded
        self.searchResu = self.model.resultArray
        self.designProjectIdModel.append(self.model.resultArray, index: ProjectId)
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
        return 120
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if searchResu.count == 0 {
            NothingLabel.isHidden = false
            AlertImage.isHidden = false
            tableView.isHidden = true
        } else {
            tableView.isHidden = false
            NothingLabel.isHidden = true
            AlertImage.isHidden = true
        }
        return searchResu.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DesignsOfProjectTableViewCell", for: indexPath) as! DesignsOfProjectTableViewCell
        
        cell.layer.cornerRadius = 10
        cell.layer.borderColor = UIColor.clear.cgColor // set cell border color here
        cell.layer.masksToBounds = true
        
        cell.CreateDate.text = searchResu[indexPath.section].CreateDate
        cell.StagesDetailsName.text = searchResu[indexPath.section].StagesDetailsName
        cell.Details.text = searchResu[indexPath.section].Details
        let status = searchResu[indexPath.section].Status
        if searchResu[indexPath.section].DesignFile == "" {
            cell.BtnOutlet.isHidden = true
        }
        if status == "1"{
            cell.Status.image = #imageLiteral(resourceName: "stat1")
            cell.nameOfStatus.text = "انتظار الموافقة"
            cell.nameOfStatus.textColor = #colorLiteral(red: 0.8279563785, green: 0.3280953765, blue: 0, alpha: 1)
            cell.PDF.isHidden = false
            cell.BtnOutlet.isHidden = false
            if searchResu[indexPath.section].DesignFile == "" {
                cell.BtnOutlet.isHidden = true
            }
        }else if status == "2"{
            cell.Status.image = #imageLiteral(resourceName: "stat2")
            cell.nameOfStatus.text = "موافقة"
            cell.nameOfStatus.textColor = #colorLiteral(red: 0.1521916687, green: 0.6835762858, blue: 0.376893878, alpha: 1)
            cell.PDF.isHidden = false
            cell.BtnOutlet.isHidden = false
            if searchResu[indexPath.section].DesignFile == "" {
                cell.BtnOutlet.isHidden = true
            }
        }else if status == "3"{
            cell.Status.image = #imageLiteral(resourceName: "stat3")
            cell.nameOfStatus.text = "مرفوض"
            cell.nameOfStatus.textColor = #colorLiteral(red: 0.7531306148, green: 0.2227272987, blue: 0.1705473661, alpha: 1)
            cell.PDF.isHidden = false
            cell.BtnOutlet.isHidden = false
            if searchResu[indexPath.section].DesignFile == "" {
                cell.BtnOutlet.isHidden = true
            }
        }else if status == "5"{
            cell.Status.image = #imageLiteral(resourceName: "stat4")
            cell.nameOfStatus.text = "جاري العمل"
            cell.nameOfStatus.textColor = #colorLiteral(red: 0.9019555449, green: 0.4952987432, blue: 0.1308369637, alpha: 1)
            cell.PDF.isHidden = true
            cell.BtnOutlet.isHidden = true
            if searchResu[indexPath.section].DesignFile == "" {
                cell.BtnOutlet.isHidden = true
            }
        }else {
            print("error status")
            cell.PDF.isHidden = false
            if searchResu[indexPath.section].DesignFile == "" {
                cell.BtnOutlet.isHidden = true
            }
        }
        let EmpName = searchResu[indexPath.section].EmpName
        cell.EmpMobile.setTitle(EmpName, for: .normal)
        
        cell.contentView.layer.borderColor = UIColor.clear.cgColor
        cell.contentView.layer.borderWidth = 0
        
        return cell
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
    
    
    @IBAction func openPdf(_ sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: tableView)
        let index = tableView.indexPathForRow(at: point)?.section
        let openPdf = searchResu[index!].DesignFile
        let storyBoard : UIStoryboard = UIStoryboard(name: "DesignsAndDetails", bundle:nil)
        let secondView = storyBoard.instantiateViewController(withIdentifier: "openPdfViewController") as! openPdfViewController
        self.navigationController?.pushViewController(secondView, animated: true)
        secondView.url = openPdf!
        
        //        if let url = URL(string: openPdf) {
        //            UIApplication.shared.open(url)
        //        }
        tableView.reloadData()
        
    }
    
    
    
    @IBAction func designCancel(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "DesignsAndDetails", bundle: nil)
        let secondView = storyBoard.instantiateViewController(withIdentifier: "AlertDesignCancelViewController") as! AlertDesignCancelViewController
        let index = tableView.indexPathForSelectedRow?.section
        designStagesID = searchResu[index!].DesignStagesID!
        secondView.modalPresentationStyle = .custom
        self.present(secondView, animated: true)
    }
    
    @IBAction func designOk(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "DesignsAndDetails", bundle: nil)
        let secondView = storyBoard.instantiateViewController(withIdentifier: "AlertDesignOkViewController") as! AlertDesignOkViewController
        let index = tableView.indexPathForSelectedRow?.section
        designStagesID = searchResu[index!].DesignStagesID!
        print("des: \(designStagesID)")
        secondView.modalPresentationStyle = .custom
        self.present(secondView, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDeti" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let cont = segue.destination as! DesignDetailsTableViewController
                cont.CreateDate = searchResu[indexPath.section].CreateDate!
                cont.DesignFile = searchResu[indexPath.section].DesignFile!
                cont.DesignStagesID = searchResu[indexPath.section].DesignStagesID!
                cont.Details = searchResu[indexPath.section].Details!
                cont.EmpName = searchResu[indexPath.section].EmpName!
                cont.mobileStr = searchResu[indexPath.section].Mobile!
                cont.ProjectBildTypeName = searchResu[indexPath.section].ProjectBildTypeName!
                cont.ProjectStatusID = searchResu[indexPath.section].ProjectStatusID!
                cont.SakNum = searchResu[indexPath.section].SakNum!
                cont.StagesDetailsName = searchResu[indexPath.section].StagesDetailsName!
                cont.Status = searchResu[indexPath.section].Status!
                cont.ClientReply = searchResu[indexPath.section].ClientReply!
                cont.EmpReply = searchResu[indexPath.section].EmpReply!
                cont.ComapnyName = searchResu[indexPath.section].ComapnyName!
                cont.Logo = searchResu[indexPath.section].Logo!
                cont.Address = searchResu[indexPath.section].Address!
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
    
    @IBAction func CallMe(_ sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: tableView)
        let index = tableView.indexPathForRow(at: point)?.section
        let mobileNum = searchResu[index!].Mobile!
        var mobile: String = (mobileNum)
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
    
    @IBAction func goToNotfication(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "NewHome", bundle:nil)
        let secondView = storyBoard.instantiateViewController(withIdentifier: "MyProjectNotficationViewController") as! MyProjectNotficationViewController
        secondView.projectId = self.ProjectOfResult[0].ProjectId!
        self.navigationController?.pushViewController(secondView, animated: true)
    }
    
    @IBAction func CallEng(_ sender: UIButton) {
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
}
