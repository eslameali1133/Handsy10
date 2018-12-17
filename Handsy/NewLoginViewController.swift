//
//  NewLoginViewController.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 12/19/17.
//  Copyright © 2017 Ahmed Wahdan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class NewLoginViewController: UITableViewController, UITextFieldDelegate {
    
    // prameter sign up
    var PrjTypeID = ""
    var BranchID = ""
    let pickerPlaceLable = UIPickerView()
    let pikerProjectLable = UIPickerView()
    var CompanyInfoID = ""
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

    //
    @IBOutlet weak var flagImage: UIImageView!
    @IBOutlet weak var NextBtnOut: LoadingButton!{
        didSet {
            DispatchQueue.main.async {
                self.NextBtnOut.circleView(UIColor.clear, borderWidth: 1.0)
            }
        }
    }
    @IBOutlet weak var TextFNumber: UITextField!
    @IBOutlet weak var alertCode: UILabel!
    
    var code = ""
    
    
    var date = Date()
    
    var timerDismis: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        alertCode.isHidden = true
        NextBtnOut.isEnabled = false
        flagImage.layer.cornerRadius = 6.0
        flagImage.layer.masksToBounds = true
        TextFNumber.delegate = self
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.black
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(AlertDesignOkViewController.donePicker))
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        TextFNumber.inputAccessoryView = toolBar
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
       timerDismis = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(update), userInfo: nil, repeats: true)
    }
    
