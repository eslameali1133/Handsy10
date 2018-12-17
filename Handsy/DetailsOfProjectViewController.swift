//
//  DetailsOfProjectViewController.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 8/2/17.
//  Copyright © 2017 Ahmed Wahdan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import MapKit

class DetailsOfProjectViewController: UIViewController, GMSMapViewDelegate {
    var ProjectOfResult: [ProjectDetialsArray] = [ProjectDetialsArray]()
    var BranchID: String?
    var BranchName: String?
    var ProjectsPaymentsCost: String?
    var CountNotPaid: String?
    var CountPaid: String?
    var CustmoerName: String?
    var CustomerEmail: String?
    var CustomerMobile: String?
    var CustomerNationalId: String?
    var DataSake: String?
    var DateLicence: String?
    var EmpImage: String?
    var EmpMobile: String?
    var EmpName: String?
    var GroundId: String?
    var IsDeleted: String?
    var JobName: String?
    var LatBranch: Double = 0.0
    var LatPrj: String?
    var LicenceNum: String?
    var LngBranch: Double = 0.0
    var LngPrj: String?
    var Notes: String?
    var PlanId: String?
    var ProjectInvoice: String?
    var ProjectContract: String?
    var ProjectStatusNum: String?
    var ProjectBildTypeId: String?
    var ProjectEngComment: String?
    var ProjectId: String?
    var ProjectStatusColor: String?
    var ProjectStatusID: String?
    var ProjectStatusName: String?
    var ProjectTitle: String?
    var ProjectTypeId: String?
    var ProjectTypeName: String?
    var SakNum: String?
    var Space: String?
    var Status: String?
    var TotalNotPaid: String?
    var TotalPaid: String?
    var ZoomBranch: String?
    var ZoomPrj: String?
    var projectOrderContractPhotoPath: String?
    var ProvincesName: String?
    var SectoinName: String?
    var ProjectsOrdersCellarErea: String?
    var ProjectsOrdersReFloorErea: String?
    var ProjectsOrdersSupplementErea: String?
    var ProjectsOrdersSupplementExternalErea: String?
    var ProjectsOrdersFloorErea: String?
    var ProjectsOrdersLandErea: String?
    var ProjectsOrdersFloorNummber: String?
    var ProjectsOrdersTotalBildErea: String?
    var ProjectsPaymentsWork: String?
    var ProjectsPaymentsDiscount: String?
    var CompanyInfoID: String?
    var ComapnyName: String?
    var CompanyAddress: String?
    var Logo: String?
    var norma: String?
    var flagdown = false
    
    @IBOutlet weak var ProjectTitleHeaderLabel: UILabel!
    
    @IBOutlet weak var StackCont_Header: UIStackView!
    @IBOutlet weak var Constrain_Seg_TOp: NSLayoutConstraint!
    @IBOutlet weak var HeaderView: UIView!{
        didSet{
            HeaderView.layer.cornerRadius = 4
        }
    }
    @IBOutlet weak var UpdownBtnHeader: UIButton!
    @IBOutlet weak var PlaceLocation: UIView!
    @IBOutlet weak var InformationView: UIView!
    @IBOutlet weak var AllHeaderView: UIView!{
        didSet{
            AllHeaderView.layer.cornerRadius = 4
        }
    }
    
    @IBOutlet weak var StatusView: UIView!
//        {
//        didSet{
////            StatusView.layer.cornerRadius = 7
//            StatusView.roundCorners([.bottomRight], radius: 20)
//        }
//    }
    @IBOutlet weak var OtherView: UIView!
    
