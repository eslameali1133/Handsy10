//
//  RequestProjectViewController.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 7/29/17.
//  Copyright © 2017 Ahmed Wahdan. All rights reserved.
//

import UIKit
import Haneke
import Alamofire
import SwiftyJSON
import NVActivityIndicatorView

class RequestProjectViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, RequestProjectModelDelegate {
    @IBOutlet weak var barView: UIView!
    @IBOutlet weak var popUp: UIView!
    @IBOutlet weak var endPopUp: UIView!
    @IBOutlet weak var EditOut: UIButton!
    @IBOutlet weak var CancelOut: UIButton!
    @IBOutlet weak var NewProjectBtn: UIBarButtonItem!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var companyNameLabel: UILabel!
    
    
    
    @IBAction func YesRemove(_ sender: UIButton) {
        ProjectCancel()
        popUp.isHidden = true
        endPopUp.isHidden = false
    }
    
    @IBAction func NoThanks(_ sender: UIButton) {
        popUp.isHidden = true
    }
    
    @IBAction func endDismissBtn(_ sender: UIButton) {
        popUp.isHidden = true
    }
    
    @IBAction func end(_ sender: UIButton) {
        endPopUp.isHidden = true
        model.GetProjectByCustID(view: self.view, VC: self)
        requestProjectTableView.reloadData()
    }
    
    @IBOutlet weak var requestProjectTableView: UITableView!
    @IBOutlet weak var NothingLabel: UILabel!
    @IBAction func deleteBtn(_ sender: UIButton) {
        popUp.isHidden = false
    }
    
    var searchResu:[GetProjectEngCustByCustID] = [GetProjectEngCustByCustID]()
    
    let model: RequestProjectModel = RequestProjectModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addBackBarButtonItem()
        
        
        popUp.isHidden = true
        endPopUp.isHidden = true
        requestProjectTableView.delegate = self
        requestProjectTableView.dataSource = self
        model.delegate = self
        model.GetProjectByCustID(view: self.view, VC: self)
        //        NewProjectBtn.setBackgroundImage(#imageLiteral(resourceName: "round1"), for: .normal, barMetrics: .default)
        //        NewProjectBtn.isEnabled = true
        //        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(self.longPressHandler(gesture:)))
        //        gesture.isEnabled = true
        //        gesture.minimumPressDuration = 1
        //
        //        view.addGestureRecognizer(gesture)
        
