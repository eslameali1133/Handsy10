//
//  NewMyProjectsViewController.swift
//  Handsy
//  Created by Ahmed Wahdan on 12/27/17.
//  Copyright © 2017 Ahmed Wahdan. All rights reserved.


import UIKit
import MapKit
import Alamofire
import SwiftyJSON
import UserNotifications
var checkEmpty = 0
var trypNotification = ""
var ProIDGloable = ""
var Filegl = ""
var comingnotification = false
var messageByProjectIdObjgl = MessageByProjectId()

class NewMyProjectsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, RequestProjectModelDelegate {
    
    @IBOutlet var navViewOut: UIView!
    @IBOutlet weak var callBtn: UIButton!{
        didSet {
            callBtn.layer.borderWidth = 1.0
            callBtn.layer.borderColor = #colorLiteral(red: 0.2, green: 0.5647058824, blue: 0.3882352941, alpha: 1)
            callBtn.layer.cornerRadius = 4.0
        }
    }
    
    @IBOutlet weak var titleVCLabel: UILabel!
    @IBOutlet weak var archiveBtn: UIButton!{
        didSet {
            archiveBtn.layer.borderWidth = 1.0
            archiveBtn.layer.borderColor = #colorLiteral(red: 0.2, green: 0.5647058824, blue: 0.3882352941, alpha: 1)
            archiveBtn.layer.cornerRadius = 4.0
        }
    }
    @IBOutlet weak var messageNotfiCount: UILabel!{
        didSet {
            DispatchQueue.main.async {
                self.messageNotfiCount.layer.cornerRadius = self.messageNotfiCount.frame.width/2
                self.messageNotfiCount.layer.masksToBounds = true
            }
        }
    }
    
    
    @IBOutlet weak var MyProjectsTableView: UITableView!
    var myProjects:[GetProjectEngCustByCustID] = [GetProjectEngCustByCustID]()
    
    let model: RequestProjectModel = RequestProjectModel()
    let projectModel : projectsModel = projectsModel()
    
    @IBOutlet weak var NothingLabel: UILabel!
    @IBOutlet weak var AlertImage: UIImageView!
    let applicationl = UIApplication.shared
    var qustion = 0
    var LatBranch: Double = 0.0
    var LngBranch: Double = 0.0
    
    var NotiProjectCount = 0
    var NotiMessageCount = 0
    var NotiTotalCount = 0
  
