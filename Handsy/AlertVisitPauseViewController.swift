//
//  AlertVisitPauseViewController.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 8/27/17.
//  Copyright © 2017 Ahmed Wahdan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

var MeetingID = ""

class AlertVisitPauseViewController: UIViewController {
    @IBOutlet weak var alertDone: AMUIView!
    @IBOutlet weak var doneBtnOut: UIButton!{
        didSet {
            DispatchQueue.main.async {
                self.doneBtnOut.circleView(UIColor.clear, borderWidth: 1.0)
            }
        }
    }
    var reloadApi: reloadApi?
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
        // Do any additional setup after loading the view.
        alertDone.isHidden = true
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
    }
    
    @objc func donePicker(){
        self.view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func dismissBtn(_ sender: UIButton) {
        //        let sub = self.storyboard?.instantiateViewController(withIdentifier: "main") as! MyTabBarController
        //        self.present(sub, animated: true ,completion: nil)
        self.reloadApi?.reload()
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func end(_ sender: UIButton) {
        if Comments.text != "" {
            pauseVisit()
        } else {
            alertComments.isHidden = false
            alertViewLine.backgroundColor = #colorLiteral(red: 0.9019607843, green: 0.2980392157, blue: 0.2352941176, alpha: 1)
        }
    }
    
    func pauseVisit() {
        let parameters: Parameters = [
            "meetingID": MeetingID,
            "clientReply": Comments.text!,
            "status": "4"
        ]
        
        Alamofire.request("http://smusers.promit2030.com/Service1.svc/UpdateVisit", method: .get, parameters: parameters, encoding: URLEncoding.default).responseJSON { response in
            debugPrint(response)
            
            let json = JSON(response.result.value!)
            if json["result"].stringValue == "Done" {
                self.alertDone.isHidden = false
//                let storyBoard : UIStoryboard = UIStoryboard(name: "DesignsAndDetails", bundle: nil)
//                let secondView = storyBoard.instantiateViewController(withIdentifier: "AlertDoneViewController") as! AlertDoneViewController
//                secondView.modalPresentationStyle = .custom
//                self.present(secondView, animated: true)
            }
            
        }
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
