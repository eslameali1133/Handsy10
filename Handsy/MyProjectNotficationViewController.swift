//
//  MyProjectNotficationTableViewController.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 3/29/18.
//  Copyright © 2018 Ahmed Wahdan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class MyProjectNotficationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MyProjectNotficationsModelDelegate {
    @IBOutlet weak var myProjectTableView: UITableView!
    
    var projectId = ""
    var companyName = ""
    var companyPhone = ""
    var projectTitle = ""
    var companyLogo = ""
  var Empname = ""
 var SakeNammer = ""
    var NotiProjectCount = 0
    var NotiMessageCount = 0
    var NotiTotalCount = 0
    
    var myProjectNotfications: [MyProjectNotfications] = [MyProjectNotfications]()
    
    let myProjectNotficationsModel: MyProjectNotficationsModel = MyProjectNotficationsModel()
    @IBOutlet weak var companyLogoImg: AMCircleImageView!
    @IBOutlet weak var notficationLightView: UIView!{
        didSet {
            DispatchQueue.main.async {
                self.notficationLightView.layer.cornerRadius = self.notficationLightView.frame.width/2
                self.notficationLightView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                self.notficationLightView.layer.borderWidth = 1.0
                self.notficationLightView.layer.masksToBounds = true
            }
        }
    }
    @IBOutlet weak var NothingLabel: UILabel!
    @IBOutlet weak var AlertImage: UIImageView!
    @IBOutlet weak var projectNameLabel: UILabel!
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var companyMobile: UIButton!
    
    @IBOutlet weak var Emp_Name: UILabel!
    @IBOutlet weak var SakNumber: UILabel!
    override func viewDidLoad() {
        CountCustomerNotification()
        super.viewDidLoad()
        setHeader()
        DispatchQueue.main.async {
            self.NothingLabel.isHidden = true
            self.AlertImage.isHidden = true
        }
        myProjectTableView.delegate = self
        myProjectTableView.dataSource = self
        myProjectNotficationsModel.delegate = self
        myProjectNotficationsModel.GetAllNotificationByProjectId(view: self.view, projectId: projectId, VC: self)
    }

    func setHeader() {
        projectNameLabel.text = projectTitle
        companyNameLabel.text = companyName
        Emp_Name.text = Empname
        if(SakeNammer == "")
        {
            SakNumber.text = projectId
      
        }else
        {
             SakNumber.text = SakeNammer
        }
//        companyMobile.setTitle(companyPhone, for: .normal)
        let trimmedString = companyLogo.trimmingCharacters(in: .whitespaces)
//        if let url = URL.init(string: trimmedString) {
//            print(url)
//            companyLogoImg.hnk_setImageFromURL(url, placeholder: #imageLiteral(resourceName: "officePlaceholder"))
//        } else{
//            print("nil")
//            companyLogoImg.image = #imageLiteral(resourceName: "officePlaceholder")
//        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
         CountCustomerNotification()
        if NotiTotalCount != 0 {
            let second = tabBarController?.tabBar
            second?.items![1].badgeValue = "\(NotiTotalCount)"
            second?.items![1].badgeColor = #colorLiteral(red: 0.3058823529, green: 0.5058823529, blue: 0.5333333333, alpha: 1)
        } else {
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
     let applicationl = UIApplication.shared
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
    
    func setBadge() {
        var AllNot = 0
        for item in self.myProjectNotficationsModel.resultArray {
            if item.IsRead == "False" {
                AllNot += 1
            }
        }
        if NotiTotalCount != 0 {
            let second = tabBarController?.tabBar
            second?.items![1].badgeValue = "\(NotiTotalCount)"
            second?.items![1].badgeColor = #colorLiteral(red: 0.3058823529, green: 0.5058823529, blue: 0.5333333333, alpha: 1)
        } else {
            let second = tabBarController?.tabBar
            second?.items![1].badgeValue = ""
            second?.items![1].badgeColor = UIColor.clear
        }
    }
    func dataReady() {
        // Access the video objects that have been downloaded
        self.myProjectNotfications = self.myProjectNotficationsModel.resultArray
        if myProjectNotfications.count == 0 {
            myProjectTableView.isHidden = true
            self.NothingLabel.isHidden = false
            self.AlertImage.isHidden = false
        }else {
            myProjectTableView.isHidden = false
            self.NothingLabel.isHidden = true
            self.AlertImage.isHidden = true
        }
        // Tell the tableview to reload
        setBadge()
        
        self.CountCustomerNotification()
        self.myProjectTableView.reloadData()
    }
    
    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return myProjectNotfications.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyProjectNotficationTableViewCell", for: indexPath) as! MyProjectNotficationTableViewCell
        // Configure the cell...
        
        let isRead = myProjectNotfications[indexPath.row].IsRead
        if isRead == "True" {
            cell.contentView.backgroundColor = #colorLiteral(red: 0.1177957579, green: 0.10955102, blue: 0.1219234392, alpha: 1)
            cell.newNotficationBtn.isHidden = true
        }else {
            cell.contentView.backgroundColor = #colorLiteral(red: 0.199973762, green: 0.2000150383, blue: 0.1999711692, alpha: 1)
            cell.newNotficationBtn.isHidden = false
        }
//        cell.companyNameLabel.text = myProjectNotfications[indexPath.row].ComapnyName
        cell.notficationTitleLabel.text = myProjectNotfications[indexPath.row].Desc
//        cell.projectNameLabel.text = myProjectNotfications[indexPath.row].ProjectTitle
        cell.notficationTimeLabel.text = myProjectNotfications[indexPath.row].TimeAgo
        cell.notficationDateLabel.text = myProjectNotfications[indexPath.row].DateCreate
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let notificationID = myProjectNotfications[indexPath.row].NotificationID
        MarkNotifyReadByNotifyID(NotificationID: notificationID!)
        setBadge()
        let type = myProjectNotfications[indexPath.row].NotificationTypeID
//         myProjectNotficationsModel.GetAllNotificationByProjectId(view: self.view, projectId: projectId, VC: self)
        if type == "1" {
            let ProjectId = myProjectNotfications[indexPath.row].ProjectId
            let storyBoard : UIStoryboard = UIStoryboard(name: "NewHome", bundle: nil)
            let secondView = storyBoard.instantiateViewController(withIdentifier: "NewProjectDetialsFilterTableViewController") as! NewProjectDetialsFilterTableViewController
            secondView.nou = "uu"
            secondView.ProjectId = ProjectId!
            self.navigationController?.pushViewController(secondView, animated: true)
        }else if type == "2" {
            let MeetingId = myProjectNotfications[indexPath.row].MeetingID
            MeetingID = MeetingId!
            let storyBoard : UIStoryboard = UIStoryboard(name: "VisitsAndDetails", bundle: nil)
            let secondView = storyBoard.instantiateViewController(withIdentifier: "VisitsDetialsTableViewController") as! VisitsDetialsTableViewController
            self.navigationController?.pushViewController(secondView, animated: true)
        }else if type == "3" {
            let ProjectId = myProjectNotfications[indexPath.row].ProjectId
            let storyBoard : UIStoryboard = UIStoryboard(name: "NewHome", bundle: nil)
            let secondView = storyBoard.instantiateViewController(withIdentifier: "NewProjectDetialsFilterTableViewController") as! NewProjectDetialsFilterTableViewController
            secondView.nou = "uu"
            secondView.ProjectId = ProjectId!
           self.navigationController?.pushViewController(secondView, animated: true)
        }else if type == "4" {
            let ProjectId = myProjectNotfications[indexPath.row].ProjectId
            let storyBoard : UIStoryboard = UIStoryboard(name: "ProjectsAndEdit", bundle:nil)
            let secondView = storyBoard.instantiateViewController(withIdentifier: "MoneyManagmentDetialsTableViewController") as! MoneyManagmentDetialsTableViewController
            secondView.ProjectId = ProjectId!
            secondView.pushCond = "LOl"
            self.navigationController?.pushViewController(secondView, animated: true)
        }else if type == "5" {
            let DesignStagesID = myProjectNotfications[indexPath.row].DesignStagesID
            designStagesID = DesignStagesID!
            let storyBoard : UIStoryboard = UIStoryboard(name: "DesignsAndDetails", bundle: nil)
            let secondView = storyBoard.instantiateViewController(withIdentifier: "DetailsDesignTableViewController") as! DetailsDesignTableViewController
            self.navigationController?.pushViewController(secondView, animated: true)
        }else if type == "7" {
            let DesignStagesID = myProjectNotfications[indexPath.row].DesignStagesID
            designStagesID = DesignStagesID!
            let storyBoard : UIStoryboard = UIStoryboard(name: "DesignsAndDetails", bundle: nil)
            let secondView = storyBoard.instantiateViewController(withIdentifier: "DetailsDesignTableViewController") as! DetailsDesignTableViewController
//            secondView.isScroll = true
            self.navigationController?.pushViewController(secondView, animated: true)
        }else if type == "8" {
            let File = myProjectNotfications[indexPath.row].File
            let ProjectContract = myProjectNotfications[indexPath.row].ProjectContract
            if ProjectContract == "1" || ProjectContract == "4"{
                let storyBoard : UIStoryboard = UIStoryboard(name: "ProjectsAndEdit", bundle:nil)
                let secondView = storyBoard.instantiateViewController(withIdentifier: "ShowContractViewController") as! ShowContractViewController
                secondView.url = File!
                secondView.ProjectId = myProjectNotfications[indexPath.row].ProjectId!
                self.navigationController?.pushViewController(secondView, animated: true)
            }else {
                let storyBoard : UIStoryboard = UIStoryboard(name: "DesignsAndDetails", bundle:nil)
                let secondView = storyBoard.instantiateViewController(withIdentifier: "openPdfViewController") as! openPdfViewController
                secondView.url = File!
                secondView.Webtitle = "العقد"
                self.navigationController?.pushViewController(secondView, animated: true)
            }
        }else if type == "10" {
            let ProjectId = myProjectNotfications[indexPath.row].ProjectId
            let storyBoard : UIStoryboard = UIStoryboard(name: "NewHome", bundle: nil)
            let secondView = storyBoard.instantiateViewController(withIdentifier: "NewProjectDetialsFilterTableViewController") as! NewProjectDetialsFilterTableViewController
            secondView.nou = "uu"
            secondView.ProjectId = ProjectId!
            self.navigationController?.pushViewController(secondView, animated: true)
        }
        else {
            print("type: \(type)")
        }
    }
    
    func MarkNotifyReadByNotifyID(NotificationID: String) {
        let parameters: Parameters = [
            "NotificationID": NotificationID
        ]
        Alamofire.request("http://smusers.promit2030.co/Service1.svc/MarkNotifyReadByNotifyID", method: .get, parameters: parameters, encoding: URLEncoding.default).responseJSON { response in
            debugPrint(response)
            
        }
    }
    
    @IBAction func CallMe(_ sender: UIButton) {
        var mobile: String = (companyPhone)
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
