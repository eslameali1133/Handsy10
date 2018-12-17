//
//  DesplayImagesModel.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 8/23/17.
//  Copyright © 2017 Ahmed Wahdan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

protocol DesplayImagesModelDelegate {
    func dataReady()
}


class DesplayImagesModel: NSObject {
    var resultArray = [DesplayImagesArray]()
    
    var delegate: DesplayImagesModelDelegate?
    
    func GetImageprojectByProjID(projectID: String, view: UIView){
        let sv = UIViewController.displaySpinner(onView: view)
        let para: Parameters = ["projectId": projectID]
        
        Alamofire.request("http://smusers.promit2030.co/Service1.svc/GetImageprojectByProjID", method: .get, parameters: para, encoding: URLEncoding.default).responseJSON { response in
            debugPrint(response)
            
            
            var arrayOfResulr = [DesplayImagesArray]()
            
            
            for json in JSON(response.result.value!).arrayValue {
                let requestProjectObj = DesplayImagesArray(ProjectsImageID: json["ProjectsImageID"].stringValue, ProjectId: json["ProjectId"].stringValue, ProjectsImagePath: json["ProjectsImagePath"].stringValue, ProjectsImageType: json["ProjectsImageType"].stringValue, ProjectsImageRotate: json["ProjectsImageRotate"].stringValue)
                
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
