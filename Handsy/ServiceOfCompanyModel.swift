//
//  ServiceOfCompanyModel.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 8/19/17.
//  Copyright © 2017 Ahmed Wahdan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

protocol ServiceOfCompanyModelDelegate {
    func dataReady()
}

class ServiceOfCompanyModel: NSObject {
    var resultArray = [ArrayServiceOfCompany]()
    
    var delegate: ServiceOfCompanyModelDelegate?
    
    func GetServices(view: UIView, VC: UIViewController,CompanyInfoID : String){
       var CompanyInfoIDSecond = ""
        let sv = UIViewController.displaySpinner(onView: view)
         let parameters: Parameters?
       
            CompanyInfoIDSecond = CompanyInfoID
            parameters = [
                "CompanyInfoID": CompanyInfoID
            ]
           
        
        
       print(CompanyInfoIDSecond)
        
        print(parameters)
        Alamofire.request("http://smusers.promit2030.co/Service1.svc/GetServices", method: .get, parameters: parameters, encoding: URLEncoding.default).responseJSON { response in
            debugPrint(response)
            
            
            var arrayOfResulr = [ArrayServiceOfCompany]()
           
          
            switch response.result {
            case .success:
                for json in JSON(response.result.value!).arrayValue {
                    let requestProjectObj = ArrayServiceOfCompany(serviceName: json["ServiceName"].stringValue, content: json["Content"].stringValue, CompanyInfoID: CompanyInfoIDSecond)
                    
                    
                    requestProjectObj.serviceName = json["ServiceName"].stringValue
                    requestProjectObj.content = json["Content"].stringValue
                    
                    
                    
                    arrayOfResulr.append(requestProjectObj)
                }
                
                self.resultArray = arrayOfResulr
                
                if self.delegate != nil {
                    self.delegate!.dataReady()
                    UIViewController.removeSpinner(spinner: sv)
                }
                
            case .failure(let error):
                print(error)
                UIViewController.removeSpinner(spinner: sv)
                let alertAction = UIAlertController(title: "خطاء في الاتصال", message: "اعادة المحاولة", preferredStyle: .alert)
                
                alertAction.addAction(UIAlertAction(title: "نعم", style: .default, handler: { action in
                    self.GetServices(view: view, VC: VC, CompanyInfoID: CompanyInfoID)
                }))
                
                alertAction.addAction(UIAlertAction(title: "رجوع", style: .cancel, handler: { action in
                    VC.navigationController!.popViewController(animated: true)
                }))
                
                VC.present(alertAction, animated: true, completion: nil)
                
            }
            
        }
        
    }
}
