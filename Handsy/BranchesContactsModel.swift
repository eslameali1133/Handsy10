//
//  BranchesContactsModel.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 8/10/17.
//  Copyright © 2017 Ahmed Wahdan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

protocol BranchesContactsModelDelegate {
    func dataReady()
}

class BranchesContactsModel: NSObject {
    var resultArray = [BranchesContactsArr]()
    
    var delegate: BranchesContactsModelDelegate?
    
    func BranchesContacts(){
        
        
        
        Alamofire.request("http://smusers.promit2030.co/Service1.svc/BranchesContacts?branchID=1", method: .get, encoding: URLEncoding.default).responseJSON { response in
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
            }
            
        }
        
        
    }

}
