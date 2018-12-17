
//  EditDesigRecordsVC.swift
//  Handsy

//  Created by apple on 12/10/18.
//  Copyright © 2018 Ahmed Wahdan. All rights reserved.

import UIKit
import Alamofire
import SwiftyJSON
class EditDesigRecordsVC: UIViewController, UITableViewDelegate, UITableViewDataSource,DesigRecordModelDelegate {
    
    var searchResuDes:[EditRecoredModel] = [EditRecoredModel]()
    var searchResuContr:[EditRecoredContractModel] = [EditRecoredContractModel]()
    
    let model: DesignRecordsModel = DesignRecordsModel()
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var CallBtn: UIButton!{
        didSet {
            CallBtn.layer.borderWidth = 1.0
            CallBtn.layer.borderColor = #colorLiteral(red: 0.2, green: 0.5647058824, blue: 0.3882352941, alpha: 1)
            CallBtn.layer.cornerRadius = 4.0
        }
    }
    @IBOutlet weak var messageChat: UIButton!{
        didSet {
            messageChat.layer.borderWidth = 1.0
            messageChat.layer.borderColor = #colorLiteral(red: 0.2, green: 0.5647058824, blue: 0.3882352941, alpha: 1)
            messageChat.layer.cornerRadius = 4.0
        }
    }
    @IBOutlet weak var messageCountLabel: UILabel!{
        didSet {
            DispatchQueue.main.async {
                self.messageCountLabel.layer.cornerRadius = self.messageCountLabel.frame.width/2
                self.messageCountLabel.layer.masksToBounds = true
            }
        }
    }
    
    @IBOutlet weak var sakNumber: UILabel!
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var EngNameLabel: UILabel!
    @IBOutlet weak var ProjectTitle: UILabel!
    
    
    var ProjectId = ""
    var ProjectTiti = ""
    var EngName = ""
    var companyName = ""
    var sakNum = ""
    var DesignStagesID = ""
    var mobilestr = ""
    var  StatusLa = ""
    var  Condition = ""
   
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messageCountLabel.isHidden = true
        tableView.delegate = self
        tableView.dataSource = self
        model.delegate = self
        SetupHeader()
        
