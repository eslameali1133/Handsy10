

import UIKit
import Alamofire
import SwiftyJSON

protocol DesigRecordModelDelegate {
    func dataReady()
}

class DesignRecordsModel: NSObject {
    var resultArrayDesign = [EditRecoredModel]()
      var resultArrayContract = [EditRecoredContractModel]()
   
    var delegate: DesigRecordModelDelegate?
    
    func GetEditReorecBrDesID(view: UIView, VC: UIViewController , DesignID: String,Condition : String){
        let sv = UIViewController.displaySpinner(onView: view)
        let custId = UserDefaults.standard.string(forKey: "CustmoerId")!
        var serviceName = ""
        var parameters : Parameters = [:]
        if Condition == "Design"
        {
        serviceName = "GetDesignsLogById"
        parameters = ["DesignStagesID": DesignID]
        }
        else
        {
            serviceName = "GetContractHistory"
            parameters = ["ProjectId": DesignID]
        }
        Alamofire.request("http://smusers.promit2030.co/api/ApiService/\(serviceName)", method: .get, parameters: parameters, encoding: URLEncoding.default).responseJSON { response in
            debugPrint(response)
            
            if Condition == "Design"
            {
                var arrayOfResulr = [EditRecoredModel]()
                switch response.result {
                case .success:
                    for json in JSON(response.result.value!).arrayValue {
                        
                        let requestProjectObj = EditRecoredModel(CreateDate: json["CreateDate"].stringValue,
                                                                 UserId:
                            json["UserId"].stringValue,
                                                                 File:
                            json["File"].stringValue,
                                                                 Details:
                            json["Details"].stringValue,
                                                                 ActionID:
                            json["ActionID"].stringValue,
                                                                 DesignStagesID:
                            json["DesignStagesID"].stringValue
                            , DesignStagesLogGUID:
                            json["DesignStagesLogGUID"].stringValue, DesignStagesLogID: json["DesignStagesLogID"].stringValue )
                        arrayOfResulr.append(requestProjectObj)
                    }
                    
                    self.resultArrayDesign = arrayOfResulr
                    
                    if self.delegate != nil {
                        self.delegate!.dataReady()
                        UIViewController.removeSpinner(spinner: sv)
                    }
                    
                case .failure(let error):
                    print(error)
                    UIViewController.removeSpinner(spinner: sv)
                    let alertAction = UIAlertController(title: "خطاء في الاتصال", message: "اعادة المحاولة", preferredStyle: .alert)
                    
                    alertAction.addAction(UIAlertAction(title: "نعم", style: .default, handler: { action in
                        self.GetEditReorecBrDesID(view: view, VC: VC,DesignID: DesignID ,Condition:  Condition)
                    }))
                    
                    alertAction.addAction(UIAlertAction(title: "رجوع", style: .cancel, handler: { action in
                        VC.navigationController!.popViewController(animated: true)
                    }))
                    
                    VC.present(alertAction, animated: true, completion: nil)
                    
                }
                //end
            }
            else
            {
                var arrayOfResulr = [EditRecoredContractModel]()
                switch response.result {
                case .success:
                    for json in JSON(response.result.value!).arrayValue {
                        
                        let requestProjectObj = EditRecoredContractModel(ContractHistoryID: json["ContractHistoryID"].stringValue,
                                                                 ContractHistoryGUID:
                            json["ContractHistoryGUID"].stringValue,
                                                                 ProjectId:
                            json["ProjectId"].stringValue,
                                                                 UserId:
                            json["UserId"].stringValue,
                                                                 ContractHistoryTitle:
                            json["ContractHistoryTitle"].stringValue,
                                                                 ContractHistoryPath:
                            json["ContractHistoryPath"].stringValue
                            , ContractHistoryNote:
                            json["ContractHistoryNote"].stringValue, ContractHistoryStatus: json["ContractHistoryStatus"].stringValue, ContractHistoryDate: json["ContractHistoryDate"].stringValue  )
                        arrayOfResulr.append(requestProjectObj)
                    }
                    
                    self.resultArrayContract = arrayOfResulr
                    
                    if self.delegate != nil {
                        self.delegate!.dataReady()
                        UIViewController.removeSpinner(spinner: sv)
                    }
                    
                case .failure(let error):
                    print(error)
                    UIViewController.removeSpinner(spinner: sv)
                    let alertAction = UIAlertController(title: "خطاء في الاتصال", message: "اعادة المحاولة", preferredStyle: .alert)
                    
                    alertAction.addAction(UIAlertAction(title: "نعم", style: .default, handler: { action in
                        self.GetEditReorecBrDesID(view: view, VC: VC,DesignID: DesignID,Condition: Condition )
                    }))
                    
                    alertAction.addAction(UIAlertAction(title: "رجوع", style: .cancel, handler: { action in
                        VC.navigationController!.popViewController(animated: true)
                    }))
                    
                    VC.present(alertAction, animated: true, completion: nil)
                    
                }
                //
            }
       
            
        }
    }
}
