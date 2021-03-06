//
//  DesignsOfProjectViewController.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 12/31/17.
//  Copyright © 2017 Ahmed Wahdan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import MapKit

class DesignsOfProjectViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, DesignByProjectIdModelDelegate {
    
    var searchResu:[DesignByProjectIdArray] = [DesignByProjectIdArray]()
    
    let model: DesignByProjectIdModel = DesignByProjectIdModel()
    
    let designProjectIdModel = DesignProjectIdModel()
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var callBtnNumber: UIButton!
    
    @IBOutlet weak var callBtn: UIButton! {
        didSet {
            callBtn.layer.borderWidth = 1.0
            callBtn.layer.borderColor = #colorLiteral(red: 0.2, green: 0.5647058824, blue: 0.3882352941, alpha: 1)
            callBtn.layer.cornerRadius = 4.0
        }
    }
    
    @IBOutlet weak var chatbtn: UIButton!{
        didSet {
            chatbtn.layer.borderWidth = 1.0
            chatbtn.layer.borderColor = #colorLiteral(red: 0.2, green: 0.5647058824, blue: 0.3882352941, alpha: 1)
            chatbtn.layer.cornerRadius = 4.0
        }
    }
    
    @IBOutlet weak var btn_direction: UIButton!{
        didSet {
            btn_direction.layer.borderWidth = 1.0
            btn_direction.layer.borderColor = #colorLiteral(red: 0.2, green: 0.5647058824, blue: 0.3882352941, alpha: 1)
            btn_direction.layer.cornerRadius = 4.0
        }
    }
    @IBOutlet weak var lbl_chat: UILabel!{
        didSet {
            DispatchQueue.main.async {
                self.lbl_chat.layer.cornerRadius = self.lbl_chat.frame.width/2
                self.lbl_chat.layer.masksToBounds = true
            }
        }
    }
    
    @IBOutlet weak var companyImageOut: UIImageView!{
        didSet {
            DispatchQueue.main.async {
                self.companyImageOut.layer.cornerRadius = 14.0
            }
        }
    }
    @IBOutlet weak var statusName: UILabel!
    @IBOutlet weak var statusImage: UIImageView!
    @IBOutlet weak var SakNumber: UILabel!
    
    @IBOutlet weak var projectTitleLabel: UILabel!
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var statusNameBtn: UIButton!
    @IBOutlet weak var cancelStatusBtn: UIButton!
    
    var ProjectOfResult: [ProjectDetialsArray] = [ProjectDetialsArray]()
    var ProjectId: String = ""
    var projectTitleView: String = ""
    var ProjectFilesTitle: String = ""
    var ComapnyName: String = ""
    var EmpName = ""
    var EmpMobile = ""
    var Logo = ""
    var LatBranch: Double = 0.0
    var LngBranch: Double = 0.0
    var CompanyInfoID = ""
    var arrayOfResulr = [GetOfficesArray]()
    var indexi:Int = 0
    var isCompany = ""
    var StatusId = ""
    var MessageCount = ""
    
    @IBOutlet weak var NothingLabel: UILabel!
    @IBOutlet weak var AlertImage: UIImageView!
      var AlertController: UIAlertController!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cancelStatusBtn.isHidden = true
       
        DispatchQueue.main.async {
            self.NothingLabel.isHidden = true
            self.AlertImage.isHidden = true
        }
        tableView.delegate = self
        tableView.dataSource = self
        tableView.indicatorStyle = UIScrollViewIndicatorStyle.white;
        
        
        
        DispatchQueue.main.async {
            self.NothingLabel.isHidden = true
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
        
        if Reachability.isConnectedToNetwork(){
            
            GetCountMessageUnReaded()
            model.delegate = self
            model.GetDesignsByProjectID(view: self.view, projectId: ProjectId, type: "1", StatusId: "")
        }else{
            designProjectIdModel.loadItems()
            if designProjectIdModel.returnProjectDetials(at: ProjectId) != nil {
                let  designsDetials = designProjectIdModel.returnProjectDetials(at: ProjectId)
                self.searchResu = designsDetials!
                ComapnyNameFunc()
                
            }
            
            tableView.reloadData()
        }
        
        viewDidLoad()
    }
    
