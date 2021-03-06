//
//  AlertVisitOkViewController.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 8/27/17.
//  Copyright © 2017 Ahmed Wahdan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class AlertVisitOkViewController: UIViewController {
    
    var reloadApi: reloadApi?
    @IBOutlet weak var popUpBtnOut: UIButton!{
        didSet {
            DispatchQueue.main.async {
                self.popUpBtnOut.circleView(UIColor.clear, borderWidth: 1.0)
            }
        }
    }
    
    @IBOutlet weak var popUpBtnOutOne: UIButton!{
        didSet {
            DispatchQueue.main.async {
                self.popUpBtnOutOne.circleView(UIColor.clear, borderWidth: 1.0)
            }
        }
    }
    @IBOutlet weak var alertDoneView: AMUIView!
    @IBOutlet weak var endViewOut: UIButton!{
        didSet {
            DispatchQueue.main.async {
                self.endViewOut.circleView(UIColor.clear, borderWidth: 1.0)
            }
        }
    }
    
    @IBAction func end(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        
    }
    @IBAction func Done(_ sender: UIButton) {
        OKVisit()
    }
    
    @IBAction func dismissBtn(_ sender: UIButton) {
        //        let sub = self.storyboard?.instantiateViewController(withIdentifier: "main") as! MyTabBarController
        //        self.present(sub, animated: true ,completion: nil)
      //  self.reloadApi?.reload()
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        alertDoneView.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func OKVisit(){
          let sv = UIViewController.displaySpinner(onView: self.view)
        let parameters: Parameters = [
            "meetingID": MeetingID,
            "clientReply": "موافقه",
            "status": "5"
        ]
        Alamofire.request("http://smusers.promit2030.co/Service1.svc/UpdateVisit", method: .get, parameters: parameters, encoding: URLEncoding.default).responseJSON { response in
            debugPrint(response)
            
            let json = JSON(response.result.value!)
            print(json["Result"].boolValue)
            if json["Result"].boolValue == true || json["Result"].boolValue == false {
                
                self.reloadApi?.reload()
                self.dismiss(animated: true, completion: nil)
                UIViewController.removeSpinner(spinner: sv)
                
//                let storyBoard : UIStoryboard = UIStoryboard(name: "DesignsAndDetails", bundle: nil)
//                let secondView = storyBoard.instantiateViewController(withIdentifier: "AlertDoneViewController") as! AlertDoneViewController
//                secondView.modalPresentationStyle = .custom
//                self.present(secondView, animated: true)
//                self.alertDoneView.isHidden = false
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
