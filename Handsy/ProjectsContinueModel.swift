//
//  ProjectsContinueModel.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 8/14/17.
//  Copyright © 2017 Ahmed Wahdan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

protocol ProjectsContinueModelDelegate {
    func dataReady()
}

class ProjectsContinueModel: NSObject {
    var resultArray = [ProjectsContinue]()
    
    var delegate: ProjectsContinueModelDelegate?
    
    func GetDesignsByCustID(view: UIView, VC: UIViewController){
        let sv = UIViewController.displaySpinner(onView: view)
        let custId = UserDefaults.standard.string(forKey: "CustmoerId")!
        
        Alamofire.request("http://smusers.promit2030.com/Service1.svc/GetDesignsByCustID?custId=\(custId)", method: .get, encoding: URLEncoding.default).responseJSON { response in
            debugPrint(response)
            
            
            var arrayOfResulr = [ProjectsContinue]()
            
            switch response.result {
            case .success:
                for json in JSON(response.result.value!).arrayValue {
                    let requestProjectObj = ProjectsContinue(CreateDate: json["CreateDate"].stringValue, DesignFile: json["DesignFile"].stringValue, DesignStagesID: json["DesignStagesID"].stringValue, Details: json["Details"].stringValue, EmpName: json["EmpName"].stringValue, Mobile: json["Mobile"].stringValue, ProjectBildTypeName: json["ProjectBildTypeName"].stringValue, ProjectStatusID: json["ProjectStatusID"].stringValue, SakNum: json["SakNum"].stringValue, StagesDetailsName: json["StagesDetailsName"].stringValue, Status: json["Status"].stringValue, ClientReply: json["ClientReply"].stringValue, EmpReply: json["EmpReply"].stringValue, ComapnyName: json["ComapnyName"].stringValue, LatBranch: json["LatBranch"].doubleValue, LngBranch: json["LngBranch"].doubleValue, Address: json["Address"].stringValue, Logo: json["Logo"].stringValue)
                    
                    
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
                    self.GetDesignsByCustID(view: view, VC: VC)
                }))
                
                alertAction.addAction(UIAlertAction(title: "رجوع", style: .cancel, handler: { action in
                    VC.navigationController!.popViewController(animated: true)
                }))
                
                VC.present(alertAction, animated: true, completion: nil)
                
            }
            
        }
    }
}
