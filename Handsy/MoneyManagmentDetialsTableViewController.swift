//
//  MoneyManagmentDetialsTableViewController.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 9/18/17.
//  Copyright © 2017 Ahmed Wahdan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import MapKit

class MoneyManagmentDetialsTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MoneyMangmentModelDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var viewMoney: UIView!
    
    
    let model: MoneyMangmentModel = MoneyMangmentModel()
    var searchResu:[MoneyManaagmentArray] = [MoneyManaagmentArray]()
    let moneyManagmentModel = MoneyManaagmentModel()
    
    @IBOutlet weak var alertLabel: UILabel!
    @IBOutlet weak var AlertImageOut: UIImageView!
    
    @IBOutlet weak var HeaderMoneyOut: UIView!
    @IBOutlet weak var HeaderTypeOut: UIView!
    
    @IBOutlet weak var callBtn: UIButton! {
        didSet {
            callBtn.layer.borderWidth = 1.0
            callBtn.layer.borderColor = #colorLiteral(red: 0.2, green: 0.5647058824, blue: 0.3882352941, alpha: 1)
            callBtn.layer.cornerRadius = 4.0
        }
    }
    
    @IBOutlet weak var officeDetialsBtn: UIButton! {
        didSet {
            officeDetialsBtn.layer.borderWidth = 1.0
            officeDetialsBtn.layer.borderColor = #colorLiteral(red: 0.2, green: 0.5647058824, blue: 0.3882352941, alpha: 1)
            officeDetialsBtn.layer.cornerRadius = 4.0
        }
    }
    @IBOutlet weak var messageBtn: UIButton! {
        didSet {
            messageBtn.layer.borderWidth = 1.0
            messageBtn.layer.borderColor = #colorLiteral(red: 0.2, green: 0.5647058824, blue: 0.3882352941, alpha: 1)
            messageBtn.layer.cornerRadius = 4.0
        }
    }
    
    @IBOutlet weak var companyImageOut: UIImageView!
    @IBOutlet weak var projectTitleLabel: UILabel!
    @IBOutlet weak var EngNameLabel: UILabel!
    @IBOutlet weak var engJobName: UILabel!
    @IBOutlet weak var statusView: UIView!{
        didSet{
            DispatchQueue.main.async {
                self.statusView.roundCorners([.topLeft, .topRight], radius: 10)
            }
        }
    }
    @IBOutlet weak var lastStatusLabel: UILabel!
    @IBOutlet weak var statusImgView: UIImageView!
    @IBOutlet weak var statusNameLabel: UILabel!
    @IBOutlet weak var notficationAlertBtnOut: UIButton!
    @IBOutlet weak var notficationCountLabel: UILabel!{
        didSet {
            DispatchQueue.main.async {
                self.notficationCountLabel.layer.cornerRadius = self.notficationCountLabel.frame.width/2
                self.notficationCountLabel.layer.masksToBounds = true
            }
        }
    }
    var ProjectOfResult: [ProjectDetialsArray] = [ProjectDetialsArray]()
    var arrayOfResulr = [GetOfficesArray]()
    
    @IBOutlet weak var contractBtnOut: UIButton!{
        didSet {
            DispatchQueue.main.async {
                self.contractBtnOut.circleView(UIColor.clear, borderWidth: 1.0)
            }
        }
    }
    @IBOutlet weak var contractViewOut: UIView!
    
    func dataReady() {
        // Access the video objects that have been downloaded
        self.searchResu = self.model.resultArray
        self.moneyManagmentModel.append(self.model.resultArray, index: ProjectId)
        // Tell the tableview to reload
        self.tableView.reloadData()
    }
    
    
    var BranchID: String = ""
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
    var ComapnyName = ""
    var CompanyAddress = ""
    var Logo = ""
    
    var pushCond = ""
    
    @IBOutlet weak var paymentsCost: UILabel!
    @IBOutlet weak var projectTotalPaid: UILabel!
    @IBOutlet weak var projectTotalNotPaid: UILabel!
    @IBOutlet weak var projectCountNotPaid: UILabel!
    @IBOutlet weak var projectCountPaid: UILabel!
    @IBOutlet weak var statusImageB: UIImageView!
    @IBOutlet weak var statusLabelB: UILabel!
    @IBOutlet weak var contractBtn: UIButton!
    @IBOutlet weak var acceptContractBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        HeaderMoneyOut.backgroundColor = #colorLiteral(red: 0.2274509804, green: 0.231372549, blue: 0.2352941176, alpha: 1)
        HeaderTypeOut.backgroundColor = #colorLiteral(red: 0.2274509804, green: 0.231372549, blue: 0.2352941176, alpha: 1)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if pushCond == "" {
            
        }else {
            GetProjectByProjectId()
        }
        acceptContractBtn.isHidden = false
        if ProjectStatusNum == "1" {
            tableView.isHidden = true
            viewMoney.isHidden = true
            alertLabel.isHidden = false
            AlertImageOut.isHidden = false
        }else {
            tableView.isHidden = false
            viewMoney.isHidden = false
            alertLabel.isHidden = true
            AlertImageOut.isHidden = true
            loadTabel()
            tableView.reloadData()
        }
        tableView.reloadData()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func loadTabel(){
        if Reachability.isConnectedToNetwork(){
            model.delegate = self
            self.model.PaymentByCustIDAndProjectId(projectId: self.ProjectId)
        }else{
            moneyManagmentModel.loadItems()
            if moneyManagmentModel.returnProjectDetials(at: ProjectId) != nil {
                let  moneyManagmentDetials = moneyManagmentModel.returnProjectDetials(at: ProjectId)
                self.searchResu = moneyManagmentDetials!
            }
            tableView.reloadData()
        }
        test()
        setViewContent()
        setHeaderDetials()
    } 
    
    func test() {
        if ProjectStatusID == "4" || ProjectStatusID == "7" {
            viewMoney.isHidden = true
            tableView.isHidden = true
            alertLabel.isHidden = false
            AlertImageOut.isHidden = false
        }else {
            viewMoney.isHidden = false
            tableView.isHidden = false
            alertLabel.isHidden = true
            AlertImageOut.isHidden = true
        }
    }
    
    func setHeaderDetials(){
        lastStatusLabel.text = ProjectOfResult[0].ProjectLastComment!
        let NotLabel = ProjectOfResult[0].NotifiCount!
        
        if NotLabel != 0 {
            notficationAlertBtnOut.isHidden = false
            notficationCountLabel.isHidden = false
            notficationCountLabel.text = "\(NotLabel)"
        } else {
            notficationAlertBtnOut.isHidden = false
            notficationCountLabel.isHidden = true
        }
        let status = ProjectOfResult[0].ProjectStatusID!
        let statusName = ProjectOfResult[0].ProjectStatusName!
        if status == "5"{
            statusNameLabel.text = statusName
            statusImgView.backgroundColor = #colorLiteral(red: 0.9921568627, green: 0.4274509804, blue: 0.337254902, alpha: 1)
        }else if status == "4"{
            statusNameLabel.text = statusName
            statusImgView.backgroundColor = #colorLiteral(red: 0.1176470588, green: 0.368627451, blue: 0.4666666667, alpha: 1)
        }else if status == "3"{
            statusNameLabel.text = statusName
            statusImgView.backgroundColor = #colorLiteral(red: 0.1764705882, green: 0.4745098039, blue: 0.8862745098, alpha: 1)
        }else if status == "1"{
            statusNameLabel.text = statusName
            statusImgView.backgroundColor = #colorLiteral(red: 0.831372549, green: 0.6862745098, blue: 0.2117647059, alpha: 1)
        }else if status == "2"{
            statusNameLabel.text = statusName
            statusImgView.backgroundColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
        }else if status == "6"{
            statusNameLabel.text = statusName
            statusImgView.backgroundColor = #colorLiteral(red: 0.2588235294, green: 0.8666666667, blue: 0.1764705882, alpha: 1)
        }else if status == "7"{
            statusNameLabel.text = statusName
            statusImgView.backgroundColor = #colorLiteral(red: 0.2, green: 0.5647058824, blue: 0.3882352941, alpha: 1)
        }else {
            print("error status \(status)")
        }
        //        companyNameLabel.text = ProjectOfResult[0].ComapnyName!
        projectTitleLabel.text = "( \(ProjectOfResult[0].ProjectTitle!) )"
        EngNameLabel.text = ProjectOfResult[0].EmpName
        engJobName.text = ProjectOfResult[0].JobName
        let img = ProjectOfResult[0].EmpImage
        if let url = URL.init(string: img!) {
            companyImageOut.hnk_setImageFromURL(url, placeholder: #imageLiteral(resourceName: "officePlaceholder"))
        } else{
            print("nil")
            companyImageOut.image = #imageLiteral(resourceName: "officePlaceholder")
        }
    }
    
    func GetProjectByProjectId(){
        let sv = UIViewController.displaySpinner(onView: self.view)
        let parameters: Parameters = [
            "projectId": ProjectId
        ]
        
        Alamofire.request("http://smusers.promit2030.com/Service1.svc/GetProjectByProjectId", method: .get, parameters: parameters, encoding: URLEncoding.default).responseJSON { response in
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
            self.ComapnyName = json["ComapnyName"].stringValue
            self.CompanyAddress = json["Address"].stringValue
            self.Logo = json["Logo"].stringValue
            self.test()
            self.setViewContent()
            self.setHeaderDetials()
            self.tableView.reloadData()
            UserDefaults.standard.set(json["CompanyInfoID"].stringValue, forKey: "companyInfoID")
            UIViewController.removeSpinner(spinner: sv)
        }
    }
    
    func setViewContent(){
        let largeNumber = Double(ProjectsPaymentsCost) ?? 0.0
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        let formattedNumber = numberFormatter.string(from: NSNumber(value:largeNumber))!
        paymentsCost.text = "\(formattedNumber) \n ر.س"
        let largeNumber1 = Double(TotalPaid) ?? 0.0
        let numberFormatter1 = NumberFormatter()
        numberFormatter1.numberStyle = NumberFormatter.Style.decimal
        let formattedNumber1 = numberFormatter.string(from: NSNumber(value:largeNumber1))!
        projectTotalPaid.text = "\(formattedNumber1) \n ر.س"
        if TotalNotPaid == "0" {
            projectTotalPaid.textColor = UIColor(red: 212/250.0, green: 175/250.0, blue: 54/250.0, alpha: 1.0)
        } else {
            projectTotalPaid.textColor = UIColor(red: 38/250.0, green: 163/250.0, blue: 90/250.0, alpha: 1.0)
        }
        let largeNumber2 = Double(TotalNotPaid) ?? 0.0
        let numberFormatter2 = NumberFormatter()
        numberFormatter2.numberStyle = NumberFormatter.Style.decimal
        let formattedNumber2 = numberFormatter.string(from: NSNumber(value:largeNumber2))!
        projectTotalNotPaid.text = "\(formattedNumber2) \n ر.س"
        if TotalPaid == "0" {
            projectTotalNotPaid.textColor = UIColor(red: 212/250.0, green: 175/250.0, blue: 54/250.0, alpha: 1.0)
        } else {
            projectTotalNotPaid.textColor = UIColor.red
            //(red: 184/250.0, green: 101/250.0, blue: 27/250.0, alpha: 1.0)
        }
        projectCountNotPaid.text = CountNotPaid
        projectCountPaid.text = CountPaid
        if ProjectInvoice == "1" {
            statusLabelB.text = "مكتمل الدفع"
            statusLabelB.textColor = #colorLiteral(red: 0.8314196467, green: 0.6866896152, blue: 0.2108715177, alpha: 1)
            statusImageB.image = #imageLiteral(resourceName: "Active")
        } else if ProjectInvoice == "2"  {
            statusLabelB.text = "غير مكتمل الدفع"
            statusLabelB.textColor = #colorLiteral(red: 0.666592598, green: 0.6667093039, blue: 0.666585207, alpha: 1)
            statusImageB.image = #imageLiteral(resourceName: "NotActiveGray")
            
        }
        if ProjectContract == "1" {
            contractBtn.isEnabled = true
            contractBtn.setImage(#imageLiteral(resourceName: "NewConterct"), for: .normal)
            acceptContractBtn.isHidden = false
            contractViewOut.isHidden = false
            contractBtnOut.isHidden = false
        } else if ProjectContract == "2" {
            contractBtn.isEnabled = false
            contractBtn.setImage(#imageLiteral(resourceName: "Subtraction"), for: .disabled)
            acceptContractBtn.isHidden = true
            contractViewOut.isHidden = true
            contractBtnOut.isHidden = true
            viewMoney.frame = CGRect.init(x: 0, y: 0, width: self.view.frame.width, height: 525)
            self.view.setNeedsLayout()
            self.view.layoutIfNeeded()
        } else {
            contractBtn.isEnabled = true
            contractBtn.setImage(#imageLiteral(resourceName: "NewConterct"), for: .normal)
            acceptContractBtn.isHidden = true
            contractViewOut.isHidden = true
            contractBtnOut.isHidden = true
            viewMoney.frame = CGRect.init(x: 0, y: 0, width: self.view.frame.width, height: 525)
            self.view.setNeedsLayout()
            self.view.layoutIfNeeded()
        }
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func downloadContract(_ sender: UIButton) {
        let openContract = projectOrderContractPhotoPath
        if ProjectContract == "1" {
            let storyBoard : UIStoryboard = UIStoryboard(name: "ProjectsAndEdit", bundle:nil)
            let secondView = storyBoard.instantiateViewController(withIdentifier: "ShowContractViewController") as! ShowContractViewController
            secondView.url = openContract
            secondView.ProjectId = ProjectId
            secondView.Webtitle = "العقد"
             self.navigationController?.pushViewController(secondView, animated: true)
        } else if ProjectContract == "2" {
            let storyBoard : UIStoryboard = UIStoryboard(name: "DesignsAndDetails", bundle:nil)
            let secondView = storyBoard.instantiateViewController(withIdentifier: "openPdfViewController") as! openPdfViewController
            secondView.url = openContract
            secondView.Webtitle = "العقد"
            self.navigationController?.pushViewController(secondView, animated: true)
        } else {
            let storyBoard : UIStoryboard = UIStoryboard(name: "DesignsAndDetails", bundle:nil)
            let secondView = storyBoard.instantiateViewController(withIdentifier: "openPdfViewController") as! openPdfViewController
            secondView.url = openContract
            secondView.Webtitle = "العقد"
            self.navigationController?.pushViewController(secondView, animated: true)
        }
        print(projectOrderContractPhotoPath)
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return searchResu.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    //    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    //        return 20
    //    }
    //    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    //        let view = UIView()
    //        view.backgroundColor = UIColor.clear
    //        return view
    //    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let PaymentBatch = searchResu[indexPath.section].PaymentBatchStatusID
        if PaymentBatch == "2" {
            return UITableViewAutomaticDimension
        } else {
            return 80
        }
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let PaymentBatch = searchResu[indexPath.section].PaymentBatchStatusID
        
        if PaymentBatch == "2" {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CollectedDetialRowTableViewCell", for: indexPath) as! CollectedDetialRowTableViewCell
            
            cell.PayDate.text = searchResu[indexPath.section].PayDate
            let paydateHijri = searchResu[indexPath.section].PayDateHijri
            let paytime = searchResu[indexPath.section].PayTime
            cell.PayDateHijri.text = paytime! + " - " + paydateHijri!
            let NewlargeNumber = Double(searchResu[indexPath.section].PaymentValue!)
            let NewnumberFormatter = NumberFormatter()
            NewnumberFormatter.numberStyle = NumberFormatter.Style.decimal
            let NewformattedNumber = NewnumberFormatter.string(from: NSNumber(value:NewlargeNumber!))
            cell.PaymentValueLabel.text = NewformattedNumber
            cell.PaymentTypeNameLabel.text = searchResu[indexPath.section].PaymentTypeName
            let RefranceIdEqual = searchResu[indexPath.section].RefranceId!
            cell.ProjectsPaymentsIdlabel.text = " الدفعة رقم: \(RefranceIdEqual)"
            cell.ProjectsPaymentsNumberLabel.text = searchResu[indexPath.section].ProjectsPaymentsNumber
            cell.contentView.backgroundColor = #colorLiteral(red: 0.2274509804, green: 0.231372549, blue: 0.2352941176, alpha: 1)
            cell.layer.masksToBounds = true
            
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NotCollectedDetialsTableViewCell") as! NotCollectedDetialsTableViewCell
            let largeNumber = Double(searchResu[indexPath.section].PaymentValue!)
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = NumberFormatter.Style.decimal
            let formattedNumber = numberFormatter.string(from: NSNumber(value:largeNumber!))
            cell.MoneyOfDf3a.text = formattedNumber
            let RefranceIdEqual = searchResu[indexPath.section].RefranceId!
            cell.numberOfDf3A.text = " الدفعة رقم: \(RefranceIdEqual)"
            cell.contentView.backgroundColor = #colorLiteral(red: 0.2274509804, green: 0.231372549, blue: 0.2352941176, alpha: 1)
            cell.layer.masksToBounds = true
            
            return cell
        }
    }
    
    
    @IBAction func InvoiceAction(_ sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: tableView)
        let index = tableView.indexPathForRow(at: point)?.row
        let storyBoard : UIStoryboard = UIStoryboard(name: "DesignsAndDetails", bundle:nil)
        let secondView = storyBoard.instantiateViewController(withIdentifier: "openPdfViewController") as! openPdfViewController
        secondView.url = searchResu[index!].projectOrderInvoicePhotoPath!
        secondView.Webtitle = "الايصال"
        tableView.reloadData()
        self.navigationController?.pushViewController(secondView, animated: true)
    }
    
    @IBAction func acceptContractAction(_ sender: UIButton) {
        AcceptContract()
    }
    
    func AcceptContract() {
        let sv = UIViewController.displaySpinner(onView: self.view)
        let parameters: Parameters = [
            "projectId": ProjectId
        ]
        
        Alamofire.request("http://smusers.promit2030.com/Service1.svc/AcceptContract", method: .get, parameters: parameters, encoding: URLEncoding.default).responseJSON { response in
            debugPrint(response)
            
            switch response.result {
            case .success:
                let json = JSON(response.result.value!)
                print(json)
                self.viewWillAppear(false)
            case .failure(let error):
                print(error)
                UIViewController.removeSpinner(spinner: sv)
                let alertAction = UIAlertController(title: "خطاء في الاتصال", message: "اعادة المحاولة", preferredStyle: .alert)
                
                alertAction.addAction(UIAlertAction(title: "نعم", style: .default, handler: { action in
                    self.AcceptContract()
                }))
                
                alertAction.addAction(UIAlertAction(title: "رجوع", style: .cancel, handler: { action in
                    
                }))
                
                self.present(alertAction, animated: true, completion: nil)
                
            }
            
        }
        UIViewController.removeSpinner(spinner: sv)
    }
    
    @IBAction func downloadInvoice(_ sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: tableView)
        let index = tableView.indexPathForRow(at: point)?.row
        let url = searchResu[index!].projectOrderInvoicePhotoPath!
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
    }
    
    @IBAction func goOfficeDetials(_ sender: UIButton) {
        GetOfficesByProvincesID()
    }
    
    func GetOfficesByProvincesID(){
        let sv = UIViewController.displaySpinner(onView: self.view)
        //        let id = UserDefaults.standard.string(forKey: "account_id")!
        //        let account_type = UserDefaults.standard.string(forKey: "account_type")!
        
        
        let Parameters: Parameters = [
            "companyInfoID": ProjectOfResult[0].CompanyInfoID!
        ]
        
        Alamofire.request("http://smusers.promit2030.com/Service1.svc/GetOfficeByCompanyInfoID", method: .get, parameters: Parameters, encoding: URLEncoding.default).responseJSON { response in
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
        secondView.CompanyInfoID = self.ProjectOfResult[0].CompanyInfoID!
        secondView.conditionService = "condition"
        secondView.LatBranch = LatBranch
        secondView.LngBranch = LngBranch
        self.navigationController?.pushViewController(secondView, animated: true)
    }
    
    @IBAction func directionBtn(_ sender: UIButton) {
        let location = CLLocation(latitude: LatBranch, longitude: LngBranch)
        print(location.coordinate)
        MKMapView.openMapsWith(location) { (error) in
            if error != nil {
                print("Could not open maps" + error!.localizedDescription)
            }
        }
    }
    
    @IBAction func CallMe(_ sender: UIButton) {
        let mobileNum = EmpMobile
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
    @IBAction func goToNotfication(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "NewHome", bundle:nil)
        let secondView = storyBoard.instantiateViewController(withIdentifier: "MyProjectNotficationViewController") as! MyProjectNotficationViewController
        secondView.projectId = self.ProjectOfResult[0].ProjectId!
        self.navigationController?.pushViewController(secondView, animated: true)
    }
}
