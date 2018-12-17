//
//  EditContractViewController.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 7/30/18.
//  Copyright © 2018 Ahmed Wahdan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class EditContractViewController: UIViewController {
     @IBOutlet weak var Constrain_Top: NSLayoutConstraint!
    @IBOutlet weak var Comments: KMPlaceholderTextView!
    @IBOutlet weak var alertComments: UILabel!
    @IBOutlet weak var alertViewLine: UIView!
    
    @IBOutlet weak var StackCommet: UIStackView!
    @IBOutlet weak var popUpBtnOut: UIButton!{
        didSet {
            DispatchQueue.main.async {
                self.popUpBtnOut.circleView(UIColor.clear, borderWidth: 1.0)
            }
        }
    }
    
    var ProjectId = ""
    var ContractHistoryPath = ""
    var reloadApi: reloadApi?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        alertComments.isHidden = true
        StackCommet.isHidden = true
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.black
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(EditContractViewController.donePicker))
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
          Constrain_Top.constant = 142
    }
    
    @IBAction func dismissBtn(_ sender: UIButton) {
        //        let sub = self.storyboard?.instantiateViewController(withIdentifier: "main") as! MyTabBarController
        //        self.present(sub, animated: true ,completion: nil)
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func end(_ sender: UIButton) {
        if Comments.text != "" {
            AddContractHistory()
        } else {
            alertComments.isHidden = false
            StackCommet.isHidden = false
            alertViewLine.backgroundColor = #colorLiteral(red: 0.9019607843, green: 0.2980392157, blue: 0.2352941176, alpha: 1)
        }
    }
    
    func AddContractHistory() {
        let sv = UIViewController.displaySpinner(onView: self.view)
        let UserId = UserDefaults.standard.string(forKey: "UserId")!
        let ContractHistoryNote = Comments.text!
        
        let parameters: Parameters = [
            "ProjectId": ProjectId,
            "UserId": UserId,
            "ContractHistoryNote": ContractHistoryNote,
            "ContractHistoryPath": ContractHistoryPath
        ]
        
        Alamofire.request("http://smusers.promit2030.co/api/ApiService/AddContractHistory", method: .get, parameters: parameters, encoding: URLEncoding.default).responseJSON { response in
            debugPrint(response)
            
            let json = JSON(response.result.value!)
            
            print(json["Result"].boolValue)
            if json["Result"].boolValue == true || json["Result"].boolValue == false {
                 self.reloadApi?.reload()
                self.dismiss(animated: false, completion: nil)
                UIViewController.removeSpinner(spinner: sv)
               
            }
        }
    }

}
