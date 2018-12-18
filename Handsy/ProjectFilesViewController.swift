//
//  ProjectFilesViewController.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 10/1/17.
//  Copyright © 2017 Ahmed Wahdan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ProjectFilesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ProjectFilesModelDelegate {
    
   
    @IBOutlet weak var projectFilesTableView: UITableView!
    @IBOutlet weak var HeaderViewOut: UIView!
    
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var EmpNameLabel: UILabel!
     @IBOutlet weak var projectTitle: UILabel!
      @IBOutlet weak var Saknumber: UILabel!
    @IBOutlet weak var companyImageOut: UIImageView!{
        didSet {
            DispatchQueue.main.async {
                self.companyImageOut.layer.cornerRadius = 7.0
                self.companyImageOut.layer.masksToBounds = true
            }
        }
    }
    
    var ProjectId: String = ""
    var type: String = ""
    var projectTitleView: String = ""
    var ProjectFilesTitle: String = ""
    var ComapnyName: String = ""
    var EmpName = ""
    var EmpMobile = ""
    var Address = ""
    var Logo = ""
       var Snumber = ""
    var LatBranch: Double = 0.0
    var LngBranch: Double = 0.0
    var searchResu:[ProjectFilesArray] = [ProjectFilesArray]()
    let model: ProjectFilesModel = ProjectFilesModel()
    let projectFilesProjectIdModel = ProjectFilesProjectIdModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        HeaderViewOut.backgroundColor = UIColor.clear
        HeaderViewOut.layer.cornerRadius = 7
        HeaderViewOut.layer.masksToBounds = true
        print("pro\(ProjectId)")
        print("pro\(type)")
        projectFilesTableView.delegate = self
        projectFilesTableView.dataSource = self
        
        if Reachability.isConnectedToNetwork(){
            print("Internet Connection Available!")
            model.delegate = self
            model.GetProjectFilesByProjectId(projectId: ProjectId, projectType: type, view: self.view)
        }else{
            print("Internet Connection not Available!")
            projectFilesProjectIdModel.loadItems()
            if projectFilesProjectIdModel.returnProjectDetials(at: ProjectId) != nil {
                let projectFilesDetials = projectFilesProjectIdModel.returnProjectDetials(at: ProjectId)
                self.searchResu = projectFilesDetials!
            }
            projectFilesTableView.reloadData()
        }
        self.navigationItem.title = ProjectFilesTitle
        ComapnyNameFunc()
        // Do any additional setup after loading the view.
    }
    
    func ComapnyNameFunc(){
        companyNameLabel.text = ComapnyName
        projectTitle.text = projectTitleView
        EmpNameLabel.text = EmpName
       Saknumber.text = Snumber
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dataReady() {
        // Access the video objects that have been downloaded
        self.searchResu = self.model.resultArray
        // Tell the tableview to reload
        self.projectFilesTableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return searchResu.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = projectFilesTableView.dequeueReusableCell(withIdentifier: "ProjectFilesTableViewCell", for: indexPath) as! ProjectFilesTableViewCell
        cell.ProjectTitle.text = searchResu[indexPath.section].ProjectFileName
        cell.layer.cornerRadius = 10.0
        cell.layer.masksToBounds = true
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = UIColor.clear
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "DesignsAndDetails", bundle:nil)
        let secondView = storyBoard.instantiateViewController(withIdentifier: "openPdfViewController") as! openPdfViewController
        secondView.url = searchResu[indexPath.section].ProjectFileAttached!
        secondView.Webtitle = "عرض الملف"
        projectFilesTableView.reloadData()
        self.navigationController?.pushViewController(secondView, animated: true)
    }
    
    @IBAction func visibleFiles(_ sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: projectFilesTableView)
        let index = projectFilesTableView.indexPathForRow(at: point)?.section
        let storyBoard : UIStoryboard = UIStoryboard(name: "DesignsAndDetails", bundle:nil)
        let secondView = storyBoard.instantiateViewController(withIdentifier: "openPdfViewController") as! openPdfViewController
        secondView.url = searchResu[index!].ProjectFileAttached!
        secondView.Webtitle = "عرض الملف"
        projectFilesTableView.reloadData()
        self.navigationController?.pushViewController(secondView, animated: true)
    }
    
    
    @IBAction func UploadFileBtn(_ sender: UIButton) {
    }
    
    func uploadFile() {
        
    }
    
    
    @IBAction func CallMe(_ sender: UIButton) {
        let mobileNum = EmpMobile
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
    
}
