//
//  RateVC.swift
//  Handsy
//
//  Created by M on 9/23/18.
//  Copyright © 2018 Ahmed Wahdan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class RateVC: UIViewController,UITableViewDelegate,UITableViewDataSource,GetRateValue {
    
    @IBOutlet weak var title_stak: UIStackView!
    @IBOutlet weak var empnew: UIView!
    
    @IBOutlet weak var bottom_Constrain: NSLayoutConstraint!
    @IBOutlet weak var sprateview: UIView!
    @IBOutlet weak var companynew: UIView!
    
 
    @IBOutlet var DoneView: UIView!
    
   
    
    
    func getRateValue(info: String, Index: Int) {
        
        QuestionArryRate.remove(at: Index)
        if(Index == 0)
        {
            QuestionArryRate.insert(info, at: (Index))
        }
        else
        {
            QuestionArryRate.insert(info, at: (Index))
            
        }
        print(QuestionArryRate)
        
    }
    
    
    
  
    
    var QuestionCounter = 0
    var http = HttpHelper()
    var QuestionArry = [QuestionRate]()
    var QuestionArryID = [String]()
    //    var QuestionArryRate = [String]()
    var ProjectID = ""
    var ratesend = [String]()
    var SumQesWRate = ""
    var Mobile = ""
    var comfromNotification = false
    
    var QuestionArryRate = [String](repeating: "0" , count: 0 )
    
    @IBOutlet weak var TableviewRate: UITableView!
    @IBOutlet weak var ContentView: UIView!
    @IBOutlet weak var lbl_CompanyName: UILabel!
    @IBOutlet weak var lbl_ProjectTitle: UILabel!
    @IBOutlet weak var lbl_EmpName: UILabel!
    @IBOutlet weak var txt_Comm: UITextField!
    @IBOutlet weak var btn_Send: UIButton!{
        didSet {
            btn_Send.layer.borderWidth = 1.0
            btn_Send.layer.cornerRadius = 6.0
        }
    }
    @IBOutlet weak var TextCommView: AMUIView!        {
        didSet {
            TextCommView.layer.borderWidth = 1.0
            TextCommView.layer.borderColor = UIColor.lightGray.cgColor
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DoneView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        view.addSubview(DoneView)
        DoneView.isHidden = true
        
        TableviewRate.dataSource = self
        TableviewRate.delegate = self
        
        if comfromNotification == true
        {
            comfromNotification = false
            loadQuestionsNotification()
        }
        else
        {
        loadQuestion()
        }
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.black
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.bordered, target: self, action: #selector(RateVC.donePicker))
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        txt_Comm.inputAccessoryView = toolBar
        
    }
    
    @objc func donePicker(){
        title_stak.isHidden = false
        empnew.isHidden = false
        companynew.isHidden = false
        sprateview.isHidden = false
        bottom_Constrain.constant = 90
        self.view.endEditing(true)
    }
    
    @IBAction func Startedit(_ sender: Any) {
        title_stak.isHidden = false
        empnew.isHidden = false
        companynew.isHidden = false
        sprateview.isHidden = false
         bottom_Constrain.constant = 300
        
        
    }
  
    
    @IBAction func DoneEnd(_ sender: Any) {
        //move to home
        if let CustmoerId = UserDefaults.standard.string(forKey: "CustmoerId") {
            if let UserId = UserDefaults.standard.string(forKey: "UserId") {
                let storyBoard : UIStoryboard = UIStoryboard(name: "NewHome", bundle:nil)
                let sub = storyBoard.instantiateViewController(withIdentifier: "NewMain") as! NewTabBarViewController
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                
                appDelegate.window?.rootViewController = sub
                
            }}
        //end
    }
    
    
    @IBAction func Dissmissdone(_ sender: Any) {
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = .lightContent
    }
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return QuestionArry.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RateTableViewCell", for: indexPath) as! RateTableViewCell
        print(QuestionArry[indexPath.row].Question)
        cell.lbl_Question.text = QuestionArry[indexPath.row].Question
        cell.index = indexPath.row
        cell.delegate = self
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 105
    }
    
    
    @IBAction func CallEmp(_ sender: Any) {
        var mobile: String = Mobile
        if mobile.count == 10 {
            if mobile.first! == "0" {
                if mobile[mobile.index(mobile.startIndex, offsetBy: 1)] == "5" {
                    mobile.remove(at: mobile.startIndex)
                    mobile.insert("6", at: mobile.startIndex)
                    mobile.insert("6", at: mobile.startIndex)
                    mobile.insert("9", at: mobile.startIndex)
                    callNumber(phoneNumber: mobile)
                } else {
                    callNumber(phoneNumber: mobile)
                }
            } else {
                callNumber(phoneNumber: mobile)
            }
        } else {
            callNumber(phoneNumber: mobile)
        }
    }
    
    
    
    private func callNumber(phoneNumber:String) {
        
        if let phoneCallURL = URL(string: "tel://\(phoneNumber)") {
            
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                application.open(phoneCallURL, options: [:], completionHandler: nil)
            }
        }
    }
    
    
    
    
    
    
    func SumRateWithId()
    {
        ratesend = []
        for item  in QuestionArryID
        {
            if(QuestionArryID.count > QuestionArryRate.count)
            {
                QuestionArryRate.append("0")
            }
            
        }
        
        for (index, element) in QuestionArryID.enumerated() {
            let str = ",\(QuestionArryRate[index]),"
            ratesend.append(element)
            ratesend.append(str)
        }
        
        print(ratesend)
        
        let characterArray = ratesend.flatMap { String.CharacterView($0) }
        //let characterArray = stringArray.flatMap { $0.characters } // also works
        var string = String(characterArray)
        string.remove(at: string.index(before: string.endIndex))
        SumQesWRate = string
        print(string)
    }
    
    @IBAction func SendRate(_ sender: Any) {
        
       SendrateApi()
    }
    
    
    func SendrateApi(){
        let comment = txt_Comm.text!
       
        let parameters = ["ProjectId":ProjectID,
                          "EvaluationMasterComment":comment,
                          "QuestionsArray":SumQesWRate
        ]
      
       
        let sv = UIViewController.displaySpinner(onView: self.view)
        
        //test
        let url = "http://smusers.promit2030.co/api/ApiService/AddCusEvaluate"/* your API url */
        
        let headers: HTTPHeaders = [
            /* "Authorization": "your_access_token",  in case you need authorization header */
            "Content-type": "multipart/form-data"
        ]
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            for (key, value) in parameters {
                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
            }
            
            
        }, usingThreshold: UInt64.init(), to: url, method: .post, headers: headers) { (result) in
            switch result{
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    print("Succesfully uploaded")
                    if let err = response.error{
                        //
                        return
                    }
                    
                    UIViewController.removeSpinner(spinner: sv)
                    
                    self.DoneView.isHidden = false
                    
                    
                }
            case .failure(let error):
                print("Error in upload: \(error.localizedDescription)")
                //               case .failure(let error):
                print(error)
                UIViewController.removeSpinner(spinner: sv)
                let alertAction = UIAlertController(title: "خطاء في الاتصال", message: "اعادة المحاولة", preferredStyle: .alert)
                
                alertAction.addAction(UIAlertAction(title: "نعم", style: .default, handler: { action in
                    self.SendrateApi()
                }))
                
                alertAction.addAction(UIAlertAction(title: "رجوع", style: .cancel, handler: { action in
                    self.navigationController!.popViewController(animated: true)
                }))
                
                self.present(alertAction, animated: true, completion: nil)
                
            }
        }
        
        
    }
    
    
    
    
    func loadQuestion(){
        let sv = UIViewController.displaySpinner(onView: self.view)
        let CustmoerId = UserDefaults.standard.string(forKey: "CustmoerId")
        self.QuestionArry.removeAll()
        Alamofire.request("http://smusers.promit2030.co/api/ApiService/CheckIsAllProjectEvaluated?CustmoerId=\(CustmoerId!)", method: .get, encoding: URLEncoding.default).responseJSON { response in
            debugPrint(response)
            switch response.result {
            case .success(let value):
                let Alljson = JSON(value)
                print(Alljson)
                let count = Alljson.dictionary
                let projectData = count!["Masterdata"]?.dictionary
                
                self.lbl_EmpName.text = projectData!["EmpName"]?.stringValue
                self.lbl_CompanyName.text = projectData!["BranchName"]?.stringValue
                self.lbl_ProjectTitle.text = projectData!["ProjectBildTypeName"]?.stringValue
                self.ProjectID = (projectData!["ProjectId"]?.stringValue)!
                self.Mobile = (projectData!["Mobile"]?.stringValue)!
                let QuestiontData = count!["DetailsData"]?.arrayValue
                for json in QuestiontData! {
                    let requestProjectObj = QuestionRate()
                    requestProjectObj.Question = json["EvaluationQuestionsName"].stringValue
                    requestProjectObj.QuestionID = json["EvaluationQuestionsID"].stringValue
                    
                    self.QuestionArry.append(requestProjectObj)
                    self.QuestionArryID.append(json["EvaluationQuestionsID"].stringValue)
                }
                self.TableviewRate.reloadData()
                self.QuestionArryRate = [String](repeating: "0" , count:  self.QuestionArryID.count )
                
                self.SumRateWithId()
                UIViewController.removeSpinner(spinner: sv)
            case .failure(let error):
                print(error)
                UIViewController.removeSpinner(spinner: sv)
                let alertAction = UIAlertController(title: "خطاء في الاتصال", message: "اعادة المحاولة", preferredStyle: .alert)
                
                alertAction.addAction(UIAlertAction(title: "نعم", style: .default, handler: { action in
                    self.loadQuestion()
                }))
                
                alertAction.addAction(UIAlertAction(title: "رجوع", style: .cancel, handler: { action in
                    self.navigationController!.popViewController(animated: true)
                }))
                
                self.present(alertAction, animated: true, completion: nil)
                
            }
        }
        
    }
    // load fron notiffication
    
    func loadQuestionsNotification(){
        let sv = UIViewController.displaySpinner(onView: self.view)
        self.QuestionArry.removeAll()
        Alamofire.request("http://smusers.promit2030.co/api/ApiService/CheckIsProjectEvaluatedById?ProjectId=\(ProjectID)", method: .get, encoding: URLEncoding.default).responseJSON { response in
            debugPrint(response)
            switch response.result {
            case .success(let value):
                let Alljson = JSON(value)
                print(Alljson)
                let count = Alljson.dictionary
                let projectData = count!["Masterdata"]?.dictionary
                
                self.lbl_EmpName.text = projectData!["EmpName"]?.stringValue
                self.lbl_CompanyName.text = projectData!["BranchName"]?.stringValue
                self.lbl_ProjectTitle.text = projectData!["ProjectBildTypeName"]?.stringValue
                self.ProjectID = (projectData!["ProjectId"]?.stringValue)!
                self.Mobile = (projectData!["Mobile"]?.stringValue)!
                let QuestiontData = count!["DetailsData"]?.arrayValue
                for json in QuestiontData! {
                    let requestProjectObj = QuestionRate()
                    requestProjectObj.Question = json["EvaluationQuestionsName"].stringValue
                    requestProjectObj.QuestionID = json["EvaluationQuestionsID"].stringValue
                    
                    self.QuestionArry.append(requestProjectObj)
                    self.QuestionArryID.append(json["EvaluationQuestionsID"].stringValue)
                }
                self.TableviewRate.reloadData()
                self.QuestionArryRate = [String](repeating: "0" , count:  self.QuestionArryID.count )
                
                self.SumRateWithId()
                UIViewController.removeSpinner(spinner: sv)
            case .failure(let error):
                print(error)
                UIViewController.removeSpinner(spinner: sv)
                let alertAction = UIAlertController(title: "خطاء في الاتصال", message: "اعادة المحاولة", preferredStyle: .alert)
                
                alertAction.addAction(UIAlertAction(title: "نعم", style: .default, handler: { action in
                    self.loadQuestion()
                }))
                
                alertAction.addAction(UIAlertAction(title: "رجوع", style: .cancel, handler: { action in
                    self.navigationController!.popViewController(animated: true)
                }))
                
                self.present(alertAction, animated: true, completion: nil)
                
            }
        }
        
    }
    
    
   
    
}

