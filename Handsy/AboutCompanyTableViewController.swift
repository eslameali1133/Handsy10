//
//  AboutCompanyTableViewController.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 8/19/17.
//  Copyright © 2017 Ahmed Wahdan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class AboutCompanyTableViewController: UITableViewController, ServiceOfCompanyModelDelegate {
    
    var searchResu:[ArrayServiceOfCompany] = [ArrayServiceOfCompany]()
    
    let model: ServiceOfCompanyModel = ServiceOfCompanyModel()
    
    var AboutTitle: String?
    var AboutContent: String?
    var ExperTitle: String?
    var ExperContent: String?
    
    var CompanyInfoID = ""
    var isCompany = ""
    
    var resultAboutArray = [AboutArray]()
    let aboutModel = AboutModel()
    
    let serviceModel = ServiceModel()
    var arrayServiceCompany = [String: ArrayServiceOfCompany]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if Reachability.isConnectedToNetwork(){
            print("Internet Connection Available!")
            GetAbout()
            model.delegate = self
            model.GetServices(view: self.view)
        }else{
            aboutModel.loadItems()
            if CompanyInfoID == "" {
                CompanyInfoID = UserDefaults.standard.string(forKey: "CompanyInfoID")!
                if aboutModel.returnProjectDetials(at: CompanyInfoID) != nil {
                    let aboutDetials = aboutModel.returnProjectDetials(at: CompanyInfoID)
                    self.resultAboutArray = [aboutDetials!]
                }
                if serviceModel.returnProjectDetials(at: CompanyInfoID) != nil {
                    let serviceDetials = serviceModel.returnProjectDetials(at: CompanyInfoID)
                    self.searchResu = serviceDetials!
                }
                print("comp: \(CompanyInfoID)")
            }else {
                if aboutModel.returnProjectDetials(at: CompanyInfoID) != nil {
                    let aboutDetials = aboutModel.returnProjectDetials(at: CompanyInfoID)
                    self.resultAboutArray = [aboutDetials!]
                }
                if serviceModel.returnProjectDetials(at: CompanyInfoID) != nil {
                    let serviceDetials = serviceModel.returnProjectDetials(at: CompanyInfoID)
                    self.searchResu = serviceDetials!
                }
            }
            tableView.reloadData()
        }
        if isCompany == "0" {
            navigationItem.title = "عن المهندس"
        }else {
            navigationItem.title = "عن الشركة"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dataReady() {
        // Access the video objects that have been downloaded
        self.searchResu = self.model.resultArray
        if CompanyInfoID == "" {
            self.serviceModel.append(self.model.resultArray, index: CompanyInfoID)
        }else{
            let companyInfoID = UserDefaults.standard.string(forKey: "CompanyInfoID")!
            self.serviceModel.append(self.model.resultArray, index: companyInfoID)
        }
        
        // Tell the tableview to reload
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResu.count+2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AboutTableViewCell", for: indexPath) as! AboutTableViewCell
            if Reachability.isConnectedToNetwork(){
                print("Internet Connection Available!")
                cell.AboutTit.text = AboutTitle
                cell.AboutConten.text = AboutContent
            }else{
                cell.AboutTit.text = resultAboutArray[indexPath.row].AboutTitle
                cell.AboutConten.text = resultAboutArray[indexPath.row].AboutContent
            }
            return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ExperienceTableViewCell", for: indexPath) as! ExperienceTableViewCell
            if Reachability.isConnectedToNetwork(){
                print("Internet Connection Available!")
                cell.ExperienceTit.text = ExperTitle
                cell.ExperienceConten.text = ExperContent
            }else{
                cell.ExperienceTit.text = resultAboutArray[indexPath.row-1].ExperTitle
                cell.ExperienceConten.text = resultAboutArray[indexPath.row-1].ExperContent
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AboutCompanyTableViewCell", for: indexPath) as! AboutCompanyTableViewCell
            cell.ServiceName.text = searchResu[indexPath.row-2].serviceName
            adjustUITextViewHeight(arg: cell.Content)
            cell.Content.text = searchResu[indexPath.row-2].content
            return cell
        }
        
    }
 
    func adjustUITextViewHeight(arg : UITextView)
    {
        //        arg.translatesAutoresizingMaskIntoConstraints = true
        //        arg.sizeToFit()
        arg.isScrollEnabled = false
    }

    func GetAbout() {
        let parameters: Parameters?
        var CompInfID: String?
        if CompanyInfoID == "" {
            parameters = [
                "CompanyInfoID": UserDefaults.standard.string(forKey: "CompanyInfoID")!
            ]
            CompInfID = UserDefaults.standard.string(forKey: "CompanyInfoID")!
        } else {
            parameters = [
                "CompanyInfoID": CompanyInfoID
            ]
            CompInfID = CompanyInfoID
        }
        let sv = UIViewController.displaySpinner(onView: self.view)
        
        Alamofire.request("http://smusers.promit2030.com/Service1.svc/GetAbout", method: .get, parameters: parameters, encoding: URLEncoding.default).responseJSON { response in
            let json = JSON(response.result.value!)
            print(json)
            let aboutArray = AboutArray(AboutTitle: json["AboutTilte"].stringValue, AboutContent: json["AboutContent"].stringValue, ExperTitle: json["ExperienceTitle"].stringValue, ExperContent: json["ExperienceContent"].stringValue, CompanyInfoID: CompInfID!)
            self.resultAboutArray.append(aboutArray)
            for i in self.resultAboutArray {
                self.aboutModel.append(i)
            }
            self.AboutTitle = json["AboutTilte"].stringValue
            self.AboutContent = json["AboutContent"].stringValue
            self.ExperTitle = json["ExperienceTitle"].stringValue
            self.ExperContent = json["ExperienceContent"].stringValue
            UIViewController.removeSpinner(spinner: sv)
        }
    }
}
