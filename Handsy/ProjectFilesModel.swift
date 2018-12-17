//
//  ProjectFilesModel.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 10/1/17.
//  Copyright © 2017 Ahmed Wahdan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

protocol ProjectFilesModelDelegate {
    func dataReady()
}

class ProjectFilesModel: NSObject {
    var resultArray = [ProjectFilesArray]()
    
    var delegate: ProjectFilesModelDelegate?
    
    func GetProjectFilesByProjectId(projectId: String, projectType: String, view: UIView){
        let sv = UIViewController.displaySpinner(onView: view)
        
        let Parameters: Parameters = [
            "ProjectId": projectId,
            "Type": projectType
        ]
        
        
        Alamofire.request("http://smusers.promit2030.co/Service1.svc/GetProjectFilesByProjectId", method: .get, parameters: Parameters, encoding: URLEncoding.default).responseJSON { response in
            debugPrint(response)
            
            
            var arrayOfResulr = [ProjectFilesArray]()
            
            
            for json in JSON(response.result.value!).arrayValue {
                let requestProjectObj = ProjectFilesArray(ProjectFileAttached: json["ProjectFileAttached"].stringValue, ProjectFileName: json["ProjectFileName"].stringValue, ProjectFileSubCategoryName: json["ProjectFileSubCategoryName"].stringValue, ComapnyName: json["ComapnyName"].stringValue, ProjectId: projectId)
                requestProjectObj.ProjectFileAttached = json["ProjectFileAttached"].stringValue
                requestProjectObj.ProjectFileName = json["ProjectFileName"].stringValue
                requestProjectObj.ProjectFileSubCategoryName = json["ProjectFileSubCategoryName"].stringValue
                requestProjectObj.ComapnyName = json["ComapnyName"].stringValue
                
                
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
