//
//  AlertDesignOkViewController.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 8/15/17.
//  Copyright © 2017 Ahmed Wahdan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class AlertDesignOkViewController: UIViewController, UITextViewDelegate {
    
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
//        let sub = self.storyboard?.instantiateViewController(withIdentifier: "main") as! MyTabBarController
//        self.present(sub, animated: true ,completion: nil)
        self.dismiss(animated: true, completion: nil)
        
    }
    @IBAction func Done(_ sender: UIButton) {
        OKDesign()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("des: \(designStagesID)")
        ReplayTF.delegate = self
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
    
    func textViewDidChange(_ textView: UITextView) {
//        performAfter(delay: 2) {
//            print("task to be done")
//            self.view.endEditing(true)
//        }
    }
    
    func performAfter(delay: TimeInterval, completion: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            completion()
        }
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
        
        Alamofire.request("http://smusers.promit2030.co/Service1.svc/DesignStages", method: .get, parameters: parameters, encoding: URLEncoding.default).responseJSON { response in
            debugPrint(response)
            
            let json = JSON(response.result.value!)
            if json == "Done" {
                let storyBoard : UIStoryboard = UIStoryboard(name: "DesignsAndDetails", bundle: nil)
                let secondView = storyBoard.instantiateViewController(withIdentifier: "AlertDoneViewController") as! AlertDoneViewController
                secondView.modalPresentationStyle = .custom
                self.present(secondView, animated: true)
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