    @IBAction func DropDownActionBtn(_ sender: Any) {
        print(self.view.frame.width)
        if flagdown == false
        {
            flagdown = true
            Constrain_Seg_TOp.constant = self.view.frame.width / 7.6
            StackCont_Header.isHidden = true
            UpdownBtnHeader.setImage(#imageLiteral(resourceName: "dropDown"), for: .normal)
            AllHeaderView.backgroundColor = UIColor.clear
        }
        else
        {
            flagdown = false
            if(self.view.frame.width == 414)
            {
                Constrain_Seg_TOp.constant = self.view.frame.width / 2.37
                
            }
            else
            {
                 Constrain_Seg_TOp.constant = self.view.frame.width / 2.14
            }
           
            StackCont_Header.isHidden = false
            UpdownBtnHeader.setImage(#imageLiteral(resourceName: "dropUp"), for: .normal)
           
                    AllHeaderView.backgroundColor = UIColor(red: 58/255.0, green: 59/255.0, blue: 60/255.0, alpha: 1.0)
            
        }
    }
    @IBAction func Segment(_ sender: AWSegmentController) {
        switch Segm.selectedIndex
        {
        case 0:
            OtherView.isHidden = false
            PlaceLocation.isHidden = true
            InformationView.isHidden = true
        case 1:
            OtherView.isHidden = true
            PlaceLocation.isHidden = false
            InformationView.isHidden = true
        case 2:
            OtherView.isHidden = true
            PlaceLocation.isHidden = true
            InformationView.isHidden = false
        default:
            break;
        }
        
    }
    @IBOutlet weak var Segm: AWSegmentController!
    var sv: UIView?
    
//    @IBOutlet weak var HeaderViewOut: UIView!
    
//    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var projectTitleLabel: UILabel!
    @IBOutlet weak var Emp_NAme: UILabel!
    @IBOutlet weak var lbl_companyName: UILabel!
    
    @IBOutlet weak var nameOfStatus: UILabel!
    @IBOutlet weak var PhoneNumberEmp: UIButton!
    @IBOutlet weak var SakNumber: UILabel!
    
    @IBOutlet weak var imageOfStatus: UIImageView!
    //    @IBOutlet weak var EngNameLabel: UILabel!
//    @IBOutlet weak var companyImageOut: UIImageView!{
//        didSet {
//            DispatchQueue.main.async {
//                self.companyImageOut.layer.cornerRadius = 7.0
//                self.companyImageOut.layer.masksToBounds = true
//            }
//        }
//    }
      @IBOutlet var loderview: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        loderview.isHidden = true
        loderview.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        self.view.addSubview(loderview)
    
//        HeaderViewOut.backgroundColor = UIColor(red: 58/255.0, green: 59/255.0, blue: 60/255.0, alpha: 1.0)
//        HeaderViewOut.layer.cornerRadius = 7
//        HeaderViewOut.layer.masksToBounds = true
        if(self.view.frame.width == 414)
        {
            Constrain_Seg_TOp.constant = self.view.frame.width /  2.37
            
        }
        else
        {
            Constrain_Seg_TOp.constant = self.view.frame.width / 2.14
        }
        Segm.backgroundColor = UIColor(red: 58/255.0, green: 59/255.0, blue: 60/255.0, alpha: 1.0)
        sv = UIViewController.displaySpinner(onView: view)
        print("proid"+ProjectId!)
        self.navigationItem.title = "تفاصيل المشروع"

        
        OtherView.isHidden = true
        InformationView.isHidden = false
        PlaceLocation.isHidden = true
//        assignbackground()
        
        if norma != "" {
            
        } else {
            addBackBarButtonItem()
        }
        if Reachability.isConnectedToNetwork(){
            print("Internet Connection Available!")
            GetProjectByProjectId()
        }else{
            self.ProjectId = ProjectOfResult[0].ProjectId ?? ""
            self.ProjectsPaymentsCost = ProjectOfResult[0].ProjectsPaymentsCost ?? ""
            self.CountNotPaid = ProjectOfResult[0].CountNotPaid ?? ""
            self.CountPaid = ProjectOfResult[0].CountPaid ?? ""
            self.EmpImage = ProjectOfResult[0].EmpImage ?? ""
            self.BranchID = ProjectOfResult[0].BranchID ?? ""
            self.BranchName  = ProjectOfResult[0].BranchName ?? ""
            self.CustmoerName = ProjectOfResult[0].CustmoerName ?? ""
            self.CustomerEmail = ProjectOfResult[0].CustomerEmail ?? ""
            self.CustomerMobile = ProjectOfResult[0].CustomerMobile ?? ""
            self.CustomerNationalId = ProjectOfResult[0].CustomerNationalId ?? ""
            self.DataSake = ProjectOfResult[0].DataSake ?? ""
            self.DateLicence = ProjectOfResult[0].DateLicence ?? ""
            self.EmpMobile = ProjectOfResult[0].EmpMobile ?? ""
            self.EmpName = ProjectOfResult[0].EmpName ?? ""
            self.GroundId = ProjectOfResult[0].GroundId ?? ""
            self.IsDeleted = ProjectOfResult[0].IsDeleted ?? ""
            self.JobName = ProjectOfResult[0].JobName ?? ""
            self.LatBranch = ProjectOfResult[0].LatBranch
            self.LatPrj = ProjectOfResult[0].LatPrj ?? ""
            self.LicenceNum = ProjectOfResult[0].LicenceNum ?? ""
            self.LngBranch = ProjectOfResult[0].LngBranch
            self.LngPrj = ProjectOfResult[0].LngPrj ?? ""
            self.Notes = ProjectOfResult[0].Notes ?? ""
            self.PlanId = ProjectOfResult[0].PlanId ?? ""
            self.ProjectInvoice = ProjectOfResult[0].ProjectInvoice ?? ""
            self.ProjectContract = ProjectOfResult[0].ProjectContract ?? ""
            self.ProjectStatusNum = ProjectOfResult[0].ProjectStatusNum ?? ""
            self.ProjectBildTypeId = ProjectOfResult[0].ProjectBildTypeId ?? ""
            self.ProjectEngComment = ProjectOfResult[0].ProjectEngComment ?? ""
            self.ProjectStatusColor = ProjectOfResult[0].ProjectStatusColor ?? ""
            self.ProjectStatusID = ProjectOfResult[0].ProjectStatusID ?? ""
            self.ProjectStatusName = ProjectOfResult[0].ProjectStatusName ?? ""
            self.ProjectTitle = ProjectOfResult[0].ProjectTitle ?? ""
            self.ProjectTypeId = ProjectOfResult[0].ProjectTypeId ?? ""
            self.ProjectTypeName = ProjectOfResult[0].ProjectTypeName ?? ""
            self.SakNum = ProjectOfResult[0].SakNum ?? ""
            self.Space = ProjectOfResult[0].Space ?? ""
            self.Status = ProjectOfResult[0].Status ?? ""
            self.TotalNotPaid = ProjectOfResult[0].TotalNotPaid ?? ""
            self.TotalPaid = ProjectOfResult[0].TotalPaid ?? ""
            self.ZoomBranch = ProjectOfResult[0].ZoomBranch ?? ""
            self.ZoomPrj = ProjectOfResult[0].ZoomPrj ?? ""
            self.projectOrderContractPhotoPath = ProjectOfResult[0].projectOrderContractPhotoPath ?? ""
            self.ProvincesName = ProjectOfResult[0].ProvincesName ?? ""
            self.SectoinName = ProjectOfResult[0].SectoinName ?? ""
            self.ProjectsOrdersCellarErea = ProjectOfResult[0].ProjectsOrdersCellarErea ?? ""
            self.ProjectsOrdersReFloorErea = ProjectOfResult[0].ProjectsOrdersReFloorErea ?? ""
            self.ProjectsOrdersSupplementErea = ProjectOfResult[0].ProjectsOrdersSupplementErea ?? ""
            self.ProjectsOrdersSupplementExternalErea = ProjectOfResult[0].ProjectsOrdersSupplementExternalErea ?? ""
            self.ProjectsOrdersFloorErea = ProjectOfResult[0].ProjectsOrdersFloorErea ?? ""
            self.ProjectsOrdersLandErea = ProjectOfResult[0].ProjectsOrdersLandErea ?? ""
            self.ProjectsOrdersFloorNummber = ProjectOfResult[0].ProjectsOrdersFloorNummber ?? ""
            self.ProjectsOrdersTotalBildErea = ProjectOfResult[0].ProjectsOrdersTotalBildErea ?? ""
            self.ProjectsPaymentsWork = ProjectOfResult[0].ProjectsPaymentsWork ?? ""
            self.ProjectsPaymentsDiscount = ProjectOfResult[0].ProjectsPaymentsDiscount ?? ""
            self.CompanyInfoID = ProjectOfResult[0].CompanyInfoID ?? ""
            self.ComapnyName = ProjectOfResult[0].ComapnyName ?? ""
            self.CompanyAddress = ProjectOfResult[0].CompanyAddress ?? ""
            self.Logo = ProjectOfResult[0].Logo ?? ""
            
            self.vcConf3()
            self.vcConf4()
            self.vcConf5()
            self.CompanyNamefunc()
            print("Internet Connection not Available!")
            
        }
        
        // Do any additional setup after loading the view.
    }
    
    func addBackBarButtonItem() {
        let backButton = UIButton(type: .system)
        backButton.setTitle("مشاريعي", for: .normal)
        backButton.setImage(UIImage(named: "DBackBtn"), for: .normal)
        backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        backButton.sizeToFit()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }
    
    @objc func backButtonPressed(){
        let storyBoard : UIStoryboard = UIStoryboard(name: "NewHome", bundle:nil)
        let secondView = storyBoard.instantiateViewController(withIdentifier: "NewMyProjectsViewController") as! NewMyProjectsViewController
        let topController = UIApplication.topViewController()
        topController?.show(secondView, sender: true)
    }

    func vcConf3(){
        let vc3 = self.childViewControllers[0] as! OtherViewCollectionViewController
//        vc3.getprojID(proID: self.ProjectId!)
        vc3.ProjectId = self.ProjectId!
        vc3.viewDidLoad()
    }
    func vcConf4(){
        let dLati = Double(self.LatPrj!) ?? 0.0
        let dLang = Double(self.LngPrj!) ?? 0.0
        let dZoom = Float(self.ZoomPrj!) ?? 0.0
        print("zoom" + "\(dZoom)")
        let vc4 = self.childViewControllers[1] as! PlaceLocationViewController
        vc4.mapView.delegate = self
//        vc4.zoom(zoom: dZoom)
        vc4.map(l: dLati, lng: dLang, Z: dZoom)
        
    }
    func vcConf5(){
        let vc5 = self.childViewControllers[2] as! InformationViewController
//        if self.ProjectStatusName == "ملغي"{
//            vc5.imageOfStatus.image = #imageLiteral(resourceName: "تم الالغاء-1")
//        }else if self.ProjectStatusName == "قيد الاستقبال"{
//            vc5.imageOfStatus.image = #imageLiteral(resourceName: "قيد الالستقبال")
//        }else if self.ProjectStatusName == "تم الانجاز"{
//            vc5.imageOfStatus.image = #imageLiteral(resourceName: "تم الانجاز-1")
//        }else if self.ProjectStatusName == "جاري العمل"{
//            vc5.imageOfStatus.image = #imageLiteral(resourceName: "جاري العمل-1")
//        }else if self.ProjectStatusName == "مرفوض"{
//            vc5.imageOfStatus.image = #imageLiteral(resourceName: "مرفوض-1")
//        }else {
//            print("error status")
//        }
        vc5.nameOfStatus = self.ProjectStatusName!
        vc5.EngNotes = self.ProjectEngComment!
        vc5.officePlace = self.BranchName!
        vc5.projectType = self.ProjectTypeName!
        vc5.numberOfSake = self.SakNum!
        vc5.customerDetials = self.Notes!
        vc5.nameOfProject = self.ProjectTitle!
        vc5.nameOfEmploy = self.EmpName!
        vc5.mobileEmploy = self.EmpMobile!
        vc5.numberALlmogh = self.PlanId!
        vc5.numberLicence = self.LicenceNum!
        vc5.space = self.Space!
        vc5.numberPlan = self.GroundId!
        vc5.LatBranch = self.LatBranch
        vc5.LngBranch = self.LngBranch
        vc5.ZoomBranch = self.ZoomBranch!
        vc5.namePio = self.JobName!
        vc5.nameEmp = self.EmpName!
        vc5.mobileEmp = self.EmpMobile!
        vc5.BranchName = self.BranchName!
        vc5.ProvincesName = self.ProvincesName!
        vc5.SectoinName = self.SectoinName!
        vc5.ProjectsOrdersCellarErea = self.ProjectsOrdersCellarErea!
        vc5.ProjectsOrdersReFloorErea = self.ProjectsOrdersReFloorErea!
        vc5.ProjectsOrdersSupplementErea = self.ProjectsOrdersSupplementErea!
        vc5.ProjectsOrdersSupplementExternalErea = self.ProjectsOrdersSupplementExternalErea!
        vc5.ProjectsOrdersFloorErea = self.ProjectsOrdersFloorErea!
        vc5.ProjectsOrdersLandErea = self.ProjectsOrdersLandErea!
        vc5.ProjectsOrdersFloorNummber = self.ProjectsOrdersFloorNummber!
        vc5.ProjectsOrdersTotalBildErea = self.ProjectsOrdersTotalBildErea!
        vc5.ProjectsPaymentsWork = self.ProjectsPaymentsWork!
        vc5.ProjectsPaymentsDiscount = self.ProjectsPaymentsDiscount!
        vc5.ProjectsPaymentsCost = self.ProjectsPaymentsCost!
        vc5.ProjectStatusNum = self.ProjectStatusNum!
        vc5.dataOfLicence = DateLicence!
        vc5.dataOfSak = DataSake!
        vc5.ProjectStatusID = self.ProjectStatusID!
        vc5.informationTableView.reloadData()
        UIViewController.removeSpinner(spinner: sv!)
    }
    
    func CompanyNamefunc() {
//        projectTitleLabel.text = ProjectTitle ?? ""
        ProjectTitleHeaderLabel.text = ProjectTitle ?? ""
        Emp_NAme.text = EmpName
        if SakNum != ""
        {
        SakNumber.text = SakNum
        }else
        {
             SakNumber.text = ProjectId
        }
        lbl_companyName.text = ComapnyName
        PhoneNumberEmp.setTitle(EmpMobile, for: .normal)
        if self.ProjectStatusID == "5"{

            StatusView.backgroundColor = HelperMethod.hexStringToUIColor(hex: ProjectStatusColor!)
        }else if self.ProjectStatusID == "4"{
//            imageOfStatus.image = #imageLiteral(resourceName: "قيد الالستقبال")
            StatusView.backgroundColor = HelperMethod.hexStringToUIColor(hex: ProjectStatusColor!)
        }else if self.ProjectStatusID == "3"{
//            imageOfStatus.image = #imageLiteral(resourceName: "تم الانجاز-1")
            StatusView.backgroundColor = HelperMethod.hexStringToUIColor(hex: ProjectStatusColor!)
        }else if self.ProjectStatusID == "1"{
//            imageOfStatus.image = #imageLiteral(resourceName: "جاري العمل-1")
            StatusView.backgroundColor = HelperMethod.hexStringToUIColor(hex: ProjectStatusColor!)
            
        }else if self.ProjectStatusID == "2"{
//            imageOfStatus.image = #imageLiteral(resourceName: "مرفوض-1")
           StatusView.backgroundColor = HelperMethod.hexStringToUIColor(hex: ProjectStatusColor!)
        }else if self.ProjectStatusID == "6"{
//            imageOfStatus.image = #imageLiteral(resourceName: "تم الالغاء-1")
           StatusView.backgroundColor = HelperMethod.hexStringToUIColor(hex: ProjectStatusColor!)
        }else if self.ProjectStatusID == "7"{
//            imageOfStatus.image = #imageLiteral(resourceName: "جاري العمل-1")
            StatusView.backgroundColor = HelperMethod.hexStringToUIColor(hex: ProjectStatusColor!)
        }else {
            print("error status")
        }
        nameOfStatus.text = ProjectStatusName
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    func GetProjectByProjectId(){
        loderview.isHidden = false
        
        let sv = UIViewController.displaySpinner(onView: self.view)
        let parameters: Parameters = [
            "projectId": self.ProjectId!
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
            self.ComapnyName = json["ComapnyName"].stringValue
            self.CompanyAddress = json["Address"].stringValue
            self.Logo = json["Logo"].stringValue
            UserDefaults.standard.set(json["CompanyInfoID"].stringValue, forKey: "companyInfoID")
            self.vcConf3()
            self.vcConf4()
            self.vcConf5()
            self.CompanyNamefunc()
            UIViewController.removeSpinner(spinner: sv)
            self.loderview.isHidden = true
        }
        
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
        var mobile: String = (mobileNum!)
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
