//
//  VisitsByProjectIdModel.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 1/1/18.
//  Copyright © 2018 Ahmed Wahdan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

protocol VisitsByProjectIdModelDelegate {
    func dataReady()
}
class VisitsByProjectIdModel: NSObject {
    var resultArray = [VisitsByProjectIdArray]()
    
    var delegate: VisitsByProjectIdModelDelegate?
    
    func GetMeetingByCustId(view: UIView, projectId: String, condtion: String){
        let sv = UIViewController.displaySpinner(onView: view)
        
        let parameters: Parameters = [
            "projectId": projectId
        ]
        
        if condtion == "first" {
            Alamofire.request("http://smusers.promit2030.com/Service1.svc/GetMeetingByProjectId", method: .get, parameters: parameters, encoding: URLEncoding.default).responseJSON { response in
                debugPrint(response)
                
                
                var arrayOfResulr = [VisitsByProjectIdArray]()
                
                
                for json in JSON(response.result.value!).arrayValue {
                    let requestProjectObj = VisitsByProjectIdArray(MeetingID: json["MeetingID"].stringValue, Title: json["Title"].stringValue, MeetingStatus: json["MeetingStatus"].stringValue, Description: json["Description"].stringValue, Notes: json["Notes"].stringValue, Start: json["Start"].stringValue, TimeStartMeeting: json["TimeStartMeeting"].stringValue, ProjectBildTypeName: json["ProjectBildTypeName"].stringValue, Mobile: json["Mobile"].stringValue, EmpName: json["EmpName"].stringValue, JobName: json["JobName"].stringValue, Replay: json["Replay"].stringValue, DateReply: json["DateReply"].stringValue, StartTime: json["StartTime"].stringValue, EndTime: json["EndTime"].stringValue, ComapnyName: json["ComapnyName"].stringValue, LatBranch: json["LatBranch"].doubleValue, LngBranch: json["LngBranch"].doubleValue, Address: json["Address"].stringValue, Logo: json["Logo"].stringValue)
                    
                    requestProjectObj.ComapnyName = json["ComapnyName"].stringValue
                    requestProjectObj.Address = json["Address"].stringValue
                    requestProjectObj.Logo = json["Logo"].stringValue
                    requestProjectObj.Title = json["Title"].stringValue
                    requestProjectObj.MeetingID = json["MeetingID"].stringValue
                    requestProjectObj.MeetingStatus = json["MeetingStatus"].stringValue
                    requestProjectObj.Description = json["Description"].stringValue
                    requestProjectObj.Notes = json["Notes"].stringValue
                    requestProjectObj.Start = json["Start"].stringValue
                    requestProjectObj.TimeStartMeeting = json["TimeStartMeeting"].stringValue
                    requestProjectObj.ProjectBildTypeName = json["ProjectBildTypeName"].stringValue
                    requestProjectObj.Mobile = json["Mobile"].stringValue
                    requestProjectObj.EmpName = json["EmpName"].stringValue
                    requestProjectObj.Replay = json["Replay"].stringValue
                    requestProjectObj.DateReply = json["DateReply"].stringValue
                    requestProjectObj.LatBranch = json["LatBranch"].doubleValue
                    requestProjectObj.LngBranch = json["LngBranch"].doubleValue
                    requestProjectObj.StartTime = json["StartTime"].stringValue
                    requestProjectObj.EndTime = json["EndTime"].stringValue
                    requestProjectObj.JobName = json["JobName"].stringValue
                    arrayOfResulr.append(requestProjectObj)
                }
                
                self.resultArray = arrayOfResulr
                
                if self.delegate != nil {
                    self.delegate!.dataReady()
                    UIViewController.removeSpinner(spinner: sv)
                }
                
            }
        } else {
            Alamofire.request("http://smusers.promit2030.com/Service1.svc/GetMeetingArchiveByProjectId", method: .get, parameters: parameters, encoding: URLEncoding.default).responseJSON { response in
                debugPrint(response)
                
                
                var arrayOfResulr = [VisitsByProjectIdArray]()
                
                
                for json in JSON(response.result.value!).arrayValue {
                    let requestProjectObj = VisitsByProjectIdArray(MeetingID: json["MeetingID"].stringValue, Title: json["Title"].stringValue, MeetingStatus: json["MeetingStatus"].stringValue, Description: json["Description"].stringValue, Notes: json["Notes"].stringValue, Start: json["Start"].stringValue, TimeStartMeeting: json["TimeStartMeeting"].stringValue, ProjectBildTypeName: json["ProjectBildTypeName"].stringValue, Mobile: json["Mobile"].stringValue, EmpName: json["EmpName"].stringValue, JobName: json["JobName"].stringValue, Replay: json["Replay"].stringValue, DateReply: json["DateReply"].stringValue, StartTime: json["StartTime"].stringValue, EndTime: json["EndTime"].stringValue, ComapnyName: json["ComapnyName"].stringValue, LatBranch: json["LatBranch"].doubleValue, LngBranch: json["LngBranch"].doubleValue, Address: json["Address"].stringValue, Logo: json["Logo"].stringValue)
                    
                    requestProjectObj.ComapnyName = json["ComapnyName"].stringValue
                    requestProjectObj.Address = json["Address"].stringValue
                    requestProjectObj.Logo = json["Logo"].stringValue
                    requestProjectObj.Title = json["Title"].stringValue
                    requestProjectObj.MeetingID = json["MeetingID"].stringValue
                    requestProjectObj.MeetingStatus = json["MeetingStatus"].stringValue
                    requestProjectObj.Description = json["Description"].stringValue
                    requestProjectObj.Notes = json["Notes"].stringValue
                    requestProjectObj.Start = json["Start"].stringValue
                    requestProjectObj.TimeStartMeeting = json["TimeStartMeeting"].stringValue
                    requestProjectObj.ProjectBildTypeName = json["ProjectBildTypeName"].stringValue
                    requestProjectObj.Mobile = json["Mobile"].stringValue
                    requestProjectObj.EmpName = json["EmpName"].stringValue
                    requestProjectObj.Replay = json["Replay"].stringValue
                    requestProjectObj.DateReply = json["DateReply"].stringValue
                    requestProjectObj.LatBranch = json["LatBranch"].doubleValue
                    requestProjectObj.LngBranch = json["LngBranch"].doubleValue
                    requestProjectObj.StartTime = json["StartTime"].stringValue
                    requestProjectObj.EndTime = json["EndTime"].stringValue
                    requestProjectObj.JobName = json["JobName"].stringValue
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
    
}
