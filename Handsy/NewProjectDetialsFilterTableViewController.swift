//
//  NewProjectDetialsFilterTableViewController.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 12/27/17.
//  Copyright © 2017 Ahmed Wahdan. All rights reserved.
//

import UIKit
import MapKit
import Alamofire
import SwiftyJSON


class NewProjectDetialsFilterTableViewController: UITableViewController {
    
    
    // constian of constrzct status
    
    @IBOutlet weak var ContractBoton: NSLayoutConstraint!
    @IBOutlet weak var Money_botom: NSLayoutConstraint!
    @IBOutlet weak var ConstrainStackBotton: NSLayoutConstraint!
    //
    @IBOutlet var detialsBtnView: UIView!
  
    
    @IBOutlet weak var lbl_pro_number: UILabel!
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var projectTitleLabel: UILabel!
    @IBOutlet weak var EngNameLabel: UILabel!
    @IBOutlet weak var engJobName: UILabel!
    
    @IBOutlet weak var companyImageOut: UIImageView!
    
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
    
    @IBOutlet weak var messageWithEng: UIButton! {
        didSet {
            messageWithEng.layer.borderWidth = 1.0
            messageWithEng.layer.borderColor = #colorLiteral(red: 0.2, green: 0.5647058824, blue: 0.3882352941, alpha: 1)
            messageWithEng.layer.cornerRadius = 4.0
        }
    }
    
    
    @IBOutlet weak var messageCountLabel: UILabel!{
        didSet {
            DispatchQueue.main.async {
                self.messageCountLabel.layer.cornerRadius = self.messageCountLabel.frame.width/2
                self.messageCountLabel.layer.masksToBounds = true
            }
        }
    }
    
    @IBOutlet weak var cancelProView: UIView!{
        didSet {
            cancelProView.layer.cornerRadius = 4.0
        }
    }
    
    
    @IBOutlet weak var projectDetialsBtnOut: UIButton!{
        didSet {
            DispatchQueue.main.async {
                self.projectDetialsBtnOut.layer.cornerRadius = 7.0
                self.projectDetialsBtnOut.layer.masksToBounds = true
            }
        }
    }
    
    @IBOutlet weak var contractAlertLabel: UILabel!{
        didSet{
            contractAlertLabel.layer.cornerRadius = 7.0
            contractAlertLabel?.layer.masksToBounds = true
        }
    }
    
    @IBOutlet weak var MoneyDetialsBtnOut: UIButton!{
        didSet {
            DispatchQueue.main.async {
                self.MoneyDetialsBtnOut.layer.cornerRadius = 7.0
                self.MoneyDetialsBtnOut.layer.masksToBounds = true
            }
        }
    }
    @IBOutlet weak var DesignsDetialsBtnOut: UIButton!
    
    @IBOutlet weak var contractBtnOut: UIButton!{
        didSet {
            DispatchQueue.main.async {
                self.contractBtnOut.circleView(UIColor.clear, borderWidth: 1.0)
            }
        }
    }
    @IBOutlet weak var newContractOut: UIView!
    
    @IBOutlet weak var newVisitsCountLabel: UILabel!{
        didSet {
            
            DispatchQueue.main.async {
                self.newVisitsCountLabel.layer.cornerRadius =  self.newVisitsCountLabel.frame.width/2
                self.newVisitsCountLabel.layer.masksToBounds = true
            }
        }
    }
    
    @IBOutlet weak var newDesignsCountLabel: UILabel!{
        didSet {
            DispatchQueue.main.async {
                self.newDesignsCountLabel.layer.cornerRadius = self.newDesignsCountLabel.frame.width/2
                self.newDesignsCountLabel.layer.masksToBounds = true
            }
        }
    }
    
    
    @IBOutlet weak var StatusView1: UIView!
//        {
//        didSet{
//             self.StatusView1.roundCorners([.bottomRight], radius: 15)
//        }
//    }
    
    @IBOutlet weak var VisitsDetialsBtnOut: UIButton!
    
    
    @IBOutlet weak var FilesOneDetialsBtnOut: UIButton!
    
    @IBOutlet weak var FilesTwoDetialsBtnOut: UIButton!
    
    @IBOutlet weak var paymentsCost: UILabel!
    @IBOutlet weak var projectTotalPaid: UILabel!
    @IBOutlet weak var projectTotalNotPaid: UILabel!
    
    @IBOutlet weak var contractBtn: UIButton!
    
    
    var searchResu:[GetProjectEngCustByCustID] = [GetProjectEngCustByCustID]()
    var index: Int?
    var ProjectOfResult: [ProjectDetialsArray] = [ProjectDetialsArray]()
    var projectsDetialsModel: ProjectsDetialsModel = ProjectsDetialsModel()
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
    var FileCount = ""
    var DocCount = ""
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
    var ContractHistoryCount: String = ""
   
    var arrayOfResulr = [GetOfficesArray]()
    var indexi:Int = 0
    var isCompany = ""
    var nou = ""
    var nour = ""
    var comafterlogin = false
    var MeetingCountcheck = ""
     var DesignCountcheck = ""
    
    @IBOutlet weak var statusView: UIView!
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
    
    @IBOutlet weak var DocCountLabel: UILabel!{
        didSet {
            DispatchQueue.main.async {
                self.DocCountLabel.layer.cornerRadius = self.DocCountLabel.frame.width/2
                self.DocCountLabel.layer.masksToBounds = true
            }
        }
    }
    @IBOutlet weak var FileCountLabel: UILabel!{
        didSet {
            DispatchQueue.main.async {
                self.FileCountLabel.layer.cornerRadius = self.FileCountLabel.frame.width/2
                self.FileCountLabel.layer.masksToBounds = true
            }
        }
    }
    