      var AlertController: UIAlertController!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if comingnotification == true
        {
            comingnotification = false
            
            if trypNotification == "1" {
                let ProjectId = ProIDGloable
                let storyBoard : UIStoryboard = UIStoryboard(name: "NewHome", bundle: nil)
                let secondView = storyBoard.instantiateViewController(withIdentifier: "NewProjectDetialsFilterTableViewController") as! NewProjectDetialsFilterTableViewController
                secondView.ProjectId = ProjectId
                secondView.comafterlogin = true
                secondView.nou = "LOl"
                 self.navigationController?.pushViewController(secondView, animated: true)
            }else if trypNotification == "2" {
            
                let storyBoard1 : UIStoryboard = UIStoryboard(name: "VisitsAndDetails", bundle: nil)
                let secondView = storyBoard1.instantiateViewController(withIdentifier: "VisitsDetialsTableViewController") as! VisitsDetialsTableViewController
                self.navigationController?.pushViewController(secondView, animated: true)
                
            }else if trypNotification == "3" {
                let ProjectId = ProIDGloable
                let storyBoard : UIStoryboard = UIStoryboard(name: "NewHome", bundle: nil)
                let secondView = storyBoard.instantiateViewController(withIdentifier: "NewProjectDetialsFilterTableViewController") as! NewProjectDetialsFilterTableViewController
                secondView.ProjectId = ProjectId
                secondView.nou = "LOl"
                 secondView.comafterlogin = true
              
                  self.navigationController?.pushViewController(secondView, animated: true)
                
            }else if trypNotification == "4" {
                let ProjectId = ProIDGloable
                let storyBoard : UIStoryboard = UIStoryboard(name: "ProjectsAndEdit", bundle:nil)
                let secondView = storyBoard.instantiateViewController(withIdentifier: "MoneyManagmentDetialsTableViewController") as! MoneyManagmentDetialsTableViewController
                secondView.ProjectId = ProjectId
                secondView.pushCond = "LOl"
                self.navigationController?.pushViewController(secondView, animated: true)
            }else if trypNotification == "5" {
                let storyBoard : UIStoryboard = UIStoryboard(name: "DesignsAndDetails", bundle: nil)
                let secondView = storyBoard.instantiateViewController(withIdentifier: "DetailsDesignTableViewController") as! DetailsDesignTableViewController
                   self.navigationController?.pushViewController(secondView, animated: true)
                
            }else if trypNotification == "7" {
                let storyBoard : UIStoryboard = UIStoryboard(name: "DesignsAndDetails", bundle: nil)
                let secondView = storyBoard.instantiateViewController(withIdentifier: "DetailsDesignTableViewController") as! DetailsDesignTableViewController
                 self.navigationController?.pushViewController(secondView, animated: true)
            }else if trypNotification == "8" {
                let storyBoard : UIStoryboard = UIStoryboard(name: "ProjectsAndEdit", bundle:nil)
                let secondView = storyBoard.instantiateViewController(withIdentifier: "ShowContractViewController") as! ShowContractViewController
                secondView.url = Filegl
                secondView.ProjectId = ProIDGloable
                 self.navigationController?.pushViewController(secondView, animated: true)
            }
            else if trypNotification == "10" {
                  let ProjectId = ProIDGloable
                // move to Rate Page
                let storyBoard : UIStoryboard = UIStoryboard(name: "NewHome", bundle:nil)
                let sub = storyBoard.instantiateViewController(withIdentifier: "RateVC") as! RateVC
                sub.comfromNotification = true
                sub.ProjectID = ProjectId
                
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.window?.rootViewController = sub
            }
                
            else if trypNotification == "9" {
                let ProjectId = ProIDGloable
                ReadAllMessageForCust(ProjectId: ProjectId)
               
                    let storyboard = UIStoryboard(name: "Chat", bundle: nil)
                    let FirstViewController = storyboard.instantiateViewController(withIdentifier: "ChatOfProjectsViewController") as! ChatOfProjectsViewController
                    FirstViewController.ProjectId = ProjectId
                self.navigationController?.pushViewController(FirstViewController, animated: true)
                }
            
        else {
                print("type: \(trypNotification)")
            }
            
            
        }
            
           
        
//
        messageNotfiCount.isHidden = true
        titleVCLabel.text = "مشاريعي"
        DispatchQueue.main.async {
            self.navViewOut.frame = CGRect.init(x: 0, y: 0, width: self.view.frame.width, height: 32)
            self.navViewOut.widthAnchor.constraint(equalToConstant: self.view.frame.width-20).isActive = true
            self.navigationItem.titleView = self.navViewOut
        }
        if qustion == 0 {
            qustion = 1
            GetMobileUpdate()
        }else {
            print("No New Update in store")
        }
        NothingLabel.text = "لا يوجد مشاريع حاليه ! \n إضغط مشروع جديد"
        DispatchQueue.main.async {
            self.NothingLabel.isHidden = true
            self.AlertImage.isHidden = true
        }
        self.navigationItem.hidesBackButton = true
        MyProjectsTableView.delegate = self
        MyProjectsTableView.dataSource = self
        model.delegate = self
        setBadge()
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

    
    
    @IBAction func callBtnAction(_ sender: UIButton) {
        callButtonPressed() 
    }
    
    @IBAction func homeChatAction(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Chat", bundle: nil)
        let secondView = storyBoard.instantiateViewController(withIdentifier: "HomeChatOfProjectsViewController") as! HomeChatOfProjectsViewController
        self.navigationController?.pushViewController(secondView, animated: true)
    }
    
    func addArchiveBarButtonItem() {
        let archiveButton = UIButton(type: .system)
        archiveButton.layer.borderWidth = 1.0
        archiveButton.layer.borderColor = #colorLiteral(red: 0.2, green: 0.5647058824, blue: 0.3882352941, alpha: 1)
        archiveButton.layer.cornerRadius = 4.0
        archiveButton.frame = CGRect.init(x: 0, y: 0, width: 104, height: 30)
        archiveButton.setTitle("تحدث معنا", for: .normal)
        archiveButton.titleEdgeInsets.left = 5
        archiveButton.titleEdgeInsets.right = -5
        archiveButton.setImage(UIImage(named: "proMessage"), for: .normal)
        archiveButton.addTarget(self, action: #selector(archiveButtonPressed), for: .touchUpInside)
        archiveButton.sizeToFit()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: archiveButton)
    }
    