        barView.isHidden = true
        DispatchQueue.main.async {
            self.NothingLabel.isHidden = true
        }
        
    }
    
    func addBackBarButtonItem() {
        let backButton = UIButton(type: .system)
        backButton.setTitle("الرئيسية", for: .normal)
        backButton.setImage(UIImage(named: "DBackBtn"), for: .normal)
        backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        backButton.sizeToFit()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }
    
    @objc func backButtonPressed(){
        let storyBoard : UIStoryboard = UIStoryboard(name: "NewHome", bundle:nil)
        let secondView = storyBoard.instantiateViewController(withIdentifier: "NewMyProjectsViewController") as! NewMyProjectsViewController
        //        self.present(secondView, animated: false, completion: nil)
        let topController = UIApplication.topViewController()
        topController?.show(secondView, sender: true)
    }
    //    func longPressHandler(gesture: UILongPressGestureRecognizer) {
    //
    //        // Get the location of the gesture relative to the table view.
    //        let location = gesture.location(in: requestProjectTableView)
    //
    //        // Determine the row where the touch occurred.
    //        guard let selectedIndexPath = requestProjectTableView.indexPathForRow(at: location) else {
    //            return
    //        }
    //
    //        // Iterate through all visible rows.
    //        guard let indexPaths = requestProjectTableView.indexPathsForVisibleRows else {
    //            return
    //        }
    //
    //        for indexPath in indexPaths {
    //
    //            // Get the cell for each visible row.
    //            guard let cell = requestProjectTableView.cellForRow(at: indexPath) else {
    //                continue
    //            }
    //
    //
    //
    //
    //            // If the index path is for the selected cell, then show the highlighted border, otherwise remove the border.
    //            let layer = cell.contentView.layer
    //
    //            if indexPath == selectedIndexPath {
    //                layer.borderColor = UIColor(red: 212/255, green: 175/255, blue: 52/255, alpha: 1).cgColor
    //                layer.borderWidth = 3
    //                layer.cornerRadius = 10
    //            }
    //            else {
    //                layer.borderWidth = 0
    //            }
    //
    //            cell.setNeedsLayout()
    //        }
    //
    //    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if let selectedIndexPath = self.requestProjectTableView.indexPathForSelectedRow {
            self.requestProjectTableView.deselectRow(at: selectedIndexPath, animated: true)
            self.requestProjectTableView.reloadData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dataReady() {
        // Access the video objects that have been downloaded
        self.searchResu = self.model.resultArray
        // Tell the tableview to reload
        self.requestProjectTableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if searchResu.count == 0 {
            NothingLabel.isHidden = false
            requestProjectTableView.isHidden = true
        } else {
            requestProjectTableView.isHidden = false
            NothingLabel.isHidden = true
        }
        return searchResu.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    //    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    //        return 20
    //    }
    //
    //    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    //        let view = UIView()
    //        view.backgroundColor = UIColor.clear
    //        return view
    //    }
    
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RequestTableViewCell", for: indexPath) as! RequestTableViewCell
        
        cell.layer.cornerRadius = 10
        cell.layer.borderColor = UIColor.clear.cgColor // set cell border color here
        cell.layer.masksToBounds = true
        
        
        cell.TyoeProject.text = searchResu[indexPath.section].ProjectTypeName
        if searchResu[indexPath.section].ProjectBildTypeNum == "1" {
            cell.AddressProject.isHidden = true
            cell.AddressProject.text = searchResu[indexPath.section].ProjectTitle
        }else {
            cell.AddressProject.isHidden = false
            cell.AddressProject.text = searchResu[indexPath.section].ProjectTitle
        }
        
        let emplImage = searchResu[indexPath.section].EmpImage
        if let url = URL.init(string: emplImage) {
            print(url)
            cell.EmpImage.hnk_setImageFromURL(url, placeholder: #imageLiteral(resourceName: "custlogo"))
        } else{
            print("nil")
        }
        cell.EmpName.text = searchResu[indexPath.section].EmpName
        cell.Mobile.setTitle(searchResu[indexPath.section].EmpMobile, for: .normal)
        cell.companyNameLabel.text = searchResu[indexPath.section].ComapnyName
        
        let status = searchResu[indexPath.section].ProjectStatusID
        
        if status == "5"{
            cell.StatusImage.image = #imageLiteral(resourceName: "تم الالغاء")
        }else if status == "4"{
            cell.StatusImage.image = #imageLiteral(resourceName: "قيد الاستقبال")
        }else if status == "3"{
            cell.StatusImage.image = #imageLiteral(resourceName: "تم الانجاز")
        }else if status == "1"{
            cell.StatusImage.image = #imageLiteral(resourceName: "جاري العمل")
        }else if status == "2"{
            cell.StatusImage.image = #imageLiteral(resourceName: "مرفوض")
        }else if status == "6"{
            cell.StatusImage.image = #imageLiteral(resourceName: "NewStateFive")
        }else if status == "7"{
            cell.StatusImage.image = #imageLiteral(resourceName: "Recived")
        }else {
            print("error status \(status)")
        }
        
        self.updateCell(cell)
        cell.contentView.layer.borderColor = UIColor.clear.cgColor
        cell.contentView.layer.borderWidth = 0
        NewProjectBtn.isEnabled = true
        barView.isHidden = true
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        let status = searchResu[indexPath.section].ProjectStatusID
        
        if status == "5"{
            EditOut.isEnabled = false
            CancelOut.isEnabled = false
            EditOut.backgroundColor = UIColor.gray
            CancelOut.backgroundColor = UIColor.gray
        }else if status == "4"{
            EditOut.isEnabled = true
            CancelOut.isEnabled = true
            EditOut.backgroundColor = UIColor(red: 212/250.0, green: 175/250.0, blue: 52/250.0, alpha: 1.0)
            CancelOut.backgroundColor = UIColor(red: 212/250.0, green: 175/250.0, blue: 52/250.0, alpha: 1.0)
        }else if status == "3"{
            EditOut.isEnabled = false
            CancelOut.isEnabled = false
            EditOut.backgroundColor = UIColor.gray
            CancelOut.backgroundColor = UIColor.gray
        }else if status == "1"{
            EditOut.isEnabled = false
            CancelOut.isEnabled = false
            EditOut.backgroundColor = UIColor.gray
            CancelOut.backgroundColor = UIColor.gray
        }else if status == "2"{
            EditOut.isEnabled = false
            CancelOut.isEnabled = false
            EditOut.backgroundColor = UIColor.gray
            CancelOut.backgroundColor = UIColor.gray
        }else if status == "6"{
            EditOut.isEnabled = true
            CancelOut.isEnabled = true
            EditOut.backgroundColor = UIColor(red: 212/250.0, green: 175/250.0, blue: 52/250.0, alpha: 1.0)
            CancelOut.backgroundColor = UIColor(red: 212/250.0, green: 175/250.0, blue: 52/250.0, alpha: 1.0)
        }else if status == "7"{
            EditOut.isEnabled = true
            CancelOut.isEnabled = true
            EditOut.backgroundColor = UIColor(red: 212/250.0, green: 175/250.0, blue: 52/250.0, alpha: 1.0)
            CancelOut.backgroundColor = UIColor(red: 212/250.0, green: 175/250.0, blue: 52/250.0, alpha: 1.0)
        }else {
            print("error status")
            EditOut.isEnabled = false
            CancelOut.isEnabled = false
            EditOut.backgroundColor = UIColor.gray
            CancelOut.backgroundColor = UIColor.gray
        }
        
        self.updateCell(cell)
        NewProjectBtn.isEnabled = false
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        NewProjectBtn.isEnabled = false
        let status = searchResu[indexPath.section].ProjectStatusID
        
        if status == "5" {
            EditOut.isEnabled = false
            CancelOut.isEnabled = false
            EditOut.backgroundColor = UIColor.gray
            CancelOut.backgroundColor = UIColor.gray
        }else if status == "4"{
            EditOut.isEnabled = true
            CancelOut.isEnabled = true
            EditOut.backgroundColor = UIColor(red: 212/250.0, green: 175/250.0, blue: 52/250.0, alpha: 1.0)
            CancelOut.backgroundColor = UIColor(red: 212/250.0, green: 175/250.0, blue: 52/250.0, alpha: 1.0)
        }else if status == "3"{
            EditOut.isEnabled = false
            CancelOut.isEnabled = false
            EditOut.backgroundColor = UIColor.gray
            CancelOut.backgroundColor = UIColor.gray
        }else if status == "1"{
            EditOut.isEnabled = false
            CancelOut.isEnabled = false
            EditOut.backgroundColor = UIColor.gray
            CancelOut.backgroundColor = UIColor.gray
        }else if status == "2"{
            EditOut.isEnabled = false
            CancelOut.isEnabled = false
            EditOut.backgroundColor = UIColor.gray
            CancelOut.backgroundColor = UIColor.gray
        }else if status == "6"{
            EditOut.isEnabled = true
            CancelOut.isEnabled = true
            EditOut.backgroundColor = UIColor(red: 212/250.0, green: 175/250.0, blue: 52/250.0, alpha: 1.0)
            CancelOut.backgroundColor = UIColor(red: 212/250.0, green: 175/250.0, blue: 52/250.0, alpha: 1.0)
        }else if status == "7"{
            EditOut.isEnabled = true
            CancelOut.isEnabled = true
            EditOut.backgroundColor = UIColor(red: 212/250.0, green: 175/250.0, blue: 52/250.0, alpha: 1.0)
            CancelOut.backgroundColor = UIColor(red: 212/250.0, green: 175/250.0, blue: 52/250.0, alpha: 1.0)
        }else {
            print("error status")
            EditOut.isEnabled = false
            CancelOut.isEnabled = false
            EditOut.backgroundColor = UIColor.gray
            CancelOut.backgroundColor = UIColor.gray
        }
        self.updateCell(cell)
    }
    
    
    func ProjectCancel() {
        if let selectedIndexPath = self.requestProjectTableView.indexPathForSelectedRow {
            let ProjectId = searchResu[selectedIndexPath.section].ProjectId
            self.searchResu.remove(at: selectedIndexPath.section)
            self.requestProjectTableView.deleteSections([selectedIndexPath.section], with: .right)
            // call some api
            
            let parameters: Parameters = [
                "projectId" : ProjectId
            ]
            
            Alamofire.request("http://smusers.promit2030.com/Service1.svc/ProjectCancel", method: .get, parameters: parameters, encoding: URLEncoding.default).responseJSON { response in
                debugPrint(response)
                let json = JSON(response.result.value!)
                
                print(json)
            }
            
        }
    }
    
    func updateCell(_ cell: UITableViewCell?) {
        
        if let _ = self.requestProjectTableView.indexPathForSelectedRow {
            cell?.contentView.layer.borderColor = UIColor(red: 212/255, green: 175/255, blue: 52/255, alpha: 1).cgColor
            cell?.layer.cornerRadius = 5
            cell?.contentView.layer.borderWidth = 3
            barView.isHidden = false
        } else {
            cell?.contentView.layer.borderColor = UIColor.clear.cgColor
            cell?.contentView.layer.borderWidth = 0
            barView.isHidden = true
        }
        cell?.setNeedsLayout()
    }
    
    @IBAction func newProjectBtn(_ sender: UIBarButtonItem) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "NewProject", bundle:nil)
        let secondView = storyBoard.instantiateViewController(withIdentifier: "OfficeFillterViewController") as! OfficeFillterViewController
        self.navigationController?.pushViewController(secondView, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetr" {
            if let indexPath = requestProjectTableView.indexPathForSelectedRow {
                let cont = segue.destination as! DetailsOfProjectViewController
                
                cont.ProjectId = searchResu[indexPath.section].ProjectId
                cont.ProjectTitle = searchResu[indexPath.section].ProjectTitle
            }
        }
        
        if segue.identifier == "showEdit" {
            if let indexPath = requestProjectTableView.indexPathForSelectedRow {
                let cont = segue.destination as! EditATableViewController
                cont.BranchID = searchResu[indexPath.section].BranchID
                cont.BranchName = searchResu[indexPath.section].BranchName
                cont.CustmoerName = searchResu[indexPath.section].CustmoerName
                cont.CustomerEmail = searchResu[indexPath.section].CustomerEmail
                cont.CustomerMobile = searchResu[indexPath.section].CustomerMobile
                cont.CustomerNationalId = searchResu[indexPath.section].CustomerNationalId
                cont.DataSake = searchResu[indexPath.section].DataSake
                cont.DateLicence = searchResu[indexPath.section].DateLicence
                cont.EmpImage = searchResu[indexPath.section].EmpImage
                cont.EmpMobile = searchResu[indexPath.section].EmpMobile
                cont.EmpName = searchResu[indexPath.section].EmpName
                cont.GroundId = searchResu[indexPath.section].GroundId
                cont.IsDeleted = searchResu[indexPath.section].IsDeleted
                cont.JobName = searchResu[indexPath.section].JobName
                cont.LatBranch = searchResu[indexPath.section].LatBranch
                cont.LatPrj = searchResu[indexPath.section].LatPrj
                cont.LicenceNum = searchResu[indexPath.section].LicenceNum
                cont.LngBranch = searchResu[indexPath.section].LngBranch
                cont.LngPrj = searchResu[indexPath.section].LngPrj
                cont.Notes = searchResu[indexPath.section].Notes
                cont.PlanId = searchResu[indexPath.section].PlanId
                cont.ProjectBildTypeId = searchResu[indexPath.section].ProjectBildTypeId
                cont.ProjectEngComment = searchResu[indexPath.section].ProjectEngComment
                cont.ProjectId = searchResu[indexPath.section].ProjectId
                cont.ProjectStatusColor = searchResu[indexPath.section].ProjectStatusColor
                cont.ProjectStatusID = searchResu[indexPath.section].ProjectStatusID
                cont.ProjectStatusName = searchResu[indexPath.section].ProjectStatusName
                cont.ProjectTitle = searchResu[indexPath.section].ProjectTitle
                cont.ProjectTypeId = searchResu[indexPath.section].ProjectTypeId
                cont.ProjectTypeName = searchResu[indexPath.section].ProjectTypeName
                cont.SakNum = searchResu[indexPath.section].SakNum
                cont.Space = searchResu[indexPath.section].Space
                cont.Status = searchResu[indexPath.section].Status
                cont.ZoomBranch = searchResu[indexPath.section].ZoomBranch
                cont.ZoomPrj = searchResu[indexPath.section].ZoomPrj
            }
        }
        
    }
    
    
}

extension UIViewController {
    class func displaySpinner(onView : UIView) -> UIView {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.clear
        let x = Int(spinnerView.center.x)
        let y = Int(spinnerView.center.y)
        let ai = NVActivityIndicatorView(frame: CGRect.init(x: x, y: y, width: 50, height: 50), type: .circleStrokeSpin, color: #colorLiteral(red: 0.831372549, green: 0.6862745098, blue: 0.2039215686, alpha: 1), padding: 5)
        ai.color = UIColor(red: 212/255.0, green: 175/255.0, blue: 52/255.0, alpha: 1.0)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        
        return spinnerView
    }
    
    class func removeSpinner(spinner :UIView) {
        DispatchQueue.main.async {
            spinner.removeFromSuperview()
        }
    }
}
