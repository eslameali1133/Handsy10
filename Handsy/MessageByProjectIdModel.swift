//
//  HomeMessageModel.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 7/8/18.
//  Copyright © 2018 Ahmed Wahdan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

protocol MessageByProjectIdDelegate {
    func messageByProjectIdData()
}

class MessageByProjectIdModel: NSObject {
    var messageByProjectId = [MessageByProjectId]()
    var delegate: MessageByProjectIdDelegate?
    var CompanyLogo: String = ""
    var ProjectTitle: String = ""
    var CompanyName: String = ""
    var isCompany: String = ""
    var CompanyInfoID: String = ""
    var LatBranch: Double = 0.0
    var LngBranch: Double = 0.0
    
    func messageByProjectId(view: UIView, VC: UIViewController, projectId: String) {
        let sv = UIViewController.displaySpinner(onView: view)
//        let parameters: Parameters = [
//            "ProjectId": projectId
//        ]
        Alamofire.request("http://smusers.promit2030.co/api/ApiService/AllMessageForCust?ProjectId=\(projectId)", method: .post, encoding: URLEncoding.default).responseJSON { response in
            debugPrint(response)
            
            var messageByProjectIdOfResult = [MessageByProjectId]()
            
            switch response.result {
            case .success:
                let json = JSON(response.result.value!)
                let MasterData = json["MasterData"]
                self.CompanyLogo = MasterData["CompanyLogo"].stringValue
                self.ProjectTitle = MasterData["ProjectTitle"].stringValue
                self.CompanyName = MasterData["CompanyName"].stringValue
                self.isCompany = MasterData["isCompany"].stringValue
                self.CompanyInfoID = MasterData["CompanyInfoID"].stringValue
                self.LatBranch = MasterData["LatBranch"].doubleValue
                self.LngBranch = MasterData["LngBranch"].doubleValue
                for MessagesList in json["MessagesList"].arrayValue {
                    let messageByProjectIdObj = MessageByProjectId()
                    messageByProjectIdObj.ImageName = MessagesList["ImageName"].stringValue
                    messageByProjectIdObj.ImagePath = MessagesList["ImagePath"].stringValue
                    messageByProjectIdObj.Message = MessagesList["Message"].stringValue
                    messageByProjectIdObj.MessageTime = MessagesList["MessageTime"].stringValue
                    messageByProjectIdObj.MessageType = MessagesList["MessageType"].stringValue
                    messageByProjectIdObj.SenderId = MessagesList["SenderId"].stringValue
                    messageByProjectIdObj.SenderImage = MessagesList["SenderImage"].stringValue
                    messageByProjectIdObj.SenderName = MessagesList["SenderName"].stringValue
                    messageByProjectIdObj.SenderType = MessagesList["SenderType"].stringValue
                    messageByProjectIdObj.Lat = MessagesList["Lat"].stringValue
                    messageByProjectIdObj.Lng = MessagesList["Lng"].stringValue
                    messageByProjectIdOfResult.append(messageByProjectIdObj)
                }
                
                self.messageByProjectId = messageByProjectIdOfResult
                
                if self.delegate != nil {
                    self.delegate!.messageByProjectIdData()
                    UIViewController.removeSpinner(spinner: sv)
                }
                
            case .failure(let error):
                print(error)
                UIViewController.removeSpinner(spinner: sv)
                let alertAction = UIAlertController(title: "خطاء في الاتصال", message: "اعادة المحاولة", preferredStyle: .alert)
                
                alertAction.addAction(UIAlertAction(title: "نعم", style: .default, handler: { action in
                    self.messageByProjectId(view: view, VC: VC, projectId: projectId)
                }))
                
                alertAction.addAction(UIAlertAction(title: "رجوع", style: .cancel, handler: { action in
                    VC.navigationController!.popViewController(animated: true)
                }))
                
                VC.present(alertAction, animated: true, completion: nil)
                
            }
            
        }
    }
}
