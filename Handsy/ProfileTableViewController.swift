//
//  ProfileViewController.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 8/16/17.
//  Copyright © 2017 Ahmed Wahdan. All rights reserved.
//

import UIKit
import Haneke
import Alamofire
import SwiftyJSON
import UserNotifications
class ProfileTableViewController: UITableViewController {

    @IBOutlet weak var profileImage: AMCircleImageView!
    @IBOutlet weak var CustName: UILabel!
    @IBOutlet weak var CustMobile: UILabel!
    let applicationl = UIApplication.shared
    var imagePath = ""
    
    @IBAction func VisubleImageBtn(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Home", bundle:nil)
        let secondView = storyBoard.instantiateViewController(withIdentifier: "ProfileImageViewController") as! ProfileImageViewController
        secondView.imagePath = self.imagePath
        self.navigationController?.pushViewController(secondView, animated: true)
    }
    
    //    @IBOutlet weak var CustNational: UILabel!
//    @IBOutlet weak var CompanyLabel: UILabel!
//    
//    @IBOutlet weak var EditCompanyOut: UIButton!{
//        didSet {
//            DispatchQueue.main.async {
//                self.EditCompanyOut.layer.cornerRadius = 7.0
//                self.EditCompanyOut.layer.masksToBounds = true
//            }
//        }
//    }
    
    @IBOutlet weak var alertLineView: UIView!
    
    @IBOutlet weak var alertLabelTimer: UILabel!
    
    @IBOutlet weak var edit: UIButton!{
        didSet {
            DispatchQueue.main.async {
                self.edit.layer.shadowColor = UIColor.black.cgColor
                self.edit.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
                self.edit.layer.shadowRadius = 2.0
                self.edit.layer.shadowOpacity = 0.5
                self.edit.layer.borderColor = UIColor.black.cgColor
                self.edit.layer.borderWidth = 0.5
                self.edit.layer.cornerRadius = 7.0
                self.edit.layer.masksToBounds = false
            }
        }
    }
    
    var timere: Timer?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timere = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(update), userInfo: nil, repeats: true)
        alertLineView.isHidden = true
        alertLabelTimer.isHidden = true
        
        navigationItem.title = "حسابي"
        addBackBarButtonItem()
        
        
        