    var timer: Timer?
    
     var AlertController: UIAlertController!
      @IBOutlet var loderview: UIView!
    
    
    override func viewDidLoad() {
          super.viewDidLoad()
      CountCustomerNotification()
        detialsBtnView.isHidden = true
        
        detialsBtnView.isHidden = true
         loderview.isHidden = true
        loderview.frame = CGRect(x: 0, y: 0, width: self.tableView.frame.width, height: self.tableView.frame.height)
        self.view.addSubview(loderview)
        
      
        self.tabBarController?.tabBar.isHidden = false
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(hideContract), userInfo: nil, repeats: false)
        newVisitsCountLabel.isHidden = true
        //        newVisitsCountImage.isHidden = true
        cancelProView.isHidden = true
        MoneyDetialsBtnOut.isHidden = true
        contractAlertLabel.isHidden = true
        DispatchQueue.main.async {
            self.statusView.roundCorners([.topLeft, .topRight], radius: 10)
        }
        contractBtn.isHidden = true
        //        if norma != "" {
        //            navigationItem.title = ProjectTitle
        //        } else {
        //            navigationItem.title = searchResu[index!].ProjectTitle
        //        }
        
        
        popUp.isHidden = true
        DispatchQueue.main.async {
            self.popUp.frame = CGRect.init(x: 0, y: 0, width: 338, height: 190)
            self.popUp.center = self.view.center
            self.view.addSubview(self.popUp)
        }
        endPopUp.isHidden = true
        DispatchQueue.main.async {
            self.endPopUp.frame = CGRect.init(x: 0, y: 0, width: 338, height: 190)
            self.endPopUp.center = self.view.center
            self.view.addSubview(self.endPopUp)
        }
        DispatchQueue.main.async {
            self.detialsBtnView.frame = CGRect.init(x: 0, y: self.tableView.contentOffset.y + (self.view.frame.height-57), width: self.view.frame.width, height: 57)
            if #available(iOS 11, *) {
                self.tableView.contentInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 47, right: 0)
            }else{
                self.tableView.contentInset = UIEdgeInsets.init(top: 52, left: 0, bottom: 47, right: 0)
            }
            self.tableView.bringSubview(toFront: self.detialsBtnView)
            self.tableView.addSubview(self.detialsBtnView)
        }
        
        if nou == "" {
            
        } else if norma != "" {
            
        } else {
            if nour == "loll" {
                
            }else if nou == "uu" {
                
            }else {
                addBackBarButtonItem()
            }
        }
        // Do any additional setup after loading the view.
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
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        messageCountLabel.isHidden = true
        if Reachability.isConnectedToNetwork(){
            print("Internet Connection Available!")
            GetProjectByProjectId()
            GetCountMessageUnReaded()
        }else{
            projectsDetialsModel.loadItems()
            print("Internet Connection not Available!")
            if nou == "" && norma == "" {
                if projectsDetialsModel.returnProjectDetials(at: searchResu[index!].ProjectId) != nil {
                    let detials = projectsDetialsModel.returnProjectDetials(at: searchResu[index!].ProjectId)
                    self.ProjectOfResult = [detials!]
                }
            }else{
                if projectsDetialsModel.returnProjectDetials(at: ProjectId) != nil {
                    let detials = projectsDetialsModel.returnProjectDetials(at: ProjectId)
                    self.ProjectOfResult = [detials!]
                }
            }
            self.setFirstSection()
            self.setSecondSection()
            self.setThirdSection()
            self.setFourthSection()
            self.BtnSettingFunc()
            tableView.reloadData()
        }
    }
    
    @objc func hideContract() {
        newContractOut.isHidden = true
        tableView.reloadData()
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
        if comafterlogin == true
        {
            comafterlogin = false
            let storyBoard : UIStoryboard = UIStoryboard(name: "NewHome", bundle:nil)
            let sub = storyBoard.instantiateViewController(withIdentifier: "NewMain") as! NewTabBarViewController
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            
            appDelegate.window?.rootViewController = sub
        }
        
//        let storyBoard : UIStoryboard = UIStoryboard(name: "NewHome", bundle:nil)
//        let NavController = storyBoard.instantiateViewController(withIdentifier: "NewMain") as! NewTabBarViewController
//        NavController.selectedIndex = 0
//        self.present(NavController, animated: false, completion: nil)
        else
        {
        dismiss(animated: true, completion: nil)
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func BtnSettingFunc() {
        let status: String?
        if nou == "" && norma == "" {
            status = searchResu[index!].ProjectStatusID
        }else {
            status = ProjectStatusID
        }
    }
    
    func setFirstSection() {
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
            cancelProView.isHidden = true
            statusNameLabel.text = statusName
            StatusView1.backgroundColor = HelperMethod.hexStringToUIColor(hex: ProjectOfResult[0].ProjectStatusColor!)
        }else if status == "4"{
            cancelProView.isHidden = false
            statusNameLabel.text = statusName
            StatusView1.backgroundColor = HelperMethod.hexStringToUIColor(hex: ProjectOfResult[0].ProjectStatusColor!)
        }else if status == "3"{
            cancelProView.isHidden = true
            statusNameLabel.text = statusName
            StatusView1.backgroundColor = HelperMethod.hexStringToUIColor(hex: ProjectOfResult[0].ProjectStatusColor!)
        }else if status == "1"{
            cancelProView.isHidden = true
            statusNameLabel.text = statusName
            StatusView1.backgroundColor = HelperMethod.hexStringToUIColor(hex: ProjectOfResult[0].ProjectStatusColor!)
        }else if status == "2"{
            cancelProView.isHidden = true
            statusNameLabel.text = statusName
            StatusView1.backgroundColor = HelperMethod.hexStringToUIColor(hex: ProjectOfResult[0].ProjectStatusColor!)
        }else if status == "6"{
            cancelProView.isHidden = true
            statusNameLabel.text = statusName
            StatusView1.backgroundColor = HelperMethod.hexStringToUIColor(hex: ProjectOfResult[0].ProjectStatusColor!)
        }else if status == "7"{
            cancelProView.isHidden = false
            statusNameLabel.text = statusName
            StatusView1.backgroundColor = HelperMethod.hexStringToUIColor(hex: ProjectOfResult[0].ProjectStatusColor!)
        }else {
            print("error status \(status)")
        }
        //        companyNameLabel.text = ProjectOfResult[0].ComapnyName!
        projectTitleLabel.text = ProjectOfResult[0].ProjectTitle
       
        if ProjectOfResult[0].SakNum == ""
        {
        lbl_pro_number.text = ProjectOfResult[0].ProjectId
        }
        else
        {
               lbl_pro_number.text = ProjectOfResult[0].SakNum
        }
        
        EngNameLabel.text = ProjectOfResult[0].EmpName
        engJobName.text = ProjectOfResult[0].JobName
        let img = ProjectOfResult[0].EmpImage!
        let trimmedString = img.trimmingCharacters(in: .whitespaces)
        
     let updatedUrl = trimmedString.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        print(img)
           print(updatedUrl!)
        if let url = URL.init(string: updatedUrl!) {
            companyImageOut.hnk_setImageFromURL(url, placeholder: #imageLiteral(resourceName: "officePlaceholder"))
        } else{
            print("nil")
            companyImageOut.image = #imageLiteral(resourceName: "officePlaceholder")
        }
        
        if ContractHistoryCount != "" ||  ContractHistoryCount != "0"
        {
            ConntractRecordBtn.isHidden = false
            
        }else
        {
            ConntractRecordBtn.isHidden = true
        }
    }
    
    func setSecondSection() {
        //        let condition = ProjectOfResult[0].ProjectStatusNum
        //        if condition == "1" {
        //            MoneyDetialsBtnOut.isHidden = true
        //            contractAlertLabel.isHidden = false
        //        } else {
        //            MoneyDetialsBtnOut.isHidden = false
        //            contractAlertLabel.isHidden = true
        //        }
        
        print(ProjectOfResult[0].ProjectContract!)
        
        if ProjectOfResult[0].ProjectContract == "1"  {
            contractBtn.isHidden = false
            contractBtn.isEnabled = true
            contractBtn.setImage(#imageLiteral(resourceName: "NewConterct"), for: .normal)
            newContractOut.isHidden = false
            contractBtnOut.isHidden = false
            MoneyDetialsBtnOut.isHidden = false
            contractAlertLabel.isHidden = true
            Money_botom.constant = 10
            ConstrainStackBotton.constant = -5
            ContractBoton.constant = 4
            
        } else if  ProjectContract == "4"
        {
            contractBtn.isHidden = false
            contractBtn.isEnabled = true
            contractBtn.setImage(#imageLiteral(resourceName: "NewConterct"), for: .normal)
            newContractOut.isHidden = false
            contractBtnOut.isHidden = false
            MoneyDetialsBtnOut.isHidden = false
            
            contractAlertLabel.isHidden = true
            Money_botom.constant = 10
            ConstrainStackBotton.constant = -5
            ContractBoton.constant = 4
//            contractAlertLabel.text = "جاري العمل علي طلبات التعديل في بنود العقد,وإعاده إرسالة إليكم "
        }
        else if  ProjectContract == "2"
        {
            contractBtn.isHidden = true
            contractBtn.isEnabled = true
            contractBtn.setImage(#imageLiteral(resourceName: "NewConterct"), for: .normal)
            newContractOut.isHidden = true
            contractBtnOut.isHidden = true
            MoneyDetialsBtnOut.isHidden = true
            contractAlertLabel.isHidden = false
            contractAlertLabel.text = "تم تسجيل طلب المشروع بنجاع"
//            contractAlertLabel.backgroundColor = UIColor.red
            ConstrainStackBotton.constant = -45
        }
        else if ProjectOfResult[0].ProjectContract == "3" {
            contractBtn.isEnabled = true
            contractBtn.setImage(#imageLiteral(resourceName: "NewConterct"), for: .normal)
            contractBtn.isHidden = false
            newContractOut.isHidden = true
            contractBtnOut.isHidden = true
            MoneyDetialsBtnOut.isHidden = false
            contractAlertLabel.isHidden = true
            Money_botom.constant = 10
            ConstrainStackBotton.constant = -5
            ContractBoton.constant = 4
        } else {
            contractBtn.isHidden = true
            contractBtn.isEnabled = true
            contractBtn.setImage(#imageLiteral(resourceName: "NewConterct"), for: .normal)
            newContractOut.isHidden = true
            contractBtnOut.isHidden = true
            MoneyDetialsBtnOut.isHidden = true
            contractAlertLabel.isHidden = false
            contractAlertLabel.text = "تم تسجيل طلب المشروع بنجاع"
//            contractAlertLabel.backgroundColor = UIColor.red
            ConstrainStackBotton.constant = -45
        }
        tableView.reloadData()
        
        let largeNumber = Double(ProjectOfResult[0].ProjectsPaymentsCost!) ?? 0.0
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        let formattedNumber = numberFormatter.string(from: NSNumber(value:largeNumber))
        if formattedNumber == "0" {
            paymentsCost.textColor = #colorLiteral(red: 0.831372549, green: 0.6862745098, blue: 0.2117647059, alpha: 1)
            paymentsCost.text = "0.0 \n ر.س"
        }else {
            paymentsCost.text = "\(formattedNumber ?? "0.0") \n ر.س"
        }
        let largeNumber1 = Double(ProjectOfResult[0].TotalPaid!) ?? 0.0
        let numberFormatter1 = NumberFormatter()
        numberFormatter1.numberStyle = NumberFormatter.Style.decimal
        let formattedNumber1 = numberFormatter.string(from: NSNumber(value:largeNumber1))
        if formattedNumber1 == "0" {
            projectTotalPaid.textColor = #colorLiteral(red: 0.831372549, green: 0.6862745098, blue: 0.2117647059, alpha: 1)
            projectTotalPaid.text = "0.0 \n ر.س"
        }else {
            projectTotalPaid.text = "\(formattedNumber1 ?? "0.0") \n ر.س"
        }
        
        let largeNumber2 = Double(ProjectOfResult[0].TotalNotPaid!) ?? 0.0
        let numberFormatter2 = NumberFormatter()
        numberFormatter2.numberStyle = NumberFormatter.Style.decimal
        let formattedNumber2 = numberFormatter.string(from: NSNumber(value:largeNumber2))
        if formattedNumber2 == "0" {
            projectTotalNotPaid.textColor = #colorLiteral(red: 0.831372549, green: 0.6862745098, blue: 0.2117647059, alpha: 1)
            projectTotalNotPaid.text = "0.0 \n ر.س"
        }else {
            projectTotalNotPaid.text = "\(formattedNumber2 ?? "0.0") \n ر.س"
        }
        tableView.reloadData()
    }
    
    func setThirdSection() {
      
        print(DesignCount)
        
        if DesignCount != "0" {
            print("Design: \(DesignCountcheck)")
            newDesignsCountLabel.isHidden = false
            newDesignsCountLabel.text = DesignCount
        } else {
            newDesignsCountLabel.isHidden = true
        }
        
        if FileCount != "0"
        {
            FileCountLabel.isHidden = false
            FileCountLabel.text = FileCount
        }else
        {
             FileCountLabel.isHidden = true
        }
        
        if DocCount != "0"
        {
            DocCountLabel.isHidden = false
            DocCountLabel.text = DocCount
        }else
        {
            DocCountLabel.isHidden = true
        }
        
    }
    
    func setFourthSection() {
        print(self.ProjectOfResult[0].MeetingNotifiCount)
        print(self.ProjectOfResult[0].Meetingcount)
        if MeetingCount != "" {
            //            newVisitsCountImage.isHidden = false
            if MeetingCount == "0" {
                newVisitsCountLabel.isHidden = true
            }else {
                newVisitsCountLabel.isHidden = false
            }
            newVisitsCountLabel.text = MeetingCount
        } else {
            //            newVisitsCountImage.isHidden = true
            newVisitsCountLabel.isHidden = true
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 4
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            if newContractOut.isHidden == true {
                return 0.0
            }else {
                return 100
                
            }
        }else {
            return 100
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            if newContractOut.isHidden == true {
                return 0.0
            }else {
                return 115
            }
        }else {
            return UITableViewAutomaticDimension
        }
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView){
        if scrollView == tableView {
            var frame: CGRect = self.detialsBtnView.frame
            frame.origin.y = scrollView.contentOffset.y + self.view.frame.height - 57
            detialsBtnView.frame = frame
        }
    }
    
    @IBAction func showCancelPopUp(_ sender: UIButton) {
        popUp.isHidden = false
    }
    
    @IBOutlet weak var popUp: UIView!
    @IBOutlet weak var endPopUp: UIView!
    @IBOutlet weak var YesOutBt: UIButton!{
        didSet {
            DispatchQueue.main.async {
                self.YesOutBt.circleView(UIColor.clear, borderWidth: 1.0)
            }
        }
    }
    
    @IBAction func YesRemove(_ sender: UIButton) {
        ProjectCancel()
        popUp.isHidden = true
        endPopUp.isHidden = false
    }
    
    func ProjectCancel() {
        // call some api
        
        let parameters: Parameters = [
            "projectId" : ProjectId
        ]
        
        Alamofire.request("http://smusers.promit2030.co/Service1.svc/ProjectCancel", method: .get, parameters: parameters, encoding: URLEncoding.default).responseJSON { response in
            debugPrint(response)
            let json = JSON(response.result.value!)
            
            print(json)
        }
        
    }
    
    @IBOutlet weak var NoOutBt: UIButton!{
        didSet {
            DispatchQueue.main.async {
                self.NoOutBt.circleView(UIColor.clear, borderWidth: 1.0)
            }
        }
    }
    
    @IBAction func NoThanks(_ sender: UIButton) {
        popUp.isHidden = true
    }
    
    @IBAction func endDismissBtn(_ sender: UIButton) {
        popUp.isHidden = true
    }
    
    @IBOutlet weak var EndOutBt: UIButton!{
        didSet {
            DispatchQueue.main.async {
                self.EndOutBt.circleView(UIColor.clear, borderWidth: 1.0)
            }
        }
    }
    //    @IBOutlet weak var viewOneConst: UIView!
    //    @IBOutlet weak var ViewOneCons: NSLayoutConstraint!
    
    //    @IBOutlet weak var viewTwoConst: UIView!
    //    @IBOutlet weak var viewTwoCons: NSLayoutConstraint!
    //    @IBOutlet weak var stackBtn: UIStackView!
    
    @IBAction func end(_ sender: UIButton) {
        endPopUp.isHidden = true
        GetProjectByProjectId()
        //        DispatchQueue.main.async {
        //            self.ViewOneCons.constant = 52
        //            self.viewTwoCons.constant = 52
        //            self.EditViewOut.isHidden = true
        //        }
        tableView.reloadData()
    }
    
    //    @IBOutlet weak var EditViewOut: AMUIView!
    
    @IBAction func EditBtnAction(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "ProjectsAndEdit", bundle:nil)
        let cont = storyBoard.instantiateViewController(withIdentifier: "EditATableViewController")as! EditATableViewController
        cont.BranchID = BranchID
        cont.BranchName = BranchName
        cont.CustmoerName = CustmoerName
        cont.CustomerEmail = CustomerEmail
        cont.CustomerMobile = CustomerMobile
        cont.CustomerNationalId = CustomerNationalId
        cont.DataSake = DataSake
        cont.DateLicence = DateLicence
        cont.EmpImage = EmpImage
        cont.EmpMobile = EmpMobile
        cont.EmpName = EmpName
        cont.GroundId = GroundId
        cont.IsDeleted = IsDeleted
        cont.JobName = JobName
        cont.LatBranch = LatBranch
        cont.LatPrj = LatPrj
        cont.LicenceNum = LicenceNum
        cont.LngBranch = LngBranch
        cont.LngPrj = LngPrj
        cont.Notes = Notes
        cont.PlanId = PlanId
        cont.ProjectBildTypeId = ProjectBildTypeId
        cont.ProjectEngComment = ProjectEngComment
        cont.ProjectId = ProjectId
        cont.ProjectStatusColor = ProjectStatusColor
        cont.ProjectStatusID = ProjectStatusID
        cont.ProjectStatusName = ProjectStatusName
        cont.ProjectTitle = ProjectTitle
        cont.ProjectTypeId = ProjectTypeId
        cont.ProjectTypeName = ProjectTypeName
        cont.SakNum = SakNum
        cont.Space = Space
        cont.Status = Status
        cont.ZoomBranch = ZoomBranch
        cont.ZoomPrj = ZoomPrj
        self.navigationController?.pushViewController(cont, animated: true)
    }
    
    //    @IBOutlet weak var CancelBtnOut: UIButton!
    //    @IBOutlet weak var CancelViewBtn: AMUIView!
    //    @IBOutlet weak var CancelStackView: UIStackView!
    //
    //    @IBAction func CancelBtnAction(_ sender: UIButton) {
    //        popUp.isHidden = false
    //    }
    
    @IBAction func goOfficeDetials(_ sender: UIButton) {
        GetOfficesByProvincesID()
    }
    
    func GetOfficesByProvincesID(){
        loderview.isHidden = false
        tableView.isHidden = true
         detialsBtnView.isHidden = true
        let sv = UIViewController.displaySpinner(onView: self.view)
        //        let id = UserDefaults.standard.string(forKey: "account_id")!
        //        let account_type = UserDefaults.standard.string(forKey: "account_type")!
        
        
        let Parameters: Parameters = [
            "companyInfoID": CompanyInfoID
        ]
        
        Alamofire.request("http://smusers.promit2030.co/Service1.svc/GetOfficeByCompanyInfoID", method: .get, parameters: Parameters, encoding: URLEncoding.default).responseJSON { response in
            debugPrint(response)
            switch response.result {
            case .success:
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
               
                
                self.detialsBtnView.isHidden = false
                     self.tableView.isHidden =  false
                 self.loderview.isHidden = true
                self.goH()
            case .failure(let error):
                print(error)
                UIViewController.removeSpinner(spinner: sv)
                let alertAction = UIAlertController(title: "خطاء في الاتصال", message: "اعادة المحاولة", preferredStyle: .alert)
                
                alertAction.addAction(UIAlertAction(title: "نعم", style: .default, handler: { action in
                    self.GetOfficesByProvincesID()
                }))
                
                alertAction.addAction(UIAlertAction(title: "رجوع", style: .cancel, handler: { action in
                    self.navigationController!.popViewController(animated: true)
                }))
                
                self.present(alertAction, animated: true, completion: nil)
                
            }
        }
    }
    
    func goH(){
        let storyBoard : UIStoryboard = UIStoryboard(name: "NewProject", bundle:nil)
        let secondView = storyBoard.instantiateViewController(withIdentifier: "DetailsOfOfficeTableViewController") as! DetailsOfOfficeTableViewController
        secondView.arrayOfResulr = self.arrayOfResulr
        print("arrr: \(self.arrayOfResulr.count)")
        secondView.index = self.indexi
        secondView.isCompany = self.isCompany
        secondView.CompanyInfoID = self.CompanyInfoID
        secondView.conditionService = "condition"
        secondView.LatBranch = LatBranch
        secondView.LngBranch = LngBranch
        self.navigationController?.pushViewController(secondView, animated: true)
    }
    
    @IBAction func CallMe(_ sender: UIButton) {
        let mobileNum = searchResu[index!].EmpMobile
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
    
    @IBAction func directionBtn(_ sender: UIButton) {
        LatBranch = searchResu[index!].LatBranch
        LngBranch = searchResu[index!].LngBranch
        
//        let dLati = searchResu[index!].LatBranch
//        let dLang = searchResu[index!].LngBranch
//        
//        let alertAction = UIAlertController(title: "اختر الخريطة", message: "", preferredStyle: .alert)
//
//        alertAction.addAction(UIAlertAction(title: "جوجل ماب", style: .default, handler: { action in
//            if UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!) {
//                UIApplication.shared.open(URL(string: "comgooglemaps://?center=\(dLati),\(dLang)&zoom=14&views=traffic&q=\(dLati),\(dLang)")!, options: [:], completionHandler: nil)
//            } else {
//                print("Can't use comgooglemaps://")
//                UIApplication.shared.open(URL(string: "http://maps.google.com/maps?q=\(dLati),\(dLang)&zoom=14&views=traffic")!, options: [:], completionHandler: nil)
//            }
//        }))
//
//        alertAction.addAction(UIAlertAction(title: "الخرائط", style: .default, handler: { action in
//            self.openMapsForLocation()
//        }))
//
//        alertAction.addAction(UIAlertAction(title: "رجوع", style: .cancel, handler: { action in
//        }))
//        self.present(alertAction, animated: true, completion: nil)
        
        if Helper.isDeviceiPad() {
            
            if let popoverController = AlertController.popoverPresentationController {
                popoverController.sourceView = sender
            }
        }
 
        self.present(AlertController, animated: true, completion: nil)
    }
    func openMapsForLocation() {
        let dLati = searchResu[index!].LatBranch
        let dLang = searchResu[index!].LngBranch
        
        let location = CLLocation(latitude: dLati, longitude: dLang)
        print(location.coordinate)
        MKMapView.openMapsWith(location) { (error) in
            if error != nil {
                print("Could not open maps" + error!.localizedDescription)
            }
        }
    }
    
    func GetProjectByProjectId(){
        loderview.isHidden = false
         detialsBtnView.isHidden = true
         tableView.isHidden = true
        let sv = UIViewController.displaySpinner(onView: self.view)
        let parameters: Parameters?
        if nou == "" && norma == "" {
            parameters = [
                "projectId": searchResu[index!].ProjectId
            ]
        }else if nou == "uu"{
            parameters = [
                "projectId": ProjectId
            ]
        }else{
            parameters = [
                "projectId": ProjectId
            ]
        }
        
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
            self.MeetingCountcheck = json["viewMeetingCount"].stringValue
            self.DesignCountcheck = json["viewDesignsCount"].stringValue
            self.FileCount = json["FileCount"].stringValue
            self.DocCount = json["DocCount"].stringValue
            self.ContractHistoryCount =  json["ContractHistoryCount"].stringValue
            
            self.ProjectOfResult.append(requestProjectObj)
            for i in self.ProjectOfResult {
                self.projectsDetialsModel.append(i)
            }
            self.setFirstSection()
            self.setSecondSection()
            self.setThirdSection()
            self.setFourthSection()
            self.BtnSettingFunc()
            UIViewController.removeSpinner(spinner: sv)
           
            self.detialsBtnView.isHidden = false
            self.tableView.isHidden = false
             self.loderview.isHidden = true
            
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
    
    
    
    @IBAction func openDetialsViewController(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "ProjectsAndEdit", bundle:nil)
        let vc1 = storyBoard.instantiateViewController(withIdentifier: "DetailsOfProjectViewController") as! DetailsOfProjectViewController
        vc1.ProjectId = self.ProjectOfResult[0].ProjectId!
        vc1.ProjectOfResult = self.ProjectOfResult
        vc1.ProjectTitle = self.ProjectOfResult[0].ProjectTitle!
        vc1.norma = "hkhk"
        vc1.LatBranch = LatBranch
        vc1.LngBranch = LngBranch
        self.navigationController?.pushViewController(vc1, animated: true)
    }
    
    @IBAction func VisubleContractAction(_ sender: UIButton) {
        let openContract = self.ProjectOfResult[0].projectOrderContractPhotoPath!
        print(self.ProjectOfResult[0].projectOrderContractPhotoPath!)
        print(ProjectContract)
        if ProjectContract == "1" || ProjectContract == "4"{
            let storyBoard : UIStoryboard = UIStoryboard(name: "ProjectsAndEdit", bundle:nil)
            let secondView = storyBoard.instantiateViewController(withIdentifier: "ShowContractViewController") as! ShowContractViewController
            print(openContract)
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
    }
    
    @IBAction func openMoneyViewController(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "ProjectsAndEdit", bundle:nil)
        let vc1 = storyBoard.instantiateViewController(withIdentifier: "MoneyManagmentDetialsTableViewController") as! MoneyManagmentDetialsTableViewController
        vc1.BranchID = self.ProjectOfResult[0].BranchID!
        vc1.BranchName = self.ProjectOfResult[0].BranchName!
        vc1.ProjectsPaymentsCost = self.ProjectOfResult[0].ProjectsPaymentsCost!
        vc1.CountNotPaid = self.ProjectOfResult[0].CountNotPaid!
        vc1.CountPaid = self.ProjectOfResult[0].CountPaid!
        vc1.CustmoerName = self.ProjectOfResult[0].CustmoerName!
        vc1.CustomerEmail = self.ProjectOfResult[0].CustomerEmail!
        vc1.CustomerMobile = self.ProjectOfResult[0].CustomerMobile!
        vc1.CustomerNationalId = self.ProjectOfResult[0].CustomerNationalId!
        vc1.DataSake = self.ProjectOfResult[0].DataSake!
        vc1.DateLicence = self.ProjectOfResult[0].DateLicence!
        vc1.EmpImage = self.ProjectOfResult[0].EmpImage!
        if Reachability.isConnectedToNetwork(){
            print("Internet Connection Available!")
            vc1.EmpMobile = self.ProjectOfResult[0].EmpMobile!
            vc1.Status = self.ProjectOfResult[0].Status!
        }else {
            vc1.EmpMobile = self.EmpMobile
            vc1.Status = self.Status
        }
        vc1.EmpName = self.ProjectOfResult[0].EmpName!
        vc1.GroundId = self.ProjectOfResult[0].GroundId!
        vc1.IsDeleted = self.ProjectOfResult[0].IsDeleted!
        vc1.JobName = self.ProjectOfResult[0].JobName!
        vc1.LatBranch = self.ProjectOfResult[0].LatBranch
        vc1.LatPrj = self.ProjectOfResult[0].LatPrj!
        vc1.LicenceNum = self.ProjectOfResult[0].LicenceNum!
        vc1.LngBranch = self.ProjectOfResult[0].LngBranch
        vc1.LngPrj = self.ProjectOfResult[0].LngPrj!
        vc1.Notes = self.ProjectOfResult[0].Notes!
        vc1.PlanId = self.ProjectOfResult[0].PlanId!
        vc1.ProjectInvoice = self.ProjectOfResult[0].ProjectInvoice!
        vc1.ProjectContract = self.ProjectOfResult[0].ProjectContract!
        vc1.ProjectStatusNum = self.ProjectOfResult[0].ProjectStatusNum!
        vc1.ProjectBildTypeId = self.ProjectOfResult[0].ProjectBildTypeId!
        vc1.ProjectEngComment = self.ProjectOfResult[0].ProjectEngComment!
        vc1.ProjectId = self.ProjectOfResult[0].ProjectId!
        vc1.ProjectStatusColor = self.ProjectOfResult[0].ProjectStatusColor!
        vc1.ProjectStatusID = self.ProjectOfResult[0].ProjectStatusID!
        vc1.ProjectStatusName = self.ProjectOfResult[0].ProjectStatusName!
        vc1.ProjectTitle = self.ProjectOfResult[0].ProjectTitle!
        vc1.ProjectTypeId = self.ProjectOfResult[0].ProjectTypeId!
        vc1.ProjectTypeName = self.ProjectOfResult[0].ProjectTypeName!
        vc1.SakNum = self.ProjectOfResult[0].SakNum!
        vc1.Space = self.ProjectOfResult[0].Space!
        vc1.TotalNotPaid = self.ProjectOfResult[0].TotalNotPaid!
        vc1.TotalPaid = self.ProjectOfResult[0].TotalPaid!
        vc1.ZoomBranch = self.ProjectOfResult[0].ZoomBranch!
        vc1.ZoomPrj = self.ProjectOfResult[0].ZoomPrj!
        vc1.projectOrderContractPhotoPath = self.ProjectOfResult[0].projectOrderContractPhotoPath!
        vc1.ComapnyName = self.ProjectOfResult[0].ComapnyName!
        vc1.CompanyAddress = self.ProjectOfResult[0].CompanyAddress!
        vc1.Logo = self.ProjectOfResult[0].Logo!
        vc1.ProjectOfResult = ProjectOfResult
        self.navigationController?.pushViewController(vc1, animated: true)
    }
    
    @IBAction func goDesignsViewController(_ sender: UIButton) {
        let desCount = DesignCount
        print(DesignCount)
        if DesignCount == "" || DesignCount == "0" {
            Toast.long(message: "لا يوجد لك تصاميم حالياً")
        } else {
            let storyBoard : UIStoryboard = UIStoryboard(name: "NewHome", bundle:nil)
            let secondView = storyBoard.instantiateViewController(withIdentifier: "DesignsOfProjectViewController") as! DesignsOfProjectViewController
            secondView.ProjectId = self.ProjectOfResult[0].ProjectId!
            secondView.projectTitleView = "(\(self.ProjectOfResult[0].ProjectTitle!)"+" - "+"\(self.ProjectOfResult[0].ProjectTypeName!))"
            secondView.ComapnyName = self.ProjectOfResult[0].ComapnyName!
            secondView.Logo = self.ProjectOfResult[0].Logo!
            secondView.CompanyInfoID = self.ProjectOfResult[0].CompanyInfoID!
            if Reachability.isConnectedToNetwork(){
                print("Internet Connection Available!")
                secondView.EmpMobile = self.ProjectOfResult[0].EmpMobile!
            }else{
                secondView.EmpMobile = self.EmpMobile
            }
            secondView.EmpName = self.ProjectOfResult[0].EmpName!
            secondView.LatBranch = self.ProjectOfResult[0].LatBranch
            secondView.LngBranch = self.ProjectOfResult[0].LngBranch
            secondView.ProjectOfResult = ProjectOfResult
            self.navigationController?.pushViewController(secondView, animated: true)
        }
    }
    
    @IBAction func goVisitsViewController(_ sender: UIButton) {
        let meetingCount = MeetingCount
        print(MeetingCount)
        if MeetingCount == "" || MeetingCount == "0" {
            Toast.long(message: "لا يوجد زيارات لك حالياً")
        }else {
            let storyBoard : UIStoryboard = UIStoryboard(name: "NewHome", bundle:nil)
            let secondView = storyBoard.instantiateViewController(withIdentifier: "VisitsOfProjectsViewController") as! VisitsOfProjectsViewController
            secondView.ProjectId = self.ProjectOfResult[0].ProjectId!
            secondView.projectTitleView = "(\(self.ProjectOfResult[0].ProjectTitle!)"+" - "+"\(self.ProjectOfResult[0].ProjectTypeName!))"
            secondView.ComapnyName = self.ProjectOfResult[0].ComapnyName!
            secondView.Logo = self.ProjectOfResult[0].Logo!
            secondView.CompanyInfoID = self.ProjectOfResult[0].CompanyInfoID!
            if Reachability.isConnectedToNetwork(){
                print("Internet Connection Available!")
                secondView.EmpMobile = self.ProjectOfResult[0].EmpMobile!
            }else{
                secondView.EmpMobile = self.EmpMobile
            }
            secondView.EmpName = self.ProjectOfResult[0].EmpName!
            secondView.LatBranch = LatBranch
            secondView.LngBranch = LngBranch
            secondView.ProjectOfResult = ProjectOfResult
            self.navigationController?.pushViewController(secondView, animated: true)
        }
    }
    
    
    @IBAction func MyFilesBtn(_ sender: UIButton) {
           print(DocCount)
        if self.DocCount == "0" {
            Toast.long(message: "لايوجد وثائق للارض")
        }else {
            let storyBoard : UIStoryboard = UIStoryboard(name: "MyFilesAndMoney", bundle:nil)
            let secondView = storyBoard.instantiateViewController(withIdentifier: "ProjectFilesViewController") as! ProjectFilesViewController
            secondView.ProjectId = self.ProjectOfResult[0].ProjectId!
            secondView.projectTitleView = self.ProjectOfResult[0].ProjectTitle!
            if ProjectOfResult[0].SakNum == ""
            {
          secondView.Snumber = ProjectOfResult[0].ProjectId!
            }
            else
            {
                secondView.Snumber = ProjectOfResult[0].SakNum!
            }

            secondView.type = "1"
            secondView.ProjectFilesTitle = "وثائق الأرض"
            secondView.ComapnyName = self.ProjectOfResult[0].ComapnyName!
            secondView.Logo = self.ProjectOfResult[0].Logo!
            if Reachability.isConnectedToNetwork(){
                print("Internet Connection Available!")
                secondView.EmpMobile = self.ProjectOfResult[0].EmpMobile!
            }else{
                secondView.EmpMobile = self.EmpMobile
            }
            secondView.EmpName = self.ProjectOfResult[0].EmpName!
            secondView.LatBranch = LatBranch
            secondView.LngBranch = LngBranch
            self.navigationController?.pushViewController(secondView, animated: true)
        }
    }
    
    @IBAction func ProjectFilesBtn(_ sender: UIButton) {
      print(FileCount)
        if self.FileCount == "0" {
            Toast.long(message: "لايوجد ملفات للمشروع")
        }else {
            let storyBoard : UIStoryboard = UIStoryboard(name: "MyFilesAndMoney", bundle:nil)
            let secondView = storyBoard.instantiateViewController(withIdentifier: "ProjectFilesViewController") as! ProjectFilesViewController
            secondView.ProjectId = self.ProjectOfResult[0].ProjectId!
            secondView.projectTitleView = self.ProjectOfResult[0].ProjectTitle!
            
            secondView.type = "2"
            secondView.ProjectFilesTitle = "ملفات المشروع"
            secondView.ComapnyName = self.ProjectOfResult[0].ComapnyName!
            secondView.Logo = self.ProjectOfResult[0].Logo!
            if Reachability.isConnectedToNetwork(){
                print("Internet Connection Available!")
                secondView.EmpMobile = self.ProjectOfResult[0].EmpMobile!
            }else{
                secondView.EmpMobile = self.EmpMobile
            }
            secondView.EmpName = self.ProjectOfResult[0].EmpName!
            secondView.LatBranch = LatBranch
            secondView.LngBranch = LngBranch
            if ProjectOfResult[0].SakNum == ""
            {
                secondView.Snumber = ProjectOfResult[0].ProjectId!
            }
            else
            {
                secondView.Snumber = ProjectOfResult[0].SakNum!
            }
            self.navigationController?.pushViewController(secondView, animated: true)
        }
        
    }
    
    @IBAction func openChatBtn(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Chat", bundle: nil)
        let FirstViewController = storyboard.instantiateViewController(withIdentifier: "ChatOfProjectsViewController") as! ChatOfProjectsViewController
        FirstViewController.ProjectId = self.ProjectId
        self.navigationController?.pushViewController(FirstViewController, animated: true)
    }
    
    // func to Get Messages Count UnReaded
    func GetCountMessageUnReaded() {
        // call some api
        
        var parameters: Parameters = [:]
        if nou == "" && norma == "" {
            parameters = [
                "projectId": searchResu[index!].ProjectId
            ]
        }else if nou == "uu"{
            parameters = [
                "projectId": ProjectId
            ]
        }else{
            parameters = [
                "projectId": ProjectId
            ]
        }
        
        Alamofire.request("http://smusers.promit2030.co/api/ApiService/GetCountMessageUnReaded", method: .get, parameters: parameters, encoding: URLEncoding.default).responseJSON { response in
            debugPrint(response)
            let json = JSON(response.result.value!)
            let MessageCount = json["MessageCount"].stringValue
            if MessageCount == "" || MessageCount == "0" {
                self.messageCountLabel.isHidden = true
            }else {
                self.messageCountLabel.isHidden = false
                self.messageCountLabel.text = MessageCount
            }
            print(json)
        }
        
    }
    
    
    
    
    var NotiProjectCount = 0
    var NotiMessageCount = 0
    var NotiTotalCount = 0
    let applicationl = UIApplication.shared
    
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
        FirstViewController.mobilestr = searchResu[index!].EmpMobile
       
        FirstViewController.DesignStagesID = ProjectId
        
        self.navigationController?.pushViewController(FirstViewController, animated: true)
        
    }
    
    
    
}
