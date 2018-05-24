//
//  TeamWorkModel.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 8/9/17.
//  Copyright © 2017 Ahmed Wahdan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

protocol TeamWorkModelDelegate {
    func dataReady()
}

class TeamWorkModel: NSObject {
    
    var resultArray = [GetTeamGallery]()
    
    var delegate: TeamWorkModelDelegate?
    
    func GetAllCompanyGallery(view: UIView, companyInfoID: String){
        let sv = UIViewController.displaySpinner(onView: view)
        let Parameters: Parameters?
        var CompInfID: String?
        if companyInfoID == "" {
            let CompanyInfoID = UserDefaults.standard.string(forKey: "CompanyInfoID")!
            Parameters = [
                "companyInfoID": CompanyInfoID
            ]
            CompInfID = CompanyInfoID
        } else {
            Parameters = [
                "companyInfoID": companyInfoID
            ]
            CompInfID = companyInfoID
        }
        
        Alamofire.request("http://smusers.promit2030.com/Service1.svc/GetAllCompanyGallery", method: .get, parameters: Parameters, encoding: URLEncoding.default).responseJSON { response in
            debugPrint(response)
            
            
            var arrayOfResulr = [GetTeamGallery]()
            
            
            for json in JSON(response.result.value!).arrayValue {
                let requestProjectObj = GetTeamGallery(CompanyInfoID: CompInfID!, CompanyGalleryName: json["CompanyGalleryName"].stringValue, CompanyGalleryPath: json["CompanyGalleryPath"].stringValue)
                
                
                requestProjectObj.CompanyGalleryName = json["CompanyGalleryName"].stringValue
                requestProjectObj.CompanyGalleryPath = json["CompanyGalleryPath"].stringValue
            
                
                
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