    func ComapnyNameFunc(){
        companyNameLabel.text = ProjectOfResult[0].ComapnyName!
        projectTitleLabel.text = ProjectOfResult[0].ProjectTitle
        if ProjectOfResult[0].SakNum != ""
        {
                SakNumber.text = ProjectOfResult[0].SakNum
        }else
        {
        SakNumber.text = ProjectOfResult[0].ProjectId
        }
//        addressLabel.text = ProjectOfResult[0].CompanyAddress
        
        if MessageCount == "" || MessageCount == "0" {
           lbl_chat.isHidden = true
        }else {
            lbl_chat.isHidden = false
           lbl_chat.text = MessageCount
        }
        if MessageCount == "" || MessageCount == "0" {
            lbl_chat.isHidden = true
        }else {
           lbl_chat.isHidden = false
            lbl_chat.text = MessageCount
        }
        
//        callBtnNumber.setTitle(ProjectOfResult[0].EmpMobile, for: .normal)
        let status = ProjectOfResult[0].ProjectStatusID!
        let statusName = ProjectOfResult[0].ProjectStatusName!
//        if status == "5"{
//            self.statusName.text = statusName
//            statusImage.backgroundColor = #colorLiteral(red: 0.9921568627, green: 0.4274509804, blue: 0.337254902, alpha: 1)
//        }else if status == "4"{
//            self.statusName.text = statusName
//            statusImage.backgroundColor = #colorLiteral(red: 0.1176470588, green: 0.368627451, blue: 0.4666666667, alpha: 1)
//        }else if status == "3"{
//            self.statusName.text = statusName
//            statusImage.backgroundColor = #colorLiteral(red: 0.1764705882, green: 0.4745098039, blue: 0.8862745098, alpha: 1)
//        }else if status == "1"{
//            self.statusName.text = statusName
//            statusImage.backgroundColor = #colorLiteral(red: 0.831372549, green: 0.6862745098, blue: 0.2117647059, alpha: 1)
//        }else if status == "2"{
//            self.statusName.text = statusName
//            statusImage.backgroundColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
//        }else if status == "6"{
//            self.statusName.text = statusName
//            statusImage.backgroundColor = #colorLiteral(red: 0.2588235294, green: 0.8666666667, blue: 0.1764705882, alpha: 1)
//        }else if status == "7"{
//            self.statusName.text = statusName
//            statusImage.backgroundColor = #colorLiteral(red: 0.2, green: 0.5647058824, blue: 0.3882352941, alpha: 1)
//        }else {
//            print("error status \(status)")
//        }
//        let img = searchResu[0].Logo!
//        print(img)
//        let trimmedString = img.trimmingCharacters(in: .whitespaces)
//        if let url = URL.init(string: trimmedString) {
//            companyImageOut.hnk_setImageFromURL(url, placeholder: #imageLiteral(resourceName: "officePlaceholder"))
//        } else{
//            print("nil")
//            companyImageOut.image = #imageLiteral(resourceName: "officePlaceholder")
//        }
    }
    
    
    func dataReady() {
        // Access the video objects that have been downloaded
        self.searchResu = self.model.resultArray
        self.designProjectIdModel.append(self.model.resultArray, index: ProjectId)
        // Tell the tableview to reload
        ComapnyNameFunc()
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
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
        return 205
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
        
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "DesignsAndDetails", bundle:nil)
        let cont = storyBoard.instantiateViewController(withIdentifier: "DetailsDesignTableViewController") as! DetailsDesignTableViewController
      
