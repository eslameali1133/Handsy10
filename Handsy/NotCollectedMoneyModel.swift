//
//  NotCollectedMoneyModel.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 9/17/17.
//  Copyright © 2017 Ahmed Wahdan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

protocol NotCollectedMoneyModelDelegate {
    func dataReady()
    
}
class NotCollectedMoneyModel: NSObject {
    var resultArray = [NotCollectedArray]()
    
    var delegate: NotCollectedMoneyModelDelegate?
    
    func GetCustomerPaymentByCustID_PaymentStatus(view: UIView, VC: UIViewController){
        let sv = UIViewController.displaySpinner(onView: view)
        let custmoerId = UserDefaults.standard.string(forKey: "CustmoerId")!
        
        let parameters: Parameters = [
            "custmoerId": custmoerId,
            "paymentStatus":"0"
        ]
        
        Alamofire.request("http://smusers.promit2030.co/Service1.svc/GetCustomerPaymentByCustID_PaymentStatus", method: .get, parameters: parameters, encoding: URLEncoding.default).responseJSON { response in
            debugPrint(response)
            
            
            var arrayOfResulr = [NotCollectedArray]()
            
            switch response.result {
            case .success:
                for json in JSON(response.result.value!).arrayValue {
                    let NotCollectedObject = NotCollectedArray(CustmoerId: json["CustmoerId"].stringValue, CustmoerName: json["CustmoerName"].stringValue, PaymentBatchStatusID: json["PaymentBatchStatusID"].stringValue, PaymentBatchStatusName: json["PaymentBatchStatusName"].stringValue, PaymentStatus: json["PaymentStatus"].stringValue, PaymentTypeName: json["PaymentTypeName"].stringValue, PaymentTypeeID: json["PaymentTypeeID"].stringValue, PaymentValue: json["PaymentValue"].stringValue, ProjectId: json["ProjectId"].stringValue, ProjectContract: json["ProjectContract"].stringValue, ProjectTitle: json["ProjectTitle"].stringValue, ProjectTypeName: json["ProjectTypeName"].stringValue, ProjectsOrdersId: json["ProjectsOrdersId"].stringValue, ProjectsPaymentsId: json["ProjectsPaymentsId"].stringValue, ProjectsPaymentsNumber: json["ProjectsPaymentsNumber"].stringValue, RefranceId: json["RefranceId"].stringValue, projectOrderInvoicePhotoPath: json["projectOrderInvoicePhotoPath"].stringValue, projectOrderContractPhotoPath: json["projectOrderContractPhotoPath"].stringValue, PayDate: json["PayDate"].stringValue, ComapnyName: json["ComapnyName"].stringValue,EmpName:json["EmpName"].stringValue ,
                                                               EmpPhone : json["EmpPhone"].stringValue
                        )
                    
                    arrayOfResulr.append(NotCollectedObject)
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
                    self.GetCustomerPaymentByCustID_PaymentStatus(view: view, VC: VC)
                }))
                
                alertAction.addAction(UIAlertAction(title: "انهاء", style: .cancel, handler: { action in
                    VC.navigationController!.popViewController(animated: true)
                }))
                
                VC.present(alertAction, animated: true, completion: nil)
                
            }
            
        }
        
        
    }
}
