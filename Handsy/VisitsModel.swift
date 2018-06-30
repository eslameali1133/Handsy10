//
//  VisitsModel.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 8/22/17.
//  Copyright © 2017 Ahmed Wahdan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

protocol VisitsModelDelegate {
    func dataReady()
}
class VisitsModel: NSObject {
    var resultArray = [VisitsArray]()
    
    var delegate: VisitsModelDelegate?
    
    func GetMeetingByCustId(view: UIView, VC: UIViewController, condition: String, StatusId: String){
        let sv = UIViewController.displaySpinner(onView: view)
        
        let CustmoerId = UserDefaults.standard.string(forKey: "CustmoerId")!
        var serviceName = ""
        var parameters : Parameters = [:]
        if condition == "New" {
            serviceName = "GetNewMeetingsByCustID"
            parameters = ["custId": CustmoerId]
        }else if condition == "Other" {
            serviceName = "GetOtherMeetingsByCustID"
            parameters = ["custId": CustmoerId]
        }else {
            serviceName = "GetMeetingsByCustIDAndStatus"
            parameters = ["custId": CustmoerId, "StatusId": StatusId]
        }
        
        Alamofire.request("http://smusers.promit2030.com/Service1.svc/\(serviceName)", method: .get, parameters: parameters, encoding: URLEncoding.default).responseJSON { response in
            debugPrint(response)
            
            var arrayOfResulr = [VisitsArray]()
            switch response.result {
            case .success:
                for json in JSON(response.result.value!).arrayValue {
                    let requestProjectObj = VisitsArray(MeetingID: json["MeetingID"].stringValue, Title: json["Title"].stringValue, MeetingStatus: json["MeetingStatus"].stringValue, Description: json["Description"].stringValue, Notes: json["Notes"].stringValue, Start: json["Start"].stringValue, TimeStartMeeting: json["TimeStartMeeting"].stringValue, ProjectBildTypeName: json["ProjectBildTypeName"].stringValue, Mobile: json["Mobile"].stringValue, EmpName: json["EmpName"].stringValue, Replay: json["Replay"].stringValue, DateReply: json["DateReply"].stringValue, StartTime: json["StartTime"].stringValue, EndTime: json["EndTime"].stringValue, LatBranch: json["LatBranch"].doubleValue, LngBranch: json["LngBranch"].doubleValue, ComapnyName: json["ComapnyName"].stringValue, Address: json["Address"].stringValue, Logo: json["Logo"].stringValue)
                    
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
                    self.GetMeetingByCustId(view: view, VC: VC, condition: condition, StatusId: StatusId)
                }))
                
                alertAction.addAction(UIAlertAction(title: "رجوع", style: .cancel, handler: { action in
                    VC.navigationController!.popViewController(animated: true)
                }))
                
                VC.present(alertAction, animated: true, completion: nil)
                
            }
            
        }
    }

}
