//
//  AlertSignUpDoneViewController.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 8/8/17.
//  Copyright © 2017 Ahmed Wahdan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class AlertSignUpDoneViewController: UIViewController {
    
    @IBAction func logIn(_ sender: UIButton) {
        GetEmptByMobileNum()
    }
    
    func GetEmptByMobileNum() {
        let mobile = UserDefaults.standard.string(forKey: "mobile")!
        Alamofire.request("http://smusers.promit2030.co/Service1.svc/GetEmptByMobileNum?mobileNum=\(mobile)", method: .get).responseJSON { response in
            debugPrint(response)
            
            let json = JSON(response.result.value!)
            print(json)
            
            if json["Mobile"].stringValue == "" {
                
                
                
            } else {
                
                UserDefaults.standard.set(json["UserId"].stringValue, forKey: "UserId")
                UserDefaults.standard.set(json["CustmoerId"].stringValue, forKey: "CustmoerId")
                UserDefaults.standard.set(json["CustmoerName"].stringValue, forKey: "CustmoerName")
                UserDefaults.standard.set(json["Email"].stringValue, forKey: "Email")
                UserDefaults.standard.set(json["CustomerPhoto"].stringValue, forKey: "CustomerPhoto")
                UserDefaults.standard.set(json["NationalId"].stringValue, forKey: "NationalId")
                
                let storyBoard : UIStoryboard = UIStoryboard(name: "NewHome", bundle: nil)
                let sub = storyBoard.instantiateViewController(withIdentifier: "NewMyProjectsViewController") as! NewMyProjectsViewController
                let topController = UIApplication.topViewController()
                topController?.show(sub, sender: true)
                
            }
            
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
