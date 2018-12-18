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



class MoneyManagmentDetialsTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MoneyMangmentModelDelegate,GotoEsal {
    func GotoEsalView(urlEsla: String) {
        print(urlEsla)
        let storyBoard : UIStoryboard = UIStoryboard(name: "DesignsAndDetails", bundle:nil)
        let secondView = storyBoard.instantiateViewController(withIdentifier: "openPdfViewController") as! openPdfViewController
        secondView.url = urlEsla
        secondView.Webtitle = "الايصال"
        tableView.reloadData()
        self.navigationController?.pushViewController(secondView, animated: true)
        
    }
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var viewMoney: UIView!
    
    @IBOutlet weak var Saknumber: UILabel!
    let model: MoneyMangmentModel = MoneyMangmentModel()
    var searchResu:[MoneyManaagmentArray] = [MoneyManaagmentArray]()
    let moneyManagmentModel = MoneyManaagmentModel()
    
    @IBOutlet weak var alertLabel: UILabel!
    @IBOutlet weak var AlertImageOut: UIImageView!
    
    @IBOutlet weak var HeaderMoneyOut: UIView!
    @IBOutlet weak var HeaderTypeOut: UIView!
    
    
    
    @IBOutlet weak var projectTitleLabel: UILabel!
   
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
    var LngBranch: Double = 0.0
    var LatPrj: String = ""
    var LicenceNum: String = ""
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
    var ComapnyName = ""
    var CompanyAddress = ""
    var Logo = ""
    var MeetingDate = ""
    var MeetingTime = ""
    var DesignCount = ""
    var DesignNewCount = ""
    var norma = ""
    var ProjectLastComment: String = ""
    var ProjectLastTpye: String = ""
    var ProjectCommentOther: String = ""
    var LastDesignStagesID: String = ""
    var LastMeetingID: String = ""
    var MeetingNotifiCount: String = ""
    var MeetingCount = ""
    var DesignNotifiCount: String = ""
    var NotifiCount: Int?
    var ProjectFileCount: String = ""
    var FileCount: String = ""
    var indexi:Int = 0
    var isCompany = ""
    var nou = ""
    var nour = ""
    let applicationl = UIApplication.shared
    var NotiProjectCount = 0
    var NotiMessageCount = 0
    var NotiTotalCount = 0
    var pushCond = ""
    @IBOutlet var detialsBtnView: UIView!
    @IBOutlet weak var projectDetialsBtnOut: UIButton!{
        didSet {
            DispatchQueue.main.async {
                self.projectDetialsBtnOut.layer.cornerRadius = 7.0
                self.projectDetialsBtnOut.layer.masksToBounds = true
            }
        }
    }
    @IBOutlet weak var paymentsCost: UILabel!
    @IBOutlet weak var projectTotalPaid: UILabel!
    @IBOutlet weak var projectTotalNotPaid: UILabel!
    @IBOutlet weak var projectCountNotPaid: UILabel!
    @IBOutlet weak var projectCountPaid: UILabel!
    @IBOutlet weak var statusImageB: UIImageView!
    @IBOutlet weak var statusLabelB: UILabel!
    @IBOutlet weak var contractBtn: UIButton!
    @IBOutlet weak var acceptContractBtn: UIButton!
      @IBOutlet var loderview: UIView!
   
