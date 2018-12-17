//
//  OfficeFillterViewController.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 12/4/17.
//  Copyright © 2017 Ahmed Wahdan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class OfficeFillterViewController: UIViewController {
    
    @IBOutlet weak var entobtn: UIButton!{
        didSet{
            entobtn.layer.cornerRadius = 8
        }
    }
    @IBOutlet weak var lbl_title2: UILabel!
    @IBOutlet weak var lbl_titlt1: UILabel!
    // controller for not login
    @IBOutlet weak var constainTOpView: NSLayoutConstraint!
    @IBOutlet weak var titleLogo: UILabel!
    @IBOutlet weak var logoNot: UIView!
    @IBOutlet weak var stackBtnNot: UIStackView!
    @IBOutlet weak var aboutHandasyNot: UIButton!{
        didSet{
            aboutHandasyNot.layer.cornerRadius = 8
        }
    }
    //
    
    @IBOutlet weak var BgStack: UIView!
    // Action For Not Login
    @IBAction func About(_ sender: Any) {
       self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    @IBAction func loginNot(_ sender: Any) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        let storyboard = UIStoryboard(name: "NewLogin", bundle: nil)
                let sub = storyboard.instantiateViewController(withIdentifier: "NewLoginViewController")
       
                self.navigationController?.pushViewController(sub, animated: true)
    }
   
    
    @IBAction func RegisterNot(_ sender: Any) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    //
    @IBOutlet var navViewOut: UIView!
    @IBOutlet weak var titleVCLabel: UILabel!
    var logout = ""
    @IBOutlet weak var callBtn: UIButton!{
        didSet {
            callBtn.layer.borderWidth = 1.0
            callBtn.layer.borderColor = #colorLiteral(red: 0.2, green: 0.5647058824, blue: 0.3882352941, alpha: 1)
            callBtn.layer.cornerRadius = 4.0
        }
    }
    @IBOutlet weak var messageBtn: UIButton!{
        didSet {
            messageBtn.layer.borderWidth = 1.0
            messageBtn.layer.borderColor = #colorLiteral(red: 0.2, green: 0.5647058824, blue: 0.3882352941, alpha: 1)
            messageBtn.layer.cornerRadius = 4.0
        }
    }
    @IBOutlet weak var messageNotfiCount: UILabel!{
        didSet {
            DispatchQueue.main.async {
                self.messageNotfiCount.layer.cornerRadius = self.messageNotfiCount.frame.width/2
                self.messageNotfiCount.layer.masksToBounds = true
            }
        }
    }
    
    let applicationl = UIApplication.shared
    var NotiProjectCount = 0
    var NotiMessageCount1 = 0
    var NotiTotalCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
     self.tabBarController?.tabBar.isHidden = false
        messageNotfiCount.isHidden = true
       
        DispatchQueue.main.async {
            self.navViewOut.frame = CGRect.init(x: 0, y: 0, width: self.view.frame.width, height: 32)
            self.navViewOut.widthAnchor.constraint(equalToConstant: self.view.frame.width-20).isActive = true
            self.navigationItem.titleView = self.navViewOut
        }
        
        let CustmoerId = UserDefaults.standard.string(forKey: "CustmoerId")
        
        
        if CustmoerId == nil
        {
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.clear]
            self.navigationController?.setNavigationBarHidden(true, animated: true)