        //        if Reachability.isConnectedToNetwork(){
        //
        //            model.GetEditReorecBrDesID(view: self.view, VC: self, DesignID: DesignStagesID, Condition: Condition)
        //            self.GetCountMessageUnReaded()
        //
        //        }
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if Reachability.isConnectedToNetwork(){
            
            model.GetEditReorecBrDesID(view: self.view, VC: self, DesignID: DesignStagesID, Condition: Condition)
            self.GetCountMessageUnReaded()
            
        }
    }
    //Set DAtaToHeader
    func  SetupHeader(){
        sakNumber.text = sakNum
        ProjectTitle.text = ProjectTiti
        companyNameLabel.text = companyName
        EngNameLabel.text = EngName
    }
    //read data from controller
    
    func dataReady() {
        
        print("Internet Connection Available!")
        if Condition == "Design"
        {
            self.searchResuDes = self.model.resultArrayDesign
            if searchResuDes.count == 0 {
                tableView.isHidden = true
            }
        }
        else
        {
            self.searchResuContr = self.model.resultArrayContract
            if searchResuContr.count == 0 {
                tableView.isHidden = true
            }
        }
        
        tableView.reloadData()
        
    }
    
    // table view config
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5
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
        if Condition == "Design"
        {
            return searchResuDes.count
        }
        else
        {
            return searchResuContr.count
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EditDesignRecordCell", for: indexPath) as! EditDesignRecordCell
        if Condition == "Design"
        {
            
            cell.Date.text = searchResuDes[indexPath.section].CreateDate
            cell.note.text = searchResuDes[indexPath.section].Details
            cell.ViewDesignBtn.setTitle("عرض التصميم", for: .normal)
        }
        else
        {
            cell.ViewDesignBtn.setTitle("عرض العقد", for: .normal)
            cell.Date.text = searchResuContr[indexPath.section].ContractHistoryDate
            cell.note.text = searchResuContr[indexPath.section].ContractHistoryNote
        }
        return cell
    }
    
    
    
    @IBAction func openChat(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Chat", bundle: nil)
        let FirstViewController = storyboard.instantiateViewController(withIdentifier: "ChatOfProjectsViewController") as! ChatOfProjectsViewController
        FirstViewController.ProjectId = ProjectId
        self.navigationController?.pushViewController(FirstViewController, animated: true)
    }
    
    @IBAction func OpenDesign(_ sender: UIButton) {
        
        let point = sender.convert(CGPoint.zero, to: tableView)
        let index = tableView.indexPathForRow(at: point)?.section
        
        var openPdf = ""
        if Condition == "Design"
        {
            if searchResuDes[index!].File != ""
            {
                let storyBoard : UIStoryboard = UIStoryboard(name: "DesignsAndDetails", bundle:nil)
                let secondView = storyBoard.instantiateViewController(withIdentifier: "openPdfViewController") as! openPdfViewController
                openPdf = searchResuDes[index!].File
                secondView.url = openPdf
                secondView.condBottomButtons = "dsa"
                self.navigationController?.pushViewController(secondView, animated: true)
                
            }else
            {
                 Toast.long(message: "لا يوجد ملف")
            }
        }
        else
        {
            if searchResuContr[index!].ContractHistoryPath == ""
            {
                 Toast.long(message: "لا يوجد ملف")
            }else
            {
                openPdf = searchResuContr[index!].ContractHistoryPath
                let  ProjectContract =  searchResuContr[index!].ContractHistoryStatus
                
                if ProjectContract == "1" || ProjectContract == "4"{
                    let storyBoard : UIStoryboard = UIStoryboard(name: "ProjectsAndEdit", bundle:nil)
                    let secondView = storyBoard.instantiateViewController(withIdentifier: "ShowContractViewController") as! ShowContractViewController
                    secondView.url = openPdf
                    secondView.ProjectId = ProjectId
                    secondView.Webtitle = "العقد"
                    self.navigationController?.pushViewController(secondView, animated: true)
                } else if ProjectContract == "2" {
                    let storyBoard : UIStoryboard = UIStoryboard(name: "DesignsAndDetails", bundle:nil)
                    let secondView = storyBoard.instantiateViewController(withIdentifier: "openPdfViewController") as! openPdfViewController
                    secondView.url = openPdf
                    secondView.Webtitle = "العقد"
                    self.navigationController?.pushViewController(secondView, animated: true)
                } else {
                    let storyBoard : UIStoryboard = UIStoryboard(name: "DesignsAndDetails", bundle:nil)
                    let secondView = storyBoard.instantiateViewController(withIdentifier: "openPdfViewController") as! openPdfViewController
                    secondView.url = openPdf
                    secondView.Webtitle = "العقد"
                    self.navigationController?.pushViewController(secondView, animated: true)
                }
                
            }
            
        }
        
    }
    
    @IBAction func CallMe(_ sender: UIButton) {
        var mobile: String = mobilestr
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
    
    // func to Get Messages Count UnReaded
    func GetCountMessageUnReaded() {
        // call some api
        
        let parameters: Parameters = ["projectId": ProjectId]
        
        Alamofire.request("http://smusers.promit2030.co/api/ApiService/GetCountMessageUnReaded", method: .get, parameters: parameters, encoding: URLEncoding.default).responseJSON { response in
            debugPrint(response)
            let json = JSON(response.result.value!)
            let MessageCount = json["MessageCount"].stringValue
            if MessageCount == "" || MessageCount == "0" {
                self.messageCountLabel.isHidden = true
            }else {
                self.messageCountLabel.isHidden = false
                self.messageCountLabel.text = MessageCount
            }
            print(json)
        }
        
    }
    
}
