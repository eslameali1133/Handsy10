//
//  FilterVisitsViewController.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 6/30/18.
//  Copyright © 2018 Ahmed Wahdan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class FilterVisitsViewController: UIViewController {
    @IBOutlet weak var newVisitssCountLabel: UILabel!{
        didSet {
            DispatchQueue.main.async {
                self.newVisitssCountLabel.layer.cornerRadius = self.newVisitssCountLabel.frame.width/2
                self.newVisitssCountLabel.layer.masksToBounds = true
            }
        }
    }
    @IBOutlet weak var oldVisitsCountLabel: UILabel!{
        didSet {
            DispatchQueue.main.async {
                self.oldVisitsCountLabel.layer.cornerRadius = self.oldVisitsCountLabel.frame.width/2
                self.oldVisitsCountLabel.layer.masksToBounds = true
            }
        }
    }
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
    var indexi:Int = 0
    var isCompany = ""
    var ProjectOfResult: [ProjectDetialsArray] = [ProjectDetialsArray]()
    var condition = ""
    var FinishMeetingCount = ""
    var NewMeetingCount = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        oldVisitsCountLabel.isHidden = true
        newVisitssCountLabel.isHidden = true
        MeetingCountByCustmoerId()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        oldVisitsCountLabel.isHidden = true
        newVisitssCountLabel.isHidden = true
        MeetingCountByCustmoerId()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func goNewVisits(_ sender: UIButton) {
        if NewMeetingCount == "0" {
            Toast.long(message: "لا يوجد زيارات جديدة حالياً")
        }else{
            let storyBoard : UIStoryboard = UIStoryboard(name: "VisitsAndDetails", bundle: nil)
            let secondView = storyBoard.instantiateViewController(withIdentifier: "VisitsViewController") as! VisitsViewController
            secondView.condition = "New"
            self.navigationController?.pushViewController(secondView, animated: true)
            
        }
    }
    
    
    @IBAction func goOldVisits(_ sender: UIButton) {
        if FinishMeetingCount == "0" {
            Toast.long(message: "لايوجد زيارات منتهية حالياً")
        }else{
        let storyBoard : UIStoryboard = UIStoryboard(name: "VisitsAndDetails", bundle: nil)
        let secondView = storyBoard.instantiateViewController(withIdentifier: "VisitsViewController") as! VisitsViewController
        secondView.condition = "Other"
            self.navigationController?.pushViewController(secondView, animated: true)}
    }
    
    func MeetingCountByCustmoerId() {
        let CustmoerId = UserDefaults.standard.string(forKey: "CustmoerId")!
        let parameters: Parameters = [
            "CustmoerId": CustmoerId
        ]
        Alamofire.request("http://smusers.promit2030.co/Service1.svc/MeetingCountByCustmoerId", method: .get, parameters: parameters, encoding: URLEncoding.default).responseJSON { response in
            debugPrint(response)
            let json = JSON(response.result.value!)
            self.FinishMeetingCount = json["FinishMeetingCount"].stringValue
            self.NewMeetingCount = json["NewMeetingCount"].stringValue
            if self.FinishMeetingCount == "0" || self.FinishMeetingCount == ""{
                self.oldVisitsCountLabel.isHidden = true
            }else {
                self.oldVisitsCountLabel.isHidden = false
                self.oldVisitsCountLabel.text = self.FinishMeetingCount
            }
            if self.NewMeetingCount == "0" || self.NewMeetingCount == ""{
                self.newVisitssCountLabel.isHidden = true
            }else {
                self.newVisitssCountLabel.isHidden = false
                self.newVisitssCountLabel.text = self.NewMeetingCount
            }
        }
    }
}