    var AlertController: UIAlertController!
    override func viewDidLoad() {
     
        super.viewDidLoad()
            CountCustomerNotification()
        loderview.isHidden = true
        loderview.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        self.view.addSubview(loderview)
        
        HeaderMoneyOut.backgroundColor = #colorLiteral(red: 0.2274509804, green: 0.231372549, blue: 0.2352941176, alpha: 1)
        HeaderTypeOut.backgroundColor = #colorLiteral(red: 0.2274509804, green: 0.231372549, blue: 0.2352941176, alpha: 1)
        AlertController = UIAlertController(title:"" , message: "اختر الخريطة", preferredStyle: UIAlertControllerStyle.actionSheet)
        
        let Google = UIAlertAction(title: "جوجل ماب", style: UIAlertActionStyle.default, handler: { (action) in
            self.openMapsForLocationgoogle(Lat:self.LatBranch, Lng:self.LngBranch)
        })
        let MapKit = UIAlertAction(title: "الخرائط", style: UIAlertActionStyle.default, handler: { (action) in
            self.openMapsForLocation(Lat:self.LatBranch, Lng:self.LngBranch)
        })
        
        let Cancel = UIAlertAction(title: "رجوع", style: UIAlertActionStyle.cancel, handler: { (action) in
            //
        })
        
        self.AlertController.addAction(Google)
        self.AlertController.addAction(MapKit)
        self.AlertController.addAction(Cancel)
    }
    
