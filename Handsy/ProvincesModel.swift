//
//  ProvincesModel.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 2/24/18.
//  Copyright © 2018 Ahmed Wahdan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

protocol ProvincesModelDelegate {
    func dataReady()
}

class ProvincesModel: NSObject {
    var provincesArray = [ProvincesArray]()
    
    var delegate: ProvincesModelDelegate?
    
    func GetProvincesReg(view: UIView, VC: UIViewController) {
        let sv = UIViewController.displaySpinner(onView: view)
        
        Alamofire.request("http://smusers.promit2030.co/Service1.svc/GetProvincesReg", method: .get, encoding: URLEncoding.default).responseJSON { response in
            debugPrint(response)
            
            
            var provincesOfResult = [ProvincesArray]()
            
            switch response.result {
            case .success:
                for json in JSON(response.result.value!).arrayValue {
                    let requestProjectObj = ProvincesArray()
                    requestProjectObj.ProvincesID = json["ProvincesID"].stringValue
                    requestProjectObj.ProvincesName = json["ProvincesName"].stringValue
                    provincesOfResult.append(requestProjectObj)
                }
                
                self.provincesArray = provincesOfResult
                
                if self.delegate != nil {
                    self.delegate!.dataReady()
                    UIViewController.removeSpinner(spinner: sv)
                }
                
            case .failure(let error):
                print(error)
                UIViewController.removeSpinner(spinner: sv)
                let alertAction = UIAlertController(title: "خطاء في الاتصال", message: "اعادة المحاولة", preferredStyle: .alert)
                
                alertAction.addAction(UIAlertAction(title: "نعم", style: .default, handler: { action in
                    self.GetProvincesReg(view: view, VC: VC)
                }))
                
                alertAction.addAction(UIAlertAction(title: "رجوع", style: .cancel, handler: { action in
                    VC.navigationController!.popViewController(animated: true)
                }))
                
                VC.present(alertAction, animated: true, completion: nil)
                
            }
            
        }
    }
}
