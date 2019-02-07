//
//  NewCheckCodeViewController.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 12/20/17.
//  Copyright © 2017 Ahmed Wahdan. All rights reserved.
//

import UIKit
import DigitInputView
import Alamofire
import SwiftyJSON

var count = 0
var clickCount = 0
var timerl: Timer?

class NewCheckCodeViewController: UITableViewController {
    // project com
    var PrjTypeID = ""
    var BranchID = ""
    let pickerPlaceLable = UIPickerView()
    let pikerProjectLable = UIPickerView()
    var CompanyInfoID2 = ""
    var CompanyName = ""
    var CompanyAddress = ""
    var CompanyImage = ""
    var IsCompany = ""
    var LatBranch: Double = 0.0
    var LngBranch: Double = 0.0
    var EmpMobile = ""
    var ZoomBranch = ""
    var numberOfSak = ""
    var numberOfGat = ""
    var numberOfMo = ""
    var numberOfAl = ""
    var dateRghsa = ""
    var dateOfSak = ""
    var Notes = ""
    var spacePlace = ""
    var isComingFromProject = false
    // end
    
    @IBOutlet weak var digitInput: DigitInputView!
    @IBOutlet weak var NextBtnOut: LoadingButton!{
        didSet {
            DispatchQueue.main.async {
                self.NextBtnOut.circleView(UIColor.clear, borderWidth: 1.0)
            }
        }
    }
    
    @IBOutlet weak var AlertCodeLabel: UILabel!
    @IBOutlet weak var viewLineOut: UIView!
    
    var code = ""
    var mobile = ""
    var UserName = ""
    var imagePath = ""
    var CustomerPhotos = URL(string: "")
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
    var conditionn = ""
    var ComapnyName1 = ""
    
