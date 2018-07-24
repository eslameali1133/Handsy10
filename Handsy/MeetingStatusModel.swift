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

protocol MeetingStatusModelDelegate {
    func meetingStatusDataReady()
}

class MeetingStatusModel: NSObject {
    var meetingStatus = [MeetingStatus]()
    
    var delegate: MeetingStatusModelDelegate?
    
    func GetMeetingsStatus(view: UIView, VC: UIViewController, Type: String){
        let sv = UIViewController.displaySpinner(onView: view)
        let parameters : Parameters = ["Type": Type]
        
        Alamofire.request("http://smusers.promit2030.com/Service1.svc/GetMeetingsStatus", method: .get, parameters: parameters, encoding: URLEncoding.default).responseJSON { response in
            debugPrint(response)
            
            var arrayOfResulr = [MeetingStatus]()
            
            switch response.result {
            case .success:
                for json in JSON(response.result.value!).arrayValue {
                    let requestProjectObj = MeetingStatus()
                    requestProjectObj.MeetingTypeID = json["MeetingTypeID"].stringValue
                    requestProjectObj.MeetingTypeDetails = json["MeetingTypeDetails"].stringValue
                    arrayOfResulr.append(requestProjectObj)
                }
                
                self.meetingStatus = arrayOfResulr
                
                if self.delegate != nil {
                    self.delegate!.meetingStatusDataReady()
                    UIViewController.removeSpinner(spinner: sv)
                }
                
            case .failure(let error):
                print(error)
                UIViewController.removeSpinner(spinner: sv)
                let alertAction = UIAlertController(title: "خطاء في الاتصال", message: "اعادة المحاولة", preferredStyle: .alert)
                
                alertAction.addAction(UIAlertAction(title: "نعم", style: .default, handler: { action in
                    self.GetMeetingsStatus(view: view, VC: VC, Type: Type)
                }))
                
                alertAction.addAction(UIAlertAction(title: "رجوع", style: .cancel, handler: { action in
                }))
                
                VC.present(alertAction, animated: true, completion: nil)
                
            }
            
        }
    }
}