        cont.CreateDate = searchResu[indexPath.row].CreateDate!
        cont.DesignFile = searchResu[indexPath.section].DesignFile!
        designStagesID = searchResu[indexPath.section].DesignStagesID!
        cont.Details = searchResu[indexPath.section].Details!
        cont.EmpName = searchResu[indexPath.section].EmpName!
        cont.mobileStr = searchResu[indexPath.section].Mobile!
        cont.ProjectBildTypeName = searchResu[indexPath.section].ProjectBildTypeName!
        cont.ProjectStatusID = searchResu[indexPath.section].ProjectStatusID!
        cont.SakNum = searchResu[indexPath.section].SakNum!
        cont.StagesDetailsName = searchResu[indexPath.section].StagesDetailsName!
        cont.Status = searchResu[indexPath.section].Status!
        cont.ClientReply = searchResu[indexPath.section].ClientReply!
        cont.EmpReply = searchResu[indexPath.section].EmpReply!
        cont.ComapnyName = searchResu[indexPath.section].ComapnyName!
        cont.Logo = searchResu[indexPath.section].Logo!
        cont.Address = searchResu[indexPath.section].Address!
          self.navigationController?.pushViewController(cont, animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if searchResu.count == 0 {
            NothingLabel.isHidden = false
            AlertImage.isHidden = false
        } else {
            NothingLabel.isHidden = true
            AlertImage.isHidden = true
        }
        return searchResu.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DesignsOfProjectTableViewCell", for: indexPath) as! DesignsOfProjectTableViewCell
        
        cell.CreateDate.text = searchResu[indexPath.section].CreateDate
        cell.StagesDetailsName.text = searchResu[indexPath.section].StagesDetailsName
        if searchResu[indexPath.section].Details == "" {
            cell.lbl_Det.isHidden = true
               cell.lbl_descTitle.isHidden = true
        }else {
            cell.lbl_Det.isHidden = false
            cell.lbl_descTitle.isHidden = false
            cell.lbl_Det.text = searchResu[indexPath.section].Details
        }
        let status = searchResu[indexPath.section].Status
        if searchResu[indexPath.section].DesignFile == "" {
            cell.BtnOutlet.isHidden = true
        }
        cell.nameOfStatus.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        if status == "1"{
            cell.Status.backgroundColor = #colorLiteral(red: 0.8279563785, green: 0.3280953765, blue: 0, alpha: 1)
            cell.nameOfStatus.text = "انتظار الموافقة"
            cell.BtnOutlet.isHidden = false
            if searchResu[indexPath.section].DesignFile == "" {
                cell.BtnOutlet.isHidden = true
            }
        }else if status == "2"{
            cell.Status.backgroundColor = #colorLiteral(red: 0.1521916687, green: 0.6835762858, blue: 0.376893878, alpha: 1)
            cell.nameOfStatus.text = "موافقة"
            cell.BtnOutlet.isHidden = false
            if searchResu[indexPath.section].DesignFile == "" {
                cell.BtnOutlet.isHidden = true
            }
        }else if status == "3"{
            cell.Status.backgroundColor = #colorLiteral(red: 0.7531306148, green: 0.2227272987, blue: 0.1705473661, alpha: 1)
            cell.nameOfStatus.text = "طلب التعديل"
            cell.BtnOutlet.isHidden = false
            if searchResu[indexPath.section].DesignFile == "" {
                cell.BtnOutlet.isHidden = true
            }
        }else if status == "5"{
            cell.Status.backgroundColor =  #colorLiteral(red: 0.831372549, green: 0.6862745098, blue: 0.2117647059, alpha: 1)
            cell.nameOfStatus.text = "جاري العمل"
            cell.BtnOutlet.isHidden = true
            if searchResu[indexPath.section].DesignFile == "" {
                cell.BtnOutlet.isHidden = true
            }
        }else {
            print("error status")
            if searchResu[indexPath.section].DesignFile == "" {
                cell.BtnOutlet.isHidden = true
            }
        }
        let EmpName = searchResu[indexPath.section].EmpName
        cell.EmpMobile.setTitle(EmpName, for: .normal)
       
        DispatchQueue.main.async {
            cell.Status.roundCorners(.bottomRight, radius: 10.0)
            cell.roundCorners([.bottomLeft,.bottomRight,.topRight], radius: 10)
        }
        
        cell.empcal.setTitle(searchResu[indexPath.section].Mobile, for: .normal)
        return cell
    }
    
    
    
    @IBAction func goOfficeDetials(_ sender: UIButton) {
        GetOfficesByProvincesID()
    }
    
