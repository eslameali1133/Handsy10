//
//  AlertDetialsDesignCancelViewController.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 8/17/17.
//  Copyright © 2017 Ahmed Wahdan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class AlertDetialsDesignCancelViewController: UIViewController {
      @IBOutlet weak var Constrain_Top: NSLayoutConstraint!
    @IBOutlet weak var CommentStack: UIStackView!
    @IBOutlet weak var stackviewarlet: UIStackView!
    var comefrom = 0
     var searchResu:[DesignByProjectIdArray] = [DesignByProjectIdArray]()
    var reloadApi: AccepEditDesgin?
    var dismiss : DismissDelegate?
    @IBOutlet weak var alertDone: AMUIView!
    @IBOutlet weak var doneBtnOut: UIButton!{
        didSet {
            DispatchQueue.main.async {
                self.doneBtnOut.circleView(UIColor.clear, borderWidth: 1.0)
            }
        }
    }
    
    @IBOutlet weak var Comments: KMPlaceholderTextView!
    @IBOutlet weak var alertComments: UILabel!
    @IBOutlet weak var alertViewLine: UIView!
        
    @IBOutlet weak var popUpBtnOut: UIButton!{
        didSet {
            DispatchQueue.main.async {
                self.popUpBtnOut.circleView(UIColor.clear, borderWidth: 1.0)
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         CommentStack.isHidden = true
        alertDone.isHidden = true
        print("des: \(designStagesID)")
        // Do any additional setup after loading the view.
        alertComments.isHidden = true
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.black
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.bordered, target: self, action: #selector(AlertDesignOkViewController.donePicker))
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        Comments.inputAccessoryView = toolBar
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        
        Comments.addGestureRecognizer(tap)
    }
    
    // function which is triggered when handleTap is called
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        self.Comments.becomeFirstResponder()
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
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        dismiss?.Dismisview()
    }
    @IBAction func dismissBtn(_ sender: UIButton) {
        //        let sub = self.storyboard?.instantiateViewController(withIdentifier: "main") as! MyTabBarController
        //        self.present(sub, animated: true ,completion: nil)
        
        // comdrom = 3 move to
//    if comefrom == 3
//    {
//        let storyBoard : UIStoryboard = UIStoryboard(name: "DesignsAndDetails", bundle:nil)
//        let cont = storyBoard.instantiateViewController(withIdentifier: "DetailsDesignTableViewController") as! DetailsDesignTableViewController
//
//        cont.CreateDate = searchResu[0].CreateDate!
//        cont.DesignFile = searchResu[0].DesignFile!
//        cont.DesignStagesID = searchResu[0].DesignStagesID!
//        cont.Details = searchResu[0].Details!
//        cont.EmpName = searchResu[0].EmpName!
//        cont.mobileStr = searchResu[0].Mobile!
//        cont.ProjectBildTypeName = searchResu[0].ProjectBildTypeName!
//        cont.ProjectStatusID = searchResu[0].ProjectStatusID!
//        cont.SakNum = searchResu[0].SakNum!
//        cont.StagesDetailsName = searchResu[0].StagesDetailsName!
//        cont.Status = searchResu[0].Status!
//        cont.ClientReply = searchResu[0].ClientReply!
//        cont.EmpReply = searchResu[0].EmpReply!
//        cont.ComapnyName = searchResu[0].ComapnyName!
//        cont.Logo = searchResu[0].Logo!
//        cont.Address = searchResu[0].Address!
//        self.dismiss(animated: true, completion: nil)
//
//
//        var alreadyPushed = false
//        //Check if the view was already pushed
//        if let viewControllers = self.navigationController?.viewControllers {
//            for viewController in viewControllers {
//                if let viewController = viewController as? DetailsDesignTableViewController {
//                    self.navigationController?.popToViewController(viewController, animated: true);
//                    print(" Push Your Controller")
//                    alreadyPushed = true
//                    break
//                }
//            }
//        }
//        if alreadyPushed == false {
//            let YourControllerObject = storyBoard.instantiateViewController(withIdentifier: "DetailsDesignTableViewController") as! DetailsDesignTableViewController
//            self.navigationController?.pushViewController(YourControllerObject, animated: true)
//
//        }
//
//
////        self.navigationController?.popToViewController(cont, animated: true)
////         self.dismiss(animated: true, completion: nil)
//
////        let index = navigationController?.viewControllers.index(of: cont)
////        print(index!)
////        if let composeViewController = self.navigationController?.viewControllers[index!] {//Here you mention your view controllers index, because navigation controller can store all VC'c in an array.
////            print(composeViewController)
////            self.navigationController?.popToViewController(composeViewController, animated: true)
////        }
//
//
//        }
//        else
//    {
      //  self.reloadApi?.reload()
        self.dismiss?.Dismisview()
        self.dismiss(animated: true, completion: nil)
        }
        
    
    
    @IBAction func end(_ sender: UIButton) {
        if Comments.text != "" {
            CancelDesign()
        } else {
             CommentStack.isHidden = false
            alertComments.isHidden = false
            alertViewLine.backgroundColor = #colorLiteral(red: 0.9019607843, green: 0.2980392157, blue: 0.2352941176, alpha: 1)
        }
    }
    
    func CancelDesign() {
        let sv = UIViewController.displaySpinner(onView: self.view)
        let parameters: Parameters = [
            "designStagesID": designStagesID,
            "clientReply": Comments.text!,
            "status": "3"
        ]
        
        Alamofire.request("http://smusers.promit2030.co/Service1.svc/DesignStages", method: .get, parameters: parameters, encoding: URLEncoding.default).responseJSON { response in
            debugPrint(response)
            
            let json = JSON(response)
            print(json["Result"].boolValue)
            if json["Result"].boolValue == true || json["Result"].boolValue == false  {
                self.alertDone.isHidden = false
//                self.stackviewarlet.isHidden = false
                self.reloadApi?.refresh()
                self.dismiss?.Dismisview()
                self.dismiss(animated: true, completion: nil)
                UIViewController.removeSpinner(spinner: sv)
//                let storyBoard : UIStoryboard = UIStoryboard(name: "NewHome", bundle:nil)
//                let sub = storyBoard.instantiateViewController(withIdentifier: "NewMain")
//                let topController = UIApplication.topViewController()
//                topController?.show(sub, sender: true)
            }
            
        }
    }


}
