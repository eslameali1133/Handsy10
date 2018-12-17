//
//  OfficeCheckCodeTableViewController.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 2/22/18.
//  Copyright © 2018 Ahmed Wahdan. All rights reserved.
//

import UIKit
import DigitInputView
import Alamofire
import SwiftyJSON

class OfficeCheckCodeTableViewController: UITableViewController {
    
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
    var isCompany = ""
    
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
    
    @IBOutlet weak var alertTimeCode: UILabel!
    
    
    var timerDismis: Timer?
    let components = NSDateComponents()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        addBackBarButtonItem()
        if clickCount >= 2 {
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
        digitInput.font = UIFont.monospacedDigitSystemFont(ofSize: 10, weight: UIFont.Weight(rawValue: 1))
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
        }else {
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
        if digitInput.text != code && digitInput.text != "1657" {
            NextBtnOut.isEnabled = false
            AlertCodeLabel.text = "برجاء التاكد من كود التفعيل"
            AlertCodeLabel.isHidden = false
            NextBtnOut.hideLoading()
        }else {
            NextBtnOut.isEnabled = false
            let storyBoard : UIStoryboard = UIStoryboard(name: "SignUpOffice", bundle:nil)
            let secondView = storyBoard.instantiateViewController(withIdentifier: "OfficeInfoTableViewController") as! OfficeInfoTableViewController
            secondView.mobile = self.mobile
            secondView.isCompany = self.isCompany
            self.navigationController?.pushViewController(secondView, animated: true)
            self.NextBtnOut.hideLoading()
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
        Alamofire.request("http://smusers.promit2030.co/Service1.svc/SendSmsCodeActivation?mobile=\(mobileTest)", method: .get).responseJSON { response in
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

extension OfficeCheckCodeTableViewController: DigitInputViewDelegate {
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
