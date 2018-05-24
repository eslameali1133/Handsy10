//
//  APIManager.swift
//  pro2
//
//  Created by Ahmed Wahdan on 5/4/17.
//  Copyright © 2017 Ahmed Wahdan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class APIManager: NSObject {
    class func apiMultipart(_ serviceName:String,parameters: [String:Any]?, completionHandler: @escaping (JSON?, NSError?) -> ()) {
        let randomNumber = arc4random()
        Alamofire.upload(multipartFormData: { (multipartFormData:MultipartFormData) in
            for (key, value) in parameters! {
                if key == "image_person" {
                    multipartFormData.append(
                        value as! Data,
                        withName: key,
                        fileName: "Swift\(randomNumber).jpg",
                        mimeType: "image/jpg"
                    )
                } else {
                    //Data other than image
                    multipartFormData.append((value as! String).data(using: .utf8)!, withName: key)
                }
            }
        }, usingThreshold: 1, to: serviceName, method: .post) { (encodingResult:SessionManager.MultipartFormDataEncodingResult) in
            
            switch encodingResult {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    if response.result.error != nil {
                        completionHandler(nil,response.result.error as NSError?)
                        return
                    }
                    print(response.result.value!)
                    if let data = response.result.value {
                        let json = JSON(data)
                        completionHandler(json,nil)
                    }
                }
                break
                
            case .failure(let encodingError):
                print(encodingError)
                completionHandler(nil,encodingError as NSError?)
                break
            }
        }
    }
}