//    override func viewDidDisappear(_ animated: Bool) {
//        timerDismis?.invalidate()
//        timerDismis = nil
//    }
    
    @objc func donePicker(){
        self.view.endEditing(true)
        let mobile = TextFNumber.text!
        if mobile.count == 8 {
               NextBtnOut.isEnabled = true
//            if mobile.first! == "0" {
//                if mobile[mobile.index(mobile.startIndex, offsetBy: 1)] == "5" {
//                    NextBtnOut.isEnabled = true
//                }else {
//                    NextBtnOut.isEnabled = false
//                    alertCode.text = "من فضلك تأكد من رقم الجوال"
//                    alertCode.isHidden = false
//                }
//            }else {
//                NextBtnOut.isEnabled = false
//                alertCode.text = "من فضلك تأكد من رقم الجوال"
//                alertCode.isHidden = false
//            }
        }else {
            NextBtnOut.isEnabled = false
            alertCode.text = "من فضلك تأكد من رقم الجوال"
            alertCode.isHidden = false
        }
    }
    
    @objc func update() {
        var countt = UserDefaults.standard.integer(forKey: "count")
        if let savedTimeInterval = UserDefaults.standard.object(forKey: "savedTimeInterval") as? TimeInterval {
            let currentTimeInterval = Date().timeIntervalSince1970
            let numberOfSeconds = Int(currentTimeInterval - savedTimeInterval)
            let counterNumberOfSeconds = 180 - numberOfSeconds
            
            if numberOfSeconds > 180 {
                print("180 seconds has finished")
                countt = 180
                alertCode.isHidden = true
                tableView.isUserInteractionEnabled = true
                timerDismis?.invalidate()
                timerDismis = nil
            } else {
                print("You still need to wait another \(counterNumberOfSeconds) seconds")
                alertCode.isHidden = false
                tableView.isUserInteractionEnabled = false
                let minutes = String(counterNumberOfSeconds / 60)
                let seconds = String(counterNumberOfSeconds % 60)
                alertCode.isHidden = false
                alertCode.text = "لن يمكن تسجيل الدخول قبل " + minutes + ":" + seconds
                countt -= 1
                UserDefaults.standard.set(counterNumberOfSeconds, forKey: "count")
            }
            
        }
//        if let OldDate = UserDefaults.standard.object(forKey: "dateTime") as? Date {
//            let threeMinutesAgo = Date(timeIntervalSinceNow: -3 * 60)
//            if (OldDate) <= threeMinutesAgo {
//                countt = 180
//                alertCode.isHidden = true
//                tableView.isUserInteractionEnabled = true
//            }else {
//                if(countt > 0){
//                    alertCode.isHidden = false
//                    tableView.isUserInteractionEnabled = false
//                    let minutes = String(countt / 60)
//                    let seconds = String(countt % 60)
//                    alertCode.isHidden = false
//                    alertCode.text = "لن يمكن تسجيل الدخول قبل " + minutes + ":" + seconds
//                    countt -= 1
//                    UserDefaults.standard.set(countt, forKey: "count")
//                } else {
//                    countt = 180
//                    alertCode.isHidden = true
//                    tableView.isUserInteractionEnabled = true
//                }
//            }
//        }
        
    }
    
    func getCount() {
        let OldDate = UserDefaults.standard.object(forKey: "dateTime") as? Date
        let calendar = Calendar.current
        let OldDateHour = calendar.component(.hour, from: OldDate!)
        let OldDateMinutes = calendar.component(.minute, from: OldDate!)
        let OldDateSeconds = calendar.component(.second, from: OldDate!)
        print("hours = \(OldDateHour):\(OldDateMinutes):\(OldDateSeconds)")
        
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        let seconds = calendar.component(.second, from: date)
        print("hours = \(hour):\(minutes):\(seconds)")
        
        var devided = minutes - OldDateMinutes
        print("div: \(devided)")
        devided = devided * 60
    }
    
    @IBAction func TextFieldDidEnd(_ sender: Any) {
        print("text = \(TextFNumber.text!)")
        if validatePassword(text: TextFNumber.text!) {
            // correct password
            alertCode.isHidden = true
            if TextFNumber.text?.count == 8 {
                NextBtnOut.isEnabled = true
                self.view.endEditing(true)
            }else {
                NextBtnOut.isEnabled = false
            }
        } else {
            NextBtnOut.isEnabled = false
            alertCode.text = "من فضلك تأكد من رقم الجوال"
            alertCode.isHidden = false
        }
    }
    
    func validatePassword(text: String) -> Bool {
        var result = false
        if text.count == 1 {
            // test password
            if text.first == "0"{
                result = true
            }
        } else {
            if text.first == "0" {
                if text[text.index(text.startIndex, offsetBy: 1)] == "5" {
                    result = true
                    
                }
                
            }
        }
        
        return true
    }
    
    
    @IBAction func NextActionBtn(_ sender: UIButton) {
        NextBtnOut.showLoading()
        print("clicked")
        NextBtnOut.isEnabled = false
        let storyBoard : UIStoryboard = UIStoryboard(name: "NewLogin", bundle:nil)
        let secondView = storyBoard.instantiateViewController(withIdentifier: "NewCheckCodeViewController") as! NewCheckCodeViewController
        secondView.mobile = "05\(self.TextFNumber.text!)"
        secondView.code = self.code
        
        secondView.isComingFromProject = self.isComingFromProject
        secondView.CompanyInfoID2 = self.CompanyInfoID
        secondView.ComapnyName1 = self.CompanyName
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func SendSmsCodeActivation() {
        var mobileTest = TextFNumber.text!
        
        if mobileTest.count == 10 {
            if mobileTest.first! == "0" {
                if mobileTest[mobileTest.index(mobileTest.startIndex, offsetBy: 1)] == "5" {
//                    mobileTest.remove(at: mobileTest.startIndex)
//                    mobileTest.insert("6", at: mobileTest.startIndex)
//                    mobileTest.insert("6", at: mobileTest.startIndex)
//                    mobileTest.insert("9", at: mobileTest.startIndex)
                    print(mobileTest)
                    Alamofire.request("http://smusers.promit2030.co/Service1.svc/SendSmsCodeActivation?mobile=\(mobileTest)", method: .get).responseJSON { response in
                        debugPrint(response)
                        
                        let json = JSON(response.result.value!)
                        print(json)
                        
                        if json["Status"] == "OK" {
                            
                        }
                        self.code = json["Code"].stringValue
                        
                        let storyBoard : UIStoryboard = UIStoryboard(name: "NewLogin", bundle:nil)
                        let secondView = storyBoard.instantiateViewController(withIdentifier: "NewCheckCodeViewController") as! NewCheckCodeViewController
                        secondView.mobile = self.TextFNumber.text!
                        secondView.code = self.code
                        self.navigationController?.pushViewController(secondView, animated: true)
                        self.NextBtnOut.hideLoading()
                    }
                    
                }
            }
        }
    }
    
    
    
}
extension UIButton {
    func loadingIndicator(_ show: Bool) {
        let tag = 808404
        if show {
            self.isEnabled = false
            self.alpha = 0.5
            let indicator = UIActivityIndicatorView()
            let buttonHeight = self.bounds.size.height
            let buttonWidth = self.bounds.size.width
            indicator.center = CGPoint(x: buttonWidth/2, y: buttonHeight/2)
            indicator.tag = tag
            self.addSubview(indicator)
            indicator.startAnimating()
        } else {
            self.isEnabled = true
            self.alpha = 1.0
            if let indicator = self.viewWithTag(tag) as? UIActivityIndicatorView {
                indicator.stopAnimating()
                indicator.removeFromSuperview()
            }
        }
    }
}
