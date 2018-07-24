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
        MeetingCountByCustmoerId()
        // Do any additional setup after loading the view.
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
        Alamofire.request("http://smusers.promit2030.com/Service1.svc/MeetingCountByCustmoerId", method: .get, parameters: parameters, encoding: URLEncoding.default).responseJSON { response in
            debugPrint(response)
            let json = JSON(response.result.value!)
            self.FinishMeetingCount = json["FinishMeetingCount"].stringValue
            self.NewMeetingCount = json["NewMeetingCount"].stringValue
        }
    }
}
