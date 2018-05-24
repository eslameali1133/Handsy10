//
//  MoneyMangmentModel.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 9/18/17.
//  Copyright © 2017 Ahmed Wahdan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

protocol MoneyMangmentModelDelegate {
    func dataReady()
    
}
class MoneyMangmentModel: NSObject {
    var resultArray = [MoneyManaagmentArray]()
    
    var delegate: MoneyMangmentModelDelegate?
    
    func PaymentByCustIDAndProjectId(projectId: String){
        
        let custmoerId = UserDefaults.standard.string(forKey: "CustmoerId")!
        
        let parameters: Parameters = [
            "custmoerId": custmoerId,
            "projectId": projectId
        ]
        
        Alamofire.request("http://smusers.promit2030.com/Service1.svc/PaymentByCustIDAndProjectId", method: .get, parameters: parameters, encoding: URLEncoding.default).responseJSON { response in
            debugPrint(response)
            
            
            var arrayOfResulr = [MoneyManaagmentArray]()
            
            
            for json in JSON(response.result.value!).arrayValue {
                let moneyMangeObject = MoneyManaagmentArray(CustmoerId: json["CustmoerId"].stringValue, CustmoerName: json["CustmoerName"].stringValue, PayDate: json["PayDate"].stringValue, PayDateHijri: json["PayDateHijri"].stringValue, PayTime: json["PayTime"].stringValue, PaymentBatchStatusID: json["PaymentBatchStatusID"].stringValue, PaymentBatchStatusName: json["PaymentBatchStatusName"].stringValue, PaymentStatus: json["PaymentStatus"].stringValue, PaymentTypeName: json["PaymentTypeName"].stringValue, PaymentTypeeID: json["PaymentTypeeID"].stringValue, PaymentValue: json["PaymentValue"].stringValue, ProjectId: json["ProjectId"].stringValue, ProjectTitle: json["ProjectTitle"].stringValue, ProjectTypeName: json["ProjectTypeName"].stringValue, ProjectsOrdersId: json["ProjectsOrdersId"].stringValue, ProjectsPaymentsId: json["ProjectsPaymentsId"].stringValue, ProjectsPaymentsNumber: json["ProjectsPaymentsNumber"].stringValue, RefranceId: json["RefranceId"].stringValue, projectOrderInvoicePhotoPath: json["projectOrderInvoicePhotoPath"].stringValue)
                
                moneyMangeObject.CustmoerId = json["CustmoerId"].stringValue
                moneyMangeObject.CustmoerName = json["CustmoerName"].stringValue
                moneyMangeObject.PayDate = json["PayDate"].stringValue
                moneyMangeObject.PayDateHijri = json["PayDateHijri"].stringValue
                moneyMangeObject.PayTime = json["PayTime"].stringValue
                moneyMangeObject.PaymentBatchStatusID = json["PaymentBatchStatusID"].stringValue
                moneyMangeObject.PaymentBatchStatusName = json["PaymentBatchStatusName"].stringValue
                moneyMangeObject.PaymentStatus = json["PaymentStatus"].stringValue
                moneyMangeObject.PaymentTypeeID = json["PaymentTypeeID"].stringValue
                moneyMangeObject.PaymentTypeName = json["PaymentTypeName"].stringValue
                moneyMangeObject.PaymentValue = json["PaymentValue"].stringValue
                moneyMangeObject.ProjectId = json["ProjectId"].stringValue
                moneyMangeObject.ProjectTypeName = json["ProjectTypeName"].stringValue
                moneyMangeObject.projectOrderInvoicePhotoPath = json["projectOrderInvoicePhotoPath"].stringValue
                moneyMangeObject.ProjectsOrdersId = json["ProjectsOrdersId"].stringValue
                moneyMangeObject.ProjectsPaymentsId = json["ProjectsPaymentsId"].stringValue
                moneyMangeObject.ProjectsPaymentsNumber = json["ProjectsPaymentsNumber"].stringValue
                moneyMangeObject.RefranceId = json["RefranceId"].stringValue
                moneyMangeObject.projectOrderInvoicePhotoPath = json["projectOrderInvoicePhotoPath"].stringValue
                moneyMangeObject.ProjectTitle = json["ProjectTitle"].stringValue
                
                arrayOfResulr.append(moneyMangeObject)
            }
            
            self.resultArray = arrayOfResulr
            
            if self.delegate != nil {
                self.delegate!.dataReady()
            }
            
        }
        
        
    }
}
