//
//  NewMyProjectsViewController.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 12/27/17.
//  Copyright © 2017 Ahmed Wahdan. All rights reserved.
//

import UIKit
import MapKit
import Alamofire
import SwiftyJSON

var checkEmpty = 0

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
    
    @IBOutlet weak var MyProjectsTableView: UITableView!
    
    var myProjects:[GetProjectEngCustByCustID] = [GetProjectEngCustByCustID]()
    
    let model: RequestProjectModel = RequestProjectModel()
    
    let projectModel : projectsModel = projectsModel()
    
    @IBOutlet weak var NothingLabel: UILabel!
    @IBOutlet weak var AlertImage: UIImageView!
    let applicationl = UIApplication.shared
    var qustion = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func callBtnAction(_ sender: UIButton) {
        callButtonPressed() 
    }
    
    @IBAction func archiveBtnAction(_ sender: UIButton) {
        archiveButtonPressed()
    }
    
    func addArchiveBarButtonItem() {
        let archiveButton = UIButton(type: .system)
        archiveButton.layer.borderWidth = 1.0
        archiveButton.layer.borderColor = #colorLiteral(red: 0.2, green: 0.5647058824, blue: 0.3882352941, alpha: 1)
        archiveButton.layer.cornerRadius = 4.0
        archiveButton.frame = CGRect.init(x: 0, y: 0, width: 104, height: 30)
        archiveButton.setTitle("الأرشيف", for: .normal)
        archiveButton.titleEdgeInsets.left = 5
        archiveButton.titleEdgeInsets.right = -5
        archiveButton.setImage(UIImage(named: "Search"), for: .normal)
        archiveButton.addTarget(self, action: #selector(archiveButtonPressed), for: .touchUpInside)
        archiveButton.sizeToFit()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: archiveButton)
    }
    
    @objc func archiveButtonPressed() {
        let storyBoard : UIStoryboard = UIStoryboard(name: "NewHome", bundle: nil)
        let secondView = storyBoard.instantiateViewController(withIdentifier: "FilterViewController") as! FilterViewController
        self.navigationController?.pushViewController(secondView, animated: true)
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
        if Reachability.isConnectedToNetwork(){
            print("Internet Connection Available!")
            model.GetProjectByCustID(view: self.view, VC: self)
        }else{
            print("Internet Connection not Available!")
            projectModel.loadItems()
            self.myProjects = projectModel.projects
            MyProjectsTableView.reloadData()
        }
        
    }
    

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func HideFunc() {
        let storyBoard : UIStoryboard = UIStoryboard(name: "NewHome", bundle: nil)
        let secondView = storyBoard.instantiateViewController(withIdentifier: "NewProjectAlertViewController") as! NewProjectAlertViewController
        secondView.modalPresentationStyle = .custom
        self.present(secondView, animated: false)
//        tabBarController?.tabBar.isUserInteractionEnabled = false
//        AlertNewProjectView.alpha = 0
//        AlertNewProjectView.isHidden = false
//        UIView.animate(withDuration: 3) {
//            self.AlertNewProjectView.alpha = 1
//        }
//        // swift:
//        UIView.animate(withDuration: 6, animations: {
//            self.AlertNewProjectView.alpha = 0
//        }) { (finished) in
//            self.AlertNewProjectView.isHidden = finished
//            self.tabBarController?.tabBar.isUserInteractionEnabled = true
//        }
        
        //        UserDefaults.standard.set("1", forKey: "alert")
    }
    
    func GetMobileUpdate() {
        let parameters : Parameters = [
            "TypeID": "2"
        ]
        Alamofire.request("http://smusers.promit2030.com/Service1.svc/GetMobileUpdate", method: .get, parameters: parameters, encoding: URLEncoding.default).responseJSON { response in
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
        if myProjects.count == 0 {
            NothingLabel.isHidden = false
            AlertImage.isHidden = false
            MyProjectsTableView.isHidden = true
        } else {
            MyProjectsTableView.isHidden = false
            NothingLabel.isHidden = true
            AlertImage.isHidden = true
        }
        return myProjects.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 213
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

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MyProjectsTableView.dequeueReusableCell(withIdentifier: "NewMyProjectsTableViewCell", for: indexPath) as! NewMyProjectsTableViewCell
        let iscompany = myProjects[indexPath.row].IsCompany
        
        let projectTitle = "\(myProjects[indexPath.row].ProjectTitle)"
        cell.projectTitleLabel.text = projectTitle
        cell.DateRegisterLabel.text = myProjects[indexPath.row].DateRegister
        cell.companyNameLabel.text = myProjects[indexPath.row].ComapnyName
        cell.EngNameLabel.text = myProjects[indexPath.row].EmpName
        let emplImage = myProjects[indexPath.row].EmpImage
        if let url = URL.init(string: emplImage) {
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
            cell.statusImage.backgroundColor = #colorLiteral(red: 0.9921568627, green: 0.4274509804, blue: 0.337254902, alpha: 1)
        }else if status == "4"{
            cell.StatusNameLabel.text = statusName
            cell.statusImage.backgroundColor = #colorLiteral(red: 0.1176470588, green: 0.368627451, blue: 0.4666666667, alpha: 1)
        }else if status == "3"{
            cell.StatusNameLabel.text = statusName
            cell.statusImage.backgroundColor = #colorLiteral(red: 0.1764705882, green: 0.4745098039, blue: 0.8862745098, alpha: 1)
        }else if status == "1"{
            cell.StatusNameLabel.text = statusName
            cell.statusImage.backgroundColor = #colorLiteral(red: 0.831372549, green: 0.6862745098, blue: 0.2117647059, alpha: 1)
        }else if status == "2"{
            cell.StatusNameLabel.text = statusName
            cell.statusImage.backgroundColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
        }else if status == "6"{
            cell.StatusNameLabel.text = statusName
            cell.statusImage.backgroundColor = #colorLiteral(red: 0.2588235294, green: 0.8666666667, blue: 0.1764705882, alpha: 1)
        }else if status == "7"{
            cell.StatusNameLabel.text = statusName
            cell.statusImage.backgroundColor = #colorLiteral(red: 0.2, green: 0.5647058824, blue: 0.3882352941, alpha: 1)
        }else {
            print("error status \(status)")
        }
        cell.lastStatusLabel.text = myProjects[indexPath.row].ProjectLastComment
        let NotLabel = myProjects[indexPath.row].NotifiCount
        
        if NotLabel != 0 {
            cell.notficationAlertBtnOut.isHidden = false
            cell.notficationCountLabel.isHidden = false
            cell.notficationCountLabel.text = "\(NotLabel)"
        } else {
            cell.notficationAlertBtnOut.isHidden = false
            cell.notficationCountLabel.isHidden = true
        }
        
//        let first = tabBarController?.viewControllers?.first
//        AllNot += NotLabel
//        first?.tabBarItem.badgeValue = "\(AllNot)"
//        first?.tabBarItem.badgeColor = #colorLiteral(red: 0.3063454032, green: 0.5060613751, blue: 0.5319297314, alpha: 1)
        
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
        
        // Tell the tableview to reload
        self.MyProjectsTableView.reloadData()
        setBadge()
        if myProjects.count == 0 {
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
//            if let check = UserDefaults.standard.string(forKey: "checkEmpty"){
//
//            }else {
//
//            }
            
            
//            _ = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(HideFunc), userInfo: nil, repeats: false)
        }
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
            self.applicationl.applicationIconBadgeNumber = AllNot
        } else {
            self.applicationl.applicationIconBadgeNumber = 0
        }
    }
    
    @IBAction func goToNotfication(_ sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: MyProjectsTableView)
        let index = MyProjectsTableView.indexPathForRow(at: point)?.row
        let storyBoard : UIStoryboard = UIStoryboard(name: "NewHome", bundle:nil)
        let secondView = storyBoard.instantiateViewController(withIdentifier: "MyProjectNotficationViewController") as! MyProjectNotficationViewController
        secondView.projectId = myProjects[index!].ProjectId
        self.navigationController?.pushViewController(secondView, animated: true)
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
        let location = CLLocation(latitude: dLati, longitude: dLang)
        print(location.coordinate)
        MKMapView.openMapsWith(location) { (error) in
            if error != nil {
                print("Could not open maps" + error!.localizedDescription)
            }
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
