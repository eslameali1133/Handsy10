//
//  NewTabBarViewController.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 12/27/17.
//  Copyright © 2017 Ahmed Wahdan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import UserNotifications

class NewTabBarViewController: UITabBarController, UITabBarControllerDelegate {
    
    var CounterProjectArr: [GetProjectDataCountByCustIDMainTab] = [GetProjectDataCountByCustIDMainTab]()
    var ProjectDataCountByCustIDMainTabdModel: GetProjectDataCountByCustIDMainTabdModel = GetProjectDataCountByCustIDMainTabdModel()
    
    @IBOutlet weak var heightConstrianWord: NSLayoutConstraint!
   
    @IBOutlet weak var ConstrianHeigthBtn: NSLayoutConstraint!
    @IBOutlet weak var ConstrinWidhrBtn: NSLayoutConstraint!
    
    @IBOutlet var buttonsView: UIView!
      var freshLaunch = false
     @IBInspectable var defaultIndex: Int = 2
    @IBOutlet weak var profileBtn: UIButton!{
        didSet {
            self.profileBtn.layer.cornerRadius = self.profileBtn.frame.width / 2
        }
    }
    @IBOutlet weak var AboutHandasy: UIButton!{
        didSet {
            self.AboutHandasy.layer.cornerRadius = self.AboutHandasy.frame.width / 2
        }
    }
    @IBOutlet weak var EntroBtn: UIButton!{
        didSet {
            self.EntroBtn.layer.cornerRadius = self.EntroBtn.frame.width / 2
        }
    }
    @IBOutlet weak var contactUSBtn: UIButton!{
        didSet {
            self.contactUSBtn.layer.cornerRadius = self.contactUSBtn.frame.width / 2
        }
    }
    @IBOutlet weak var chatBtn: UIButton!{
        didSet {
            self.chatBtn.layer.cornerRadius = self.chatBtn.frame.width / 2
        }
    }
    @IBOutlet weak var archiveVisitsBtn: UIButton!{
        didSet {
            self.archiveVisitsBtn.layer.cornerRadius = self.archiveVisitsBtn.frame.width / 2
        }
    }
    @IBOutlet weak var archiveDesignsBtn: UIButton!{
        didSet {
            self.archiveDesignsBtn.layer.cornerRadius = self.archiveDesignsBtn.frame.width / 2
        }
    }
    @IBOutlet weak var archiveFilesBtn: UIButton!{
        didSet {
            self.archiveFilesBtn.layer.cornerRadius = self.archiveFilesBtn.frame.width / 2
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        // Do any additional setup after loading the view.
         
       
   
        if Reachability.isConnectedToNetwork(){
            print("Internet Connection Available!")
            GetProjectDataCountByCustID()
              CountCustomerNotification()
        }
        else
        {
            ProjectDataCountByCustIDMainTabdModel.loadItems()
            self.CounterProjectArr = [ProjectDataCountByCustIDMainTabdModel.returnCountByCustmoerId()!]
        
        }
        
        
    }
  
    override func viewWillAppear(_ animated: Bool) {
        if freshLaunch == true {
            freshLaunch = false
           
           selectedIndex = defaultIndex
          
            
        }
    }
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let vcIndex = tabBarController.viewControllers!.index(of: viewController)!
        if  vcIndex == 4 {
           
            let currentView = tabBarController.selectedViewController!.view!
            DispatchQueue.main.async {
                self.buttonsView.frame = CGRect.init(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
                currentView.addSubview(self.buttonsView)
                currentView.bringSubview(toFront: self.buttonsView)
            }
            
            return false
        }else{
            return true
        }
    }
    @IBAction func dismissBtn(_ sender: UIButton) {
        if let parentStackView = sender.superview {
            parentStackView.removeFromSuperview()
        }
    }
    
    @IBAction func goProfile(_ sender: UIButton) {
        buttonsView.removeFromSuperview()
        let storyBoard : UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
        let secondView = storyBoard.instantiateViewController(withIdentifier: "ProfileTableViewController") as! ProfileTableViewController
        let topController = UIApplication.topViewController()
        topController?.show(secondView, sender: true)
    }
    
    @IBAction func callBtnAction(_ sender: UIButton) {
        buttonsView.removeFromSuperview()
        let storyBoard : UIStoryboard = UIStoryboard(name: "NewHome", bundle: nil)
        let secondView = storyBoard.instantiateViewController(withIdentifier: "ContactUSViewController") as! ContactUSViewController
        let topController = UIApplication.topViewController()
        topController?.show(secondView, sender: true)
    }
    
    @IBAction func goVisitsArchive(_ sender: UIButton) {
        if CounterProjectArr[0].MeetingCount == 0 {
            Toast.long(message: "لا يوجد زيارات")
        }else {
            buttonsView.removeFromSuperview()
            let storyBoard : UIStoryboard = UIStoryboard(name: "VisitsAndDetails", bundle: nil)
            let secondView = storyBoard.instantiateViewController(withIdentifier: "FilterVisitsViewController") as! FilterVisitsViewController
            secondView.condition = "Filter"
            let topController = UIApplication.topViewController()
            topController?.show(secondView, sender: true)
        }
    }
    
    @IBAction func goDesignsArchive(_ sender: UIButton) {
        if CounterProjectArr[0].DesignsCount == 0 {
            Toast.long(message: "لايوجد تصاميم")
        }else {
            buttonsView.removeFromSuperview()
            let storyBoard : UIStoryboard = UIStoryboard(name: "DesignsAndDetails", bundle: nil)
            let secondView = storyBoard.instantiateViewController(withIdentifier: "FilterDesignsViewController") as! FilterDesignsViewController
            secondView.condition = "Filter"
            let topController = UIApplication.topViewController()
            topController?.show(secondView, sender: true)
        }
    }
    @IBAction func goFilesArchive(_ sender: UIButton) {
        if CounterProjectArr[0].FileCount == 0 {
            Toast.long(message: "لا يوجد وثايق و مستندات ")
        }else {
        buttonsView.removeFromSuperview()
        let storyBoard : UIStoryboard = UIStoryboard(name: "MyFilesAndMoney", bundle: nil)
        let secondView = storyBoard.instantiateViewController(withIdentifier: "MyFilesViewController") as! MyFilesViewController
        let topController = UIApplication.topViewController()
        topController?.show(secondView, sender: true)
        }
        
    }
    @IBAction func GotoAbout(_ sender: Any) {
        buttonsView.removeFromSuperview()
        let storyBoard : UIStoryboard = UIStoryboard(name: "AboutHandasy", bundle: nil)
        let secondView = storyBoard.instantiateViewController(withIdentifier: "MomeyManagmentViewController") as! aboutHangsyViewController
        let topController = UIApplication.topViewController()
        topController?.show(secondView, sender: true)
    }
    @IBAction func Gotoproview(_ sender: Any) {
        buttonsView.removeFromSuperview()
        let storyBoard : UIStoryboard = UIStoryboard(name: "EntroStoryboard", bundle:nil)
        let secondView = storyBoard.instantiateViewController(withIdentifier: "EntroVC") as! EntroVC
       secondView.comingmain = true 
        let topController = UIApplication.topViewController()
        topController?.show(secondView, sender: true)
    }
    
    @IBAction func openChats(_ sender: UIButton) {
        buttonsView.removeFromSuperview()
        let storyBoard : UIStoryboard = UIStoryboard(name: "Chat", bundle: nil)
        let secondView = storyBoard.instantiateViewController(withIdentifier: "HomeChatOfProjectsViewController") as! HomeChatOfProjectsViewController
        let topController = UIApplication.topViewController()
        topController?.show(secondView, sender: true)
    }
    
    @IBAction func logOut(_ sender: UIButton) {
        backButtonPressed()
    }
    func backButtonPressed(){
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
            
            self.applicationl.applicationIconBadgeNumber = 0
            let center = UNUserNotificationCenter.current()
            center.removeAllDeliveredNotifications() // To remove all delivered notifications
            center.removeAllPendingNotificationRequests()
            
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
            switch response.result {
            case .success:
                let json = JSON(response.result.value!)
                print(json)
            case .failure(let error):
                print(error)
                let alertAction = UIAlertController(title: "خطاء في الاتصال", message: "اعادة المحاولة", preferredStyle: .alert)
                
                alertAction.addAction(UIAlertAction(title: "نعم", style: .default, handler: { action in
                    self.PushInsertUpdate()
                }))
                
                alertAction.addAction(UIAlertAction(title: "رجوع", style: .cancel, handler: { action in
                }))
                
                self.present(alertAction, animated: true, completion: nil)
                
            }
        }
    }
    // set CountCustomerNotification
    let applicationl = UIApplication.shared
    var NotiProjectCount = 0
    var NotiMessageCount = 0
    var NotiTotalCount = 0
    func CountCustomerNotification() {
        let CustmoerId = UserDefaults.standard.string(forKey: "CustmoerId")!
        let parameters: Parameters = [
            "CustmoerId":CustmoerId
        ]
        Alamofire.request("http://smusers.promit2030.com/Service1.svc/CountCustomerNotification", method: .get, parameters: parameters, encoding: URLEncoding.default).responseJSON { response in
            switch response.result {
            case .success:
                let json = JSON(response.result.value!)
                print(json)
                self.NotiProjectCount = json["NotiProjectCount"].intValue
                self.NotiMessageCount = json["NotiMessageCount"].intValue
                self.NotiTotalCount = json["NotiTotalCount"].intValue
                
                
                self.setAppBadge()
            case .failure(let error):
                print(error)
                let alertAction = UIAlertController(title: "خطاء في الاتصال", message: "اعادة المحاولة", preferredStyle: .alert)
                
                alertAction.addAction(UIAlertAction(title: "نعم", style: .default, handler: { action in
                    self.CountCustomerNotification()
                }))
                
                alertAction.addAction(UIAlertAction(title: "رجوع", style: .cancel, handler: { action in
                }))
                
                self.present(alertAction, animated: true, completion: nil)
                
            }
        }
    }
    func setAppBadge() {
        let count = NotiTotalCount
          let CustmoerId = UserDefaults.standard.string(forKey: "CustmoerId")!
        if CustmoerId != nil || CustmoerId != ""
        {
        applicationl.applicationIconBadgeNumber = count
        }else
        {
              applicationl.applicationIconBadgeNumber = 0
        }
    }
    
    
    var DesignsCount = 0
    var MeetingCount = 0
     var FilesCount = 0
    
