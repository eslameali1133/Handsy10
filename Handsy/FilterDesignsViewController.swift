//
//  FilterDesignsViewController.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 6/28/18.
//  Copyright © 2018 Ahmed Wahdan. All rights reserved.
//

import UIKit

class FilterDesignsViewController: UIViewController {

    var ProjectId = ""
    var projectTitleView = ""
    var ComapnyName = ""
    var Logo = ""
    var CompanyInfoID = ""
    var EmpMobile = ""
    var EmpName = ""
    var LatBranch: Double = 0.0
    var LngBranch: Double = 0.0
    var ProjectOfResult: [ProjectDetialsArray] = [ProjectDetialsArray]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func goNewDesigns(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "NewHome", bundle:nil)
        let secondView = storyBoard.instantiateViewController(withIdentifier: "DesignsOfProjectViewController") as! DesignsOfProjectViewController
        secondView.ProjectId = ProjectId
        secondView.projectTitleView = "(\(self.ProjectOfResult[0].ProjectTitle!)"+" - "+"\(self.ProjectOfResult[0].ProjectTypeName!))"
        secondView.ComapnyName = ComapnyName
        secondView.Logo = Logo
        secondView.CompanyInfoID = CompanyInfoID
        secondView.EmpMobile = EmpMobile
        secondView.EmpName = EmpName
        secondView.LatBranch = LatBranch
        secondView.LngBranch = LngBranch
        secondView.ProjectOfResult = ProjectOfResult
        self.navigationController?.pushViewController(secondView, animated: true)
    }
    

    @IBAction func goOldDesigns(_ sender: UIButton) {
    }
    
}