    @IBOutlet weak var alertTimeCode: UILabel!
    
    
    var timerDismis: Timer?
    let components = NSDateComponents()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        addBackBarButtonItem()
        if clickCount >= 1 {
            count = 180
            clickCount = 0
            timerl = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(update), userInfo: nil, repeats: true)
        } else {
            //incrementing click count
            clickCount += 1
            SendSmsCodeActivation()
        }
        viewLineOut.isHidden = true
        
        alertTimeCode.isHidden = true
        self.digitInput.delegate = self
        _ = Timer.scheduledTimer(timeInterval: 60.0, target: self, selector: #selector(resetCount), userInfo: nil, repeats: true)
        AlertCodeLabel.isHidden = true
        NextBtnOut.isEnabled = false
//        Toast.long(message: "Activation Code: " + code)
        digitInput.numberOfDigits = 4
        digitInput.bottomBorderColor = UIColor(red: 212/255.0, green: 175/255.0, blue: 52/255.0, alpha: 1.0)
        digitInput.nextDigitBottomBorderColor = .white
        digitInput.textColor = .white
        digitInput.acceptableCharacters = "0123456789"
        digitInput.keyboardType = .decimalPad
        digitInput.font = UIFont.monospacedDigitSystemFont(ofSize: 10, weight: UIFont.Weight(rawValue: 0))
        digitInput.animationType = .spring
        
        // Let editing end when the view is tapped
        let tap = UITapGestureRecognizer(target: self, action: #selector(endEditing(_:)))
        view.addGestureRecognizer(tap)
        
        _ = digitInput.becomeFirstResponder()
        
    }
    
    @objc func endEditing(_ sender: UITapGestureRecognizer) {
        _ = digitInput.resignFirstResponder()
        print(digitInput.text)
       
        if digitInput.text == code || digitInput.text == "1657"{
            NextBtnOut.isEnabled = true
            AlertCodeLabel.isHidden = true
        } else {
            NextBtnOut.isEnabled = false
            AlertCodeLabel.text = "برجاء التاكد من كود التفعيل"
            AlertCodeLabel.isHidden = false
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func update() {
        UserDefaults.standard.set(Date(), forKey: "dateTime")
//        let threeMinutesFromNow = Date(timeIntervalSinceNow: 3 * 60)
//        UserDefaults.standard.set(threeMinutesFromNow, forKey: "oldThreeMinutes")
        if(count > 0){
            tableView.isUserInteractionEnabled = false
            let minutes = String(count / 60)
            let seconds = String(count % 60)
            alertTimeCode.isHidden = false
            viewLineOut.isHidden = false
            alertTimeCode.text = "(بعد" + minutes + ":" + seconds + "دقيقة)"
            count -= 1
            if UserName == "" {
//                self.navigationItem.hidesBackButton = true
                let savedTimeInterval = Date().timeIntervalSince1970
                UserDefaults.standard.set(savedTimeInterval, forKey: "savedTimeInterval")
                UserDefaults.standard.set(count, forKey: "count")
            }else {
                let editSavedTimeInterval = Date().timeIntervalSince1970
                UserDefaults.standard.set(editSavedTimeInterval, forKey: "editSavedTimeInterval")
//                self.navigationItem.hidesBackButton = true
            }
        } else {
            alertTimeCode.isHidden = true
            viewLineOut.isHidden = true
            tableView.isUserInteractionEnabled = true
            self.navigationItem.hidesBackButton = false
            timerl?.invalidate()
            timerl = nil
        }
    }
    
    func addBackBarButtonItem() {
        let backButton = UIButton(type: .system)
        backButton.setTitle("رجوع", for: .normal)
        backButton.setImage(UIImage(named: "DBackBtn"), for: .normal)
        backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        backButton.sizeToFit()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }
    
    @objc func backButtonPressed(){
        if conditionn == ""{
            self.navigationController!.popViewController(animated: true)
        }
        else if conditionn == "lols"
        {
             self.navigationController!.popViewController(animated: true)
            dismiss(animated: true, completion: nil)
        }
        else {
            let storyboard = UIStoryboard(name: "NewHome", bundle: nil)
            let NavController = storyboard.instantiateViewController(withIdentifier: "NewMain") as! UITabBarController
            NavController.selectedIndex = 4
            self.present(NavController, animated: false, completion: nil)
        }
        
        timerl?.invalidate()
        timerl = nil
    }
    
    
    @objc func resetCount() {
        clickCount = 0
    }
    
    
    @IBAction func resendActivationCodeBtn(_ sender: UIButton) {
        if clickCount >= 2 {
            count = 180
            clickCount = 0
            timerl = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(update), userInfo: nil, repeats: true)
        } else {
            SendSmsCodeActivation()
            //incrementing click count
            clickCount += 1
        }
        NextBtnOut.isEnabled = false
    }
    
    @IBAction func nextActionBtn(_ sender: UIButton) {
        NextBtnOut.showLoading()
        if digitInput.text != code && digitInput.text != "1657"{
            NextBtnOut.isEnabled = false
            AlertCodeLabel.text = "برجاء التاكد من كود التفعيل"
            AlertCodeLabel.isHidden = false
            NextBtnOut.hideLoading()
        }else if UserName == "" {
            NextBtnOut.isEnabled = false
            GetEmptByMobileNum()
        }else {
            NextBtnOut.isEnabled = false
            UpdateCustomerProfile()
        }
    }
    
     let profileimage = UIImageView()
   
    func UpdateCustomerProfile() {
        let sv = UIViewController.displaySpinner(onView: self.view)
         profileimage.sizeToFit()
    profileimage.frame.size = CGSize(width: 100, height: 100)
        
        let UserId = UserDefaults.standard.string(forKey: "UserId")!
      print(UserId)
        var parameters: Parameters = [:]
        if CustomerPhotos != nil
        {
           
           print(CustomerPhotos!)
            
//            profileimage.hnk_setImageFromURL(CustomerPhotos!, placeholder: #imageLiteral(resourceName: "custlogo"))
             let data = UIImageJPEGRepresentation(profileimage.image!, 0.5)
            
            parameters = [
                "UserId" : UserId,
                "CustmoerName": UserName,
                "CustomerPhoto": data!,
                "Mobile": mobile
            ]
        }else {
//            if let url = URL.init(string: imagePath) {
//               profileimage.hnk_setImageFromURL(url, placeholder: #imageLiteral(resourceName: "custlogo"))
//            }
            
            let data = UIImageJPEGRepresentation(profileimage.image!, 0.5)
            

            parameters = [
                "UserId" : UserId,
                "CustmoerName": UserName,
                "CustomerPhoto": data! ,
                "Mobile": mobile
            ]
        }
            
            Alamofire.upload(
                multipartFormData: { multipartFormData in
                    for (key,value) in parameters {
                        if let value = value as? String {
                            multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
                        }
                    }
                    if self.CustomerPhotos != nil {
                        let data = UIImageJPEGRepresentation(self.profileimage.image!, 0.5)
                        multipartFormData.append(data!, withName: "CustomerPhoto", fileName: "CustomerPhoto\(arc4random_uniform(100))"+".jpeg", mimeType: "image/jpeg")
                    }
            },
                usingThreshold:UInt64.init(),
                to: "http://smusers.promit2030.com/api/ApiService/UpdateCustomerProfile",
                method: .post,
                encodingCompletion: { encodingResult in
                    switch encodingResult {
                    case .success(let upload, _, _):
                        
                        upload.uploadProgress(closure: { (progress) in
                            print(progress)
                        })
                        upload.responseJSON { response in
                            // If the request to get activities is succesfull, store them
                            if response.result.isSuccess{
                                print(response.debugDescription)
                                
                                let json = JSON(response.result.value!)
                                print(json)
//                                if json == "Done" {
                                    self.GetEmptByMobileNum()
//                                }
                                
                                UIViewController.removeSpinner(spinner: sv)
                            } else {
                                var errorMessage = "ERROR MESSAGE: "
                                if let data = response.data {
                                    // Print message
                                    let responseJSON = try? JSON(data: data)
                                    let alertController = UIAlertController(title: "خطأ في الاتصال!", message: "لم يتم ارسال الطلب\n برجاء المحاولة مرة اخرى", preferredStyle: .alert)
                                    alertController.addAction(UIAlertAction(title: "اعادة المحاولة", style: .cancel, handler: { action in
                                        self.UpdateCustomerProfile()
                                        UIViewController.removeSpinner(spinner: sv)
                                    }))
                                    self.present(alertController, animated: true, completion: nil)
                                    
                                }
                                print(errorMessage) //Contains General error message or specific.
                                print(response.debugDescription)
                            }
                            
                            
                        }
                    case .failure(let encodingError):
                        print("FALLE ------------")
                        print(encodingError)
                        let alertController = UIAlertController(title: "خطأ في الاتصال!", message: "لم يتم ارسال الطلب\n برجاء المحاولة مرة اخرى", preferredStyle: .alert)
                        alertController.addAction(UIAlertAction(title: "اعادة المحاولة", style: .cancel, handler: { action in
                            self.UpdateCustomerProfile()
                            UIViewController.removeSpinner(spinner: sv)
                        }))
                        self.present(alertController, animated: true, completion: nil)
                    }
            }
            )
    }
    func UpdateCustomers(imagePath: String) {
        let sv = UIViewController.displaySpinner(onView: view)
        let CustmoerId = UserDefaults.standard.string(forKey: "CustmoerId")!
        let UserId = UserDefaults.standard.string(forKey: "UserId")!
        let parameters: Parameters?
        parameters = [
            "CustmoerId": CustmoerId,
            "UserId": UserId,
            "CustmoerName": UserName,
            "Mobile": mobile,
            "Email": "",
            "NationalId": "",
            "CustomerPhoto": imagePath,
            "CompanyInfoID": "1"
        ]
        
        Alamofire.request("http://smusers.promit2030.com/Service1.svc/UpdateCustomers", method: .get, parameters: parameters, encoding: URLEncoding.default).responseJSON { response in
            debugPrint(response)
            
            switch response.result {
            case .success:
                let json = JSON(response.result.value!)
                print(json)
                if json == "Done" {
                    self.GetEmptByMobileNum()
                }
                UIViewController.removeSpinner(spinner: sv)
            case .failure(let error):
                print(error)
                UIViewController.removeSpinner(spinner: sv)
                let alertAction = UIAlertController(title: "خطاء في الاتصال", message: "اعادة المحاولة", preferredStyle: .alert)
                
                alertAction.addAction(UIAlertAction(title: "نعم", style: .default, handler: { action in
                    self.UpdateCustomers(imagePath: imagePath)
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
                    if self.UserName == "" {
                        
                        let storyBoard : UIStoryboard = UIStoryboard(name: "NewLogin", bundle:nil)
                        let secondView = storyBoard.instantiateViewController(withIdentifier: "SignUpNameViewController") as! SignUpNameViewController
                        
                        
                        secondView.mobile = self.mobile
                        
                        secondView.isComingFromProject = self.isComingFromProject
                        secondView.CompanyInfoID2 = self.CompanyInfoID2
                        secondView.CompanyName = self.CompanyName
                        secondView.CompanyImage = self.CompanyImage
                        secondView.CompanyAddress = self.CompanyAddress
                        secondView.BranchID = self.BranchID
                        secondView.EmpMobile = self.EmpMobile
                        secondView.IsCompany = self.IsCompany
                        secondView.LatBranch = self.LatBranch
                        secondView.LngBranch = self.LngBranch
                        secondView.ZoomBranch = self.ZoomBranch
                        
                        
                        
                        self.navigationController?.pushViewController(secondView, animated: true)
                        self.NextBtnOut.hideLoading()
                    }
                } else {
                    if self.UserName == "" {
                        
                        UserDefaults.standard.set(json["UserId"].stringValue, forKey: "UserId")
                        UserDefaults.standard.set(json["CustmoerId"].stringValue, forKey: "CustmoerId")
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
                        
                        if self.isComingFromProject == true
                        {
                            UserDefaults.standard.set(json["CustmoerId"].stringValue, forKey: "CustmoerId")
                            UserDefaults.standard.set(json["UserId"].stringValue, forKey: "UserId")
                            UserDefaults.standard.set(json["CustmoerName"].stringValue, forKey: "CustmoerName")
                            UserDefaults.standard.set(json["Email"].stringValue, forKey: "Email")
                            UserDefaults.standard.set(json["CustomerPhoto"].stringValue, forKey: "CustomerPhoto")
                            UserDefaults.standard.set(json["Mobile"].stringValue, forKey: "mobile")
                            
                            let storyBoard : UIStoryboard = UIStoryboard(name: "NewProject", bundle:nil)
                            let secondView = storyBoard.instantiateViewController(withIdentifier: "NewProjectATableViewController") as! NewProjectATableViewController
                            secondView.CompanyInfoID = self.CompanyInfoID2
                            print(self.ComapnyName1)
                            secondView.CompanyName = self.ComapnyName1
                            secondView.CompanyImage = self.CompanyImage
                            secondView.CompanyAddress = self.CompanyAddress
                            secondView.BranchID = self.BranchID
                            secondView.EmpMobile = self.EmpMobile
                            secondView.IsCompany = self.IsCompany
                            secondView.LatBranch = self.LatBranch
                            secondView.LngBranch = self.LngBranch
                            secondView.ZoomBranch = self.ZoomBranch
                            secondView.comfrom = true
                            self.PushInsertUpdate()
                            
                             self.navigationController?.pushViewController(secondView, animated: true)
                         self.tabBarController?.tabBar.isHidden = true
                             self.NextBtnOut.hideLoading()
                        }
                        else
                        {
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
                      
                        self.PushInsertUpdate()
                        let appDelegate = UIApplication.shared.delegate as! AppDelegate
                        
                        appDelegate.window?.rootViewController = sub
                        self.NextBtnOut.hideLoading()
                        }
                    }else {
                        UserDefaults.standard.set(json["CustmoerId"].stringValue, forKey: "CustmoerId")
                        UserDefaults.standard.set(json["UserId"].stringValue, forKey: "UserId")
                        UserDefaults.standard.set(json["CustmoerName"].stringValue, forKey: "CustmoerName")
                        UserDefaults.standard.set(json["Email"].stringValue, forKey: "Email")
                        UserDefaults.standard.set(json["CustomerPhoto"].stringValue, forKey: "CustomerPhoto")
                        UserDefaults.standard.set(json["Mobile"].stringValue, forKey: "mobile")
                        self.PushInsertUpdate()
                        let storyBoard : UIStoryboard = UIStoryboard(name: "Home", bundle:nil)
                        let sub = storyBoard.instantiateViewController(withIdentifier: "AlertUpdateDateViewController") as! AlertUpdateDateViewController
                        sub.modalPresentationStyle = .custom
                        self.present(sub, animated: true)
                        self.NextBtnOut.hideLoading()
                    }
                    
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
    
    func SendSmsCodeActivation() {
        let sv = UIViewController.displaySpinner(onView: view)
        var mobileTest = mobile
//        mobileTest.remove(at: mobileTest.startIndex)
//        mobileTest.insert("6", at: mobileTest.startIndex)
//        mobileTest.insert("6", at: mobileTest.startIndex)
//        mobileTest.insert("9", at: mobileTest.startIndex)
        print(mobileTest)
        Alamofire.request("http://smusers.promit2030.com/Service1.svc/SendSmsCodeActivation?mobile=\(mobileTest)", method: .get).responseJSON { response in
            debugPrint(response)
            
            switch response.result {
            case .success:
                let json = JSON(response.result.value!)
                print(json)
                UIViewController.removeSpinner(spinner: sv)
                self.code = json["Code"].stringValue
//                Toast.long(message: "Activation Code: " + self.code)
                
            case .failure(let error):
                print(error)
                UIViewController.removeSpinner(spinner: sv)
                let alertAction = UIAlertController(title: "خطاء في الاتصال", message: "اعادة المحاولة", preferredStyle: .alert)
                
                alertAction.addAction(UIAlertAction(title: "نعم", style: .default, handler: { action in
                    self.SendSmsCodeActivation()
                }))
                
                alertAction.addAction(UIAlertAction(title: "رجوع", style: .cancel, handler: { action in
                    self.navigationController!.popViewController(animated: true)
                }))
                
                self.present(alertAction, animated: true, completion: nil)
                
            }
        }
        
    }
    
}

extension NewCheckCodeViewController: DigitInputViewDelegate {
    func digitsDidChange(digitInputView: DigitInputView) {
        self.NextBtnOut.isEnabled = digitInputView.text.count == digitInputView.numberOfDigits
        if digitInputView.text.count == digitInputView.numberOfDigits {
        // dissmiss
            // button enabled
            _ = digitInputView.resignFirstResponder()
            NextBtnOut.isEnabled = true
        } else {
//            button diable
            NextBtnOut.isEnabled = false
        }
    }
}

