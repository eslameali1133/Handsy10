//
//  VisitsViewController.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 8/19/17.
//  Copyright © 2017 Ahmed Wahdan. All rights reserved.
//

import UIKit
import MapKit

protocol FilterVisitsDelegate {
    func filterVisitsByStatusId(StatusId: String, StatusName: String)
}


class VisitsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, VisitsModelDelegate {

    var searchResu:[VisitsArray] = [VisitsArray]()
    
    let model: VisitsModel = VisitsModel()
    
    let visitsModel: DecodeVisitsModel = DecodeVisitsModel()
    var condition = ""
    var StatusId = ""
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var NothingLabel: UILabel!
    
    @IBOutlet weak var AlertImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if condition == "New" {
            navigationItem.title = "الزيارات الجديدة"
        }else if condition == "Other" {
            navigationItem.title = "الزيارات الفائتة"
        }else {
        }
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
            if condition == "New" {
                model.GetMeetingByCustId(view: self.view, VC: self, condition: condition, StatusId: "")
            }else if condition == "Other" {
                model.GetMeetingByCustId(view: self.view, VC: self, condition: condition, StatusId: "")
            }else {
                model.GetMeetingByCustId(view: self.view, VC: self, condition: condition, StatusId: StatusId)
            }
        }else{
            print("Internet Connection not Available!")
            visitsModel.loadItems()
            self.searchResu = visitsModel.Visits
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
        visitsModel.removeAllItems()
        for i in self.model.resultArray {
            self.visitsModel.append(i)
        }
        // Tell the tableview to reload
        tableView.reloadData()
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
//    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        return 20
//    }
//    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        let view = UIView()
//        view.backgroundColor = UIColor.clear
//        return view
//    }

    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 195
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "VisitsTableViewCell", for: indexPath) as! VisitsTableViewCell
    
        cell.officeNameLabel.text = searchResu[indexPath.section].ComapnyName
        cell.titleVisit.text = searchResu[indexPath.section].Title
        cell.dateOfVisit.text = searchResu[indexPath.section].Start
        cell.startTime.text = "\(searchResu[indexPath.section].StartTime) - \(searchResu[indexPath.section].EndTime)"
        cell.companyAddress.text = searchResu[indexPath.section].Address
        let img = searchResu[indexPath.section].Logo
        if let url = URL.init(string: img) {
            cell.companyLogoImage.hnk_setImageFromURL(url, placeholder: #imageLiteral(resourceName: "officePlaceholder"))
        } else{
            print("nil")
            cell.companyLogoImage.image = #imageLiteral(resourceName: "officePlaceholder")
        }
        
        let status = searchResu[indexPath.section].MeetingStatus
        cell.statusNameLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        if status == "0"{
            cell.statusV.backgroundColor = #colorLiteral(red: 0.9459478259, green: 0.7699176669, blue: 0.05561546981, alpha: 1)
            cell.statusNameLabel.text = "قيد المقابلة"
        }else if status == "1"{
            cell.statusV.backgroundColor = #colorLiteral(red: 0.1812162697, green: 0.7981202602, blue: 0.4416504204, alpha: 1)
            cell.statusNameLabel.text = "تمت المقابلة"
        }else if status == "2"{
            cell.statusV.backgroundColor = #colorLiteral(red: 0.9019555449, green: 0.4952987432, blue: 0.1308369637, alpha: 1)
            cell.statusNameLabel.text = "ملغية"
        }else if status == "3"{
            cell.statusV.backgroundColor = #colorLiteral(red: 0.9074795842, green: 0.2969527543, blue: 0.2355833948, alpha: 1)
            cell.statusNameLabel.text = "فائتة"
        }else if status == "4"{
            cell.statusV.backgroundColor = #colorLiteral(red: 0.2022456229, green: 0.5951007605, blue: 0.8569586277, alpha: 1)
            cell.statusNameLabel.text = "مؤجلة"
        }else if status == "5"{
            cell.statusV.backgroundColor = #colorLiteral(red: 0.1521916687, green: 0.6835762858, blue: 0.376893878, alpha: 1)
            cell.statusNameLabel.text = "موافقة وقيد المقابلة"
        }else {
            print("error status")
        }

        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetial" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let cont = segue.destination as! VisitsDetialsTableViewController
                cont.visitTitle = searchResu[indexPath.section].Title
                MeetingID = searchResu[indexPath.section].MeetingID
                cont.Description = searchResu[indexPath.section].Description
                cont.Mobile = searchResu[indexPath.section].Mobile
                cont.EmpName = searchResu[indexPath.section].EmpName
                cont.MeetingStatus = searchResu[indexPath.section].MeetingStatus
                cont.DateReply = searchResu[indexPath.section].DateReply
                cont.Notes = searchResu[indexPath.section].Notes
                cont.ProjectBildTypeName = searchResu[indexPath.section].ProjectBildTypeName
                cont.Replay = searchResu[indexPath.section].Replay
                cont.Start = searchResu[indexPath.section].Start
                cont.TimeStartMeeting = searchResu[indexPath.section].TimeStartMeeting
                cont.StartTime = searchResu[indexPath.section].StartTime
                cont.EndTime = searchResu[indexPath.section].EndTime
                cont.ComapnyName = searchResu[indexPath.section].ComapnyName
                cont.Address = searchResu[indexPath.section].Address
                cont.Logo = searchResu[indexPath.section].Logo
            }
        }
    }
    
    @IBAction func openVisitDetials(_ sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: tableView)
        let index = tableView.indexPathForRow(at: point)?.section
        let storyBoard : UIStoryboard = UIStoryboard(name: "VisitsAndDetails", bundle:nil)
        let cont = storyBoard.instantiateViewController(withIdentifier: "VisitsDetialsTableViewController") as! VisitsDetialsTableViewController
        cont.visitTitle = searchResu[index!].Title
        MeetingID = searchResu[index!].MeetingID
        cont.Description = searchResu[index!].Description
        cont.Mobile = searchResu[index!].Mobile
        cont.EmpName = searchResu[index!].EmpName
        cont.MeetingStatus = searchResu[index!].MeetingStatus
        cont.DateReply = searchResu[index!].DateReply
        cont.Notes = searchResu[index!].Notes
        cont.ProjectBildTypeName = searchResu[index!].ProjectBildTypeName
        cont.Replay = searchResu[index!].Replay
        cont.Start = searchResu[index!].Start
        cont.TimeStartMeeting = searchResu[index!].TimeStartMeeting
        cont.StartTime = searchResu[index!].StartTime
        cont.EndTime = searchResu[index!].EndTime
        cont.ComapnyName = searchResu[index!].ComapnyName
        cont.Address = searchResu[index!].Address
        cont.Logo = searchResu[index!].Logo
        self.navigationController?.pushViewController(cont, animated: true)

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

extension VisitsViewController: FilterVisitsDelegate {
    func filterVisitsByStatusId(StatusId: String, StatusName: String){
        model.GetMeetingByCustId(view: self.view, VC: self, condition: "", StatusId: StatusId)
    }
}
