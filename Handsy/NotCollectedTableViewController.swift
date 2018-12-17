//
//  NotCollectedTableViewController.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 9/16/17.
//  Copyright © 2017 Ahmed Wahdan. All rights reserved.
//

import UIKit

class NotCollectedTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NotCollectedMoneyModelDelegate {
    
    let model: NotCollectedMoneyModel = NotCollectedMoneyModel()
    var searchResu:[NotCollectedArray] = [NotCollectedArray]()
    let notCollectedMoneyDetialsModel = NotCollectedMoneyDetialsModel()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var NothingLabel: UILabel!
    @IBOutlet weak var AlertImage: UIImageView!
    @IBOutlet var loderview: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loderview.isHidden = true
        loderview.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        self.view.addSubview(loderview)
        
        DispatchQueue.main.async {
            self.NothingLabel.isHidden = true
            self.AlertImage.isHidden = true
        }
        tableView.delegate = self
        tableView.dataSource = self
         tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0.1))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if Reachability.isConnectedToNetwork(){
            print("Internet Connection Available!")
            model.delegate = self
            model.GetCustomerPaymentByCustID_PaymentStatus(view: self.view, VC: self)
        }else{
            print("Internet Connection not Available!")
            notCollectedMoneyDetialsModel.loadItems()
            self.searchResu = notCollectedMoneyDetialsModel.notCollectedArray
            if searchResu.count == 0 {
                NothingLabel.isHidden = false
                AlertImage.isHidden = false
                tableView.isHidden = true
            } else {
                tableView.isHidden = false
                NothingLabel.isHidden = true
                AlertImage.isHidden = true
            }
            self.tableView.reloadData()
        }
    }
    
    func dataReady() {
        loderview.isHidden = false
        
        // Access the video objects that have been downloaded
        self.searchResu = self.model.resultArray
        notCollectedMoneyDetialsModel.removeAllItems()
        for i in self.model.resultArray {
            self.notCollectedMoneyDetialsModel.append(i)
        }
        // Tell the tableview to reload
        self.tableView.reloadData()
         loderview.isHidden = true
    }
    
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if searchResu.count == 0 {
            NothingLabel.isHidden = false
            AlertImage.isHidden = false
            tableView.isHidden = true
        } else {
            tableView.isHidden = false
            NothingLabel.isHidden = true
            AlertImage.isHidden = true
        }
        if(searchResu.count == 1)
        {
            tableView.isScrollEnabled = false;
        }
        return searchResu.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 186
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotCollectedTableViewCell", for: indexPath) as! NotCollectedTableViewCell
        cell.projectTitleLabel.text = searchResu[indexPath.section].ProjectTitle
        cell.CompanyNameLabel.text = searchResu[indexPath.section].ComapnyName
        cell.EmpNameLabel.setTitle(searchResu[indexPath.section].EmpName, for: .normal) 
        let largeNumber = Double(searchResu[indexPath.section].PaymentValue)
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        let formattedNumber = numberFormatter.string(from: NSNumber(value:largeNumber!))
        cell.MoneyOfDf3a.text = formattedNumber
        let RefranceIdEqual = searchResu[indexPath.section].RefranceId
        cell.numberOfDf3A.text = "دفعة رقم:  \(RefranceIdEqual)"
        cell.Saknumber.text = searchResu[indexPath.section].ProjectId
        if searchResu[indexPath.section].projectOrderContractPhotoPath == "" {
         cell.contractBtn.isHidden = true
        }else
        {
            cell.contractBtn.isEnabled = true
            
//            if searchResu[indexPath.section].ProjectContract == "1" {
//                cell.contractBtn.isEnabled = false
//            }else {
//                
//                cell.contractBtn.isEnabled = true
//            }
        }
    
        cell.contentView.backgroundColor = UIColor(red: 58/255.0, green: 59/255.0, blue: 60/255.0, alpha: 1.0)
        cell.layer.borderColor = UIColor(red: 58/255.0, green: 59/255.0, blue: 60/255.0, alpha: 1.0).cgColor // set cell border color here
        cell.layer.borderWidth = 1.0
        cell.layer.masksToBounds = true
        
        
        return cell
    }
    @IBAction func projectDetialBtn(_ sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: tableView)
        let index = tableView.indexPathForRow(at: point)?.section
        let storyBoard : UIStoryboard = UIStoryboard(name: "NewHome", bundle:nil)
        let secondView = storyBoard.instantiateViewController(withIdentifier: "NewProjectDetialsFilterTableViewController") as! NewProjectDetialsFilterTableViewController
        let proId = searchResu[index!].ProjectId
        print("pro" + proId)
        print("ind" + "\(index!)")
        secondView.norma = "Hi"
        secondView.ProjectId = proId
        secondView.ProjectTitle = searchResu[index!].ProjectTitle
        self.navigationController?.pushViewController(secondView, animated: true)
    }
    
    @IBAction func VisubleContractAction(_ sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: tableView)
        let index = tableView.indexPathForRow(at: point)?.section
        let storyBoard : UIStoryboard = UIStoryboard(name: "DesignsAndDetails", bundle:nil)
        let secondView = storyBoard.instantiateViewController(withIdentifier: "openPdfViewController") as! openPdfViewController
        secondView.url = searchResu[index!].projectOrderContractPhotoPath
        secondView.Webtitle = "العقد"
        tableView.reloadData()
        self.navigationController?.pushViewController(secondView, animated: true)
    }
    
    
    @IBAction func CallEmp(_ sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: tableView)
        let index = tableView.indexPathForRow(at: point)?.section
        
        let mobileNum =  searchResu[index!].EmpPhone
        var mobile: String = (mobileNum)
        if mobile.count == 10 {
            if mobile.first! == "0" {
                if mobile[mobile.index(mobile.startIndex, offsetBy: 1)] == "5" {
                    mobile.remove(at: mobile.startIndex)
                    mobile.insert("6", at: mobile.startIndex)
                    mobile.insert("6", at: mobile.startIndex)
                    mobile.insert("9", at: mobile.startIndex)
                    callNumber(phoneNumber: mobile)
                } else {
                    callNumber(phoneNumber: mobile)
                }
            } else {
                callNumber(phoneNumber: mobile)
            }
        } else {
            callNumber(phoneNumber: mobile)
        }
        
        
    }
    
    private func callNumber(phoneNumber:String) {
        
        if let phoneCallURL = URL(string: "tel://\(phoneNumber)") {
            
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                application.open(phoneCallURL, options: [:], completionHandler: nil)
            }
        }
    }
    
}
