//
//  EditeAlertViewController.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 8/7/17.
//  Copyright © 2017 Ahmed Wahdan. All rights reserved.
//

import UIKit

class EditeAlertViewController: UIViewController {
    
    var ProjectId = ""
    var BranchLat: Double = 0.0
    var BranchLng: Double = 0.0
    var EmpName = ""
    var Mobile = ""
    var EmpImage = ""
    var JobName = ""
    var BranchName = ""
    var zoomOffice = ""
    
    @IBAction func AlertEdit(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "ProjectsAndEdit", bundle:nil)
        let secondView = storyBoard.instantiateViewController(withIdentifier: "TheResponsibleEngineerEditViewController") as! TheResponsibleEngineerEditViewController
//        self.show(secondView, sender: true)
        secondView.ProjectId = self.ProjectId
        secondView.BranchLat = self.BranchLat
        secondView.BranchLng = self.BranchLng
        secondView.zoomOffice = self.zoomOffice
        secondView.BranchName = self.BranchName
        secondView.EmpName = self.EmpName
        secondView.JobName = self.JobName
        secondView.Mobile = self.Mobile
        secondView.EmpImage = self.EmpImage
        let topController = UIApplication.topViewController()
        topController?.show(secondView, sender: true)
        
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "المهندس المسؤول"
        self.navigationItem.hidesBackButton = true

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
