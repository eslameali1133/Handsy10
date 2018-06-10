//
//  NewWelcomeScreenViewController.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 12/26/17.
//  Copyright © 2017 Ahmed Wahdan. All rights reserved.
//

import UIKit

class NewWelcomeScreenViewController: UIViewController {
    @IBOutlet weak var layerOne: UIImageView!
    @IBOutlet weak var layerTwo: UIImageView!
    @IBOutlet weak var Layerthree: UIImageView!
    @IBOutlet weak var LayerFour: UIImageView!
    @IBOutlet weak var LabelOne: UILabel!
    @IBOutlet weak var LabelTwo: UILabel!
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
    
    var topConstraint: NSLayoutConstraint?
    var topAnimateConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.navigationItem.hidesBackButton = true
//        self.tabBarController?.tabBar.isHidden = true
        self.LabelOne.alpha = 0
        self.LabelTwo.alpha = 0
        StartBtnOut.isHidden = true
        subscribeBtn.isHidden = true
        aboutUsBtn.isHidden = true
        if logout != "" {
            _ = Timer.scheduledTimer(timeInterval: 2.5, target: self, selector: #selector(checkLogOut), userInfo: nil, repeats: false)
        } else {
            _ = Timer.scheduledTimer(timeInterval: 2.5, target: self, selector: #selector(resetCount), userInfo: nil, repeats: false)
        }
        
        assignbackground()
        // Do any additional setup after loading the view.
    }
    
    @objc func resetCount() {
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
    
    @objc func checkLogOut() {
        self.StartBtnOut.isHidden = false
        self.subscribeBtn.isHidden = false
        self.aboutUsBtn.isHidden = false
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
    
    @IBAction func StartBtnAction(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "NewLogin", bundle: nil)
        let sub = storyboard.instantiateViewController(withIdentifier: "NewLoginViewController")
        self.navigationController?.pushViewController(sub, animated: true)
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
