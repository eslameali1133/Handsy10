//
//  DesignByProjectIdModel.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 1/1/18.
//  Copyright © 2018 Ahmed Wahdan. All rights reserved.
//

import UIKit



import UIKit
import Alamofire
import SwiftyJSON

protocol DesignByProjectIdModelDelegate {
    func dataReady()
}

class DesignByProjectIdModel: NSObject {
    var resultArray = [DesignByProjectIdArray]()
    
    var delegate: DesignByProjectIdModelDelegate?
    
    func GetDesignsByProjectID(view: UIView, projectId: String, type: String, StatusId: String){
        let sv = UIViewController.displaySpinner(onView: view)
        var parameters: Parameters = [:]
        if type == "1" {
            parameters = [
            "projectId": projectId,
            "Type": type
            ]
        }else {
            parameters = [
            "projectId": projectId,
            "Type": type,
            "StatusId": StatusId
            ]
        }
        print(parameters)
        Alamofire.request("http://smusers.promit2030.co/Service1.svc/GetDesignsByProjectID", method: .get, parameters: parameters, encoding: URLEncoding.default).responseJSON { response in
            debugPrint(response)
            
            var arrayOfResulr = [DesignByProjectIdArray]()
            
            for json in JSON(response.result.value!).arrayValue {
                let requestProjectObj = DesignByProjectIdArray(CreateDate: json["CreateDate"].stringValue, DesignFile: json["DesignFile"].stringValue, DesignStagesID: json["DesignStagesID"].stringValue, Details: json["Details"].stringValue, EmpName: json["EmpName"].stringValue, Mobile: json["Mobile"].stringValue, ProjectBildTypeName: json["ProjectBildTypeName"].stringValue, ProjectStatusID: json["ProjectStatusID"].stringValue, SakNum: json["SakNum"].stringValue, StagesDetailsName: json["StagesDetailsName"].stringValue, Status: json["Status"].stringValue, ClientReply: json["ClientReply"].stringValue, EmpReply: json["EmpReply"].stringValue, ComapnyName: json["ComapnyName"].stringValue, LatBranch: json["LatBranch"].doubleValue, LngBranch: json["LngBranch"].doubleValue, Address: json["Address"].stringValue, Logo: json["Logo"].stringValue)
                
                requestProjectObj.CreateDate = json["CreateDate"].stringValue
                requestProjectObj.DesignFile = json["DesignFile"].stringValue
                requestProjectObj.DesignStagesID = json["DesignStagesID"].stringValue
                requestProjectObj.Details = json["Details"].stringValue
                requestProjectObj.EmpName = json["EmpName"].stringValue
                requestProjectObj.Mobile = json["Mobile"].stringValue
                requestProjectObj.ProjectBildTypeName = json["ProjectBildTypeName"].stringValue
                requestProjectObj.ProjectStatusID = json["ProjectStatusID"].stringValue
                requestProjectObj.SakNum = json["SakNum"].stringValue
                requestProjectObj.StagesDetailsName = json["StagesDetailsName"].stringValue
                requestProjectObj.Status = json["Status"].stringValue
                requestProjectObj.ClientReply = json["ClientReply"].stringValue
                requestProjectObj.EmpReply = json["EmpReply"].stringValue
                requestProjectObj.LatBranch = json["LatBranch"].doubleValue
                requestProjectObj.LngBranch = json["LngBranch"].doubleValue
                requestProjectObj.ComapnyName = json["ComapnyName"].stringValue
                requestProjectObj.Address = json["Address"].stringValue
                requestProjectObj.Logo = json["Logo"].stringValue
                
                arrayOfResulr.append(requestProjectObj)
            }
            
            self.resultArray = arrayOfResulr
            
            if self.delegate != nil {
                self.delegate!.dataReady()
                UIViewController.removeSpinner(spinner: sv)
            }
            
        }
    }
}
