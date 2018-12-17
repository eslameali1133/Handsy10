//
//  GetBranchesModel.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 11/29/17.
//  Copyright © 2017 Ahmed Wahdan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

protocol GetBranchesModelDelegate {
    func dataReady()
}

class GetBranchesModel: NSObject {
    var resultArray = [BranchesContactsArr]()
    
    var delegate: GetBranchesModelDelegate?
    
    func BranchesContacts(view: UIView, companyInfoID: String){
        let sv = UIViewController.displaySpinner(onView: view)
        let Parameters: Parameters?
        if companyInfoID == "" {
            let CompanyInfoID = UserDefaults.standard.string(forKey: "CompanyInfoID")!
        
            Parameters = [
                "companyInfoID": CompanyInfoID
            ]
        } else {
            Parameters = [
                "companyInfoID": companyInfoID
            ]
        }
        Alamofire.request("http://smusers.promit2030.co/Service1.svc/GetBranches", method: .get, parameters: Parameters, encoding: URLEncoding.default).responseJSON { response in
            debugPrint(response)
            
            
            var arrayOfResulr = [BranchesContactsArr]()
            
            
            for json in JSON(response.result.value!).arrayValue {
                let requestProjectObj = BranchesContactsArr()
                
                
                requestProjectObj.BranchID = json["BranchID"].stringValue
                requestProjectObj.BranchName = json["BranchName"].stringValue
                requestProjectObj.Lat = json["Lat"].stringValue
                requestProjectObj.Lng = json["Lng"].stringValue
                requestProjectObj.Zoom = json["Zoom"].stringValue
                requestProjectObj.BranchIsDeleted = json["BranchIsDeleted"].stringValue
                requestProjectObj.BranchLocation = json["BranchLocation"].stringValue
                requestProjectObj.BranchPhone = json["BranchPhone"].stringValue
                requestProjectObj.BranchFax = json["BranchFax"].stringValue
                requestProjectObj.BranchEmail = json["BranchEmail"].stringValue
                requestProjectObj.BranchFB = json["BranchFB"].stringValue
                
                
                
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
