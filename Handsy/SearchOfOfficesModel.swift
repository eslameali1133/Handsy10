//
//  SearchOfOfficesModel.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 3/20/18.
//  Copyright © 2018 Ahmed Wahdan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class SearchOfOfficesModel: NSObject {
    static func SearchOffices(text: String, SortBy: String, isCompany: String, view: UIView, completion: @escaping (_ results: [GetOfficesArray]) -> () ) {
        let sv = UIViewController.displaySpinner(onView: view)
        let Parameters: Parameters = [
            "isCompany": isCompany,
            "SortBy": SortBy,
            "SortExp": text
        ]
        
        Alamofire.request("http://smusers.promit2030.com/Service1.svc/GetOffices", method: .get, parameters: Parameters, encoding: URLEncoding.default).responseJSON { response in
            debugPrint(response)
            
            var arrayOfResulr = [GetOfficesArray]()
            
            for json in JSON(response.result.value!).arrayValue {
                let requestProjectObj = GetOfficesArray()
                
                requestProjectObj.CompanyInfoID = json["CompanyInfoID"].stringValue
                requestProjectObj.ComapnyName = json["ComapnyName"].stringValue
                requestProjectObj.CompanyMobile = json["CompanyMobile"].stringValue
                requestProjectObj.Street = json["Street"].stringValue
                requestProjectObj.BiuldNumber = json["BiuldNumber"].stringValue
                requestProjectObj.PostNumber = json["PostNumber"].stringValue
                requestProjectObj.PostSymbol = json["PostSymbol"].stringValue
                requestProjectObj.PostNumberWasl = json["PostNumberWasl"].stringValue
                requestProjectObj.Phone = json["Phone"].stringValue
                requestProjectObj.Fax = json["Fax"].stringValue
                requestProjectObj.Long = json["Long"].doubleValue
                requestProjectObj.Lat = json["Lat"].doubleValue
                requestProjectObj.Zoom = json["Zoom"].stringValue
                requestProjectObj.LicenceNumber = json["LicenceNumber"].stringValue
                requestProjectObj.CommercialNumber = json["CommercialNumber"].stringValue
                requestProjectObj.CompanyEmail = json["CompanyEmail"].stringValue
                requestProjectObj.IsCompany = json["IsCompany"].stringValue
                requestProjectObj.Specialty = json["Specialty"].stringValue
                requestProjectObj.IsSCE = json["IsSCE"].stringValue
                requestProjectObj.Logo = json["Logo"].stringValue
                requestProjectObj.BranchFB = json["BranchFB"].stringValue
                requestProjectObj.BranchID = json["BranchID"].stringValue
                requestProjectObj.Address = json["Address"].stringValue
                requestProjectObj.ProjCount = json["ProjCount"].stringValue
                
                arrayOfResulr.append(requestProjectObj)
            }
            completion(arrayOfResulr)
            UIViewController.removeSpinner(spinner: sv)
        }
    }
}
