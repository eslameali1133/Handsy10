//
//  ProjectsContinueViewController.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 8/14/17.
//  Copyright © 2017 Ahmed Wahdan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import MapKit

class ProjectsContinueViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ProjectsContinueModelDelegate {
    
    var searchResu:[ProjectsContinue] = [ProjectsContinue]()
    
    let model: ProjectsContinueModel = ProjectsContinueModel()
    let designsModel: DesignsModel = DesignsModel()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var NothingLabel: UILabel!
    
    @IBOutlet weak var AlertImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        model.delegate = self
        
        DispatchQueue.main.async {
            self.NothingLabel.isHidden = true
            self.AlertImage.isHidden = true
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if Reachability.isConnectedToNetwork(){
            print("Internet Connection Available!")
            model.GetDesignsByCustID(view: self.view, VC: self)
        }else{
            print("Internet Connection not Available!")
            designsModel.loadItems()
            self.searchResu = designsModel.designs
            tableView.reloadData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func dataReady() {
        // Access the video objects that have been downloaded
        self.searchResu = self.model.resultArray
        designsModel.removeAllItems()
        for i in self.model.resultArray {
            self.designsModel.append(i)
        }
        // Tell the tableview to reload
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProjectsContinueTableViewCell", for: indexPath) as! ProjectsContinueTableViewCell
        
        cell.layer.cornerRadius = 10
        cell.layer.borderColor = UIColor.clear.cgColor // set cell border color here
        cell.layer.masksToBounds = true
        
        cell.officeNameLabel.text = searchResu[indexPath.section].ComapnyName
        cell.CreateDate.text = searchResu[indexPath.section].CreateDate
        cell.EngName.text = searchResu[indexPath.section].EmpName
        let projectTit = searchResu[indexPath.section].ProjectBildTypeName
        cell.ProjectBildTypeName.text = "(\(projectTit))"
        cell.StagesDetailsName.text = searchResu[indexPath.section].StagesDetailsName
        cell.Details.text = searchResu[indexPath.section].Details
        cell.companyAddress.text = searchResu[indexPath.section].Address
        let img = searchResu[indexPath.section].Logo
        if let url = URL.init(string: img) {
            cell.CompanyLogoImage.hnk_setImageFromURL(url, placeholder: #imageLiteral(resourceName: "officePlaceholder"))
        } else{
            print("nil")
            cell.CompanyLogoImage.image = #imageLiteral(resourceName: "officePlaceholder")
        }
        
        let status = searchResu[indexPath.section].Status
        
        if status == "1"{
            cell.Status.image = #imageLiteral(resourceName: "stat1")
            cell.nameOfStatus.text = "انتظار الموافقة"
            cell.nameOfStatus.textColor = #colorLiteral(red: 0.8279563785, green: 0.3280953765, blue: 0, alpha: 1)
            cell.PDF.isHidden = false
        }else if status == "2"{
            cell.Status.image = #imageLiteral(resourceName: "stat2")
            cell.nameOfStatus.text = "موافقة"
            cell.nameOfStatus.textColor = #colorLiteral(red: 0.1521916687, green: 0.6835762858, blue: 0.376893878, alpha: 1)
            cell.PDF.isHidden = false
        }else if status == "3"{
            cell.Status.image = #imageLiteral(resourceName: "stat3")
            cell.nameOfStatus.text = "مرفوض"
            cell.nameOfStatus.textColor = #colorLiteral(red: 0.7531306148, green: 0.2227272987, blue: 0.1705473661, alpha: 1)
            cell.PDF.isHidden = false
        }else if status == "5"{
            cell.Status.image = #imageLiteral(resourceName: "stat4")
            cell.nameOfStatus.text = "جاري العمل"
            cell.nameOfStatus.textColor = #colorLiteral(red: 0.9019555449, green: 0.4952987432, blue: 0.1308369637, alpha: 1)
            cell.PDF.isHidden = true
        }else {
            print("error status")
            cell.PDF.isHidden = false
        }
        
        cell.contentView.layer.borderColor = UIColor.clear.cgColor
        cell.contentView.layer.borderWidth = 0
        
        return cell
    }
    
    
    
    @IBAction func openPdf(_ sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: tableView)
        let index = tableView.indexPathForRow(at: point)?.section
        let openPdf = searchResu[index!].DesignFile
        let storyBoard : UIStoryboard = UIStoryboard(name: "DesignsAndDetails", bundle:nil)
        let secondView = storyBoard.instantiateViewController(withIdentifier: "openPdfViewController") as! openPdfViewController
        self.navigationController?.pushViewController(secondView, animated: true)
        secondView.url = openPdf
        
        //        if let url = URL(string: openPdf) {
        //            UIApplication.shared.open(url)
        //        }
        tableView.reloadData()
        
    }
    @IBAction func downloadPdf(_ sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: tableView)
        let index = tableView.indexPathForRow(at: point)?.section
        let openPdf = searchResu[index!].DesignFile
        download(url: openPdf)
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
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDet" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let cont = segue.destination as! DetailsDesignTableViewController
                cont.CreateDate = searchResu[indexPath.section].CreateDate
                cont.DesignFile = searchResu[indexPath.section].DesignFile
                designStagesID = searchResu[indexPath.section].DesignStagesID
                cont.Details = searchResu[indexPath.section].Details
                cont.EmpName = searchResu[indexPath.section].EmpName
                cont.mobileStr = searchResu[indexPath.section].Mobile
                cont.ProjectBildTypeName = searchResu[indexPath.section].ProjectBildTypeName
                cont.ProjectStatusID = searchResu[indexPath.section].ProjectStatusID
                cont.SakNum = searchResu[indexPath.section].SakNum
                cont.StagesDetailsName = searchResu[indexPath.section].StagesDetailsName
                cont.Status = searchResu[indexPath.section].Status
                cont.ClientReply = searchResu[indexPath.section].ClientReply
                cont.EmpReply = searchResu[indexPath.section].EmpReply
                cont.ComapnyName = searchResu[indexPath.section].ComapnyName
                cont.Logo = searchResu[indexPath.section].Logo
                cont.Address = searchResu[indexPath.section].Address
            }
        }
    }
    
    @IBAction func openDesignDetials(_ sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: tableView)
        let index = tableView.indexPathForRow(at: point)?.section
        let storyBoard : UIStoryboard = UIStoryboard(name: "DesignsAndDetails", bundle:nil)
        let secondView = storyBoard.instantiateViewController(withIdentifier: "DetailsDesignTableViewController") as! DetailsDesignTableViewController
        secondView.CreateDate = searchResu[index!].CreateDate
        secondView.DesignFile = searchResu[index!].DesignFile
        designStagesID = searchResu[index!].DesignStagesID
        secondView.Details = searchResu[index!].Details
        secondView.EmpName = searchResu[index!].EmpName
        secondView.mobileStr = searchResu[index!].Mobile
        secondView.ProjectBildTypeName = searchResu[index!].ProjectBildTypeName
        secondView.ProjectStatusID = searchResu[index!].ProjectStatusID
        secondView.SakNum = searchResu[index!].SakNum
        secondView.StagesDetailsName = searchResu[index!].StagesDetailsName
        secondView.Status = searchResu[index!].Status
        secondView.ClientReply = searchResu[index!].ClientReply
        secondView.EmpReply = searchResu[index!].EmpReply
        secondView.ComapnyName = searchResu[index!].ComapnyName
        secondView.Logo = searchResu[index!].Logo
        secondView.Address = searchResu[index!].Address
        self.navigationController?.pushViewController(secondView, animated: true)
    }
    
    
    @IBAction func directionBtn(_ sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: tableView)
        let index = tableView.indexPathForRow(at: point)?.section
        let dLati = searchResu[index!].LatBranch
        let dLang = searchResu[index!].LngBranch
        let location = CLLocation(latitude: dLati, longitude: dLang)
        print(location.coordinate)
        MKMapView.openMapsWith(location) { (error) in
            if error != nil {
                print("Could not open maps" + error!.localizedDescription)
            }
        }
    }
    
    @IBAction func CallEng(_ sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: tableView)
        let index = tableView.indexPathForRow(at: point)?.section
        let mobileNum = searchResu[index!].Mobile
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
    
    @IBAction func CallMe(_ sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: tableView)
        let index = tableView.indexPathForRow(at: point)?.section
        let mobileNum = searchResu[index!].Mobile
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
