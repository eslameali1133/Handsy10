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
    var myProjectNotfications: [MyProjectNotfications] = [MyProjectNotfications]()
    
    let myProjectNotficationsModel: MyProjectNotficationsModel = MyProjectNotficationsModel()
    
    @IBOutlet weak var NothingLabel: UILabel!
    @IBOutlet weak var AlertImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.NothingLabel.isHidden = true
            self.AlertImage.isHidden = true
        }
        myProjectTableView.delegate = self
        myProjectTableView.dataSource = self
        myProjectNotficationsModel.delegate = self
        myProjectNotficationsModel.GetAllNotificationByProjectId(view: self.view, projectId: projectId, VC: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        let companyLogo = myProjectNotfications[indexPath.row].CompanyLogo
        if let url = URL.init(string: companyLogo!) {
            print(url)
            cell.companyLogoImg.hnk_setImageFromURL(url, placeholder: #imageLiteral(resourceName: "officePlaceholder"))
        } else{
            print("nil")
            cell.companyLogoImg.image = #imageLiteral(resourceName: "officePlaceholder")
        }
        let isRead = myProjectNotfications[indexPath.row].IsRead
        if isRead == "True" {
            cell.contentView.backgroundColor = #colorLiteral(red: 0.1177957579, green: 0.10955102, blue: 0.1219234392, alpha: 1)
            cell.notficationLightView.isHidden = true
            cell.newNotficationBtn.isHidden = true
        }else {
            cell.contentView.backgroundColor = #colorLiteral(red: 0.199973762, green: 0.2000150383, blue: 0.1999711692, alpha: 1)
            cell.notficationLightView.isHidden = false
            cell.newNotficationBtn.isHidden = false
        }
        cell.companyNameLabel.text = myProjectNotfications[indexPath.row].ComapnyName
        cell.notficationTitleLabel.text = myProjectNotfications[indexPath.row].Desc
        cell.projectNameLabel.text = myProjectNotfications[indexPath.row].ProjectTitle
        cell.notficationTimeLabel.text = myProjectNotfications[indexPath.row].TimeAgo
        cell.notficationDateLabel.text = myProjectNotfications[indexPath.row].DateCreate
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let notificationID = myProjectNotfications[indexPath.row].NotificationID
        MarkNotifyReadByNotifyID(NotificationID: notificationID!)
        let type = myProjectNotfications[indexPath.row].NotificationTypeID
        if type == "1" {
            let ProjectId = myProjectNotfications[indexPath.row].ProjectId
            let storyBoard : UIStoryboard = UIStoryboard(name: "NewHome", bundle: nil)
            let secondView = storyBoard.instantiateViewController(withIdentifier: "NewProjectDetialsFilterTableViewController") as! NewProjectDetialsFilterTableViewController
            secondView.nou = "LOl"
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
            secondView.nou = "LOl"
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
            secondView.isScroll = true
            self.navigationController?.pushViewController(secondView, animated: true)
        }else if type == "8" {
            let File = myProjectNotfications[indexPath.row].Other
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
