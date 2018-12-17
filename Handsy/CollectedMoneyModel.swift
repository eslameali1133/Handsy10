//
//  CollectedModel.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 9/16/17.
//  Copyright © 2017 Ahmed Wahdan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

protocol CollectedModelDelegate {
    func dataReady()

}
class CollectedMoneyModel: NSObject {
    var resultArray = [CollectedArray]()
    
    var delegate: CollectedModelDelegate?
    
    func GetCustomerPaymentByCustID_PaymentStatus(view: UIView, VC: UIViewController){
        let sv = UIViewController.displaySpinner(onView: view)
        
        let custmoerId = UserDefaults.standard.string(forKey: "CustmoerId")!
        
        let parameters: Parameters = [
            "custmoerId": custmoerId,
            "paymentStatus":"1"
        ]
        
        Alamofire.request("http://smusers.promit2030.co/Service1.svc/GetCustomerPaymentByCustID_PaymentStatus", method: .get, parameters: parameters, encoding: URLEncoding.default).responseJSON { response in
            debugPrint(response)
            
            
            var arrayOfResulr = [CollectedArray]()
            
            switch response.result {
            case .success:
                for json in JSON(response.result.value!).arrayValue {
                    let collectedObject = CollectedArray(CustmoerId: json["CustmoerId"].stringValue, CustmoerName: json["CustmoerName"].stringValue, PaymentBatchStatusID: json["PaymentBatchStatusID"].stringValue, PaymentBatchStatusName: json["PaymentBatchStatusName"].stringValue, PaymentStatus: json["PaymentStatus"].stringValue, PaymentTypeName: json["PaymentTypeName"].stringValue, PaymentTypeeID: json["PaymentTypeeID"].stringValue, PaymentValue: json["PaymentValue"].stringValue, ProjectId: json["ProjectId"].stringValue, ProjectContract: json["ProjectContract"].stringValue, ProjectTitle: json["ProjectTitle"].stringValue, ProjectTypeName: json["ProjectTypeName"].stringValue, ProjectsOrdersId: json["ProjectsOrdersId"].stringValue, ProjectsPaymentsId: json["ProjectsPaymentsId"].stringValue, ProjectsPaymentsNumber: json["ProjectsPaymentsNumber"].stringValue, RefranceId: json["RefranceId"].stringValue, projectOrderInvoicePhotoPath: json["projectOrderInvoicePhotoPath"].stringValue, projectOrderContractPhotoPath: json["projectOrderContractPhotoPath"].stringValue, PayDate: json["PayDate"].stringValue, PayDateHijri: json["PayDateHijri"].stringValue, PayTime: json["PayTime"].stringValue, ComapnyName: json["ComapnyName"].stringValue, LatBranch: json["LatBranch"].doubleValue, LngBranch: json["LngBranch"].doubleValue,EmpPhone:json["EmpPhone"].stringValue,EmpName: json["EmpName"].stringValue)
                    
                    arrayOfResulr.append(collectedObject)
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