    @objc func archiveButtonPressed() {
        
    }
    
    func addCallBarButtonItem() {
        let callButton = UIButton(type: .system)
        callButton.layer.borderWidth = 1.0
        callButton.layer.borderColor = #colorLiteral(red: 0.2, green: 0.5647058824, blue: 0.3882352941, alpha: 1)
        callButton.layer.cornerRadius = 4.0
        callButton.frame = CGRect.init(x: 0, y: 0, width: 104, height: 30)
        callButton.setTitle("اتصل بنا", for: .normal)
        callButton.setImage(UIImage(named: "call"), for: .normal)
        callButton.addTarget(self, action: #selector(callButtonPressed), for: .touchUpInside)
        callButton.sizeToFit()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: callButton)
    }
    
    @objc func callButtonPressed() {
        let storyBoard : UIStoryboard = UIStoryboard(name: "NewHome", bundle: nil)
        let secondView = storyBoard.instantiateViewController(withIdentifier: "ContactUSViewController") as! ContactUSViewController
        self.navigationController?.pushViewController(secondView, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        GetEmptByMobileNum()
       
    }
    

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func HideFunc() {
        let storyBoard : UIStoryboard = UIStoryboard(name: "NewHome", bundle: nil)
        let secondView = storyBoard.instantiateViewController(withIdentifier: "NewProjectAlertViewController") as! NewProjectAlertViewController
        secondView.modalPresentationStyle = .custom
        self.present(secondView, animated: false)

    }
    
    func GetMobileUpdate() {
        let parameters : Parameters = [
            "TypeID": "2"
        ]
        Alamofire.request("http://smusers.promit2030.co/Service1.svc/GetMobileUpdate", method: .get, parameters: parameters, encoding: URLEncoding.default).responseJSON { response in
            debugPrint(response)
            switch response.result {
            case .success:
                let json = JSON(response.result.value!).string
                print(json)
                if json == "True" {
                    self.popUpUpdateAlert()
                } else {
                    
                }
            case .failure(let error):
                print(error)
                let alertAction = UIAlertController(title: "خطاء في الاتصال", message: "اعادة المحاولة", preferredStyle: .alert)
                
                alertAction.addAction(UIAlertAction(title: "نعم", style: .default, handler: { action in
                    self.GetMobileUpdate()
                }))
                
                alertAction.addAction(UIAlertAction(title: "رجوع", style: .cancel, handler: { action in
                    self.navigationController!.popViewController(animated: true)
                }))
                
                self.present(alertAction, animated: true, completion: nil)
            
            }
        }
        
    }
    
    func popUpUpdateAlert() {
        let storyBoard : UIStoryboard = UIStoryboard(name: "NewHome", bundle: nil)
        let secondView = storyBoard.instantiateViewController(withIdentifier: "UpdateAlertViewViewController") as! UpdateAlertViewViewController
        secondView.modalPresentationStyle = .custom
        self.present(secondView, animated: false)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myProjects.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 260
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = MyProjectsTableView.dequeueReusableCell(withIdentifier: "SectionMyProjectTableViewCell") as! SectionMyProjectTableViewCell
        DispatchQueue.main.async {
            cell.backgroundCellView.roundCorners([.topLeft, .topRight], radius: 5)
        }
        return cell
    }
    //    change cell text color and background color

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MyProjectsTableView.dequeueReusableCell(withIdentifier: "NewMyProjectsTableViewCell", for: indexPath) as! NewMyProjectsTableViewCell
        let iscompany = myProjects[indexPath.row].IsCompany
        
        let projectTitle = "\(myProjects[indexPath.row].ProjectTitle)"
        cell.projectTitleLabel.text = projectTitle
        print( myProjects[indexPath.row].DateRegister)
        cell.DateRegisterLabel.text = myProjects[indexPath.row].DateRegister
        cell.companyNameLabel.text = myProjects[indexPath.row].ComapnyName
        cell.EngNameLabel.text = myProjects[indexPath.row].EmpName
        
        print(myProjects[indexPath.row].SakNum)
        if myProjects[indexPath.row].SakNum == ""
        {
         cell.SakNumber.text = myProjects[indexPath.row].ProjectId
        }
        else
        {
        cell.SakNumber.text = myProjects[indexPath.row].SakNum
        }
        
        let emplImage = myProjects[indexPath.row].Logo
        let trimmedString = emplImage.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        print("url: \(trimmedString)")
        if let url = URL.init(string: trimmedString!) {
            print(url)
            cell.EmpImageOut.hnk_setImageFromURL(url, placeholder: #imageLiteral(resourceName: "custlogo"))
        } else{
            print("nil")
            cell.EmpImageOut.image = #imageLiteral(resourceName: "custlogo")
        }
        let status = myProjects[indexPath.row].ProjectStatusID
        let statusName = myProjects[indexPath.row].ProjectStatusName        
        if status == "5"{
            cell.StatusNameLabel.text = statusName
            cell.statusview.backgroundColor =  HelperMethod.hexStringToUIColor(hex: myProjects[indexPath.row].ProjectStatusColor)
            cell.StatusRightView.backgroundColor = HelperMethod.hexStringToUIColor(hex: myProjects[indexPath.row].ProjectStatusColor)
        }else if status == "4"{
            cell.StatusNameLabel.text = statusName
        
            cell.statusview.backgroundColor = HelperMethod.hexStringToUIColor(hex: myProjects[indexPath.row].ProjectStatusColor)
           
              cell.StatusRightView.backgroundColor = HelperMethod.hexStringToUIColor(hex: myProjects[indexPath.row].ProjectStatusColor)
        }else if status == "3"{
            cell.StatusNameLabel.text = statusName
            cell.statusview.backgroundColor = HelperMethod.hexStringToUIColor(hex: myProjects[indexPath.row].ProjectStatusColor)
            cell.StatusRightView.backgroundColor = HelperMethod.hexStringToUIColor(hex: myProjects[indexPath.row].ProjectStatusColor)
        }else if status == "1"{
            cell.StatusNameLabel.text = statusName
            cell.statusview.backgroundColor = HelperMethod.hexStringToUIColor(hex: myProjects[indexPath.row].ProjectStatusColor)
       
            
            cell.StatusRightView.backgroundColor = HelperMethod.hexStringToUIColor(hex: myProjects[indexPath.row].ProjectStatusColor)
        }else if status == "2"{
            cell.StatusNameLabel.text = statusName
            cell.statusview.backgroundColor = HelperMethod.hexStringToUIColor(hex: myProjects[indexPath.row].ProjectStatusColor)
             cell.StatusRightView.backgroundColor = HelperMethod.hexStringToUIColor(hex: myProjects[indexPath.row].ProjectStatusColor)
        }else if status == "6"{
            cell.StatusNameLabel.text = statusName
            cell.statusview.backgroundColor = HelperMethod.hexStringToUIColor(hex: myProjects[indexPath.row].ProjectStatusColor)
            cell.StatusRightView.backgroundColor = HelperMethod.hexStringToUIColor(hex: myProjects[indexPath.row].ProjectStatusColor)
        }else if status == "7"{
            cell.StatusNameLabel.text = statusName
            cell.statusview.backgroundColor = HelperMethod.hexStringToUIColor(hex: myProjects[indexPath.row].ProjectStatusColor)
               cell.StatusRightView.backgroundColor = HelperMethod.hexStringToUIColor(hex: myProjects[indexPath.row].ProjectStatusColor)
        }else {
            print("error status \(status)")
        }
        let first2Words = myProjects[indexPath.row].ProjectLastComment?.firstWords(3)
        cell.lastStatusLabel.text = myProjects[indexPath.row].ProjectLastComment
//        "\(first2Words![0]) \(first2Words![1]) \(first2Words![2])"
        let NotLabel = myProjects[indexPath.row].NotifiCount
        
        if NotLabel != 0 {
            cell.notficationAlertBtnOut.isHidden = false
            cell.notficationCountLabel.isHidden = false
            cell.notficationCountLabel.text = "\(NotLabel)"
        } else {
            cell.notficationAlertBtnOut.isHidden = false
            cell.notficationCountLabel.isHidden = true
        }
        let MessageCount = myProjects[indexPath.row].MessageCount
        if MessageCount == "" || MessageCount == "0" {
            cell.messageCountLabel.isHidden = true
        }else {
            print(MessageCount)
            cell.messageCountLabel.isHidden = false
            cell.messageCountLabel.text = MessageCount
        }

        
        cell.backgroundCellView.layer.cornerRadius = 4.0
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "NewHome", bundle:nil)
        let sub = storyBoard.instantiateViewController(withIdentifier: "NewProjectDetialsFilterTableViewController") as! NewProjectDetialsFilterTableViewController
        sub.searchResu = self.myProjects
        sub.index = indexPath.row
        self.navigationController?.pushViewController(sub, animated: true)
    }
    
