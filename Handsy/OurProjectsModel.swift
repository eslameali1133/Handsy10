//
//  OurProjectsModel.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 8/9/17.
//  Copyright © 2017 Ahmed Wahdan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

protocol OurProjectsModelDelegate {
    func dataReady()
}

class OurProjectsModel: NSObject {
    var resultArray = [GetProjectGallery]()
    var CompanyresultArray = [GetAllCompanyGallery_AllArray]()
    
    var delegate: OurProjectsModelDelegate?
    
    func GetAllProjectGallery(view: UIView, companyInfoID: String){
        let sv = UIViewController.displaySpinner(onView: view)
        let Parameters: Parameters?
        var compInfoId: String?
        if companyInfoID == "" {
            let CompanyInfoID = UserDefaults.standard.string(forKey: "CompanyInfoID")!
            
            Parameters = [
                "companyInfoID": CompanyInfoID
            ]
            compInfoId = CompanyInfoID
        } else {
            Parameters = [
                "companyInfoID": companyInfoID
            ]
            compInfoId = companyInfoID
        }
        
        Alamofire.request("http://smusers.promit2030.com/Service1.svc/GetAllProjectGallery", method: .get, parameters: Parameters, encoding: URLEncoding.default).responseJSON { response in
            debugPrint(response)
            
            
            var arrayOfResulr = [GetProjectGallery]()
            
            
            for json in JSON(response.result.value!).arrayValue {
                let requestProjectObj = GetProjectGallery(ProjectGalleryName: json["ProjectGalleryName"].stringValue, ProjectGalleryPath: json["ProjectGalleryPath"].stringValue, CompanyInfoID: compInfoId!)
                
                requestProjectObj.ProjectGalleryName = json["ProjectGalleryName"].stringValue
                requestProjectObj.ProjectGalleryPath = json["ProjectGalleryPath"].stringValue
                
                
                
                arrayOfResulr.append(requestProjectObj)
            }
            
            self.resultArray = arrayOfResulr
            
            if self.delegate != nil {
                self.delegate!.dataReady()
                UIViewController.removeSpinner(spinner: sv)
            }
            
        }
    }
    
    func GetAllCompanyGallery_All(){
        
        Alamofire.request("http://smusers.promit2030.com/Service1.svc/GetAllCompanyGallery_All", method: .get).responseJSON { response in
            debugPrint(response)
            
            var arrayOfResulr = [GetAllCompanyGallery_AllArray]()
            
            
            for json in JSON(response.result.value!).arrayValue {
                let requestProjectObj = GetAllCompanyGallery_AllArray()
                
                
                requestProjectObj.CompanyGalleryName = json["CompanyGalleryName"].stringValue
                requestProjectObj.CompanyGalleryPath = json["CompanyGalleryPath"].stringValue
                
                
                arrayOfResulr.append(requestProjectObj)
            }
            
            self.CompanyresultArray = arrayOfResulr
            
            if self.delegate != nil {
                self.delegate!.dataReady()
            }
            
        }
    }
}
