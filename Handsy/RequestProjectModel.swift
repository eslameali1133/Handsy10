//
//  RequestProjectModel.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 8/2/17.
//  Copyright © 2017 Ahmed Wahdan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

protocol RequestProjectModelDelegate {
    func dataReady()
}

class RequestProjectModel: NSObject {
    
    var resultArray = [GetProjectEngCustByCustID]()
    
    var delegate: RequestProjectModelDelegate?
    
    func GetProjectByCustID(view: UIView, VC: UIViewController){
        let sv = UIViewController.displaySpinner(onView: view)
        //        let id = UserDefaults.standard.string(forKey: "account_id")!
        //        let account_type = UserDefaults.standard.string(forKey: "account_type")!
        
        
        let Parameters: Parameters = [
            "CustmoerId": UserDefaults.standard.string(forKey: "CustmoerId")!
        ]
        
        
        Alamofire.request("http://smusers.promit2030.com/Service1.svc/GetProjectByCustID", method: .get, parameters: Parameters, encoding: URLEncoding.default).responseJSON { response in
            debugPrint(response)
            
            
            var arrayOfResulr = [GetProjectEngCustByCustID]()
            
            switch response.result {
            case .success:
                for json in JSON(response.result.value!).arrayValue {
                    let requestProjectObj = GetProjectEngCustByCustID(BranchID: json["BranchID"].stringValue, BranchName: json["BranchName"].stringValue, CustmoerName: json["CustmoerName"].stringValue, CustomerEmail: json["CustomerEmail"].stringValue, CustomerMobile: json["CustomerMobile"].stringValue, CustomerNationalId: json["CustomerNationalId"].stringValue, DataSake: json["DataSake"].stringValue, DateLicence: json["DateLicence"].stringValue, EmpImage: json["EmpImage"].stringValue, EmpMobile: json["EmpMobile"].stringValue, EmpName: json["EmpName"].stringValue, GroundId: json["GroundId"].stringValue, IsDeleted: json["IsDeleted"].stringValue, JobName: json["JobName"].stringValue, LatBranch: json["LatBranch"].doubleValue, LatPrj: json["LatPrj"].stringValue, LicenceNum: json["LicenceNum"].stringValue, LngBranch: json["LngBranch"].doubleValue, LngPrj: json["LngPrj"].stringValue, Notes: json["Notes"].stringValue, PlanId: json["PlanId"].stringValue, ProjectBildTypeId: json["ProjectBildTypeId"].stringValue, ProjectEngComment: json["ProjectEngComment"].stringValue, ProjectId: json["ProjectId"].stringValue, ProjectStatusColor: json["ProjectStatusColor"].stringValue, ProjectStatusID: json["ProjectStatusID"].stringValue, ProjectStatusName: json["ProjectStatusName"].stringValue, ProjectTitle: json["ProjectTitle"].stringValue, ProjectTypeId: json["ProjectTypeId"].stringValue, ProjectTypeName: json["ProjectTypeName"].stringValue, SakNum: json["SakNum"].stringValue, Space: json["Space"].stringValue, Status: json["Status"].stringValue, ZoomBranch: json["ZoomBranch"].stringValue, ZoomPrj: json["ZoomPrj"].stringValue, ComapnyName: json["ComapnyName"].stringValue, Address: json["Address"].stringValue, Logo: json["Logo"].stringValue, ProjectBildTypeNum: json["ProjectBildTypeNum"].stringValue, DateRegister: json["DateRegister"].stringValue, CompanyInfoID: json["CompanyInfoID"].stringValue, IsCompany: json["IsCompany"].stringValue, NotifiCount: json["NotifiCount"].intValue, ProjectLastComment: json["ProjectLastComment"].stringValue, ProjectLastTpye: json["ProjectLastTpye"].stringValue, ProjectCommentOther: json["ProjectCommentOther"].stringValue, LastDesignStagesID: json["LastDesignStagesID"].stringValue, LastMeetingID: json["LastMeetingID"].stringValue)
                    
//                    requestProjectObj.ProjectId = json["ProjectId"].stringValue
//                    requestProjectObj.EmpImage = json["EmpImage"].stringValue
//                    requestProjectObj.BranchID = json["BranchID"].stringValue
//                    requestProjectObj.BranchName  = json["BranchName"].stringValue
//                    requestProjectObj.CustmoerName = json["CustmoerName"].stringValue
//                    requestProjectObj.CustomerEmail = json["CustomerEmail"].stringValue
//                    requestProjectObj.CustomerMobile = json["CustomerMobile"].stringValue
//                    requestProjectObj.CustomerNationalId = json["CustomerNationalId"].stringValue
//                    requestProjectObj.DataSake = json["DataSake"].stringValue
//                    requestProjectObj.DateLicence = json["DateLicence"].stringValue
//                    requestProjectObj.EmpMobile = json["EmpMobile"].stringValue
//                    requestProjectObj.EmpName = json["EmpName"].stringValue
//                    requestProjectObj.GroundId = json["GroundId"].stringValue
//                    requestProjectObj.IsDeleted = json["IsDeleted"].stringValue
//                    requestProjectObj.JobName = json["JobName"].stringValue
//                    requestProjectObj.LatBranch = json["LatBranch"].doubleValue
//                    requestProjectObj.LatPrj = json["LatPrj"].stringValue
//                    requestProjectObj.LicenceNum = json["LicenceNum"].stringValue
//                    requestProjectObj.LngBranch = json["LngBranch"].doubleValue
//                    requestProjectObj.LngPrj = json["LngPrj"].stringValue
//                    requestProjectObj.Notes = json["Notes"].stringValue
//                    requestProjectObj.PlanId = json["PlanId"].stringValue
//                    requestProjectObj.ProjectBildTypeId = json["ProjectBildTypeId"].stringValue
//                    requestProjectObj.ProjectEngComment = json["ProjectEngComment"].stringValue
//                    requestProjectObj.ProjectStatusColor = json["ProjectStatusColor"].stringValue
//                    requestProjectObj.ProjectStatusID = json["ProjectStatusID"].stringValue
//                    requestProjectObj.ProjectStatusName = json["ProjectStatusName"].stringValue
//                    requestProjectObj.ProjectTitle = json["ProjectTitle"].stringValue
//                    requestProjectObj.ProjectTypeId = json["ProjectTypeId"].stringValue
//                    requestProjectObj.ProjectTypeName = json["ProjectTypeName"].stringValue
//                    requestProjectObj.SakNum = json["SakNum"].stringValue
//                    requestProjectObj.Space = json["Space"].stringValue
//                    requestProjectObj.Status = json["Status"].stringValue
//                    requestProjectObj.ZoomBranch = json["ZoomBranch"].stringValue
//                    requestProjectObj.ZoomPrj = json["ZoomPrj"].stringValue
//                    requestProjectObj.ComapnyName = json["ComapnyName"].stringValue
//                    requestProjectObj.Address = json["Address"].stringValue
//                    requestProjectObj.Logo = json["Logo"].stringValue
//                    requestProjectObj.ProjectBildTypeNum = json["ProjectBildTypeNum"].stringValue
//                    requestProjectObj.DateRegister = json["DateRegister"].stringValue
//                    requestProjectObj.CompanyInfoID = json["CompanyInfoID"].stringValue
//                    requestProjectObj.IsCompany = json["IsCompany"].stringValue
//                    requestProjectObj.NotifiCount = json["NotifiCount"].intValue
                    
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
                    self.GetProjectByCustID(view: view, VC: VC)
                }))
                
                alertAction.addAction(UIAlertAction(title: "رجوع", style: .cancel, handler: { action in
                    VC.navigationController!.popViewController(animated: true)
                }))
                
                VC.present(alertAction, animated: true, completion: nil)
                
            }
        }
    }
}

