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

class NewTabBarViewController: UITabBarController, UITabBarControllerDelegate {
    @IBOutlet var buttonsView: UIView!
    @IBOutlet weak var profileBtn: UIButton!{
        didSet {
            self.profileBtn.layer.cornerRadius = self.profileBtn.frame.width / 2
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
        buttonsView.removeFromSuperview()
        let storyBoard : UIStoryboard = UIStoryboard(name: "VisitsAndDetails", bundle: nil)
        let secondView = storyBoard.instantiateViewController(withIdentifier: "VisitsViewController") as! VisitsViewController
        let topController = UIApplication.topViewController()
        topController?.show(secondView, sender: true)
    }
    
    @IBAction func goDesignsArchive(_ sender: UIButton) {
        buttonsView.removeFromSuperview()
        let storyBoard : UIStoryboard = UIStoryboard(name: "DesignsAndDetails", bundle: nil)
        let secondView = storyBoard.instantiateViewController(withIdentifier: "ProjectsContinueViewController") as! ProjectsContinueViewController
        let topController = UIApplication.topViewController()
        topController?.show(secondView, sender: true)
    }
    @IBAction func goFilesArchive(_ sender: UIButton) {
        buttonsView.removeFromSuperview()
        let storyBoard : UIStoryboard = UIStoryboard(name: "MyFilesAndMoney", bundle: nil)
        let secondView = storyBoard.instantiateViewController(withIdentifier: "MyFilesViewController") as! MyFilesViewController
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
            //            let domain = Bundle.main.bundleIdentifier!
            //            UserDefaults.standard.removePersistentDomain(forName: domain)
            //            UserDefaults.standard.synchronize()
            
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
}
