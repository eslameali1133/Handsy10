//
//  AllHomeMessageModel.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 7/5/18.
//  Copyright © 2018 Ahmed Wahdan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

protocol AllHomeMessageModelDelegate {
    func homeMessageData()
}

class AllHomeMessageModel: NSObject {
    var allHomeMessage = [AllHomeMessage]()
    
    var delegate: AllHomeMessageModelDelegate?
    
    func AllMessageListForCust(view: UIView, VC: UIViewController) {
        let sv = UIViewController.displaySpinner(onView: view)
        let CustmoerId = UserDefaults.standard.string(forKey: "CustmoerId")!
        print("cust: \(CustmoerId)")
        let parameters: Parameters = [
            "CustID": CustmoerId
        ]
        Alamofire.request("http://smusers.promit2030.com/api/ApiService/AllMessageListForCust?CustID=\(CustmoerId)", method: .post, encoding: URLEncoding.default).responseJSON { response in
            debugPrint(response)
            
            var AllHomeMessageOfResult = [AllHomeMessage]()
            
            switch response.result {
            case .success:
                for json in JSON(response.result.value!).arrayValue {
                    let AllHomeMessageObj = AllHomeMessage()
                    AllHomeMessageObj.CustmoerId = json["CustmoerId"].stringValue
                    AllHomeMessageObj.IsAllReaded = json["IsAllReaded"].stringValue
                    AllHomeMessageObj.Message = json["Message"].stringValue
                    AllHomeMessageObj.MessageTime = json["MessageTime"].stringValue
                    AllHomeMessageObj.MessageType = json["MessageType"].stringValue
                    AllHomeMessageObj.NotiCount = json["NotiCount"].stringValue
                    AllHomeMessageObj.ProjectId = json["ProjectId"].stringValue
                    AllHomeMessageObj.SenderImage = json["SenderImage"].stringValue
                    AllHomeMessageObj.SenderName = json["SenderName"].stringValue
                    AllHomeMessageOfResult.append(AllHomeMessageObj)
                }
                
                self.allHomeMessage = AllHomeMessageOfResult
                
                if self.delegate != nil {
                    self.delegate!.homeMessageData()
                    UIViewController.removeSpinner(spinner: sv)
                }
                
            case .failure(let error):
                print(error)
                UIViewController.removeSpinner(spinner: sv)
                let alertAction = UIAlertController(title: "خطاء في الاتصال", message: "اعادة المحاولة", preferredStyle: .alert)
                
                alertAction.addAction(UIAlertAction(title: "نعم", style: .default, handler: { action in
                    self.AllMessageListForCust(view: view, VC: VC)
                }))
                
                alertAction.addAction(UIAlertAction(title: "رجوع", style: .cancel, handler: { action in
                    VC.navigationController!.popViewController(animated: true)
                }))
                
                VC.present(alertAction, animated: true, completion: nil)
                
            }
            
        }
    }
}
