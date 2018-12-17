//
//  EditAViewController.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 8/7/17.
//  Copyright © 2017 Ahmed Wahdan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import MapKit

class EditATableViewController: UITableViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    var resultArrayProject = [SelectSection]()
    let pikerProjectLable = UIPickerView()
    
    var PrjTypeID = ""
    var BranchID = ""
    var BranchName: String = ""
    var ProjectsPaymentsCost: String = ""
    var CountNotPaid: String = ""
    var CountPaid: String = ""
    var CustmoerName: String = ""
    var CustomerEmail: String = ""
    var CustomerMobile: String = ""
    var CustomerNationalId: String = ""
    var DataSake: String = ""
    var DateLicence: String = ""
    var EmpImage: String = ""
    var EmpMobile: String = ""
    var EmpName: String = ""
    var GroundId: String = ""
    var IsDeleted: String = ""
    var JobName: String = ""
    var LatBranch: Double = 0.0
    var LatPrj: String = ""
    var LicenceNum: String = ""
    var LngBranch: Double = 0.0
    var LngPrj: String = ""
    var Notes: String = ""
    var PlanId: String = ""
    var ProjectInvoice: String = ""
    var ProjectContract: String = ""
    var ProjectStatusNum: String = ""
    var ProjectBildTypeId: String = ""
    var ProjectEngComment: String = ""
    var ProjectId: String = ""
    var ProjectStatusColor: String = ""
    var ProjectStatusID: String = ""
    var ProjectStatusName: String = ""
    var ProjectTitle: String = ""
    var ProjectTypeId: String = ""
    var ProjectTypeName: String = ""
    var SakNum: String = ""
    var Space: String = ""
    var Status: String = ""
    var TotalNotPaid: String = ""
    var TotalPaid: String = ""
    var ZoomBranch: String = ""
    var ZoomPrj: String = ""
    var projectOrderContractPhotoPath: String = ""
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
    var CompanyInfoID = ""
    var ProjectId1: String = ""
    var backTo: String = ""
    var ProjectsImagePath = ""
    var ProjectsImageRotate = ""
    var ProjectsImageType = ""
    var ComapnyNameVar = ""
    var companyAddress = ""
    var Logo = ""
    let imageView = UIImageView(image: #imageLiteral(resourceName: "splash"))
    var arrayOfResulr = [GetOfficesArray]()
    
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
    
    @IBOutlet weak var nextBtn: UIButton! {
        didSet {
            DispatchQueue.main.async {
                self.nextBtn.circleView(UIColor.black, borderWidth: 1.0)
            }
        }
    }
    
    @IBOutlet weak var alertProject: UILabel!
   
    @IBOutlet weak var chooseProjectLable: UITextField!
    
    @IBOutlet var NextView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GetProjectByProjectId()
        self.view.sendSubview(toBack: self.imageView)
        
        chooseProjectLable.text = ProjectTypeName
        pikerProjectLable.delegate = self
        pikerProjectLable.dataSource = self
        chooseProjectLable.inputView = pikerProjectLable
        assignbackground()
        chooseProjectLable.setBottomBorderGray()
        
        alertProject.isHidden = true
        
        
        GetImageprojectByProjID()
        
        
        let black = UIColor(red: 24.0/255.0, green: 23.0/255.0, blue: 23.0/255.0, alpha: 1.0)
        
        self.chooseProjectLable.AddImage(.left, imageName: "star", Frame: CGRect(x: 3, y: 0, width: 7, height: 7), backgroundColor: black)
        
        
        DispatchQueue.main.async {
            self.NextView.frame = CGRect.init(x: 0 , y: self.tableView.frame.height-170, width: self.tableView.frame.width, height: 110)
            self.tableView.addSubview(self.NextView)
        }
        
    }
    
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    @IBAction func Next(_ sender: UIButton) {
        let whitespaceSet = CharacterSet.whitespaces
        if  chooseProjectLable.text != "" {
            let storyBoard : UIStoryboard = UIStoryboard(name: "ProjectsAndEdit", bundle:nil)
            let secondView = storyBoard.instantiateViewController(withIdentifier: "EditCViewController") as! EditCViewController
            self.navigationController?.pushViewController(secondView, animated: true)
            let selectSection = BranchID
            let selectProject = PrjTypeID
            
            secondView.BranchID = BranchID
            secondView.BranchName = selectSection
            secondView.CustmoerName = CustmoerName
            secondView.CustomerEmail = CustomerEmail
            secondView.CustomerMobile = CustomerMobile
            secondView.CustomerNationalId = CustomerNationalId
            secondView.DataSake = DataSake
            secondView.DateLicence = DateLicence
            secondView.EmpImage = EmpImage
            secondView.EmpMobile = EmpMobile
            secondView.EmpName = EmpName
            secondView.GroundId = ""
            secondView.IsDeleted = IsDeleted
            secondView.JobName = JobName
            secondView.LatBranch = LatBranch
            secondView.LatPrj = LatPrj
            secondView.LicenceNum = ""
            secondView.LngBranch = LngBranch
            secondView.LngPrj = LngPrj
            secondView.Notes = Notes
            secondView.PlanId = ""
            secondView.ProjectBildTypeId = ProjectBildTypeId
            secondView.ProjectEngComment = ProjectEngComment
            secondView.ProjectId = ProjectId
            secondView.ProjectStatusColor = ProjectStatusColor
            secondView.ProjectStatusID = ProjectStatusID
            secondView.ProjectStatusName = ProjectStatusName
            secondView.ProjectTitle = ProjectTitle
            secondView.ProjectTypeId = ProjectTypeId
            secondView.ProjectTypeName = selectProject
            secondView.SakNum = ""
            secondView.Space = ""
            secondView.Status = Status
            secondView.ZoomBranch = ZoomBranch
            secondView.ZoomPrj = ZoomPrj
            secondView.ProjectsImagePath = ProjectsImagePath
            secondView.ProjectsImageRotate = ProjectsImageRotate
            secondView.ProjectsImageType = ProjectsImageType
            secondView.DataSake = ""
            secondView.DateLicence = ""
            secondView.Notes = ""
            
        } else {
            
            if chooseProjectLable.text == "" {
                alertProject.isHidden = false
                chooseProjectLable.setBottomBorderRed()
                //                tableView.reloadRows(at: [IndexPath.init(row: 2, section: 0)], with: .automatic)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                DispatchQueue.main.async {
                    self.view.sendSubview(toBack: self.imageView)
                    self.assignbackground()
                }
            }
            
        }
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        DispatchQueue.main.async {
            self.view.sendSubview(toBack: self.imageView)
            self.assignbackground()
        }
        return true
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return resultArrayProject.count+1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
            if row == 0{
                return "- اختر المشروع -"
            }else {
                return resultArrayProject[row-1].PrjTypeName
            }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
            if resultArrayProject.count != 0 {
                if row == 0 {
                    chooseProjectLable.text = nil
                }else {
                    chooseProjectLable.text = resultArrayProject[row-1].PrjTypeName
                    self.PrjTypeID = resultArrayProject[row-1].PrjTypeID
                }
                
            }
        self.view.endEditing(true)
    }
    
    
    
    func assignbackground(){
        DispatchQueue.main.async {
            self.imageView.contentMode = .scaleAspectFill
            self.view.insertSubview(self.imageView, at: 0)
            self.imageView.translatesAutoresizingMaskIntoConstraints = false
            self.imageView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
            self.imageView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
            self.imageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
            self.imageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
            self.imageView.layoutIfNeeded()
        }
    }    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func GetProjecttypes() {
        
        let parameters: Parameters = [
            "branchID": BranchID
        ]
        
        Alamofire.request("http://smusers.promit2030.co/Service1.svc/GetProjecttypes", method: .get, parameters: parameters, encoding: URLEncoding.default).responseJSON { response in
            debugPrint(response)
            
            
            var arrayOfResulr = [SelectSection]()
            
            for json in JSON(response.result.value!).arrayValue {
                let nPostObj = SelectSection()
                
                nPostObj.PrjTypeName = json["PrjTypeName"].stringValue
                nPostObj.PrjTypeID = json["PrjTypeID"].stringValue
                arrayOfResulr.append(nPostObj)
                
            }
            
            self.resultArrayProject = arrayOfResulr
            
            
        }
    }
    
    func GetProjectByProjectId() {
        
        let parameters: Parameters = [
            "projectId": self.ProjectId
        ]
        
        Alamofire.request("http://smusers.promit2030.co/Service1.svc/GetProjectByProjectId", method: .get, parameters: parameters, encoding: URLEncoding.default).responseJSON { response in
            debugPrint(response)
            
            let json = JSON(response.result.value!)
            self.ProjectId = json["ProjectId"].stringValue
            self.ProjectsPaymentsCost = json["ProjectsPaymentsCost"].stringValue
            self.CountNotPaid = json["CountNotPaid"].stringValue
            self.CountPaid = json["CountPaid"].stringValue
            self.EmpImage = json["EmpImage"].stringValue
            self.BranchID = json["BranchID"].stringValue
            self.BranchName  = json["BranchName"].stringValue
            self.CustmoerName = json["CustmoerName"].stringValue
            self.CustomerEmail = json["CustomerEmail"].stringValue
            self.CustomerMobile = json["CustomerMobile"].stringValue
            self.CustomerNationalId = json["CustomerNationalId"].stringValue
            self.DataSake = json["DataSake"].stringValue
            self.DateLicence = json["DateLicence"].stringValue
            self.EmpMobile = json["EmpMobile"].stringValue
            self.EmpName = json["EmpName"].stringValue
            self.GroundId = json["GroundId"].stringValue
            self.IsDeleted = json["IsDeleted"].stringValue
            self.JobName = json["JobName"].stringValue
            self.LatBranch = json["LatBranch"].doubleValue
            self.LatPrj = json["LatPrj"].stringValue
            self.LicenceNum = json["LicenceNum"].stringValue
            self.LngBranch = json["LngBranch"].doubleValue
            self.LngPrj = json["LngPrj"].stringValue
            self.Notes = json["Notes"].stringValue
            self.PlanId = json["PlanId"].stringValue
            self.ProjectInvoice = json["ProjectInvoice"].stringValue
            self.ProjectContract = json["ProjectContract"].stringValue
            self.ProjectStatusNum = json["ProjectStatusNum"].stringValue
            self.ProjectBildTypeId = json["ProjectBildTypeId"].stringValue
            self.ProjectEngComment = json["ProjectEngComment"].stringValue
            self.ProjectStatusColor = json["ProjectStatusColor"].stringValue
            self.ProjectStatusID = json["ProjectStatusID"].stringValue
            self.ProjectStatusName = json["ProjectStatusName"].stringValue
            self.ProjectTitle = json["ProjectTitle"].stringValue
            self.ProjectTypeId = json["ProjectTypeId"].stringValue
            self.ProjectTypeName = json["ProjectTypeName"].stringValue
            self.SakNum = json["SakNum"].stringValue
            self.Space = json["Space"].stringValue
            self.Status = json["Status"].stringValue
            self.TotalNotPaid = json["TotalNotPaid"].stringValue
            self.TotalPaid = json["TotalPaid"].stringValue
            self.ZoomBranch = json["ZoomBranch"].stringValue
            self.ZoomPrj = json["ZoomPrj"].stringValue
            self.projectOrderContractPhotoPath = json["projectOrderContractPhotoPath"].stringValue
            self.ProvincesName = json["ProvincesName"].stringValue
            self.SectoinName = json["SectoinName"].stringValue
            self.ProjectsOrdersCellarErea = json["ProjectsOrdersCellarErea"].stringValue
            self.ProjectsOrdersReFloorErea = json["ProjectsOrdersReFloorErea"].stringValue
            self.ProjectsOrdersSupplementErea = json["ProjectsOrdersSupplementErea"].stringValue
            self.ProjectsOrdersSupplementExternalErea = json["ProjectsOrdersSupplementExternalErea"].stringValue
            self.ProjectsOrdersFloorErea = json["ProjectsOrdersFloorErea"].stringValue
            self.ProjectsOrdersLandErea = json["ProjectsOrdersLandErea"].stringValue
            self.ProjectsOrdersFloorNummber = json["ProjectsOrdersFloorNummber"].stringValue
            self.ProjectsOrdersTotalBildErea = json["ProjectsOrdersTotalBildErea"].stringValue
            self.ProjectsPaymentsWork = json["ProjectsPaymentsWork"].stringValue
            self.ProjectsPaymentsDiscount = json["ProjectsPaymentsDiscount"].stringValue
            self.CompanyInfoID = json["CompanyInfoID"].stringValue
            self.ComapnyNameVar = json["ComapnyName"].stringValue
            self.companyAddress = json["Address"].stringValue
            self.Logo = json["Logo"].stringValue
            self.ComapnyNameFunc(ComapnyNameL: self.ComapnyNameVar, companyAddres: self.companyAddress, companyLogo: self.Logo)
            self.GetProjecttypes()
        }
        
    }
    
    func ComapnyNameFunc(ComapnyNameL: String, companyAddres: String, companyLogo: String){
        companyNameLabel.text = ComapnyNameL
        companyAddressLabel.text = companyAddress
        let trimmedString = companyLogo.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        if let url = URL.init(string: trimmedString!) {
            companyImageOut.hnk_setImageFromURL(url, placeholder: #imageLiteral(resourceName: "officePlaceholder"))
        } else{
            print("nil")
            companyImageOut.image = #imageLiteral(resourceName: "officePlaceholder")
        }
    }
    
    func GetImageprojectByProjID() {
        
        
        let parameters: Parameters = [
            "projectId" : ProjectId
        ]
        
        Alamofire.request("http://smusers.promit2030.co/Service1.svc/GetImageprojectByProjID", method: .get, parameters: parameters, encoding: URLEncoding.default).responseJSON { response in
            debugPrint(response)
            let json = JSON(response.result.value!)
            self.ProjectsImagePath = json["ProjectsImagePath"].stringValue
            self.ProjectId1 = json["ProjectId"].stringValue
            self.ProjectsImageRotate = json["ProjectsImageRotate"].stringValue
            self.ProjectsImageType = json["ProjectsImageType"].stringValue
            
        }
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView){
        assignbackground()
    }
    
    @IBAction func goOfficeDetials(_ sender: UIButton) {
        GetOfficesByProvincesID()
    }
    
    func GetOfficesByProvincesID(){
        let sv = UIViewController.displaySpinner(onView: self.view)
        //        let id = UserDefaults.standard.string(forKey: "account_id")!
        //        let account_type = UserDefaults.standard.string(forKey: "account_type")!
        
        
        let Parameters: Parameters = [
            "companyInfoID": CompanyInfoID
        ]
        
        Alamofire.request("http://smusers.promit2030.co/Service1.svc/GetOfficeByCompanyInfoID", method: .get, parameters: Parameters, encoding: URLEncoding.default).responseJSON { response in
            debugPrint(response)
            
            let json = JSON(response.result.value!)
            let requestProjectObj = GetOfficesArray()
            requestProjectObj.CompanyInfoID = json["CompanyInfoID"].stringValue
            requestProjectObj.ComapnyName = json["ComapnyName"].stringValue
            requestProjectObj.CompanyMobile = json["CompanyMobile"].stringValue
            requestProjectObj.Street = json["Street"].stringValue
            requestProjectObj.BiuldNumber = json["BiuldNumber"].stringValue
            requestProjectObj.PostNumber = json["PostNumber"].stringValue
            requestProjectObj.PostSymbol = json["PostSymbol"].stringValue
            requestProjectObj.PostNumberWasl = json["PostNumberWasl"].stringValue
            requestProjectObj.Phone = json["Phone"].stringValue
            requestProjectObj.Fax = json["Fax"].stringValue
            requestProjectObj.Long = json["Long"].doubleValue
            requestProjectObj.Lat = json["Lat"].doubleValue
            requestProjectObj.Zoom = json["Zoom"].stringValue
            requestProjectObj.LicenceNumber = json["LicenceNumber"].stringValue
            requestProjectObj.CommercialNumber = json["CommercialNumber"].stringValue
            requestProjectObj.CompanyEmail = json["CompanyEmail"].stringValue
            requestProjectObj.IsCompany = json["IsCompany"].stringValue
            requestProjectObj.Specialty = json["Specialty"].stringValue
            requestProjectObj.IsSCE = json["IsSCE"].stringValue
            requestProjectObj.Logo = json["Logo"].stringValue
            requestProjectObj.BranchFB = json["BranchFB"].stringValue
            requestProjectObj.BranchID = json["BranchID"].stringValue
            requestProjectObj.Address = json["Address"].stringValue
            
            self.arrayOfResulr.append(requestProjectObj)
            UIViewController.removeSpinner(spinner: sv)
            self.goH()
        }
    }
    
    func goH(){
        let storyBoard : UIStoryboard = UIStoryboard(name: "NewProject", bundle:nil)
        let secondView = storyBoard.instantiateViewController(withIdentifier: "DetailsOfOfficeTableViewController") as! DetailsOfOfficeTableViewController
        secondView.arrayOfResulr = self.arrayOfResulr
        print("arrr: \(self.arrayOfResulr.count)")
        secondView.CompanyInfoID = self.CompanyInfoID
        secondView.conditionService = "condition"
        secondView.LatBranch = LatBranch
        secondView.LngBranch = LngBranch
        self.navigationController?.pushViewController(secondView, animated: true)
    }
    
    @IBAction func CallMe(_ sender: UIButton) {
        var mobile: String = (EmpMobile)
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
    
    @IBAction func directionBtn(_ sender: UIButton) {
        let dLati = LatBranch
        let dLang = LngBranch
        let location = CLLocation(latitude: dLati, longitude: dLang)
        print(location.coordinate)
        MKMapView.openMapsWith(location) { (error) in
            if error != nil {
                print("Could not open maps" + error!.localizedDescription)
            }
        }
    }
}
