//
//  InformationTableViewController.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 9/14/17.
//  Copyright © 2017 Ahmed Wahdan. All rights reserved.
//

import UIKit

class AWObject {
    var title: String!
    var isSelected = false
    var isSelectable = true
    
    init(title: String) {
        self.title = title
    }
}

class InformationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var informationTableView: UITableView!
    
    
    
    var nameOfStatus = ""
    var EngNotes = ""
    var officePlace = ""
    var projectType = ""
    var numberOfSake = ""
    var customerDetials = ""
    var nameOfProject = ""
    var nameOfEmploy = ""
    var mobileEmploy = ""
    var numberALlmogh = ""
    var numberLicence = ""
    var space = ""
    var numberPlan = ""
    var LatBranch: Double = 0.0
    var LngBranch: Double = 0.0
    var ZoomBranch = ""
    var namePio = ""
    var nameEmp = ""
    var mobileEmp = ""
    var BranchName = ""
    var ProvincesName = ""
    var SectoinName = ""
    var ProjectsOrdersCellarErea = ""
    var ProjectsOrdersReFloorErea = ""
    var ProjectsOrdersSupplementErea = ""
    var ProjectsOrdersSupplementExternalErea = ""
    var ProjectsOrdersFloorErea = ""
    var ProjectsOrdersLandErea = ""
    var ProjectsOrdersFloorNummber = ""
    var ProjectsOrdersTotalBildErea = ""
    var ProjectsPaymentsWork = ""
    var ProjectsPaymentsDiscount = ""
    var ProjectsPaymentsCost = ""
    var ProjectStatusNum: String = ""
    var dataOfSak = ""
    var dataOfLicence = ""
    var ProjectStatusID: String = ""
    var objs: [AWObject]!
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var companyAddressLabel: UILabel!
    @IBOutlet weak var companyImageOut: UIImageView!{
        didSet {
            DispatchQueue.main.async {
                self.companyImageOut.layer.cornerRadius = 7.0
                self.companyImageOut.layer.masksToBounds = true
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        informationTableView.delegate = self
        informationTableView.dataSource = self
        self.informationTableView.flashScrollIndicators()
        self.objs = [AWObject(title: "بيانات الطلب"), AWObject(title: "بيانات المشروع")]
        informationTableView.reloadData()
        
        //        adjustUITextViewHeight(arg: EngNotes)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func adjustUITextViewHeight(arg : UITextView)
    {
        //        arg.translatesAutoresizingMaskIntoConstraints = true
        //        arg.sizeToFit()
        arg.isScrollEnabled = false
    }
    
    
    @IBAction func GoToBranch(_ sender: UIButton) {
        
        
    }
    
    func assignbackground(){
        DispatchQueue.main.async {
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
    
    //    var panelTitle = ["بيانات الطلب","بيانات المكتب والمهندس المسؤول","بيانات المشروع"]
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        if self.nameOfStatus == "تم الانجاز" || self.nameOfStatus == "جاري العمل" {
            return self.objs.count
        } else {
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 6
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 6
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return UITableViewAutomaticDimension
        }else{
            if self.nameOfStatus == "تم الانجاز" || self.nameOfStatus == "جاري العمل" {
                return 613
            }else {
                return 80
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch (indexPath.section) {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "RequestPanelTableViewCell", for: indexPath) as! RequestPanelTableViewCell
            cell.nameOfProject.text = nameOfProject
            cell.projectType.text = projectType
            cell.numberALlmogh.text = numberALlmogh
            cell.numberLicence.text = numberLicence
            cell.numberOfSake.text = numberOfSake
            cell.numberPlan.text = numberPlan
            if customerDetials == "" {
                cell.customerDetials.text = ""
            } else {
                cell.customerDetials.text = customerDetials
            }
            cell.space.text = space
            cell.dataOfSak.text = dataOfSak
            cell.dataOfLicence.text = dataOfLicence
            adjustUITextViewHeight(arg: cell.customerDetials)
            if EngNotes != "" {
                cell.EngNotesStack.isHidden = false
                cell.EngNotes.isHidden = false
                cell.EngNotesLabel.isHidden = false
                cell.EngNotes.text = EngNotes
                print("engNotes: \(EngNotes)")
                adjustUITextViewHeight(arg: cell.EngNotes)
            } else {
                cell.EngNotes.isHidden = true
                cell.EngNotesLabel.isHidden = true
                cell.EngNotesStack.isHidden = true
            }
            cell.contentView.backgroundColor = UIColor(red: 58/255.0, green: 59/255.0, blue: 60/255.0, alpha: 1.0)
            cell.layer.cornerRadius = 7
            cell.layer.borderColor = UIColor(red: 58/255.0, green: 59/255.0, blue: 60/255.0, alpha: 1.0).cgColor // set cell border color here
            cell.layer.masksToBounds = true
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProjectPanelTableViewCell", for: indexPath) as! ProjectPanelTableViewCell
            if self.nameOfStatus == "تم الانجاز" || self.nameOfStatus == "جاري العمل" {
                cell.AlertCodeLabel.isHidden = true
                cell.AlertImageOut.isHidden = true
                cell.contentStack.heightAnchor.constraint(equalToConstant: 560.0).isActive = true
                cell.contentStack.isHidden = false
                cell.ProvincesName.text = ProvincesName
                cell.SectoinName.text = SectoinName
                cell.ProjectsOrdersCellarErea.text = ProjectsOrdersCellarErea
                cell.ProjectsOrdersReFloorErea.text = ProjectsOrdersReFloorErea
                cell.ProjectsOrdersSupplementErea.text = ProjectsOrdersSupplementErea
                cell.ProjectsOrdersSupplementExternalErea.text = ProjectsOrdersSupplementExternalErea
                cell.ProjectsOrdersFloorErea.text = ProjectsOrdersFloorErea
                cell.ProjectsOrdersLandErea.text = ProjectsOrdersLandErea
                cell.ProjectsOrdersFloorNummber.text = ProjectsOrdersFloorNummber
                cell.ProjectsOrdersTotalBildErea.text = ProjectsOrdersTotalBildErea
                let largeNumber = Double(ProjectsPaymentsWork) ?? 0.0
                let numberFormatter = NumberFormatter()
                numberFormatter.numberStyle = NumberFormatter.Style.decimal
                let formattedNumber = numberFormatter.string(from: NSNumber(value:largeNumber))
                cell.ProjectsPaymentsWork.text = formattedNumber
                
                let largeNumber2 = Double(ProjectsPaymentsDiscount) ?? 0.0
                let numberFormatter2 = NumberFormatter()
                numberFormatter2.numberStyle = NumberFormatter.Style.decimal
                let formattedNumber2 = numberFormatter.string(from: NSNumber(value:largeNumber2))
                cell.ProjectsPaymentsDiscount.text = formattedNumber2
                
                let largeNumber3 = Double(ProjectsPaymentsCost) ?? 0.0
                let numberFormatter3 = NumberFormatter()
                numberFormatter3.numberStyle = NumberFormatter.Style.decimal
                let formattedNumber3 = numberFormatter.string(from: NSNumber(value:largeNumber3))
                cell.ProjectsPaymentsCost.text = formattedNumber3
            }else {
                cell.contentStack.isHidden = true
                cell.AlertCodeLabel.isHidden = false
                cell.AlertImageOut.isHidden = false
                cell.AlertCodeLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
            }
            
            
            cell.contentView.backgroundColor = UIColor(red: 58/255.0, green: 59/255.0, blue: 60/255.0, alpha: 1.0)
            cell.layer.cornerRadius = 7
            cell.layer.borderColor = UIColor(red: 58/255.0, green: 59/255.0, blue: 60/255.0, alpha: 1.0).cgColor // set cell border color here
            cell.layer.masksToBounds = true
            return cell
        }
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowEngInformation" {
            if let dest = segue.destination as? EngViewController {
                dest.BranchLatPass = self.LatBranch
                dest.BranchLngPass = self.LngBranch
                dest.BranchZoomPass = self.ZoomBranch
                dest.namePioPass = self.namePio
                dest.nameEmpPass = self.nameEmp
                dest.mobileEmpPass = self.mobileEmp
                dest.BranchNamePass = self.BranchName
            }
        }
        
    }
    
}