    func openMapsForLocation(Lat: Double, Lng: Double) {
        let location = CLLocation(latitude: Lat, longitude: Lng)
        print(location.coordinate)
        MKMapView.openMapsWith(location) { (error) in
            if error != nil {
                print("Could not open maps" + error!.localizedDescription)
            }
        }
    }
    func openMapsForLocationgoogle(Lat: Double, Lng: Double) {
        let location = CLLocation(latitude: Lat, longitude: Lng)
        if UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!) {
            UIApplication.shared.open(URL(string: "comgooglemaps://?center=\(Lat),\(Lng)&zoom=14&views=traffic&q=\(Lat),\(Lng)")!, options: [:], completionHandler: nil)
        }
        else {
            print("Can't use comgooglemaps://")
            UIApplication.shared.open(URL(string: "http://maps.google.com/maps?q=\(Lat),\(Lng)&zoom=14&views=traffic")!, options: [:], completionHandler: nil)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
         GetProjectByProjectId()
        if pushCond == "" {
            
        }else {
            GetProjectByProjectId()
        }
        
        
        
        acceptContractBtn.isHidden = true
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
        CountCustomerNotification()
        DispatchQueue.main.async {
            self.detialsBtnView.frame = CGRect.init(x: 0, y: self.tableView.contentOffset.y + (self.view.frame.height-57), width: self.view.frame.width, height: 57)
            if #available(iOS 11, *) {
                self.tableView.contentInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 20, right: 0)
            }else{
                self.tableView.contentInset = UIEdgeInsets.init(top: 52, left: 0, bottom: 20, right: 0)
            }
            self.tableView.bringSubview(toFront: self.detialsBtnView)
            self.tableView.addSubview(self.detialsBtnView)
        }
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView){
        if scrollView == tableView {
            var frame: CGRect = self.detialsBtnView.frame
            frame.origin.y = scrollView.contentOffset.y + self.view.frame.height - 57
            detialsBtnView.frame = frame
        }
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
        if ProjectOfResult.count != 0 {
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
            
            //        companyNameLabel.text = ProjectOfResult[0].ComapnyName!
            projectTitleLabel.text = "\(ProjectOfResult[0].ProjectTitle!)"
            if ProjectOfResult[0].SakNum != ""
            {
            Saknumber.text = "\(ProjectOfResult[0].SakNum!)"
            }else
            {
                 Saknumber.text = "\(ProjectOfResult[0].ProjectId!)"
            }
            
        } else {
            let NotLabel = NotifiCount
            
            if NotLabel != 0 {
                notficationAlertBtnOut.isHidden = false
                notficationCountLabel.isHidden = false
                notficationCountLabel.text = "\(NotLabel)"
            } else {
                notficationAlertBtnOut.isHidden = false
                notficationCountLabel.isHidden = true
            }
            let status = ProjectStatusID
            let statusName = ProjectStatusName
            
            //        companyNameLabel.text = ProjectOfResult[0].ComapnyName!
            projectTitleLabel.text = ProjectTitle
            
        }
    }
    
     var ContractHistoryCount: String = ""
    func GetProjectByProjectId(){
        let sv = UIViewController.displaySpinner(onView: self.view)
        self.loderview.isHidden = false
        let parameters: Parameters = [
            "projectId": ProjectId
        ]
        
        Alamofire.request("http://smusers.promit2030.co/Service1.svc/GetProjectByProjectId", method: .get, parameters: parameters, encoding: URLEncoding.default).responseJSON { response in
            debugPrint(response)
            
            let json = JSON(response.result.value!)
            let requestProjectObj = ProjectDetialsArray(ProjectId: json["ProjectId"].stringValue, ProjectsPaymentsCost: json["ProjectsPaymentsCost"].stringValue, CountNotPaid: json["CountNotPaid"].stringValue, CountPaid: json["CountPaid"].stringValue, EmpImage: json["EmpImage"].stringValue, BranchID: json["BranchID"].stringValue, BranchName: json["BranchName"].stringValue, CustmoerName: json["CustmoerName"].stringValue, CustomerEmail: json["CustomerEmail"].stringValue, CustomerMobile: json["CustomerMobile"].stringValue, CustomerNationalId: json["CustomerNationalId"].stringValue, DataSake: json["DataSake"].stringValue, DateLicence: json["DateLicence"].stringValue, EmpMobile: json["EmpMobile"].stringValue, EmpName: json["EmpName"].stringValue, GroundId: json["GroundId"].stringValue, IsDeleted: json["IsDeleted"].stringValue, JobName: json["JobName"].stringValue, LatBranch: json["LatBranch"].doubleValue, LatPrj: json["LatPrj"].stringValue, LicenceNum: json["LicenceNum"].stringValue, LngBranch: json["LngBranch"].doubleValue, LngPrj: json["LngPrj"].stringValue, Notes: json["Notes"].stringValue, PlanId: json["PlanId"].stringValue, ProjectInvoice: json["ProjectInvoice"].stringValue, ProjectContract: json["ProjectContract"].stringValue, ProjectStatusNum: json["ProjectStatusNum"].stringValue, ProjectBildTypeId: json["ProjectBildTypeId"].stringValue, ProjectEngComment: json["ProjectEngComment"].stringValue, ProjectStatusColor: json["ProjectStatusColor"].stringValue, ProjectStatusID: json["ProjectStatusID"].stringValue, ProjectStatusName: json["ProjectStatusName"].stringValue, ProjectTitle: json["ProjectTitle"].stringValue, ProjectTypeId: json["ProjectTypeId"].stringValue, ProjectTypeName: json["ProjectTypeName"].stringValue, SakNum: json["SakNum"].stringValue, Space: json["Space"].stringValue, Status: json["Status"].stringValue, TotalNotPaid: json["TotalNotPaid"].stringValue, TotalPaid: json["TotalPaid"].stringValue, ZoomBranch: json["ZoomBranch"].stringValue, ZoomPrj: json["ZoomPrj"].stringValue, projectOrderContractPhotoPath: json["projectOrderContractPhotoPath"].stringValue, ProvincesName: json["ProvincesName"].stringValue, SectoinName: json["SectoinName"].stringValue, ProjectsOrdersCellarErea: json["ProjectsOrdersCellarErea"].stringValue, ProjectsOrdersReFloorErea: json["ProjectsOrdersReFloorErea"].stringValue, ProjectsOrdersSupplementErea: json["ProjectsOrdersSupplementErea"].stringValue, ProjectsOrdersSupplementExternalErea: json["ProjectsOrdersSupplementExternalErea"].stringValue, ProjectsOrdersFloorErea: json["ProjectsOrdersFloorErea"].stringValue, ProjectsOrdersLandErea: json["ProjectsOrdersLandErea"].stringValue, ProjectsOrdersFloorNummber: json["ProjectsOrdersFloorNummber"].stringValue, ProjectsOrdersTotalBildErea: json["ProjectsOrdersTotalBildErea"].stringValue, ProjectsPaymentsWork: json["ProjectsPaymentsWork"].stringValue, ProjectsPaymentsDiscount: json["ProjectsPaymentsDiscount"].stringValue, CompanyInfoID: json["CompanyInfoID"].stringValue, ComapnyName: json["ComapnyName"].stringValue, CompanyAddress: json["Address"].stringValue, Logo: json["Logo"].stringValue, isCompany: json["IsCompany"].stringValue, DesignNewCount: json["DesignNewCount"].stringValue, DesignCount: json["DesignCount"].stringValue, Meetingcount: json["Meetingcount"].stringValue, MeetingDate: json["MeetingDate"].stringValue, MeetingTime: json["MeetingTime"].stringValue, ProjectLastComment: json["ProjectLastComment"].stringValue, ProjectLastTpye: json["ProjectLastTpye"].stringValue, ProjectCommentOther: json["ProjectCommentOther"].stringValue, LastDesignStagesID: json["LastDesignStagesID"].stringValue, LastMeetingID: json["LastMeetingID"].stringValue, MeetingNotifiCount: json["MeetingNotifiCount"].stringValue, DesignNotifiCount: json["DesignNotifiCount"].stringValue, NotifiCount: json["NotifiCount"].intValue, FileCount: json["FileCount"].stringValue, ProjectFileCount: json["ProjectFileCount"].stringValue)
            UserDefaults.standard.set(json["CompanyInfoID"].stringValue, forKey: "companyInfoID")
            self.ProjectOfResult.removeAll()
            self.ProjectOfResult.append(requestProjectObj)
            self.FileCount = json["FileCount"].stringValue
            self.ProjectFileCount = json["ProjectFileCount"].stringValue
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
            self.ComapnyName = json["ComapnyName"].stringValue
            self.CompanyAddress = json["Address"].stringValue
            self.Logo = json["Logo"].stringValue
            self.isCompany = json["IsCompany"].stringValue
            self.DesignNewCount = json["DesignNewCount"].stringValue
            self.DesignCount = json["DesignCount"].stringValue
            self.MeetingCount = json["Meetingcount"].stringValue
            self.MeetingDate = json["MeetingDate"].stringValue
            self.MeetingTime = json["MeetingTime"].stringValue
            self.ProjectLastComment = json["ProjectLastComment"].stringValue
            self.ProjectLastTpye = json["ProjectLastTpye"].stringValue
            self.ProjectCommentOther = json["ProjectCommentOther"].stringValue
            self.LastDesignStagesID = json["LastDesignStagesID"].stringValue
            self.LastMeetingID = json["LastMeetingID"].stringValue
            self.MeetingNotifiCount = json["MeetingNotifiCount"].stringValue
            self.DesignNotifiCount = json["DesignNotifiCount"].stringValue
            self.NotifiCount = json["NotifiCount"].intValue
            self.ContractHistoryCount =  json["ContractHistoryCount"].stringValue
            self.ProjectOfResult.append(requestProjectObj)
            self.test()
            self.setViewContent()
            self.setHeaderDetials()
           
            
            self.tableView.reloadData()
            UserDefaults.standard.set(json["CompanyInfoID"].stringValue, forKey: "companyInfoID")
            UIViewController.removeSpinner(spinner: sv)
             self.loderview.isHidden = true
        }
    }
    
    func setViewContent(){
        
        
        if ContractHistoryCount != "" ||  ContractHistoryCount != "0"
        {
            ConntractRecordBtn.isHidden = false
            
        }else
        {
            ConntractRecordBtn.isHidden = true
        }
        
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
            projectTotalNotPaid.textColor = #colorLiteral(red: 0.9607843137, green: 0.2745098039, blue: 0.2588235294, alpha: 1)
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
        if ProjectContract == "1" || ProjectContract ==  "4" {
            contractBtn.isEnabled = true
            contractBtn.setImage(#imageLiteral(resourceName: "NewConterct"), for: .normal)
            acceptContractBtn.isHidden = true
            contractViewOut.isHidden = false
            contractBtnOut.isHidden = false
                  viewMoney.frame = CGRect.init(x: 0, y: 0, width: self.view.frame.width, height: 465)
        }
        else if ProjectContract == "3" {
            contractBtn.isEnabled = true
            contractBtn.setImage(#imageLiteral(resourceName: "NewConterct"), for: .normal)
            acceptContractBtn.isHidden = true
            contractViewOut.isHidden = true
            contractBtnOut.isHidden = true
           viewMoney.frame = CGRect.init(x: 0, y: 0, width: self.view.frame.width, height: 360)
            
        }
        else if ProjectContract == "2" {
            contractBtn.isEnabled = false
            contractBtn.setImage(#imageLiteral(resourceName: "Subtraction"), for: .disabled)
            acceptContractBtn.isHidden = true
            contractViewOut.isHidden = true
            contractBtnOut.isHidden = true
            viewMoney.frame = CGRect.init(x: 0, y: 0, width: self.view.frame.width, height: 360)
            self.view.setNeedsLayout()
            self.view.layoutIfNeeded()
        } else {
            contractBtn.isEnabled = false
            contractBtn.setImage(#imageLiteral(resourceName: "Subtraction"), for: .disabled)
            acceptContractBtn.isHidden = true
            contractViewOut.isHidden = true
            contractBtnOut.isHidden = true
            viewMoney.frame = CGRect.init(x: 0, y: 0, width: self.view.frame.width, height: 360)
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
        if ProjectContract == "1" || ProjectContract == "4"{
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
    
        func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
            return 1
        }
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
            cell.eslaurl = searchResu[indexPath.section].projectOrderInvoicePhotoPath!
              cell.delegate = self
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
    
    @IBAction func openDetialsViewController(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "NewHome", bundle: nil)
        let secondView = storyBoard.instantiateViewController(withIdentifier: "NewProjectDetialsFilterTableViewController") as! NewProjectDetialsFilterTableViewController
        secondView.ProjectId = self.ProjectId
        secondView.nou = "uu"
        self.navigationController?.pushViewController(secondView, animated: true)
    }
    
    @IBAction func InvoiceAction(_ sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: tableView)
        let index = tableView.indexPathForRow(at: point)?.row
        print(point)
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
        
        Alamofire.request("http://smusers.promit2030.co/Service1.svc/AcceptContract", method: .get, parameters: parameters, encoding: URLEncoding.default).responseJSON { response in
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
        secondView.CompanyInfoID = self.ProjectOfResult[0].CompanyInfoID!
        secondView.conditionService = "condition"
        secondView.LatBranch = LatBranch
        secondView.LngBranch = LngBranch
        self.navigationController?.pushViewController(secondView, animated: true)
    }
    
    @IBAction func directionBtn(_ sender: UIButton) {
        if Helper.isDeviceiPad() {
            
            if let popoverController = AlertController.popoverPresentationController {
                popoverController.sourceView = sender
            }
        }
        
        self.present(AlertController, animated: true, completion: nil)
//        let alertAction = UIAlertController(title: "اختر الخريطة", message: "", preferredStyle: .alert)
//
//        alertAction.addAction(UIAlertAction(title: "جوجل ماب", style: .default, handler: { action in
//            if UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!) {
//                UIApplication.shared.open(URL(string: "comgooglemaps://?center=\(self.LatBranch),\(self.LngBranch)&zoom=14&views=traffic&q=\(self.LatBranch),\(self.LngBranch)")!, options: [:], completionHandler: nil)
//            } else {
//                print("Can't use comgooglemaps://")
//                UIApplication.shared.open(URL(string: "http://maps.google.com/maps?q=\(self.LatBranch),\(self.LngBranch)&zoom=14&views=traffic")!, options: [:], completionHandler: nil)
//            }
//        }))
//
//        alertAction.addAction(UIAlertAction(title: "الخرائط", style: .default, handler: { action in
//            let location = CLLocation(latitude: self.LatBranch, longitude: self.LngBranch)
//            print(location.coordinate)
//            MKMapView.openMapsWith(location) { (error) in
//                if error != nil {
//                    print("Could not open maps" + error!.localizedDescription)
//                }
//            }
//        }))
//
//        alertAction.addAction(UIAlertAction(title: "رجوع", style: .cancel, handler: { action in
//        }))
//        self.present(alertAction, animated: true, completion: nil)
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
    private func callNumber(phoneNumber: String) {
        
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
        secondView.projectTitle = self.ProjectOfResult[0].ProjectTitle!
        secondView.companyName = self.ProjectOfResult[0].ComapnyName!
        secondView.companyPhone = self.ProjectOfResult[0].EmpMobile!
        secondView.companyLogo = self.ProjectOfResult[0].Logo!
        secondView.SakeNammer = self.ProjectOfResult[0].SakNum!
        secondView.Empname = self.ProjectOfResult[0].EmpName!
        self.navigationController?.pushViewController(secondView, animated: true)
    }
    
    
    
    @IBOutlet weak var ConntractRecordBtn: UIButton!{
        didSet{
            self.ConntractRecordBtn.circleView(UIColor.clear, borderWidth: 1.0)
        }
    }
    @IBAction func GotoContractRecord(_ sender: Any) {
        let storyboard = UIStoryboard(name: "DesignsAndDetails", bundle: nil)
        let FirstViewController = storyboard.instantiateViewController(withIdentifier: "EditDesigRecordsVC") as! EditDesigRecordsVC
        
        
        FirstViewController.ProjectId = ProjectId
        FirstViewController.Condition = "Contract"
        FirstViewController.ProjectTiti = ProjectTitle
        FirstViewController.EngName = EmpName
        FirstViewController.companyName = ComapnyName
        if SakNum != ""
        {
            FirstViewController.sakNum = SakNum
        }
        else
        {
            FirstViewController.sakNum = ProjectId
        }
        
        FirstViewController.mobilestr = EmpMobile
        
        FirstViewController.DesignStagesID = ProjectId
        
        self.navigationController?.pushViewController(FirstViewController, animated: true)
        
    }
    
    
    
    
    
    
   
    
    func setAppBadge() {
        let count = NotiTotalCount
        print(count)
        
        
        if count != 0 {
            let second = tabBarController?.tabBar
            second?.items![1].badgeValue = "\(count)"
            second?.items![1].badgeColor = #colorLiteral(red: 0.3058823529, green: 0.5058823529, blue: 0.5333333333, alpha: 1)
            
        }else
        {
            let second = tabBarController?.tabBar
            second?.items![1].badgeValue = ""
            second?.items![1].badgeColor = UIColor.clear
        }
    }
    func CountCustomerNotification() {
        let CustmoerId = UserDefaults.standard.string(forKey: "CustmoerId")!
        let parameters: Parameters = [
            "CustmoerId":CustmoerId
        ]
        Alamofire.request("http://smusers.promit2030.co/Service1.svc/CountCustomerNotification", method: .get, parameters: parameters, encoding: URLEncoding.default).responseJSON { response in
            switch response.result {
            case .success:
                let json = JSON(response.result.value!)
                print(json)
                self.NotiProjectCount = json["NotiProjectCount"].intValue
                self.NotiMessageCount = json["NotiMessageCount"].intValue
                self.NotiTotalCount = json["NotiTotalCount"].intValue
                self.setAppBadge()
            case .failure(let error):
                print(error)
                let alertAction = UIAlertController(title: "خطاء في الاتصال", message: "اعادة المحاولة", preferredStyle: .alert)
                
                alertAction.addAction(UIAlertAction(title: "نعم", style: .default, handler: { action in
                    self.CountCustomerNotification()
                }))
                
                alertAction.addAction(UIAlertAction(title: "رجوع", style: .cancel, handler: { action in
                }))
                
                self.present(alertAction, animated: true, completion: nil)
                
            }
        }
    }
}