    func GetOfficesByProvincesID(){
        let sv = UIViewController.displaySpinner(onView: self.view)
     
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
    
    
    @IBAction func openPdf(_ sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: tableView)
        let index = tableView.indexPathForRow(at: point)?.section
        let openPdf = searchResu[index!].DesignFile
        let storyBoard : UIStoryboard = UIStoryboard(name: "DesignsAndDetails", bundle:nil)
        let secondView = storyBoard.instantiateViewController(withIdentifier: "openPdfViewController") as! openPdfViewController
        if searchResu[index!].Status == "1" {
            secondView.condBottomButtons = "AcceptAndEdit"
            secondView.reloadApi = self as! AccepEditDesgin
        }else if searchResu[index!].Status == "3" {
            secondView.condBottomButtons = "Edit"
            secondView.reloadApi = self as! AccepEditDesgin
        }else {
            print("error status")
        }
        self.navigationController?.pushViewController(secondView, animated: true)
        secondView.url = openPdf!
        
        //        if let url = URL(string: openPdf) {
        //            UIApplication.shared.open(url)
        //        }
        tableView.reloadData()
        
    }
    
    
    
    @IBAction func designCancel(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "DesignsAndDetails", bundle: nil)
        let secondView = storyBoard.instantiateViewController(withIdentifier: "AlertDesignCancelViewController") as! AlertDesignCancelViewController
        let index = tableView.indexPathForSelectedRow?.section
        designStagesID = searchResu[index!].DesignStagesID!
        secondView.modalPresentationStyle = .custom
        self.present(secondView, animated: true)
    }
    
    @IBAction func designOk(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "DesignsAndDetails", bundle: nil)
        let secondView = storyBoard.instantiateViewController(withIdentifier: "AlertDesignOkViewController") as! AlertDesignOkViewController
        let index = tableView.indexPathForSelectedRow?.section
        designStagesID = searchResu[index!].DesignStagesID!
        print("des: \(designStagesID)")
        secondView.modalPresentationStyle = .custom
        self.present(secondView, animated: true)
    }
    @IBAction func openChatBtn(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Chat", bundle: nil)
        let FirstViewController = storyboard.instantiateViewController(withIdentifier: "ChatOfProjectsViewController") as! ChatOfProjectsViewController
        FirstViewController.ProjectId = ProjectId
        self.navigationController?.pushViewController(FirstViewController, animated: true)
    }
    
    // func to Get Messages Count UnReaded
    func GetCountMessageUnReaded() {
        // call some api
        
        let parameters: Parameters = ["projectId": ProjectId]
        
        Alamofire.request("http://smusers.promit2030.co/api/ApiService/GetCountMessageUnReaded", method: .get, parameters: parameters, encoding: URLEncoding.default).responseJSON { response in
            debugPrint(response)
            let json = JSON(response.result.value!)
            self.MessageCount = json["MessageCount"].stringValue
            print(json)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDeti" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let cont = segue.destination as! DesignDetailsTableViewController
                cont.CreateDate = searchResu[indexPath.section].CreateDate!
                cont.DesignFile = searchResu[indexPath.section].DesignFile!
                cont.DesignStagesID = searchResu[indexPath.section].DesignStagesID!
                cont.Details = searchResu[indexPath.section].Details!
                cont.EmpName = searchResu[indexPath.section].EmpName!
                cont.mobileStr = searchResu[indexPath.section].Mobile!
                cont.ProjectBildTypeName = searchResu[indexPath.section].ProjectBildTypeName!
                cont.ProjectStatusID = searchResu[indexPath.section].ProjectStatusID!
                cont.SakNum = searchResu[indexPath.section].SakNum!
                cont.StagesDetailsName = searchResu[indexPath.section].StagesDetailsName!
                cont.Status = searchResu[indexPath.section].Status!
                cont.ClientReply = searchResu[indexPath.section].ClientReply!
                cont.EmpReply = searchResu[indexPath.section].EmpReply!
                cont.ComapnyName = searchResu[indexPath.section].ComapnyName!
                cont.Logo = searchResu[indexPath.section].Logo!
                cont.Address = searchResu[indexPath.section].Address!
                cont.LatBranch = LatBranch
                cont.LngBranch = LngBranch
                cont.CompanyInfoID = CompanyInfoID
                cont.ProjectId = ProjectId
            }
        }
    }
   
    @IBAction func directionBtn(_ sender: UIButton) {
        let location = CLLocation(latitude: LatBranch, longitude: LngBranch)
        
        let dLati =  LatBranch
        let dLang = LngBranch
        
        
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
//        self.present(AlertController, animated: true, completion: nil)
        if Helper.isDeviceiPad() {
            
            if let popoverController = AlertController.popoverPresentationController {
                popoverController.sourceView = sender
            }
        }
        
        self.present(AlertController, animated: true, completion: nil)
    }
    func openMapsForLocation() {
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
    @IBAction func CallMe(_ sender: UIButton) {
        
        let mobileNum = searchResu[0].Mobile!
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
    
    @IBAction func openDesignDetials(_ sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: tableView)
        let index = tableView.indexPathForRow(at: point)?.section
        
        
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "DesignsAndDetails", bundle:nil)
        let cont = storyBoard.instantiateViewController(withIdentifier: "DetailsDesignTableViewController") as! DetailsDesignTableViewController
        
        cont.CreateDate = searchResu[index!].CreateDate!
        cont.DesignFile = searchResu[index!].DesignFile!
        designStagesID = searchResu[index!].DesignStagesID!
        cont.Details = searchResu[index!].Details!
        cont.EmpName = searchResu[index!].EmpName!
        cont.mobileStr = searchResu[index!].Mobile!
        cont.ProjectBildTypeName = searchResu[index!].ProjectBildTypeName!
        cont.ProjectStatusID = searchResu[index!].ProjectStatusID!
        cont.SakNum = searchResu[index!].SakNum!
        cont.StagesDetailsName = searchResu[index!].StagesDetailsName!
        cont.Status = searchResu[index!].Status!
        cont.ClientReply = searchResu[index!].ClientReply!
        cont.EmpReply = searchResu[index!].EmpReply!
        cont.ComapnyName = searchResu[index!].ComapnyName!
        cont.Logo = searchResu[index!].Logo!
        cont.Address = searchResu[index!].Address!
        self.navigationController?.pushViewController(cont, animated: true)

        
       
    }
    
    
    @IBAction func CallEng(_ sender: UIButton) {
        let mobileNum = ProjectOfResult[0].EmpMobile
        var mobile: String = (mobileNum)!
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
    
    @IBAction func filtetByStatusName(_ sender: UIButton) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "DesignsAndDetails", bundle: nil)
        let dvc = storyBoard.instantiateViewController(withIdentifier: "DesignStatusFilterTableViewController") as! DesignStatusFilterTableViewController
        dvc.filterDesignsDelegate = self
        dvc.type = "3"
        dvc.statusId = StatusId
        dvc.modalPresentationStyle = .popover
        dvc.popoverPresentationController?.sourceView = sender
        dvc.popoverPresentationController?.sourceRect = CGRect(x: sender.frame.maxX, y: sender.frame.maxY, width: 0, height: 0)
        dvc.popoverPresentationController?.delegate = self
        dvc.preferredContentSize = CGSize(width: 200, height: 200)
        dvc.popoverPresentationController?.permittedArrowDirections = [.up]
        self.present(dvc, animated: true, completion: nil)
    }
    
    @IBAction func cancelFilterStatus(_ sender: UIButton) {
        cancelStatusBtn.isHidden = true
        StatusId = ""
        statusNameBtn.setTitle("تصفية بحالة التصميم", for: .normal)
        model.GetDesignsByProjectID(view: self.view, projectId: ProjectId, type: "1", StatusId: "")
    }
}
extension DesignsOfProjectViewController: FilterDesignsDelegate, reloadApi ,AccepEditDesgin{
    func refresh() {
         viewDidLoad()
    }
    
    func filterDesignsByStatusId(StatusId: String, StatusName: String) {
        model.GetDesignsByProjectID(view: self.view, projectId: ProjectId, type: "2", StatusId: StatusId)
        self.StatusId = StatusId
        statusNameBtn.setTitle(StatusName, for: .normal)
        cancelStatusBtn.isHidden = false
    }
    func reload() {
        viewDidLoad()
    }
}
extension DesignsOfProjectViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}
