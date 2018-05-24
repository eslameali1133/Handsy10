//
//  OneViewController.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 7/24/17.
//  Copyright © 2017 Ahmed Wahdan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class OneViewController: UIViewController {
    
    @IBAction func LogOut(_ sender: UIButton) {
        let alert = UIAlertController(title: "تنبيه", message: "هل تريد تسجيل الخروج", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "نعم", style: .default, handler: { action in
            _ = UserDefaults.standard.removeObject(forKey: "CustmoerId")
            _ = UserDefaults.standard.removeObject(forKey: "UserId")
            _ = UserDefaults.standard.removeObject(forKey: "name")
            _ = UserDefaults.standard.removeObject(forKey: "mobile")
            _ = UserDefaults.standard.removeObject(forKey: "email")
            _ = UserDefaults.standard.removeObject(forKey: "nationalId")
            _ = UserDefaults.standard.removeObject(forKey: "CustomerPhoto")
//            let domain = Bundle.main.bundleIdentifier!
//            UserDefaults.standard.removePersistentDomain(forName: domain)
//            UserDefaults.standard.synchronize()
            
            let storyboard = UIStoryboard(name: "WelcomeScreen", bundle: nil)
            let sub = storyboard.instantiateViewController(withIdentifier: "NewWelcomeScreenViewController") as! NewWelcomeScreenViewController
            sub.logout = "logout"
            let topController = UIApplication.topViewController()
            topController?.show(sub, sender: true)
        }))
        alert.addAction(UIAlertAction(title: "لا", style: .cancel, handler: { action in
            
        }))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assignbackground()
        self.navigationItem.hidesBackButton = true
        checkUpdatedDate()
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "User"), for: .normal)
        button.setTitle("بياناتي\t", for: .normal)
        button.addTarget(self, action: #selector(showCategories), for: .touchUpInside)
        button.sizeToFit()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
        // Do any additional setup after loading the view.
    }
    
    @objc func showCategories() {
//        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//        let sub = storyBoard.instantiateViewController(withIdentifier: "chooseOfficeViewController") as! chooseOfficeViewController
//        sub.RegistrationDoneType = "Signl"
//        self.navigationController?.pushViewController(sub, animated: true)
        let storyBoard : UIStoryboard = UIStoryboard(name: "Home", bundle:nil)
        let sub = storyBoard.instantiateViewController(withIdentifier: "ProfileTableViewController") as! ProfileTableViewController
//        sub.RegistrationDoneType = "Signl"
        self.navigationController?.pushViewController(sub, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func newProjectBtn(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "NewProject", bundle:nil)
        let secondView = storyBoard.instantiateViewController(withIdentifier: "OfficeFillterViewController") as! OfficeFillterViewController
        self.navigationController?.show(secondView, sender: true)
    }
    
    @IBAction func MyProjectsBtn(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "ProjectsAndEdit", bundle:nil)
        let secondView = storyBoard.instantiateViewController(withIdentifier: "RequestProjectViewController") as! RequestProjectViewController
        self.navigationController?.pushViewController(secondView, animated: true)
    }
    
    @IBAction func DesignsBtn(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "DesignsAndDetails", bundle:nil)
        let secondView = storyBoard.instantiateViewController(withIdentifier: "ProjectsContinueViewController") as! ProjectsContinueViewController
        self.navigationController?.pushViewController(secondView, animated: true)
    }
    
    @IBAction func VisitsBtn(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "VisitsAndDetails", bundle:nil)
        let secondView = storyBoard.instantiateViewController(withIdentifier: "VisitsViewController") as! VisitsViewController
        self.navigationController?.pushViewController(secondView, animated: true)
    }
    
    @IBAction func MyFilesBtn(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "MyFilesAndMoney", bundle:nil)
        let secondView = storyBoard.instantiateViewController(withIdentifier: "MyFilesViewController") as! MyFilesViewController
        self.navigationController?.pushViewController(secondView, animated: true)
    }
    
    @IBAction func MoneyBtn(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "MyFilesAndMoney", bundle:nil)
        let secondView = storyBoard.instantiateViewController(withIdentifier: "MomeyManagmentViewController") as! MomeyManagmentViewController
        self.navigationController?.pushViewController(secondView, animated: true)
    }
    
    func checkUpdatedDate() {
        var mobile = UserDefaults.standard.string(forKey: "mobile")!
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
        Alamofire.request("http://smusers.promit2030.com/Service1.svc/GetEmptByMobileNum?mobileNum=\(mobile)", method: .get).responseJSON { response in
            debugPrint(response)
            
            let json = JSON(response.result.value!)
            print(json)
            
            if json["Mobile"].stringValue == "" {
                let alertController = UIAlertController(title: "لقد قمت بتغيير رقم الجوال..", message: "فضلا قم بتسجيل الدخول مرة اخرى", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "انهاء", style: .default, handler: { action in
                    let storyboard = UIStoryboard(name: "WelcomeScreen", bundle: nil)
                    let sub = storyboard.instantiateViewController(withIdentifier: "NewWelcomeScreenViewController") as! NewWelcomeScreenViewController
                    sub.logout = "logout"
                    _ = UserDefaults.standard.removeObject(forKey: "CustmoerId")
                    _ = UserDefaults.standard.removeObject(forKey: "UserId")
                    _ = UserDefaults.standard.removeObject(forKey: "name")
                    _ = UserDefaults.standard.removeObject(forKey: "mobile")
                    _ = UserDefaults.standard.removeObject(forKey: "email")
//                    _ = UserDefaults.standard.removeObject(forKey: "nationalId")
                    _ = UserDefaults.standard.removeObject(forKey: "CustomerPhoto")
                    self.show(sub, sender: true)
                }))
                //                alertController.addAction(UIAlertAction(title: "تخطي التسجيل", style: .default, handler: { action in
                //                    let sub = self.storyboard?.instantiateViewController(withIdentifier: "LoginTableViewController") as! LoginTableViewController
                //                    self.present(sub, animated: true ,completion: nil)
                //                }))
                self.present(alertController, animated: true, completion: nil)
                
            } else {
                
                userId = json["UserId"].stringValue
                customerId = json["CustmoerId"].stringValue
                customerName = json["CustmoerName"].stringValue
                email = json["Email"].stringValue
                mobile = json["Mobile"].stringValue
                customerPhoto = json["CustomerPhoto"].stringValue
//                nationalId = json["NationalId"].stringValue
//                CompanyInfoID = json["CompanyInfoID"].stringValue
//                ComapnyName = json["ComapnyName"].stringValue
//                SectionID = json["SectionID"].stringValue
//                SectionName = json["SectionName"].stringValue
//                AreaID = json["AreaID"].stringValue
//                AreaName = json["AreaName"].stringValue
//                ProvincesID = json["ProvincesID"].stringValue
//                ProvincesName = json["ProvincesName"].stringValue
//                CountryID = json["CountryID"].stringValue
//                CountryName = json["CountryName"].stringValue
                
                UserDefaults.standard.set(mobile, forKey: "mobile")
                UserDefaults.standard.set(userId, forKey: "UserId")
                UserDefaults.standard.set(customerName, forKey: "CustmoerName")
                UserDefaults.standard.set(customerId, forKey: "CustmoerId")
                UserDefaults.standard.set(email, forKey: "Email")
                UserDefaults.standard.set(customerPhoto, forKey: "CustomerPhoto")
//                UserDefaults.standard.set(nationalId, forKey: "NationalId")
//                UserDefaults.standard.set(CompanyInfoID, forKey: "CompanyInfoID")
//                UserDefaults.standard.set(ComapnyName, forKey: "ComapnyName")
//                UserDefaults.standard.set(SectionID, forKey: "SectionID")
//                UserDefaults.standard.set(SectionName, forKey: "SectionName")
//                UserDefaults.standard.set(AreaID, forKey: "AreaID")
//                UserDefaults.standard.set(AreaName, forKey: "AreaName")
//                UserDefaults.standard.set(ProvincesID, forKey: "ProvincesID")
//                UserDefaults.standard.set(ProvincesName, forKey: "ProvincesName")
//                UserDefaults.standard.set(CountryID, forKey: "CountryID")
//                UserDefaults.standard.set(CountryName, forKey: "CountryName")
            }
        }
        
    }
    
    func assignbackground(){
        let imageView = UIImageView(image: #imageLiteral(resourceName: "splash"))
        imageView.contentMode = .scaleAspectFill
        self.view.insertSubview(imageView, at: 0)
        self.view.sendSubview(toBack: imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        imageView.layoutIfNeeded()
    }
    
    
}
