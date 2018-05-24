//
//  CollectedTableViewController.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 9/16/17.
//  Copyright © 2017 Ahmed Wahdan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class CollectedTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CollectedModelDelegate {
    
    let model: CollectedMoneyModel = CollectedMoneyModel()
    var searchResu:[CollectedArray] = [CollectedArray]()
    let collectedMoneyDetialsModel : CollectedMoneyDetialsModel = CollectedMoneyDetialsModel()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var NothingLabel: UILabel!
    @IBOutlet weak var AlertImage: UIImageView!
   
    
    func dataReady() {
        // Access the video objects that have been downloaded
        self.searchResu = self.model.resultArray
        collectedMoneyDetialsModel.removeAllItems()
        for i in self.model.resultArray {
            self.collectedMoneyDetialsModel.append(i)
        }
        
        // Tell the tableview to reload
        self.tableView.reloadData()
    }
    
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
            collectedMoneyDetialsModel.loadItems()
            self.searchResu = collectedMoneyDetialsModel.collectedArray
            if searchResu.count == 0 {
                NothingLabel.isHidden = false
                AlertImage.isHidden = false
                tableView.isHidden = true
            } else {
                tableView.isHidden = false
                NothingLabel.isHidden = true
                AlertImage.isHidden = true
            }
            tableView.reloadData()
        }
        
    }
    
    @IBAction func DownloadIsal(_ sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: tableView)
        let index = tableView.indexPathForRow(at: point)?.section
        let downloadISal = searchResu[index!].projectOrderInvoicePhotoPath
        download(url: downloadISal)
    }
    
    func download(url: String){
        let destination: DownloadRequest.DownloadFileDestination = { _, _ in
            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let date = Date(timeIntervalSinceNow: 0)
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .medium
            dateFormatter.string(from: date)
            if url.range(of:"pdf") != nil {
                print("Yes it contains 'pdf'")
                let fileURL = documentsURL.appendingPathComponent("file\(date).pdf")
                return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
            } else if url.range(of:"jpeg") != nil {
                let fileURL = documentsURL.appendingPathComponent("file\(date).jpeg")
                print("Yes it contains 'jpeg'")
                return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
            } else {
                let fileURL = documentsURL.appendingPathComponent("file\(date).png")
                print("Yes it contains 'png'")
                return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
            }
        }
        
        Alamofire.download(url, to: destination).response { response in
            print(response)
            
        }
        //        Alamofire.download(url).responseData { response in
        //            if let data = response.result.value {
        //                print(response)
        //                let image = UIImage(data: data)
        //            }
        //        }
    }
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
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
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CollectedTableViewCellA", for: indexPath) as! CollectedTableViewCellA
        cell.ProjectTitleB.text = searchResu[indexPath.section].ProjectTitle
        cell.CompanyNameLabel.text = searchResu[indexPath.section].ComapnyName
        cell.PaymentTypeNameLabel.text = searchResu[indexPath.section].PaymentTypeName
        cell.ProjectsPaymentsNumberLabel.text = searchResu[indexPath.section].ProjectsPaymentsNumber
        cell.PayDate.text = searchResu[indexPath.section].PayDate
        let paydateHijri = searchResu[indexPath.section].PayDateHijri
        let paytime = searchResu[indexPath.section].PayTime
        cell.PayDateHijri.text = paytime + " - " + paydateHijri
        let RefranceIdEqual = searchResu[indexPath.section].RefranceId
        cell.numberOfDf3A.text = "دفعة رقم:  \(RefranceIdEqual)"
        let NewlargeNumber = Double(searchResu[indexPath.section].PaymentValue)
        let NewnumberFormatter = NumberFormatter()
        NewnumberFormatter.numberStyle = NumberFormatter.Style.decimal
        let NewformattedNumber = NewnumberFormatter.string(from: NSNumber(value:NewlargeNumber!))
        cell.PaymentValueLabel.text = NewformattedNumber
        if searchResu[indexPath.section].ProjectContract == "1" {
            cell.contractBtn.isEnabled = true
        }else {
            cell.contractBtn.isEnabled = false
        }
        cell.projectDetialOut.tag = indexPath.section
        cell.contentView.backgroundColor = UIColor(red: 58/255.0, green: 59/255.0, blue: 60/255.0, alpha: 1.0)
        cell.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.0862745098, blue: 0.0862745098, alpha: 1)
        cell.layer.borderWidth = 1.0
        cell.layer.masksToBounds = true
        
        return cell
    }
    
    @IBAction func projectDetialsBtn(_ sender: UIButton) {
        let index = sender.tag
        let storyBoard : UIStoryboard = UIStoryboard(name: "NewHome", bundle:nil)
        let secondView = storyBoard.instantiateViewController(withIdentifier: "NewProjectDetialsFilterTableViewController") as! NewProjectDetialsFilterTableViewController
        let proId = searchResu[index].ProjectId
        print("pro" + proId)
        print("ind" + "\(index)")
        secondView.ProjectId = proId
        secondView.norma = "Hi"
        secondView.ProjectTitle = searchResu[index].ProjectTitle
        self.navigationController?.pushViewController(secondView, animated: true)
    }
    
    @IBAction func viewInvoice(_ sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: tableView)
        let index = tableView.indexPathForRow(at: point)?.section
        let storyBoard : UIStoryboard = UIStoryboard(name: "DesignsAndDetails", bundle:nil)
        let secondView = storyBoard.instantiateViewController(withIdentifier: "openPdfViewController") as! openPdfViewController
        secondView.url = searchResu[index!].projectOrderInvoicePhotoPath
        secondView.Webtitle = "الايصال"
        tableView.reloadData()
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

extension Double {
    func withCommas() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        return numberFormatter.string(from: NSNumber(value:self))!
    }
}
