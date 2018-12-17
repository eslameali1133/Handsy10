//
//  RateApi.swift
//  Handsy
//
//  Created by M on 9/26/18.
//  Copyright © 2018  Eslam Ali. All rights reserved.
//



import UIKit
import Alamofire
import SwiftyJSON
class HttpApi: NSObject {
    class func CheckRate(Cus_ID:String , completion: @escaping (_ error: Error?, _ success: Bool , _ Checkbool: Bool?)->Void)  {
        let url = "http://smusers.promit2030.co/api/ApiService/CheckIsAllProjectEvaluated?CustmoerId=\(Cus_ID)"
        print(Cus_ID)
        Alamofire.request(url, method: .get, parameters:nil, encoding: URLEncoding.default, headers: nil)
            
            .responseJSON { response in
                
                switch response.result
                {
                case .failure(let error):
                    completion(error, false ,nil)
                    print("///////////////////////////////////////////////////////",error)
                case .success(let value):
                    let json = JSON(value)
                    print(json)
                    guard let count = json.dictionary
                        else {
                            completion(nil, false ,nil)
                            return
                    }
                    guard let projectData = count["Masterdata"]?.dictionary
                        else {
                            completion(nil, false ,nil)
                            return
                    }
                    
                    let Countpro = projectData["ProjUnEvaluatiedCount"]?.stringValue
                   
                    if(Countpro == "0")
                   {
                    completion(nil,true , false)
                    
                   }else{
                    completion(nil,true ,true)
                    }
                }
                //completion(nil, tasks, last_page)
        }
        
    }
    
    
    
}


