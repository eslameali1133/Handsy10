//
//  NewWelcomeScreenViewController.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 12/26/17.
//  Copyright © 2017 Ahmed Wahdan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class NewWelcomeScreenViewController: UIViewController {
    @IBOutlet var viewUpdateVersion: UIView!
    @IBOutlet weak var layerOne: UIImageView!
    @IBOutlet weak var layerTwo: UIImageView!
    @IBOutlet weak var Layerthree: UIImageView!
    @IBOutlet weak var LayerFour: UIImageView!
    @IBOutlet weak var LabelOne: UILabel!
    
    @IBOutlet weak var LabelTwo: UILabel!
    @IBOutlet weak var btn_updateOk: UIButton!
        {
        didSet{
            btn_updateOk.layer.cornerRadius = 4
        }
    }
    @IBOutlet weak var btn_updateCancel: UIButton! {
        didSet{
            btn_updateCancel.layer.cornerRadius = 4
        }
    }
    var checkProjectsRate = false
    var versionneedupdate = false
    @IBOutlet weak var StartBtnOut: UIButton!{
        didSet {
            DispatchQueue.main.async {
                self.StartBtnOut.circleView(UIColor.clear, borderWidth: 1.0)
            }
        }
    }
    
    @IBOutlet weak var aboutUsBtn: UIButton!{
        didSet {
            DispatchQueue.main.async {
                self.aboutUsBtn.layer.shadowColor = UIColor.black.cgColor
                self.aboutUsBtn.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
                self.aboutUsBtn.layer.shadowRadius = 2.0
                self.aboutUsBtn.layer.shadowOpacity = 0.5
                self.aboutUsBtn.layer.borderColor = UIColor.black.cgColor
                self.aboutUsBtn.layer.borderWidth = 0.5
                self.aboutUsBtn.layer.cornerRadius = 7.0
                self.aboutUsBtn.layer.masksToBounds = false
            }
        }
    }
    
    @IBOutlet weak var subscribeBtn: UIButton!{
        didSet {
            DispatchQueue.main.async {
                self.subscribeBtn.layer.shadowColor = UIColor.black.cgColor
                self.subscribeBtn.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
                self.subscribeBtn.layer.shadowRadius = 2.0
                self.subscribeBtn.layer.shadowOpacity = 0.5
                self.subscribeBtn.layer.borderColor = UIColor.black.cgColor
                self.subscribeBtn.layer.borderWidth = 0.5
                self.subscribeBtn.layer.cornerRadius = 7.0
                self.subscribeBtn.layer.masksToBounds = false
            }
        }
    }
    
    var logout = ""
    var NotiProjectCount = 0
    var NotiMessageCount = 0
    var NotiTotalCount = 0
    let applicationl = UIApplication.shared
    var topConstraint: NSLayoutConstraint?
    var topAnimateConstraint: NSLayoutConstraint?
    var countoprn = 0
    
    func isAppAlreadyLaunchedOnce()->Bool{
        let defaults = UserDefaults.standard
        if let _ = defaults.string(forKey: "isAppAlreadyLaunchedOnce"){
            print("App already launched")
            return true
        }else{
            defaults.set(true, forKey: "isAppAlreadyLaunchedOnce")
            print("App launched first time")
            return false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if logout == "logout" {
            logout = ""
            
              DispatchQueue.main.async {
                _ = Timer.scheduledTimer(timeInterval: 2.5, target: self, selector: #selector(self.checkLogOut), userInfo: nil, repeats: false)
            }
            
        }
        else
        {
            let delegate = UIApplication.shared.delegate as! AppDelegate
            let times = delegate.currentTimesOfOpenApp
           
            let CustmoerId = UserDefaults.standard.string(forKey: "CustmoerId")
            if CustmoerId != nil
            {
                 if Reachability.isConnectedToNetwork(){
                    CountCustomerNotification()
                    
                }
            }
            viewUpdateVersion.isHidden = true
            DispatchQueue.main.async {
                self.viewUpdateVersion.frame = CGRect.init(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
                self.viewUpdateVersion.center = self.view.center
                self.view.addSubview(self.viewUpdateVersion)
            }
            
            checkForUpdate { (isUpdate) in
                print("Update needed:\(isUpdate)")
                if isUpdate{
                    DispatchQueue.main.async {
                        print("new update Available")
                        self.viewUpdateVersion.isHidden = false
                    }
                }
                else if (isUpdate == false)
                {
                    
                    let CustmoerId = UserDefaults.standard.string(forKey: "CustmoerId")
                    print(CustmoerId)
                    print(self.logout)
                    if CustmoerId == nil || CustmoerId == "" {
                        self.checkLogOut()
                        
                    } else {
                        self.resetCount()
                        
                    }
                    
                    
                }
                
            }
            
        }
        
        
    }
    
    @objc func resetCount() {
        
            ChechProRate()
        
       
        print(self.checkProjectsRate)
        
        
    }
    
    @objc func checkLogOut() {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "NewHome", bundle:nil)
        let sub = storyBoard.instantiateViewController(withIdentifier: "MainTabLogot") as! MainTabLogot
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        appDelegate.window?.rootViewController = sub
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
                        self.layerOne.center.y -= self.view.bounds.height
                        self.layerTwo.center.y -= self.view.bounds.height
                        self.Layerthree.center.y -= self.view.bounds.height
                        self.LayerFour.center.x -= self.view.bounds.width
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
                        DispatchQueue.main.async {
                            UIView.animate(withDuration: 0.5) {
                                self.layerOne.center.y += self.view.bounds.height
                            }
                            UIView.animate(withDuration: 0.5, delay: 0.3, options: [],
                                           animations: {
                                            self.layerTwo.center.y += self.view.bounds.height
                            },
                                           completion: nil
                            )
                            UIView.animate(withDuration: 0.5, delay: 0.6, options: [],
                                           animations: {
                                            self.Layerthree.center.y += self.view.bounds.height
                            },
                                           completion: nil
                            )
                            UIImageView.animate(withDuration: 0.5, delay: 0.9, options:  [],
                                                animations: {
                                                    self.LayerFour.center.x += self.view.bounds.width
                            },
                                                completion: nil
                            )
        
                            UIView.animate(withDuration: 0.5, delay: 1.2, usingSpringWithDamping: 0.6, initialSpringVelocity: 10, options: [.curveEaseOut], animations: {
        
                                let translation = CGAffineTransform(translationX: 0, y: 0)
                                let scale = CGAffineTransform(scaleX: 1, y: 1)
        
                                self.LabelOne.transform = translation.concatenating(scale)
                                self.LabelOne.alpha = 1
                                self.LabelTwo.transform = translation.concatenating(scale)
                                self.LabelTwo.alpha = 1
        
                            }, completion: nil
                            )
                        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func checkForUpdate(completion:@escaping(Bool)->()){
        
        guard let bundleInfo = Bundle.main.infoDictionary,
            let currentVersion = bundleInfo["CFBundleShortVersionString"] as? String,
            let identifier = bundleInfo["CFBundleIdentifier"] as? String,
            let url = URL(string: "http://itunes.apple.com/lookup?bundleId=\(identifier)")
            else{
                print("some thing wrong")
                completion(false)
                return
        }
        
        let task = URLSession.shared.dataTask(with: url) {
            (data, resopnse, error) in
            if error != nil{
                completion(false)
                print("something went wrong")
            }else{
                do{
                    guard let reponseJson = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String:Any],
                        let result = (reponseJson["results"] as? [Any])?.first as? [String: Any],
                        let version = result["version"] as? String
                        else{
                            completion(false)
                            return
                    }
                    let cur:Double? = NumberFormatter().number(from: currentVersion)?.doubleValue
                    let sro:Double? = (version as NSString).doubleValue
                    
                    //Int(version)
                    print("Current Ver:\(currentVersion)")
                    print("Prev version:\(version)")
                    if cur != sro {
                        completion(true)
                        
                    }else{
                        completion(false)
                    }
                }
                catch{
                    completion(false)
                    print("Something went wrong")
                }
            }
        }
        task.resume()
    }
    @IBAction func StartBtnAction(_ sender: UIButton) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "NewHome", bundle:nil)
        let sub = storyBoard.instantiateViewController(withIdentifier: "MainTabLogot") as! MainTabLogot
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        appDelegate.window?.rootViewController = sub
 
    }
    
    @IBAction func aboutUs(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "WelcomeScreen", bundle: nil)
        let secondView = storyBoard.instantiateViewController(withIdentifier: "AboutHandsyViewController") as! AboutHandsyViewController
        secondView.modalPresentationStyle = .custom
        self.present(secondView, animated: true)
    }
    
    @IBAction func updateversionbtn(_ sender: Any) {
        
        //        UIApplication.sharedApplication().openURL(NSURL(string: "itms://itunes.apple.com/de/app/x-gift/id839686104?mt=8&uo=4")!)
        if let url = URL(string: "https://itunes.apple.com/us/app/%D9%87%D9%86%D8%AF%D8%B3%D9%8A/id1287033751?ls=1&mt=8"),
            UIApplication.shared.canOpenURL(url){
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    @IBAction func cancelVersionbtn(_ sender: Any) {
        
        viewUpdateVersion.isHidden = true
        
        
        
        let CustmoerId = UserDefaults.standard.string(forKey: "CustmoerId")
        if CustmoerId == nil
        {
            let storyBoard : UIStoryboard = UIStoryboard(name: "NewHome", bundle:nil)
            let sub = storyBoard.instantiateViewController(withIdentifier: "MainTabLogot") as! MainTabLogot
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            
            appDelegate.window?.rootViewController = sub
        }
        else
        {
            _ = Timer.scheduledTimer(timeInterval: 2.5, target: self, selector: #selector(self.resetCount), userInfo: nil, repeats: false)
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
    func ChechProRate()
    {
        let CustmoerId = UserDefaults.standard.string(forKey: "CustmoerId")
        print(CustmoerId)
        HttpApi.CheckRate(Cus_ID:CustmoerId!) { (error:Error?,success:Bool,check:Bool? ) in
            if error == nil
            {
                print(check)
                
                if(check == false)
                {
                    if let CustmoerId = UserDefaults.standard.string(forKey: "CustmoerId") {
                        if let UserId = UserDefaults.standard.string(forKey: "UserId") {
                            let storyBoard : UIStoryboard = UIStoryboard(name: "NewHome", bundle:nil)
                            let sub = storyBoard.instantiateViewController(withIdentifier: "NewMain") as! NewTabBarViewController
                            let appDelegate = UIApplication.shared.delegate as! AppDelegate
                            
                            appDelegate.window?.rootViewController = sub
                            print("CustmoerId: \(CustmoerId)&&UserId: \(UserId)")
                        }else{
                            self.StartBtnOut.isHidden = false
                            self.subscribeBtn.isHidden = false
                            self.aboutUsBtn.isHidden = false
                        }
                    }else {
                        self.StartBtnOut.isHidden = false
                        self.subscribeBtn.isHidden = false
                        self.aboutUsBtn.isHidden = false
                    }
                    
                }
                else
                {
                    // move to Rate Page
                    let storyBoard : UIStoryboard = UIStoryboard(name: "NewHome", bundle:nil)
                    let sub = storyBoard.instantiateViewController(withIdentifier: "RateVC") as! RateVC
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    
                    appDelegate.window?.rootViewController = sub
                    
                }
                
                
                self.checkProjectsRate = check!
                
                
            }
        }
        
        
    }
}
