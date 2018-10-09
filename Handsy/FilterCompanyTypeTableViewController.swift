//
//  FilterCompanyTypeTableViewController.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 3/10/18.
//  Copyright © 2018 Ahmed Wahdan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class FilterCompanyTypeTableViewController: UITableViewController {

    var barBtnDelegate: BarBtnDelegate?
    var barBtnMapDelegate: BarBtnMapDelegate?
    var arrayofCompanyType = [CompanyType]()
    var reate = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        GetCompanyType()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayofCompanyType.count+1
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FilterCompanyTypeTableViewCell", for: indexPath) as! FilterCompanyTypeTableViewCell
        // Configure the cell...
        if indexPath.row == 0 {
            cell.CompanyTypeName.text = "كل التخصصات"
        }else {
            cell.CompanyTypeName.text = arrayofCompanyType[indexPath.row-1].CompanyTypeName
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.barBtnDelegate == nil {
            if indexPath.row == 0 {
              
                self.barBtnMapDelegate?.BarBtnSortExpDidChange(SortExp: "", companyTypeName: "كل التخصصات",RateNumber: reate)
                self.dismiss(animated: false, completion: nil)
            }else {
                  print(reate)
                   print(arrayofCompanyType[indexPath.row-1].CompanyTypeName)
                self.barBtnMapDelegate?.BarBtnSortExpDidChange(SortExp: arrayofCompanyType[indexPath.row-1].CompanyTypeID, companyTypeName: arrayofCompanyType[indexPath.row-1].CompanyTypeName, RateNumber:reate)
                self.dismiss(animated: false, completion: nil)
            }
            
        }else {
            if indexPath.row == 0 {
                self.barBtnDelegate?.BarBtnSortExpDidChange(SortExp: "", companyTypeName: "كل التخصصات", Rate: reate)
                self.dismiss(animated: false, completion: nil)
            }else {
                self.barBtnDelegate?.BarBtnSortExpDidChange(SortExp: arrayofCompanyType[indexPath.row-1].CompanyTypeID, companyTypeName: arrayofCompanyType[indexPath.row-1].CompanyTypeName, Rate: reate)
                self.dismiss(animated: false, completion: nil)
            }
        }
        
    }
    
    @IBAction func closeBtn(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }
    
    
    func GetCompanyType(){
        let sv = UIViewController.displaySpinner(onView: self.view)
        self.arrayofCompanyType.removeAll()
        
        Alamofire.request("http://smusers.promit2030.com/Service1.svc/GetCompanyType", method: .get, encoding: URLEncoding.default).responseJSON { response in
            debugPrint(response)
            switch response.result {
            case .success:
                for json in JSON(response.result.value!).arrayValue {
                    let requestProjectObj = CompanyType()
                    requestProjectObj.CompanyTypeID = json["CompanyTypeID"].stringValue
                    requestProjectObj.CompanyTypeName = json["CompanyTypeName"].stringValue
                    
                    self.arrayofCompanyType.append(requestProjectObj)
                }
                self.tableView.reloadData()
                UIViewController.removeSpinner(spinner: sv)
            case .failure(let error):
                print(error)
                UIViewController.removeSpinner(spinner: sv)
                let alertAction = UIAlertController(title: "خطاء في الاتصال", message: "اعادة المحاولة", preferredStyle: .alert)
                
                alertAction.addAction(UIAlertAction(title: "نعم", style: .default, handler: { action in
                    self.GetCompanyType()
                }))
                
                alertAction.addAction(UIAlertAction(title: "رجوع", style: .cancel, handler: { action in
                    self.navigationController!.popViewController(animated: true)
                }))
                
                self.present(alertAction, animated: true, completion: nil)
                
            }
        }
        
    }
}