//            self.title = "الرئيسية"
            constainTOpView.constant =  236
            lbl_title2.font = lbl_title2.font.withSize(18)
            lbl_titlt1.font = lbl_titlt1.font.withSize(18)
            logoNot.isHidden = false
            titleLogo.isHidden = false
            stackBtnNot.isHidden = false
            BgStack.isHidden = false
            aboutHandasyNot.isHidden = false
            entobtn.isHidden = false
            messageBtn.isHidden = true
            messageNotfiCount.isHidden = true
            callBtn.isHidden = true
            self.tabBarController?.tabBar.isHidden = true
        }
        else
        {
            self.tabBarController?.tabBar.isHidden = false
            lbl_title2.font = lbl_title2.font.withSize(19)
            lbl_titlt1.font = lbl_titlt1.font.withSize(19)
            constainTOpView.constant = 125
            logoNot.isHidden = true
            stackBtnNot.isHidden = true
            BgStack.isHidden = true
            entobtn.isHidden = true
            titleLogo.isHidden = true
            aboutHandasyNot.isHidden = true
            messageBtn.isHidden = false
            CountCustomerNotification()
        }
        
    }

    override func viewWillAppear(_ animated: Bool) {
        let CustmoerId = UserDefaults.standard.string(forKey: "CustmoerId")
        
        
        if CustmoerId == nil
        {

            self.navigationController?.setNavigationBarHidden(true, animated: animated)
              self.tabBarController?.tabBar.isHidden = true
        }else
        {
            CountCustomerNotification()
        }
      
    }
    
    
    
    @IBAction func CompanyAction(_ sender: UIButton) {
 self.navigationController?.setNavigationBarHidden(false, animated: true)
         self.tabBarController?.tabBar.isHidden = false
        let storyBoard : UIStoryboard = UIStoryboard(name: "NewProject", bundle:nil)
        let secondView = storyBoard.instantiateViewController(withIdentifier: "OfficesMapViewController") as! OfficesMapViewController
        secondView.isCompany = "1"
        self.navigationController?.pushViewController(secondView, animated: true)
    }
    func addBackBarButtonItem() {
        let backButton = UIButton(type: .system)
        backButton.setTitle("الرئيسية", for: .normal)
        backButton.setImage(UIImage(named: "DBackBtn"), for: .normal)
        backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        backButton.sizeToFit()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }
    
    @objc func backButtonPressed(){
        let storyBoard : UIStoryboard = UIStoryboard(name: "NewHome", bundle:nil)
        let secondView = storyBoard.instantiateViewController(withIdentifier: "NewMyProjectsViewController") as! NewMyProjectsViewController
        //        self.present(secondView, animated: false, completion: nil)
        let topController = UIApplication.topViewController()
        topController?.show(secondView, sender: true)
    }
    
    @IBAction func EngAction(_ sender: UIButton) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.tabBarController?.tabBar.isHidden = false
//        let storyBoard : UIStoryboard = UIStoryboard(name: "NewProject", bundle:nil)
//        let secondView = storyBoard.instantiateViewController(withIdentifier: "SearchCitiesViewController") as! SearchCitiesViewController
//        secondView.isCompany = "0"
//        let topController = UIApplication.topViewController()
//        topController?.show(secondView, sender: true)
        let storyBoard : UIStoryboard = UIStoryboard(name: "NewProject", bundle:nil)
        let secondView = storyBoard.instantiateViewController(withIdentifier: "OfficesMapViewController") as! OfficesMapViewController
        secondView.isCompany = "0"
        self.navigationController?.pushViewController(secondView, animated: true)
    }
    
    @IBAction func callBtnAction(_ sender: UIButton) {
        callButtonPressed()
    }
    
    @IBAction func homeChatAction(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Chat", bundle: nil)
        let secondView = storyBoard.instantiateViewController(withIdentifier: "HomeChatOfProjectsViewController") as! HomeChatOfProjectsViewController
        self.navigationController?.pushViewController(secondView, animated: true)
    }
    @objc func callButtonPressed() {
        let storyBoard : UIStoryboard = UIStoryboard(name: "NewHome", bundle: nil)
        let secondView = storyBoard.instantiateViewController(withIdentifier: "ContactUSViewController") as! ContactUSViewController
        self.navigationController?.pushViewController(secondView, animated: true)
    }

    func CountCustomerNotification() {
        let CustmoerId = UserDefaults.standard.string(forKey: "CustmoerId")!
        let parameters: Parameters = [
            "CustmoerId":CustmoerId
        ]
        Alamofire.request("http://smusers.promit2030.co/Service1.svc/CountCustomerNotification", method: .get, parameters: parameters, encoding: URLEncoding.default).responseJSON { response in
            switch response.result {
            case .success:
                let json = JSON(response.result.value!)
                print(json)
                self.NotiProjectCount = json["NotiProjectCount"].intValue
                self.NotiMessageCount1 = json["NotiMessageCount"].intValue
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
    
    @IBAction func GotoEntro(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "EntroStoryboard", bundle:nil)
        let sub = storyBoard.instantiateViewController(withIdentifier: "EntroVC") as! EntroVC
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        appDelegate.window?.rootViewController = sub
    }
    func setAppBadge() {
        let count = NotiTotalCount
        let CustmoerId = UserDefaults.standard.string(forKey: "CustmoerId")!
        if CustmoerId != nil || CustmoerId != ""
        {
            
            if count != 0 {
                let second = tabBarController?.tabBar
                second?.items![1].badgeValue = "\(count)"
                second?.items![1].badgeColor = #colorLiteral(red: 0.3058823529, green: 0.5058823529, blue: 0.5333333333, alpha: 1)
                
            }else
            {
                let second = tabBarController?.tabBar
                second?.items![1].badgeValue = ""
                second?.items![1].badgeColor = UIColor.clear
            }
        }else
        {
            applicationl.applicationIconBadgeNumber = 0
        }
       
    }
}
