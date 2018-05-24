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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.NothingLabel.isHidden = true
            self.AlertImage.isHidden = true
        }
        tableView.delegate = self
        tableView.dataSource = self
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
        // Access the video objects that have been downloaded
        self.searchResu = self.model.resultArray
        notCollectedMoneyDetialsModel.removeAllItems()
        for i in self.model.resultArray {
            self.notCollectedMoneyDetialsModel.append(i)
        }
        // Tell the tableview to reload
        self.tableView.reloadData()
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
        return searchResu.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotCollectedTableViewCell", for: indexPath) as! NotCollectedTableViewCell
        cell.projectTitleLabel.text = searchResu[indexPath.section].ProjectTitle
        cell.CompanyNameLabel.text = searchResu[indexPath.section].ComapnyName
        let largeNumber = Double(searchResu[indexPath.section].PaymentValue)
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        let formattedNumber = numberFormatter.string(from: NSNumber(value:largeNumber!))
        cell.MoneyOfDf3a.text = formattedNumber
        let RefranceIdEqual = searchResu[indexPath.section].RefranceId
        cell.numberOfDf3A.text = "دفعة رقم:  \(RefranceIdEqual)"
        if searchResu[indexPath.section].ProjectContract == "1" {
            cell.contractBtn.isEnabled = true
        }else {
            cell.contractBtn.isEnabled = false
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
    
}
