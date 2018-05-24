//
//  OfficeFillterViewController.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 12/4/17.
//  Copyright © 2017 Ahmed Wahdan. All rights reserved.
//

import UIKit

class OfficeFillterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "مشروع جديد"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    

}
