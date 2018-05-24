//
//  NoSignUpViewController.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 9/25/17.
//  Copyright © 2017 Ahmed Wahdan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class NoSignUpViewController: UIViewController {

    var facebookString = ""
    var twitterString = ""
    var youtubeString = ""
    var instagramString = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assignbackground()
        GetSocialMedia()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func GetSocialMedia() {
        Alamofire.request("http://smusers.promit2030.com/Service1.svc/GetSocialMedia", method: .get, encoding: URLEncoding.default).responseJSON { (response) in
            debugPrint(response)
            let json = JSON(response.result.value!)
            self.facebookString = json["Facebook"].stringValue
            self.instagramString = json["Instgram"].stringValue
            self.youtubeString = json["Youtube"].stringValue
            self.twitterString = json["Twitter"].stringValue
        }
    }
    

    @IBAction func AboutOfficeBtn(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Home", bundle:nil)
        let secondView = storyBoard.instantiateViewController(withIdentifier: "AboutCompanyTableViewController") as! AboutCompanyTableViewController
        self.navigationController?.pushViewController(secondView, animated: true)
    }
    
    @IBAction func ProjectsBtn(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Home", bundle:nil)
        let secondView = storyBoard.instantiateViewController(withIdentifier: "OurProjectsCollectionViewController") as! OurProjectsCollectionViewController
        self.navigationController?.pushViewController(secondView, animated: true)
    }
    
    @IBAction func LocationOfficeBtn(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Home", bundle:nil)
        let secondView = storyBoard.instantiateViewController(withIdentifier: "ContactUSTableViewController") as! ContactUSTableViewController
        self.navigationController?.pushViewController(secondView, animated: true)
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
    @IBAction func facebookBtn(_ sender: UIButton) {
        let settingsUrl = URL(string: facebookString) as! URL
        UIApplication.shared.open(settingsUrl, options: [:], completionHandler: nil)
    }
    @IBAction func twitterBtn(_ sender: UIButton) {
        let settingsUrl = URL(string:twitterString) as! URL
        UIApplication.shared.open(settingsUrl, options: [:], completionHandler: nil)
    }
    @IBAction func youtubeBtn(_ sender: UIButton) {
        let settingsUrl = URL(string:youtubeString) as! URL
        UIApplication.shared.open(settingsUrl, options: [:], completionHandler: nil)
    }
    @IBAction func instagramBtn(_ sender: UIButton) {
        let settingsUrl = URL(string:instagramString) as! URL
        UIApplication.shared.open(settingsUrl, options: [:], completionHandler: nil)
    }

}
