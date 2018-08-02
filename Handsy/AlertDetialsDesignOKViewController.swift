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

    var reloadApi: reloadApi?
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
        self.reloadApi?.reload()
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
        // Do any additional setup after loading the view.
    }
    
    @objc func donePicker(){
        self.view.endEditing(true)
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func OKDesign(){
        let parameters: Parameters = [
            "designStagesID": designStagesID,
            "clientReply": ReplayTF.text,
            "status": "2"
        ]
        
        Alamofire.request("http://smusers.promit2030.com/Service1.svc/DesignStages", method: .get, parameters: parameters, encoding: URLEncoding.default).responseJSON { response in
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
    

}
