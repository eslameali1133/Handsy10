//
//  FilterVisitsViewController.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 6/30/18.
//  Copyright © 2018 Ahmed Wahdan. All rights reserved.
//

import UIKit

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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func goNewVisits(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "VisitsAndDetails", bundle: nil)
        let secondView = storyBoard.instantiateViewController(withIdentifier: "VisitsViewController") as! VisitsViewController
        secondView.condition = "New"
        self.navigationController?.pushViewController(secondView, animated: true)
    }
    
    
    @IBAction func goOldVisits(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "VisitsAndDetails", bundle: nil)
        let secondView = storyBoard.instantiateViewController(withIdentifier: "VisitsViewController") as! VisitsViewController
        secondView.condition = "Other"
        self.navigationController?.pushViewController(secondView, animated: true)
    }
}