//        assignbackground()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        GetEmptByMobileNum()

    }
    @IBAction func EditActionBtn(_ sender: UIButton) {
        timere?.invalidate()
        timere = nil
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let secondView = storyboard.instantiateViewController(withIdentifier: "EditProfileTableViewController") as! EditProfileTableViewController
        self.navigationController?.pushViewController(secondView, animated: true)
    }
    
    func setData(){
        CustName.text = UserDefaults.standard.string(forKey: "CustmoerName")
        CustMobile.text = UserDefaults.standard.string(forKey: "mobile")
        
        let firstElem = UserDefaults.standard.string(forKey: "CustomerPhoto")!
        imagePath = firstElem
        let trimmedString = firstElem.trimmingCharacters(in: .whitespaces)
        if let url = URL.init(string: trimmedString) {
            print(url)
            profileImage.hnk_setImageFromURL(url, placeholder: #imageLiteral(resourceName: "custlogo"))
        } else{
            profileImage.image = #imageLiteral(resourceName: "custlogo")
            print("nil")
        }
    }
    
    func GetEmptByMobileNum() {
        let mobile = UserDefaults.standard.string(forKey: "mobile")!
        Alamofire.request("http://smusers.promit2030.com/Service1.svc/GetEmptByMobileNum?mobileNum=\(mobile)", method: .get).responseJSON { response in
            debugPrint(response)
            
            switch response.result {
            case .success:
            let json = JSON(response.result.value!)
            print(json)
            
            if json["Mobile"].stringValue == "" {
                UserDefaults.standard.set(json["UserId"].stringValue, forKey: "UserId")
                UserDefaults.standard.set(json["CustmoerId"].stringValue, forKey: "CustmoerId")
                UserDefaults.standard.set(json["CustmoerName"].stringValue, forKey: "CustmoerName")
                UserDefaults.standard.set(json["Email"].stringValue, forKey: "Email")
                UserDefaults.standard.set(json["CustomerPhoto"].stringValue, forKey: "CustomerPhoto")
                UserDefaults.standard.set(json["Mobile"].stringValue, forKey: "mobile")
                self.setData()
            } else {
                UserDefaults.standard.set(json["UserId"].stringValue, forKey: "UserId")
                UserDefaults.standard.set(json["CustmoerId"].stringValue, forKey: "CustmoerId")
                UserDefaults.standard.set(json["CustmoerName"].stringValue, forKey: "CustmoerName")
                UserDefaults.standard.set(json["Email"].stringValue, forKey: "Email")
                UserDefaults.standard.set(json["CustomerPhoto"].stringValue, forKey: "CustomerPhoto")
                UserDefaults.standard.set(json["Mobile"].stringValue, forKey: "mobile")
                self.setData()
            }
            case .failure(let error):
            print(error)
            UIViewController.removeSpinner(spinner: self.view)
            let alertAction = UIAlertController(title: "خطاء في الاتصال", message: "اعادة المحاولة", preferredStyle: .alert)
            
            alertAction.addAction(UIAlertAction(title: "نعم", style: .default, handler: { action in
                self.GetEmptByMobileNum()
            }))
            
            alertAction.addAction(UIAlertAction(title: "رجوع", style: .cancel, handler: { action in
            }))
            
            self.present(alertAction, animated: true, completion: nil)
            
        }
            
        }
        
    }
    
   
    @objc func update() {
        if let savedTimeInterval = UserDefaults.standard.object(forKey: "editSavedTimeInterval") as? TimeInterval {
            let currentTimeInterval = Date().timeIntervalSince1970
            let numberOfSeconds = Int(currentTimeInterval - savedTimeInterval)
            var counterNumberOfSeconds = 180 - numberOfSeconds
            if numberOfSeconds > 180 {
//                print("180 seconds has finished")
                alertLineView.isHidden = true
                alertLabelTimer.isHidden = true
                edit.isEnabled = true
            } else {
//                print("You still need to wait another \(counterNumberOfSeconds) seconds")
                edit.isEnabled = false
                let minutes = String(counterNumberOfSeconds / 60)
                let seconds = String(counterNumberOfSeconds % 60)
                alertLineView.isHidden = false
                alertLabelTimer.isHidden = false
                alertLabelTimer.text = "تعديل بعد " + minutes + ":" + seconds
                counterNumberOfSeconds -= 1
            }
            
        }
    }
    
    func addBackBarButtonItem() {
        let backButton = UIButton(type: .system)
        backButton.setTitle("تسجيل الخروج", for: .normal)
        backButton.setImage(UIImage(named: "Newpath-1"), for: .normal)
        backButton.titleEdgeInsets.left = 5
        backButton.titleEdgeInsets.right = -5
        backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        backButton.sizeToFit()
        backButton.tintColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }
    
    @objc func backButtonPressed(){
        let alert = UIAlertController(title: "تنبيه", message: "هل تريد تسجيل الخروج", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "نعم", style: .default, handler: { action in
            self.PushInsertUpdate()
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
            self.applicationl.applicationIconBadgeNumber = 0
            let center = UNUserNotificationCenter.current()
            center.removeAllDeliveredNotifications() // To remove all delivered notifications
            center.removeAllPendingNotificationRequests()
            self.timere?.invalidate()
            self.timere = nil
            let storyboard = UIStoryboard(name: "WelcomeScreen", bundle: nil)
            let NavController = storyboard.instantiateViewController(withIdentifier: "NewWelcome") as! UINavigationController
            let FirstViewController = NavController.viewControllers.first as! NewWelcomeScreenViewController
            FirstViewController.logout = "logout"
            self.present(NavController, animated: false, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "لا", style: .cancel, handler: { action in
            
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func PushInsertUpdate(){
        let CustmoerId = UserDefaults.standard.string(forKey: "CustmoerId")!
        print("cus: \(CustmoerId)")
        let DeviceToken = ""
        let DeviceID = UserDefaults.standard.string(forKey: "udidKey")!
        let parameters: Parameters = [
            "CustmoerId": CustmoerId,
            "DeviceToken":DeviceToken,
            "TypeDevice":"1",
            "DeviceID":DeviceID
        ]
        
        Alamofire.request("http://smusers.promit2030.com/Service1.svc/PushInsertUpdate", method: .get, parameters: parameters, encoding: URLEncoding.default).responseJSON { response in
            let json = JSON(response.result.value!)
            print(json)
            
        }
    }
    
    func assignbackground(){
        DispatchQueue.main.async {
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
}