    func dataReady() {
        // Access the video objects that have been downloaded
        self.myProjects = self.model.resultArray
        projectModel.removeAllItems()
        for i in self.model.resultArray {
            self.projectModel.append(i)
        }
        if self.model.resultArray.count == 0 {
            if checkEmpty != 0 {
                
            }else {
                print("che: \(checkEmpty)")
                checkEmpty = 1
                UserDefaults.standard.set(String(checkEmpty), forKey: "checkEmpty")
                //                HideFunc()
                let storyboard = UIStoryboard(name: "NewHome", bundle: nil)
                let NavController = storyboard.instantiateViewController(withIdentifier: "NewMain") as! NewTabBarViewController
                NavController.selectedIndex = 2
                
                self.present(NavController, animated: false, completion: nil)
            }
            NothingLabel.isHidden = false
            AlertImage.isHidden = false
            MyProjectsTableView.isHidden = true
        } else {
            MyProjectsTableView.isHidden = false
            NothingLabel.isHidden = true
            AlertImage.isHidden = true
        }
        setBadge()
        // Tell the tableview to reload
        self.MyProjectsTableView.reloadData()
    }
    
    
    
    func setBadge() {
        var AllNot = 0
        for item in myProjects {
            AllNot += item.NotifiCount
        }
        if AllNot != 0 {
            let second = tabBarController?.tabBar
            second?.items![1].badgeValue = "\(AllNot)"
            second?.items![1].badgeColor = #colorLiteral(red: 0.3058823529, green: 0.5058823529, blue: 0.5333333333, alpha: 1)
        } else {
            let second = tabBarController?.tabBar
            second?.items![1].badgeValue = ""
            second?.items![1].badgeColor = UIColor.clear
        }
    }
    
