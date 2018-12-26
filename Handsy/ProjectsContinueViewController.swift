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

protocol FilterDesignsDelegate {
    func filterDesignsByStatusId(StatusId: String, StatusName: String)
}

class ProjectsContinueViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ProjectsContinueModelDelegate {
    
    @IBOutlet weak var FilterHeightConstrain: NSLayoutConstraint!
    
    @IBOutlet weak var Filterbottum_Constrain: NSLayoutConstraint!
   
     @IBOutlet weak var FilterView: UIView!
    var searchResu:[ProjectsContinue] = [ProjectsContinue]()
    
    let model: ProjectsContinueModel = ProjectsContinueModel()
    let designsModel: DesignsModel = DesignsModel()
    var condition = ""
    var StatusId = ""
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var NothingLabel: UILabel!
    @IBOutlet weak var AlertImage: UIImageView!
    @IBOutlet weak var statusNameBtn: UIButton!
    @IBOutlet weak var cancelStatusBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cancelStatusBtn.isHidden = true
        if condition == "New" {
            navigationItem.title = "التصاميم الجديدة"
            FilterView.isHidden = false
            FilterHeightConstrain.constant = 35
            Filterbottum_Constrain.constant = 10
        }else if condition == "Other" {
            navigationItem.title = "التصاميم المُعتمدة"
            FilterView.isHidden = true
            FilterHeightConstrain.constant = 0
            Filterbottum_Constrain.constant = 0
            
        }else {
        }
        tableView.delegate = self
        tableView.dataSource = self
            self.tableView.flashScrollIndicators()
        tableView.indicatorStyle = UIScrollViewIndicatorStyle.white;
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
            if condition == "New" {
                model.GetDesignsByCustID(view: self.view, VC: self, condition: condition, StatusId: "")
            }else if condition == "Other" {
                model.GetDesignsByCustID(view: self.view, VC: self, condition: condition, StatusId: "")
            }else {
                model.GetDesignsByCustID(view: self.view, VC: self, condition: condition, StatusId: StatusId)
            }
            
        }else{
            print("Internet Connection not Available!")
            designsModel.loadItems()
            self.searchResu = designsModel.designs
            tableView.reloadData()
        }
        
        viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func dataReady() {
        // Access the video objects that have been downloaded
        self.searchResu = self.model.resultArray
        if searchResu.count == 0 {
            NothingLabel.isHidden = false
            AlertImage.isHidden = false
        } else {
            tableView.isHidden = false
            NothingLabel.isHidden = true
            AlertImage.isHidden = true
        }
        designsModel.removeAllItems()
        for i in self.model.resultArray {
            self.designsModel.append(i)
        }
        // Tell the tableview to reload
        tableView.reloadData()
           tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        print(UITableViewAutomaticDimension)
        return UITableViewAutomaticDimension
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return searchResu.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProjectsContinueTableViewCell", for: indexPath) as! ProjectsContinueTableViewCell
            
        cell.officeNameLabel.setTitle(searchResu[indexPath.section].ComapnyName, for: .normal)
        cell.CreateDate.text = searchResu[indexPath.section].CreateDate
        cell.StagesDetailsName.text = searchResu[indexPath.section].StagesDetailsName
        if searchResu[indexPath.section].Details == ""
        {
             cell.Details.isHidden = true
            cell.lbl_desc_Title.isHidden = true
        }
        else
        {
            cell.Details.isHidden = false
            cell.lbl_desc_Title.isHidden = false
        cell.Details.text = searchResu[indexPath.section].Details
        }
        if searchResu[indexPath.section].SakNum != ""
        {
        cell.SakNumber.text =  searchResu[indexPath.section].SakNum
        }
        else
        {
             cell.SakNumber.text =  searchResu[indexPath.section].projectId
        }
        cell.companyAddress.text = searchResu[indexPath.section].EmpName
        print(searchResu[indexPath.section].ProjectBildTypeName)
        cell.projectTitle.text = searchResu[indexPath.section].ProjectBildTypeName
        
        cell.companyMobile.setTitle(searchResu[indexPath.section].Mobile, for: .normal)
        let img = searchResu[indexPath.section].Logo
        let trimmedString = img.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        if let url = URL.init(string: trimmedString!) {
            cell.CompanyLogoImage.hnk_setImageFromURL(url, placeholder: #imageLiteral(resourceName: "officePlaceholder"))
        } else{
            print("nil")
            cell.CompanyLogoImage.image = #imageLiteral(resourceName: "officePlaceholder")
        }
        
        let status = searchResu[indexPath.section].Status
        cell.nameOfStatus.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        if status == "1"{
            cell.Status.backgroundColor = #colorLiteral(red: 0.8279563785, green: 0.3280953765, blue: 0, alpha: 1)
            cell.nameOfStatus.text = "انتظار الموافقة"
            cell.PDF.isHidden = false
        }else if status == "2"{
            cell.Status.backgroundColor = #colorLiteral(red: 0.1521916687, green: 0.6835762858, blue: 0.376893878, alpha: 1)
            cell.nameOfStatus.text = "موافقة"
            cell.PDF.isHidden = false
        }else if status == "3"{
            cell.Status.backgroundColor = #colorLiteral(red: 0.7531306148, green: 0.2227272987, blue: 0.1705473661, alpha: 1)
            cell.nameOfStatus.text = "طلب تعديل"
            cell.PDF.isHidden = false
        }else if status == "5"{
            cell.Status.backgroundColor = #colorLiteral(red: 0.831372549, green: 0.6862745098, blue: 0.2117647059, alpha: 1)
            cell.nameOfStatus.text = "جاري العمل"
            cell.PDF.isHidden = true
        }else {
            print("error status")
            cell.PDF.isHidden = false
        }
        DispatchQueue.main.async {
            cell.Status.roundCorners(.bottomRight, radius: 10.0)
            cell.roundCorners([.bottomLeft,.bottomRight,.topRight], radius: 10)
        }
        return cell
    }
    
    
    
    @IBAction func openPdf(_ sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: tableView)
        let index = tableView.indexPathForRow(at: point)?.section
        let openPdf = searchResu[index!].DesignFile
        let storyBoard : UIStoryboard = UIStoryboard(name: "DesignsAndDetails", bundle:nil)
        let secondView = storyBoard.instantiateViewController(withIdentifier: "openPdfViewController") as! openPdfViewController

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
        
        secondView.url = openPdf
        if searchResu[index!].Status == "1" {
            secondView.condBottomButtons = "AcceptAndEdit"
            secondView.reloadApi = self as! AccepEditDesgin
        }else if searchResu[index!].Status == "3" {
            secondView.condBottomButtons = "Edit"
            secondView.reloadApi = self as! AccepEditDesgin
        }else {
            print("error status")
        }
        self.navigationController?.pushViewController(secondView, animated: true)
        
        
        //        if let url = URL(string: openPdf) {
        //            UIApplication.shared.open(url)
        //        }
        tableView.reloadData()
        
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
    
    @IBAction func DetialsBtnAction(_ sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: tableView)
        let index = tableView.indexPathForRow(at: point)?.section
        let storyBoard : UIStoryboard = UIStoryboard(name: "NewProject", bundle:nil)
        let secondView = storyBoard.instantiateViewController(withIdentifier: "DetailsOfOfficeTableViewController") as! DetailsOfOfficeTableViewController
        secondView.isCompany = searchResu[index!].IsCompany!
        secondView.CompanyInfoID = searchResu[index!].CompanyInfoID!
        secondView.conditionService = "condition"
        secondView.LatBranch = searchResu[index!].LatBranch
        secondView.LngBranch = searchResu[index!].LngBranch
        self.navigationController?.pushViewController(secondView, animated: true)
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
    @IBAction func filtetByStatusName(_ sender: UIButton) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "DesignsAndDetails", bundle: nil)
        let dvc = storyBoard.instantiateViewController(withIdentifier: "DesignStatusFilterTableViewController") as! DesignStatusFilterTableViewController
        dvc.filterDesignsDelegate = self
        if condition == "New" {
            dvc.type = "1"
              dvc.preferredContentSize = CGSize(width: 200, height: 140)
        }else {
            dvc.type = "2"
              dvc.preferredContentSize = CGSize(width: 200, height: 100)
        }
        dvc.statusId = StatusId
        dvc.modalPresentationStyle = .popover
        dvc.popoverPresentationController?.sourceView = sender
        dvc.popoverPresentationController?.sourceRect = CGRect(x: sender.frame.maxX, y: sender.frame.maxY, width: 0, height: 0)
        dvc.popoverPresentationController?.delegate = self
      
        dvc.popoverPresentationController?.permittedArrowDirections = [.up]
        self.present(dvc, animated: true, completion: nil)
    }
    
    @IBAction func cancelFilterStatus(_ sender: UIButton) {
        cancelStatusBtn.isHidden = true
        statusNameBtn.setTitle("تصفية بحالة التصميم", for: .normal)
        StatusId = ""
        if condition == "New" {
            model.GetDesignsByCustID(view: self.view, VC: self, condition: condition, StatusId: "")
        }else if condition == "Other" {
            model.GetDesignsByCustID(view: self.view, VC: self, condition: condition, StatusId: "")
        }else {
        }
    }
    
}

extension ProjectsContinueViewController: FilterDesignsDelegate, reloadApi,AccepEditDesgin {
    func refresh() {
         viewWillAppear(false)
    }
    
    func filterDesignsByStatusId(StatusId: String, StatusName: String) {
        model.GetDesignsByCustID(view: self.view, VC: self, condition: "", StatusId: StatusId)
        self.StatusId = StatusId
        statusNameBtn.setTitle(StatusName, for: .normal)
        cancelStatusBtn.isHidden = false
    }
    func reload() {
        viewWillAppear(false)
    }
}
extension ProjectsContinueViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}
