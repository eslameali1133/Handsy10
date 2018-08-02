//
//  SignUpNameViewController.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 12/20/17.
//  Copyright © 2017 Ahmed Wahdan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class SignUpNameViewController: UITableViewController, UITextFieldDelegate {
    @IBOutlet weak var FirstNameTF: UITextField!
    @IBOutlet weak var LastNameTF: UITextField!
    
    @IBOutlet weak var NextBtnOut: LoadingButton!{
        didSet {
            DispatchQueue.main.async {
                self.NextBtnOut.circleView(UIColor.clear, borderWidth: 1.0)
            }
        }
    }
    
    @IBOutlet weak var AlertLabel: UILabel!
    
    
    var mobile = ""
    var userId = ""
    var customerId = ""
    var customerName = ""
    var email = ""
    var customerPhoto = ""
    var nationalId = ""
    var CompanyInfoID = ""
    var ComapnyName = ""
    var SectionID = ""
    var SectionName = ""
    var AreaID = ""
    var AreaName = ""
    var ProvincesID = ""
    var ProvincesName = ""
    var CountryID = ""
    var CountryName = ""
    var condition = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AlertLabel.isHidden = true
        NextBtnOut.isEnabled = false
        FirstNameTF.delegate = self
        LastNameTF.delegate = self
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func TextFieldAct(_ sender: UITextField) {
        if validatePassword(text: FirstNameTF.text!) && validatePassword(text: LastNameTF.text!)  {
                NextBtnOut.isEnabled = true
            AlertLabel.isHidden = true
        }else {
            NextBtnOut.isEnabled = false
            AlertLabel.text = "فضلا ادخل اسمك"
            AlertLabel.isHidden = false
        }
    }
    @IBAction func LastNameTxtFAction(_ sender: UITextField) {
        if validatePassword(text: LastNameTF.text!) && validatePassword(text: FirstNameTF.text!) {
            NextBtnOut.isEnabled = true
            AlertLabel.isHidden = true
        }else {
            NextBtnOut.isEnabled = false
            AlertLabel.text = "فضلا ادخل اسمك"
            AlertLabel.isHidden = false
        }
    }
    
    
    func validatePassword(text: String) -> Bool {
        var result = false
        let whitespaceSet = CharacterSet.whitespaces
        if !text.trimmingCharacters(in: whitespaceSet).isEmpty {
            result = true
        }
        return result
    }
    
    
    @IBAction func SignUpActionBtn(_ sender: UIButton) {
        NextBtnOut.showLoading()
        NextBtnOut.isEnabled = false
        RegCustomers()
    }
    
    
    func RegCustomers() {
        let sv = UIViewController.displaySpinner(onView: view)
        tableView.isUserInteractionEnabled = false
        let Name = FirstNameTF.text! + LastNameTF.text!
        let mobile = self.mobile
        let NatId = ""
        let parameters: Parameters = [
            "CustmoerName": Name,
            "Mobile": mobile,
            "companyInfoID": "1"
        ]
        Alamofire.request("http://smusers.promit2030.com/Service1.svc/RegCustomers", method: .get, parameters: parameters, encoding: URLEncoding.default).responseJSON { response in
            debugPrint(response)
            switch response.result {
            case .success:
                let json = JSON(response.result.value!)
                print(json)
                let result = json["result"].stringValue
                let CustmoerId = json["CustmoerId"].stringValue
                let CompanyInfoID = json["CompanyInfoID"].stringValue
                if result == "Done"{
                    print("Done")
                    UserDefaults.standard.set(CustmoerId, forKey: "CustmoerId")
                    UserDefaults.standard.set(CompanyInfoID, forKey: "CompanyInfoID")
                    self.GetEmptByMobileNum()
                }
                UIViewController.removeSpinner(spinner: sv)
            case .failure(let error):
                print(error)
                UIViewController.removeSpinner(spinner: sv)
                let alertAction = UIAlertController(title: "خطاء في الاتصال", message: "اعادة المحاولة", preferredStyle: .alert)
                
                alertAction.addAction(UIAlertAction(title: "نعم", style: .default, handler: { action in
                    self.RegCustomers()
                }))
                
                alertAction.addAction(UIAlertAction(title: "رجوع", style: .cancel, handler: { action in
                    self.navigationController!.popViewController(animated: true)
                }))
                
                self.present(alertAction, animated: true, completion: nil)
                
            }
        }
        
    }
    
    func GetEmptByMobileNum() {
        let sv = UIViewController.displaySpinner(onView: view)
        Alamofire.request("http://smusers.promit2030.com/Service1.svc/GetEmptByMobileNum?mobileNum=\(mobile)", method: .get).responseJSON { response in
            debugPrint(response)
            switch response.result {
            case .success:
                let json = JSON(response.result.value!)
                print(json)
                
                if json["Mobile"].stringValue == "" {
                    self.tableView.isUserInteractionEnabled = true
                } else {
                    let storyBoard : UIStoryboard = UIStoryboard(name: "NewHome", bundle:nil)
                    let sub = storyBoard.instantiateViewController(withIdentifier: "NewMain") as! NewTabBarViewController
                    self.userId = json["UserId"].stringValue
                    self.customerId = json["CustmoerId"].stringValue
                    self.customerName = json["CustmoerName"].stringValue
                    self.mobile = json["Mobile"].stringValue
                    self.email = json["Email"].stringValue
                    self.customerPhoto = json["CustomerPhoto"].stringValue
                    self.nationalId = json["NationalId"].stringValue
                    self.CompanyInfoID = json["CompanyInfoID"].stringValue
                    self.ComapnyName = json["ComapnyName"].stringValue
                    self.SectionID = json["SectionID"].stringValue
                    self.SectionName = json["SectionName"].stringValue
                    self.AreaID = json["AreaID"].stringValue
                    self.AreaName = json["AreaName"].stringValue
                    self.ProvincesID = json["ProvincesID"].stringValue
                    self.ProvincesName = json["ProvincesName"].stringValue
                    self.CountryID = json["CountryID"].stringValue
                    self.CountryName = json["CountryName"].stringValue
                    UserDefaults.standard.set(self.userId, forKey: "UserId")
                    UserDefaults.standard.set(self.customerId, forKey: "CustmoerId")
                    UserDefaults.standard.set(self.customerName, forKey: "CustmoerName")
                    UserDefaults.standard.set(self.mobile,forKey: "mobile")
                    UserDefaults.standard.set(self.email, forKey: "Email")
                    UserDefaults.standard.set(self.customerPhoto, forKey: "CustomerPhoto")
                    UserDefaults.standard.set(self.nationalId, forKey: "NationalId")
                    UserDefaults.standard.set(self.CompanyInfoID, forKey: "CompanyInfoID")
                    UserDefaults.standard.set(self.ComapnyName, forKey: "ComapnyName")
                    UserDefaults.standard.set(self.SectionID, forKey: "SectionID")
                    UserDefaults.standard.set(self.SectionName,forKey: "SectionName")
                    UserDefaults.standard.set(self.AreaID, forKey: "AreaID")
                    UserDefaults.standard.set(self.AreaName, forKey: "AreaName")
                    UserDefaults.standard.set(self.ProvincesID, forKey: "ProvincesID")
                    UserDefaults.standard.set(self.ProvincesName, forKey: "ProvincesName")
                    UserDefaults.standard.set(self.CountryID, forKey: "CountryID")
                    UserDefaults.standard.set(self.CountryName, forKey: "CountryName")
                    self.PushInsertUpdate()
                    
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    
                    appDelegate.window?.rootViewController = sub
                    self.NextBtnOut.hideLoading()
                }
                UIViewController.removeSpinner(spinner: sv)
            case .failure(let error):
                print(error)
                UIViewController.removeSpinner(spinner: sv)
                let alertAction = UIAlertController(title: "خطاء في الاتصال", message: "اعادة المحاولة", preferredStyle: .alert)
                
                alertAction.addAction(UIAlertAction(title: "نعم", style: .default, handler: { action in
                    self.GetEmptByMobileNum()
                }))
                
                alertAction.addAction(UIAlertAction(title: "رجوع", style: .cancel, handler: { action in
                    self.navigationController!.popViewController(animated: true)
                }))
                
                self.present(alertAction, animated: true, completion: nil)
                
            }
            
        }
        
    }
    
    func PushInsertUpdate(){
        let sv = UIViewController.displaySpinner(onView: view)
        let CustmoerId = UserDefaults.standard.string(forKey: "CustmoerId")!
        let DeviceToken = UserDefaults.standard.string(forKey: "token")!
        let DeviceID = UserDefaults.standard.string(forKey: "udidKey")!
        let parameters: Parameters = [
            "CustmoerId":CustmoerId,
            "DeviceToken":DeviceToken,
            "TypeDevice":"1",
            "DeviceID":DeviceID
        ]
        
        Alamofire.request("http://smusers.promit2030.com/Service1.svc/PushInsertUpdate", method: .get, parameters: parameters, encoding: URLEncoding.default).responseJSON { response in
            switch response.result {
            case .success:
                let json = JSON(response.result.value!)
                print(json)
                UIViewController.removeSpinner(spinner: sv)
            case .failure(let error):
                print(error)
                UIViewController.removeSpinner(spinner: sv)
                let alertAction = UIAlertController(title: "خطاء في الاتصال", message: "اعادة المحاولة", preferredStyle: .alert)
                
                alertAction.addAction(UIAlertAction(title: "نعم", style: .default, handler: { action in
                    self.PushInsertUpdate()
                }))
                
                alertAction.addAction(UIAlertAction(title: "رجوع", style: .cancel, handler: { action in
                    self.navigationController!.popViewController(animated: true)
                }))
                
                self.present(alertAction, animated: true, completion: nil)
                
            }
            
        }
    }
    
}
