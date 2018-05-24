//
//  AllNotficationTableViewController.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 3/28/18.
//  Copyright © 2018 Ahmed Wahdan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class AllNotficationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, AllNotificationsModelDelegate {
    @IBOutlet weak var allNotficationTableView: UITableView!
    var allNotifications: [AllNotifications] = [AllNotifications]()
    
    let allNotificationsModel: AllNotificationsModel = AllNotificationsModel()
    var count = 0
    let applicationl = UIApplication.shared

    @IBOutlet weak var NothingLabel: UILabel!
    @IBOutlet weak var AlertImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.NothingLabel.isHidden = true
            self.AlertImage.isHidden = true
        }
        allNotficationTableView.delegate = self
        allNotficationTableView.dataSource = self
        allNotificationsModel.delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        let CustmoerId = UserDefaults.standard.string(forKey: "CustmoerId")!
        if CustmoerId != "" {
            allNotificationsModel.GetAllNotificationByCustId(view: self.view, custmoerId: CustmoerId, VC: self)
        }
    }
    
    func dataReady() {
        // Access the video objects that have been downloaded
        self.allNotifications = self.allNotificationsModel.resultArray
        if allNotifications.count == 0 {
            allNotficationTableView.isHidden = true
            self.NothingLabel.isHidden = false
            self.AlertImage.isHidden = false
        }else {
            allNotficationTableView.isHidden = false
            self.NothingLabel.isHidden = true
            self.AlertImage.isHidden = true
        }
        // Tell the tableview to reload
        setBadge()
        self.allNotficationTableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return allNotifications.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AllNotficationTableViewCell", for: indexPath) as! AllNotficationTableViewCell
        // Configure the cell...
        let companyLogo = allNotifications[indexPath.row].CompanyLogo
        if let url = URL.init(string: companyLogo!) {
            print(url)
            cell.companyLogoImg.hnk_setImageFromURL(url, placeholder: #imageLiteral(resourceName: "officePlaceholder"))
        } else{
            print("nil")
            cell.companyLogoImg.image = #imageLiteral(resourceName: "officePlaceholder")
        }
        let isRead = allNotifications[indexPath.row].IsRead
        if isRead == "True" {
            cell.contentView.backgroundColor = #colorLiteral(red: 0.1177957579, green: 0.10955102, blue: 0.1219234392, alpha: 1)
            cell.notficationLightView.isHidden = true
            cell.newNotficationBtn.isHidden = true
        }else {
            cell.contentView.backgroundColor = #colorLiteral(red: 0.199973762, green: 0.2000150383, blue: 0.1999711692, alpha: 1)
            cell.notficationLightView.isHidden = false
            cell.newNotficationBtn.isHidden = false
        }
        cell.companyNameLabel.text = allNotifications[indexPath.row].ComapnyName
        cell.notficationTitleLabel.text = allNotifications[indexPath.row].Desc
        cell.projectNameLabel.text = allNotifications[indexPath.row].ProjectTitle
        cell.notficationTimeLabel.text = allNotifications[indexPath.row].TimeAgo
        cell.notficationDateLabel.text = allNotifications[indexPath.row].DateCreate
        return cell
    }
    func setBadge() {
        var AllNot = 0
        for item in allNotifications {
            if item.IsRead == "False" {
                AllNot += 1
            }
        }
        if AllNot != 0 {
            let second = tabBarController?.tabBar
            second?.items![1].badgeValue = "\(AllNot)"
            second?.items![1].badgeColor = #colorLiteral(red: 0.3058823529, green: 0.5058823529, blue: 0.5333333333, alpha: 1)
            self.applicationl.applicationIconBadgeNumber = AllNot
        } else {
            self.applicationl.applicationIconBadgeNumber = 0
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let notificationID = allNotifications[indexPath.row].NotificationID
        MarkNotifyReadByNotifyID(NotificationID: notificationID!)
        let type = allNotifications[indexPath.row].NotificationTypeID
        if type == "1" {
            let ProjectId = allNotifications[indexPath.row].ProjectId
            let storyBoard : UIStoryboard = UIStoryboard(name: "NewHome", bundle: nil)
            let secondView = storyBoard.instantiateViewController(withIdentifier: "NewProjectDetialsFilterTableViewController") as! NewProjectDetialsFilterTableViewController
            secondView.nou = "LOl"
            secondView.nour = "loll"
            secondView.ProjectId = ProjectId!
            self.navigationController?.pushViewController(secondView, animated: true)
        }else if type == "2" {
            let MeetingId = allNotifications[indexPath.row].MeetingID
            MeetingID = MeetingId!
            let storyBoard : UIStoryboard = UIStoryboard(name: "VisitsAndDetails", bundle: nil)
            let secondView = storyBoard.instantiateViewController(withIdentifier: "VisitsDetialsTableViewController") as! VisitsDetialsTableViewController
            self.navigationController?.pushViewController(secondView, animated: true)
        }else if type == "3" {
            let ProjectId = allNotifications[indexPath.row].ProjectId
            let storyBoard : UIStoryboard = UIStoryboard(name: "NewHome", bundle: nil)
            let secondView = storyBoard.instantiateViewController(withIdentifier: "NewProjectDetialsFilterTableViewController") as! NewProjectDetialsFilterTableViewController
            secondView.nou = "LOl"
            secondView.nour = "loll"
            secondView.ProjectId = ProjectId!
            self.navigationController?.pushViewController(secondView, animated: true)
        }else if type == "4" {
            let ProjectId = allNotifications[indexPath.row].ProjectId
            let storyBoard : UIStoryboard = UIStoryboard(name: "ProjectsAndEdit", bundle:nil)
            let secondView = storyBoard.instantiateViewController(withIdentifier: "MoneyManagmentDetialsTableViewController") as! MoneyManagmentDetialsTableViewController
            secondView.ProjectId = ProjectId!
            secondView.pushCond = "LOl"
            self.navigationController?.pushViewController(secondView, animated: true)
        }else if type == "5" {
            let DesignStagesID = allNotifications[indexPath.row].DesignStagesID
            designStagesID = DesignStagesID!
            let storyBoard : UIStoryboard = UIStoryboard(name: "DesignsAndDetails", bundle: nil)
            let secondView = storyBoard.instantiateViewController(withIdentifier: "DetailsDesignTableViewController") as! DetailsDesignTableViewController
            self.navigationController?.pushViewController(secondView, animated: true)
        }else if type == "7" {
            let DesignStagesID = allNotifications[indexPath.row].DesignStagesID
            designStagesID = DesignStagesID!
            let storyBoard : UIStoryboard = UIStoryboard(name: "DesignsAndDetails", bundle: nil)
            let secondView = storyBoard.instantiateViewController(withIdentifier: "DetailsDesignTableViewController") as! DetailsDesignTableViewController
            secondView.isScroll = true
            self.navigationController?.pushViewController(secondView, animated: true)
        }else if type == "8" {
            let File = allNotifications[indexPath.row].Other
            let storyBoard : UIStoryboard = UIStoryboard(name: "ProjectsAndEdit", bundle:nil)
            let secondView = storyBoard.instantiateViewController(withIdentifier: "ShowContractViewController") as! ShowContractViewController
            secondView.url = File!
            self.navigationController?.pushViewController(secondView, animated: true)
        }else {
            print("type: \(type)")
        }
    }
    
    func MarkNotifyReadByNotifyID(NotificationID: String) {
        let parameters: Parameters = [
            "NotificationID": NotificationID
        ]
        Alamofire.request("http://smusers.promit2030.com/Service1.svc/MarkNotifyReadByNotifyID", method: .get, parameters: parameters, encoding: URLEncoding.default).responseJSON { response in
            debugPrint(response)
            
        }
    }
}