    @IBAction func goToNotfication(_ sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: MyProjectsTableView)
        let index = MyProjectsTableView.indexPathForRow(at: point)?.row
        let storyBoard : UIStoryboard = UIStoryboard(name: "NewHome", bundle:nil)
        let secondView = storyBoard.instantiateViewController(withIdentifier: "MyProjectNotficationViewController") as! MyProjectNotficationViewController
        secondView.projectId = myProjects[index!].ProjectId
        secondView.projectTitle = myProjects[index!].ProjectTitle
        secondView.companyName = myProjects[index!].ComapnyName
        secondView.companyPhone = myProjects[index!].EmpMobile
        secondView.companyLogo = myProjects[index!].Logo
        print(myProjects[index!].EmpName)
        secondView.Empname = myProjects[index!].EmpName
         secondView.SakeNammer = myProjects[index!].SakNum
        
        self.navigationController?.pushViewController(secondView, animated: true)
    }
    
    @IBAction func openChatBtn(_ sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: MyProjectsTableView)
        let index = MyProjectsTableView.indexPathForRow(at: point)?.row
        let message = myProjects[index!]
        let storyboard = UIStoryboard(name: "Chat", bundle: nil)
        let FirstViewController = storyboard.instantiateViewController(withIdentifier: "ChatOfProjectsViewController") as! ChatOfProjectsViewController
        FirstViewController.ProjectId = message.ProjectId
        self.navigationController?.pushViewController(FirstViewController, animated: true)
    }
    
    @IBAction func DetialsBtnAction(_ sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: MyProjectsTableView)
        let index = MyProjectsTableView.indexPathForRow(at: point)?.row
        let storyBoard : UIStoryboard = UIStoryboard(name: "NewProject", bundle:nil)
        let secondView = storyBoard.instantiateViewController(withIdentifier: "DetailsOfOfficeTableViewController") as! DetailsOfOfficeTableViewController
        if myProjects[index!].IsCompany == "true" {
            secondView.isCompany = "1"
        } else {
            secondView.isCompany = "0"
        }
        secondView.CompanyInfoID = myProjects[index!].CompanyInfoID
        secondView.conditionService = "condition"
        secondView.LatBranch = myProjects[index!].LatBranch
        secondView.LngBranch = myProjects[index!].LngBranch
        self.navigationController?.pushViewController(secondView, animated: true)
    }
    
    @IBAction func directionBtn(_ sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: MyProjectsTableView)
        let index = MyProjectsTableView.indexPathForRow(at: point)?.row
        let dLati = myProjects[index!].LatBranch
        let dLang = myProjects[index!].LngBranch
        self.LatBranch = myProjects[index!].LatBranch
        self.LngBranch = myProjects[index!].LngBranch
        
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
//        alertAction.addAction(UIAlertAction(title: "الخرئط", style: .default, handler: { action in
//            let location = CLLocation(latitude: dLati, longitude: dLang)
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
//         self.present(alertAction, animated: true, completion: nil)
        
        
        if Helper.isDeviceiPad() {
            
            if let popoverController = AlertController.popoverPresentationController {
                popoverController.sourceView = sender
            }
        }
        
        DispatchQueue.main.async {
            UIApplication.shared.keyWindow?.rootViewController?.present(self.AlertController, animated: true, completion: nil)
        }

    }

    @IBAction func CallMe(_ sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: MyProjectsTableView)
        let index = MyProjectsTableView.indexPathForRow(at: point)?.row
        let mobileNum = myProjects[index!].EmpMobile
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
    
    func ReadAllMessageForCust(ProjectId: String) {
        Alamofire.request("http://smusers.promit2030.co/api/ApiService/ReadAllMessageForCust?ProjectId=\(ProjectId)", method: .post, encoding: URLEncoding.default).responseJSON { response in
            debugPrint(response)
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
                    self.PushInsertUpdate()
                }))
                
                self.present(alertAction, animated: true, completion: nil)
                
            }
        }
    }
    func setAppBadge() {
        let count = NotiTotalCount
    
        
        let CustmoerId = UserDefaults.standard.string(forKey: "CustmoerId")!
        if CustmoerId != nil || CustmoerId != ""
        {
            applicationl.applicationIconBadgeNumber = count
        }else
        {
            applicationl.applicationIconBadgeNumber = 0
        }
        
        if NotiMessageCount == 0 {
            messageNotfiCount.isHidden = true
        }else {
            messageNotfiCount.text = "\(NotiMessageCount)"
            messageNotfiCount.isHidden = false
        }
    }
    
    func PushInsertUpdate(){
        let CustmoerId = UserDefaults.standard.string(forKey: "CustmoerId")!
        print("cus: \(CustmoerId)")
        let DeviceToken = ""
        let DeviceID = UserDefaults.standard.string(forKey: "udidKey")!
        let parameters: Parameters = [
            "CustmoerId": CustmoerId,
            "DeviceToken":DeviceToken,
            "TypeDevice":"1",
            "DeviceID":DeviceID
        ]
        
        Alamofire.request("http://smusers.promit2030.co/Service1.svc/PushInsertUpdate", method: .get, parameters: parameters, encoding: URLEncoding.default).responseJSON { response in
            let json = JSON(response.result.value!)
            print(json)
            if json == "Deleted"
            {
                _ = UserDefaults.standard.removeObject(forKey: "CustmoerId")
                _ = UserDefaults.standard.removeObject(forKey: "UserId")
                _ = UserDefaults.standard.removeObject(forKey: "name")
                _ = UserDefaults.standard.removeObject(forKey: "mobile")
                _ = UserDefaults.standard.removeObject(forKey: "email")
                _ = UserDefaults.standard.removeObject(forKey: "nationalId")
                _ = UserDefaults.standard.removeObject(forKey: "CustomerPhoto")
                
                self.applicationl.applicationIconBadgeNumber = 0
                let center = UNUserNotificationCenter.current()
                center.removeAllDeliveredNotifications() // To remove all delivered notifications
                center.removeAllPendingNotificationRequests()
                
                let storyboard = UIStoryboard(name: "WelcomeScreen", bundle: nil)
                let NavController = storyboard.instantiateViewController(withIdentifier: "NewWelcome") as! UINavigationController
                let FirstViewController = NavController.viewControllers.first as! NewWelcomeScreenViewController
                FirstViewController.logout = "logout"
                self.present(NavController, animated: false, completion: nil)
            }
            
        }
    }
    
    func GetEmptByMobileNum() {
        let mobile = UserDefaults.standard.string(forKey: "mobile")!
        Alamofire.request("http://smusers.promit2030.co/Service1.svc/GetEmptByMobileNum?mobileNum=\(mobile)", method: .get).responseJSON { response in
            debugPrint(response)
            
            switch response.result {
            case .success:
                let json = JSON(response.result.value!)
                print(json)
                
                if json["Mobile"].stringValue == "" {
                    UserDefaults.standard.set(json["UserId"].stringValue, forKey: "UserId")
                    UserDefaults.standard.set(json["CustmoerId"].stringValue, forKey: "CustmoerId")
                    UserDefaults.standard.set(json["CustmoerName"].stringValue, forKey: "CustmoerName")
                    UserDefaults.standard.set(json["Email"].stringValue, forKey: "Email")
                    UserDefaults.standard.set(json["CustomerPhoto"].stringValue, forKey: "CustomerPhoto")
                    UserDefaults.standard.set(json["Mobile"].stringValue, forKey: "mobile")
                    if Reachability.isConnectedToNetwork(){
                        print("Internet Connection Available!")
                        self.model.GetProjectByCustID(view: self.view, VC: self)
                    }else{
                        print("Internet Connection not Available!")
                        self.projectModel.loadItems()
                        self.myProjects = self.projectModel.projects
                        self.MyProjectsTableView.reloadData()
                    }
                    self.CountCustomerNotification()
                } else {
                    UserDefaults.standard.set(json["UserId"].stringValue, forKey: "UserId")
                    UserDefaults.standard.set(json["CustmoerId"].stringValue, forKey: "CustmoerId")
                    UserDefaults.standard.set(json["CustmoerName"].stringValue, forKey: "CustmoerName")
                    UserDefaults.standard.set(json["Email"].stringValue, forKey: "Email")
                    UserDefaults.standard.set(json["CustomerPhoto"].stringValue, forKey: "CustomerPhoto")
                    UserDefaults.standard.set(json["Mobile"].stringValue, forKey: "mobile")
                    if Reachability.isConnectedToNetwork(){
                        print("Internet Connection Available!")
                        self.model.GetProjectByCustID(view: self.view, VC: self)
                    }else{
                        print("Internet Connection not Available!")
                        self.projectModel.loadItems()
                        self.myProjects = self.projectModel.projects
                        self.MyProjectsTableView.reloadData()
                    }
                    self.CountCustomerNotification()
                }
            case .failure(let error):
                print(error)
                UIViewController.removeSpinner(spinner: self.view)
                let alertAction = UIAlertController(title: "خطاء في الاتصال", message: "اعادة المحاولة", preferredStyle: .alert)
                
                alertAction.addAction(UIAlertAction(title: "نعم", style: .default, handler: { action in
                    self.GetEmptByMobileNum()
                }))
                
                alertAction.addAction(UIAlertAction(title: "رجوع", style: .cancel, handler: { action in
                     self.PushInsertUpdate()
                }))
                
                self.present(alertAction, animated: true, completion: nil)
                
            }
            
        }
        
    }
}
import SystemConfiguration

public class Reachability {
    
    class func isConnectedToNetwork() -> Bool {
        
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
            return false
        }
        
        /* Only Working for WIFI
         let isReachable = flags == .reachable
         let needsConnection = flags == .connectionRequired
         
         return isReachable && !needsConnection
         */
        
        // Working for Cellular and WIFI
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        let ret = (isReachable && !needsConnection)
        
        return ret
        
    }
}
extension String {
    var byWords: [String] {
        var byWords:[String] = []
        enumerateSubstrings(in: startIndex..<endIndex, options: .byWords) {
            guard let word = $0 else { return }
            print($1,$2,$3)
            byWords.append(word)
        }
        return byWords
    }
    func firstWords(_ max: Int) -> [String] {
        return Array(byWords.prefix(max))
    }
    var firstWord: String {
        return byWords.first ?? ""
    }
    func lastWords(_ max: Int) -> [String] {
        return Array(byWords.suffix(max))
    }
    var lastWord: String {
        return byWords.last ?? ""
    }
}
