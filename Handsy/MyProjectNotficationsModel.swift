//
//  MyProjectNotficationsModel.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 3/29/18.
//  Copyright © 2018 Ahmed Wahdan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

protocol MyProjectNotficationsModelDelegate {
    func dataReady()
}

class MyProjectNotficationsModel: NSObject {
    var resultArray = [MyProjectNotfications]()
    
    var delegate: MyProjectNotficationsModelDelegate?
    
    func GetAllNotificationByProjectId(view: UIView, projectId: String, VC: UIViewController){
        let sv = UIViewController.displaySpinner(onView: view)
        
        let Parameters: Parameters = [
            "projectId": projectId
        ]
        
        Alamofire.request("http://smusers.promit2030.com/Service1.svc/GetAllNotificationByProjectId", method: .get, parameters: Parameters, encoding: URLEncoding.default).responseJSON { response in
            debugPrint(response)
            
            var arrayOfResulr = [MyProjectNotfications]()
            switch response.result {
            case .success:
                for json in JSON(response.result.value!).arrayValue {
                    let requestProjectNotficationObj = MyProjectNotfications(ComapnyName: json["ComapnyName"].stringValue, CompanyLogo: json["CompanyLogo"].stringValue, Desc: json["Desc"].stringValue, DesignStagesID: json["DesignStagesID"].stringValue, IsRead: json["IsRead"].stringValue, MeetingID: json["MeetingID"].stringValue, NotificationID: json["NotificationID"].stringValue, NotificationTypeID: json["NotificationTypeID"].stringValue, Other: json["Other"].stringValue, ProjectId: json["ProjectId"].stringValue, ProjectTitle: json["ProjectTitle"].stringValue, TimeAgo: json["TimeAgo"].stringValue, DateCreate: json["DateCreate"].stringValue, ProjectContract: json["ProjectContract"].stringValue)
                    arrayOfResulr.append(requestProjectNotficationObj)
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
                    self.GetAllNotificationByProjectId(view: view, projectId: projectId, VC: VC)
                }))
                
                alertAction.addAction(UIAlertAction(title: "رجوع", style: .cancel, handler: { action in
                    VC.navigationController!.popViewController(animated: true)
                }))
                
                VC.present(alertAction, animated: true, completion: nil)
                
            }
            
        }
        
    }
}