    // func get designs and visits count
    func GetProjectDataCountByCustID() {
        let CustmoerId = UserDefaults.standard.string(forKey: "CustmoerId")!
        let parameters: Parameters = [
            "custId":CustmoerId
        ]
        Alamofire.request("http://smusers.promit2030.com/api/ApiService/GetProjectDataCountByCustID?custId=\(CustmoerId)", method: .get, encoding: URLEncoding.default).responseJSON { response in
            switch response.result {
            case .success:
                let json = JSON(response.result.value!)
                print(json)
                self.DesignsCount = json["DesignsCount"].intValue
                self.MeetingCount = json["MeetingCount"].intValue
                self.FilesCount = json["FileCount"].intValue
                
                let objectCount = GetProjectDataCountByCustIDMainTab(DesignsCount: json["DesignsCount"].intValue, MeetingCount: json["MeetingCount"].intValue, FileCount: json["FileCount"].intValue)
                
                self.CounterProjectArr.append(objectCount)
                self.ProjectDataCountByCustIDMainTabdModel.removeAllItems()
                for i in self.CounterProjectArr {
                    self.ProjectDataCountByCustIDMainTabdModel.append(i)
                }
                
            case .failure(let error):
                print(error)
                let alertAction = UIAlertController(title: "خطاء في الاتصال", message: "اعادة المحاولة", preferredStyle: .alert)
                
                alertAction.addAction(UIAlertAction(title: "نعم", style: .default, handler: { action in
                    self.GetProjectDataCountByCustID()
                }))
                
                alertAction.addAction(UIAlertAction(title: "رجوع", style: .cancel, handler: { action in
                }))
                
                self.present(alertAction, animated: true, completion: nil)
                
            }
        }
    }
    
}
