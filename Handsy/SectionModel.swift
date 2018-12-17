//
//  SectionModel.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 2/24/18.
//  Copyright © 2018 Ahmed Wahdan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

protocol SectionModelDelegate {
    func addData()
}

class SectionModel: NSObject {
    var sectionArray = [SectionArray]()
    
    var delegate: SectionModelDelegate?
    
    func GetProvincesReg(view: UIView, provincesID: String, VC: UIViewController) {
        let sv = UIViewController.displaySpinner(onView: view)
        let parameters: Parameters = [
            "provincesID": provincesID
        ]
        Alamofire.request("http://smusers.promit2030.co/Service1.svc/GetSectionsReg", method: .get, parameters: parameters, encoding: URLEncoding.default).responseJSON { response in
            debugPrint(response)
            
            var SectionOfResult = [SectionArray]()
            
            switch response.result {
            case .success:
                for json in JSON(response.result.value!).arrayValue {
                    let requestProjectObj = SectionArray()
                    requestProjectObj.SectionID = json["SectionID"].stringValue
                    requestProjectObj.SectionName = json["SectionName"].stringValue
                    SectionOfResult.append(requestProjectObj)
                }
                
                self.sectionArray = SectionOfResult
                
                if self.delegate != nil {
                    self.delegate!.addData()
                    UIViewController.removeSpinner(spinner: sv)
                }
                
            case .failure(let error):
                print(error)
                UIViewController.removeSpinner(spinner: sv)
                let alertAction = UIAlertController(title: "خطاء في الاتصال", message: "اعادة المحاولة", preferredStyle: .alert)
                
                alertAction.addAction(UIAlertAction(title: "نعم", style: .default, handler: { action in
                    self.GetProvincesReg(view: view, provincesID: provincesID, VC: VC)
                }))
                
                alertAction.addAction(UIAlertAction(title: "رجوع", style: .cancel, handler: { action in
                    VC.navigationController!.popViewController(animated: true)
                }))
                
                VC.present(alertAction, animated: true, completion: nil)
                
            }
            
            
            
        }
    }
}
