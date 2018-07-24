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
    @IBOutlet var navViewOut: UIView!
    @IBOutlet weak var titleVCLabel: UILabel!
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
    var NotiMessageCount = 0
    var NotiTotalCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messageNotfiCount.isHidden = true
        self.navigationItem.title = "مشروع جديد"
        DispatchQueue.main.async {
            self.navViewOut.frame = CGRect.init(x: 0, y: 0, width: self.view.frame.width, height: 32)
            self.navViewOut.widthAnchor.constraint(equalToConstant: self.view.frame.width-20).isActive = true
            self.navigationItem.titleView = self.navViewOut
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        CountCustomerNotification()
    }
    
    
    
    @IBAction func CompanyAction(_ sender: UIButton) {
//        let storyBoard : UIStoryboard = UIStoryboard(name: "NewProject", bundle:nil)
//        let secondView = storyBoard.instantiateViewController(withIdentifier: "SearchCitiesViewController") as! SearchCitiesViewController
//        secondView.isCompany = "1"
//        let topController = UIApplication.topViewController()
//        topController?.show(secondView, sender: true)
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
        applicationl.applicationIconBadgeNumber = count
    }
}
