//
//  FilterDesignsViewController.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 6/28/18.
//  Copyright © 2018 Ahmed Wahdan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class FilterDesignsViewController: UIViewController {
    @IBOutlet weak var newDesignsCountLabel: UILabel!{
        didSet {
            DispatchQueue.main.async {
                self.newDesignsCountLabel.layer.cornerRadius = self.newDesignsCountLabel.frame.width/2
                self.newDesignsCountLabel.layer.masksToBounds = true
            }
        }
    }
 @IBOutlet weak var oldDesignsCountLabel: UILabel!{
        didSet {
            DispatchQueue.main.async {
                self.oldDesignsCountLabel.layer.cornerRadius = self.oldDesignsCountLabel.frame.width/2
                self.oldDesignsCountLabel.layer.masksToBounds = true
            }
        }
    }
    var DesignArr: [DesignsCountByCustmoerId] = [DesignsCountByCustmoerId]()
    var designsCountByCustmoerIdModel: DesignsCountByCustmoerIdModel = DesignsCountByCustmoerIdModel()
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
    var condition = ""
    var NewDesignsCount = ""
    var FinishDesignsCount = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        oldDesignsCountLabel.isHidden = true
        newDesignsCountLabel.isHidden = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        oldDesignsCountLabel.isHidden = true
        newDesignsCountLabel.isHidden = true
        if Reachability.isConnectedToNetwork(){
      print("Internet Connection Available!")
        DesignsCountByCustmoerIdMethod()
        }
        else
        {
            designsCountByCustmoerIdModel.loadItems()
            self.DesignArr = [designsCountByCustmoerIdModel.returnDesignsCountByCustmoerId()!]
            self.SetuplabrlCount()
        }
    }

    func SetuplabrlCount(){
        
        if self.DesignArr[0].FinishDesignsCount == "0" || self.DesignArr[0].FinishDesignsCount == ""{
            self.oldDesignsCountLabel.isHidden = true
        }else {
            self.oldDesignsCountLabel.isHidden = false
            self.oldDesignsCountLabel.text = self.DesignArr[0].FinishDesignsCount
        }
        if self.DesignArr[0].NewDesignsCount == "0" || self.DesignArr[0].NewDesignsCount == ""{
            self.newDesignsCountLabel.isHidden = true
        }else {
            self.newDesignsCountLabel.isHidden = false
            self.newDesignsCountLabel.text = self.DesignArr[0].NewDesignsCount
            
        }
    }
    @IBAction func goNewDesigns(_ sender: UIButton) {
        if condition == "" {
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
        }else {
            if NewDesignsCount == "0" {
                Toast.long(message: "لايوجد تصاميم جديدة حالياً")
            }else {
                let storyBoard : UIStoryboard = UIStoryboard(name: "DesignsAndDetails", bundle: nil)
                let secondView = storyBoard.instantiateViewController(withIdentifier: "ProjectsContinueViewController") as! ProjectsContinueViewController
                secondView.condition = "New"
                self.navigationController?.pushViewController(secondView, animated: true)
            }
        }
    }
    
    @IBAction func goOldDesigns(_ sender: UIButton) {
        if condition == ""{
            
        }else {
            if FinishDesignsCount == "0" {
                Toast.long(message: "لا يوجد تصاميم المعتمدة حالياً")
            }else{
                let storyBoard : UIStoryboard = UIStoryboard(name: "DesignsAndDetails", bundle: nil)
                let secondView = storyBoard.instantiateViewController(withIdentifier: "ProjectsContinueViewController") as! ProjectsContinueViewController
                secondView.condition = "Other"
                self.navigationController?.pushViewController(secondView, animated: true)
            }
        }
    }
    
    func DesignsCountByCustmoerIdMethod() {
        let CustmoerId = UserDefaults.standard.string(forKey: "CustmoerId")!
        let parameters: Parameters = [
         "CustmoerId": CustmoerId
        ]
    print(parameters)
        Alamofire.request("http://smusers.promit2030.com/Service1.svc/DesignsCountByCustmoerId", method: .get, parameters: parameters, encoding: URLEncoding.default).responseJSON { response in
            debugPrint(response)
            let json = JSON(response.result.value!)
            let  proDesignsCountByCustmoerId = DesignsCountByCustmoerId(FinishDesignsCount: json["FinishDesignsCount"].stringValue, NewDesignsCount: json["NewDesignsCount"].stringValue)
            
            self.DesignArr.append(proDesignsCountByCustmoerId)
            self.designsCountByCustmoerIdModel.removeAllItems()
            for i in self.DesignArr {
                self.designsCountByCustmoerIdModel.append(i)
            }
            self.FinishDesignsCount = json["FinishDesignsCount"].stringValue
            self.NewDesignsCount = json["NewDesignsCount"].stringValue
            self.SetuplabrlCount()
        }
    }
    
}
