//
//  AlertDetialsDesignViewController.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 8/17/17.
//  Copyright © 2017 Ahmed Wahdan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

var designStagesID: String = ""

class AlertDetialsDesignOKViewController: UIViewController {

     @IBOutlet weak var Constrain_Top: NSLayoutConstraint!
    var CreateDate: String = ""
    var DesignFile: String = ""
    var DesignStagesID: String = ""
    var Details: String = ""
    var EmpName: String = ""
    var mobileStr: String = ""
    var ProjectBildTypeName: String = ""
    var ProjectStatusID: String = ""
    var SakNum: String = ""
    var StagesDetailsName: String = ""
    var Status: String = ""
    var ClientReply: String = ""
    var EmpReply: String = ""
    var ComapnyName: String = ""
    var LatBranch: Double = 0.0
    var LngBranch: Double = 0.0
    var JobName = ""
    var Address = ""
    var Logo = ""
    var designsDetialsOfResult = [DesignsDetialsArray]()
    var designsDetialsModel: DesignsDetialsModel = DesignsDetialsModel()
    var isScroll = false
    var ProjectId = ""
    var CompanyInfoID = ""
    var IsCompany = ""
    var comingfrompdf = false
    
      var dismiss : DismissDelegate?
    var reloadApi: AccepEditDesgin?
    @IBOutlet weak var alertDone: AMUIView!
    @IBOutlet weak var doneBtnOut: UIButton!{
        didSet {
            DispatchQueue.main.async {
                self.doneBtnOut.circleView(UIColor.clear, borderWidth: 1.0)
            }
        }
    }

    @IBOutlet weak var ReplayTF: KMPlaceholderTextView!
    @IBOutlet weak var popUpBtnOut: UIButton!{
        didSet {
            DispatchQueue.main.async {
                self.popUpBtnOut.circleView(UIColor.clear, borderWidth: 1.0)
            }
        }
    }
    
    @IBAction func dismissBtn(_ sender: UIButton) {
        //        let sub = self.storyboard?.instantiateViewController(withIdentifier: "main") as! MyTabBarController
        //        self.present(sub, animated: true ,completion: nil)
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func end(_ sender: UIButton) {
//        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let sub = storyBoard.instantiateViewController(withIdentifier: "main") as! MyTabBarController
//        self.present(sub, animated: true ,completion: nil)
//        self.reloadApi?.reload()
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func Done(_ sender: UIButton) {
        print(designStagesID)
        OKDesign()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        alertDone.isHidden = true
        print("des: \(designStagesID)")
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.black
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.bordered, target: self, action: #selector(AlertDesignOkViewController.donePicker))
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        ReplayTF.inputAccessoryView = toolBar
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        
        ReplayTF.addGestureRecognizer(tap)
        
        // Do any additional setup after loading the view.
    }
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        self.ReplayTF.becomeFirstResponder()
        Constrain_Top.constant = 50
    }
    @objc func donePicker(){
        self.view.endEditing(true)
          Constrain_Top.constant = 135
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func OKDesign(){
        let sv = UIViewController.displaySpinner(onView: self.view)
        let parameters: Parameters = [
            "designStagesID": designStagesID,
            "clientReply": ReplayTF.text!,
            "status": "2"
        ]
        print(parameters)
        Alamofire.request("http://smusers.promit2030.co/Service1.svc/DesignStages", method: .get, parameters: parameters, encoding: URLEncoding.default).responseJSON { response in
            debugPrint(response)
            
            let json = JSON(response)
            if json["Result"].boolValue == true || json["Result"].boolValue == false {
                self.alertDone.isHidden = false
                
                self.reloadApi?.refresh()
                self.dismiss?.Dismisview()
                self.dismiss(animated: true, completion: nil)
                UIViewController.removeSpinner(spinner: sv)
                
//                let storyBoard : UIStoryboard = UIStoryboard(name: "DesignsAndDetails", bundle:nil)
//                
//                let secondView = storyBoard.instantiateViewController(withIdentifier: "DetailsDesignTableViewController") as! DetailsDesignTableViewController
//               
//                self.navigationController?.pushViewController(secondView, animated: true)
                

            }
        }
    }
    

}
