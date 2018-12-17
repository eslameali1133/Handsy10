//
//  MeetingStatusModel.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 7/1/18.
//  Copyright © 2018 Ahmed Wahdan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

protocol DesignStatusModelDelegate {
    func designStatusDataReady()
}

class DesignStatusModel: NSObject {
    var designStatus = [DesignStatus]()
    
    var delegate: DesignStatusModelDelegate?
    
    func GetDesignsStatus(view: UIView, VC: UIViewController, Type: String){
        let sv = UIViewController.displaySpinner(onView: view)
        let parameters : Parameters = ["Type": Type]
        
        Alamofire.request("http://smusers.promit2030.co/Service1.svc/GetDesignsStatus", method: .get, parameters: parameters, encoding: URLEncoding.default).responseJSON { response in
            debugPrint(response)
            
            var arrayOfResulr = [DesignStatus]()
            
            switch response.result {
            case .success:
                for json in JSON(response.result.value!).arrayValue {
                    let requestProjectObj = DesignStatus()
                    requestProjectObj.DesignsTypeID = json["DesignsTypeID"].stringValue
                    requestProjectObj.DesignsTypeDetails = json["DesignsTypeDetails"].stringValue
                    arrayOfResulr.append(requestProjectObj)
                }
                
                self.designStatus = arrayOfResulr
                
                if self.delegate != nil {
                    self.delegate!.designStatusDataReady()
                    UIViewController.removeSpinner(spinner: sv)
                }
                
            case .failure(let error):
                print(error)
                UIViewController.removeSpinner(spinner: sv)
                let alertAction = UIAlertController(title: "خطاء في الاتصال", message: "اعادة المحاولة", preferredStyle: .alert)
                
                alertAction.addAction(UIAlertAction(title: "نعم", style: .default, handler: { action in
                    self.GetDesignsStatus(view: view, VC: VC, Type: Type)
                }))
                
                alertAction.addAction(UIAlertAction(title: "رجوع", style: .cancel, handler: { action in
                }))
                
                VC.present(alertAction, animated: true, completion: nil)
                
            }
            
        }
    }
}
