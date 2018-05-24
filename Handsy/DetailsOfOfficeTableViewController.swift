//
//  DetailsOfOfficeTableViewController.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 12/7/17.
//  Copyright © 2017 Ahmed Wahdan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import MapKit

class DetailsOfOfficeTableViewController: UITableViewController, UICollectionViewDelegate, UICollectionViewDataSource, TeamWorkModelDelegate, OurProjectsModelDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var CompanyNAmeLabel: UILabel!
        
    @IBOutlet weak var OurProjectsSlider: UICollectionView!
    
    @IBOutlet weak var mapView: GMSMapView!
    
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var MobileLabel: UIButton!
    
    @IBOutlet weak var FaxLabel: UIButton!
    
    @IBOutlet weak var MailLabel: UIButton!
    
    @IBOutlet weak var FBLabel: UIButton!
    
    @IBOutlet weak var AboutTextView: UILabel!
    
    @IBOutlet weak var TeamWorkSlider: UICollectionView!
    
    
    var arrayOfResulr = [GetOfficesArray]()
    var index:Int?
//    var address = ""
    var isCompany = ""
    var conditionService = ""
    var LatBranch: Double = 0.0
    var LngBranch: Double = 0.0
    
    var Address = ""
    var BranchFB = ""
    var BranchID = ""
    var BranchName = ""
    var ComapnyName = ""
    var CommercialNumber = ""
    var CompanyEmail = ""
    var CompanyInfoID = ""
    var CompanyMobile = ""
    var Fax = ""
    var IsSCE = ""
    var Lat = 0.0
    var LicenceNumber = ""
    var Logo = ""
    var Long = 0.0
    var OfficeWebsite = ""
    var Phone = ""
    var PostNumber = ""
    var PostNumberWasl = ""
    var PostSymbol = ""
    var Specialty = ""
    var Zoom = 0.0
    
    //didsele
    // if isSelcted {
    //}
    // cell.layer.border
    // cell.layer.bordercolor
    
    var getTeamImagesArr:[GetTeamGallery] = [GetTeamGallery]()
    
    let TeamModel: TeamWorkModel = TeamWorkModel()
    
    var projectImagesArr:[GetProjectGallery] = [GetProjectGallery]()
    
    let projectModel: OurProjectsModel = OurProjectsModel()
    
    var marker: GMSMarker = GMSMarker()
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var myTitleView: UIView!
    
    
    var detialsOfOfficeArray = [DetialsOfOfficeArray]()
    let detialsOfOfficeModel = DetialsOfOfficeModel()
    var resultAboutArray = [AboutArray]()
    let aboutModel = AboutModel()
    
    let teamGalleryModel = TeamGalleryModel()
    let projectGalleryModel = ProjectGalleryModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addBackBarButtonItem()
        myView.layer.cornerRadius = 10.0
        mapView.delegate = self
        mapView.mapType = .terrain
        DispatchQueue.main.async {
            if #available(iOS 11, *) {
                self.myTitleView.frame = CGRect.init(x: 0, y: 0, width: self.view.frame.width, height: 50)
                self.tableView.contentInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
                self.tableView.bringSubview(toFront: self.myTitleView)
                self.tableView.addSubview(self.myTitleView)
            } else {
                self.myTitleView.frame = CGRect.init(x: 0, y: 0, width: self.view.frame.width, height: 50)
                self.tableView.contentInset = UIEdgeInsets.init(top: 75, left: 0, bottom: 0, right: 0)
                self.tableView.bringSubview(toFront: self.myTitleView)
                self.tableView.addSubview(self.myTitleView)
            }
            
        }
        
        if Reachability.isConnectedToNetwork(){
            print("Internet Connection Available!")
            setContact()
            GetAbout()
            TeamModel.delegate = self
            projectModel.delegate = self
            if conditionService != "" {
                TeamModel.GetAllCompanyGallery(view: self.view, companyInfoID: CompanyInfoID)
                projectModel.GetAllProjectGallery(view: self.view, companyInfoID: CompanyInfoID)
            }else {
                TeamModel.GetAllCompanyGallery(view: self.view, companyInfoID: arrayOfResulr[index!].CompanyInfoID)
                projectModel.GetAllProjectGallery(view: self.view, companyInfoID: arrayOfResulr[index!].CompanyInfoID)
            }
        }else{
            detialsOfOfficeModel.loadItems()
            aboutModel.loadItems()
            teamGalleryModel.loadItems()
            projectGalleryModel.loadItems()
            if conditionService != "" {
                if detialsOfOfficeModel.returnProjectDetials(at: CompanyInfoID) != nil {
                    let detials = detialsOfOfficeModel.returnProjectDetials(at: CompanyInfoID)
                    self.detialsOfOfficeArray = [detials!]
                }
                if aboutModel.returnProjectDetials(at: CompanyInfoID) != nil {
                    let aboutDetials = aboutModel.returnProjectDetials(at: CompanyInfoID)
                    self.resultAboutArray = [aboutDetials!]
                }
                if teamGalleryModel.returnProjectDetials(at: CompanyInfoID) != nil {
                    let teamGalleryDetials = teamGalleryModel.returnProjectDetials(at: CompanyInfoID)
                    self.getTeamImagesArr = teamGalleryDetials!
                }
                if projectGalleryModel.returnProjectDetials(at: CompanyInfoID) != nil {
                    let projectGalleryDetials = projectGalleryModel.returnProjectDetials(at: CompanyInfoID)
                    self.projectImagesArr = projectGalleryDetials!
                }
                print("comp: \(CompanyInfoID)")
            }else {
                if detialsOfOfficeModel.returnProjectDetials(at: arrayOfResulr[index!].CompanyInfoID) != nil {
                    let detials = detialsOfOfficeModel.returnProjectDetials(at: arrayOfResulr[index!].CompanyInfoID)
                    self.detialsOfOfficeArray = [detials!]
                }
                if aboutModel.returnProjectDetials(at: arrayOfResulr[index!].CompanyInfoID) != nil {
                    let aboutDetials = aboutModel.returnProjectDetials(at: arrayOfResulr[index!].CompanyInfoID)
                    self.resultAboutArray = [aboutDetials!]
                }
                if teamGalleryModel.returnProjectDetials(at: arrayOfResulr[index!].CompanyInfoID) != nil {
                    let teamGalleryDetials = teamGalleryModel.returnProjectDetials(at: arrayOfResulr[index!].CompanyInfoID)
                    self.getTeamImagesArr = teamGalleryDetials!
                }
                if projectGalleryModel.returnProjectDetials(at: arrayOfResulr[index!].CompanyInfoID) != nil {
                    let projectGalleryDetials = projectGalleryModel.returnProjectDetials(at: arrayOfResulr[index!].CompanyInfoID)
                    self.projectImagesArr = projectGalleryDetials!
                }
                print("comp: \(arrayOfResulr[index!].CompanyInfoID)")
            }
            self.CompanyNAmeLabel.text = detialsOfOfficeArray[0].ComapnyName
            self.addressLabel.text = detialsOfOfficeArray[0].Address
            self.MobileLabel.setTitle("\(detialsOfOfficeArray[0].CompanyMobile ?? "")", for: .normal)
            self.FaxLabel.setTitle("\(detialsOfOfficeArray[0].Fax ?? "")", for: .normal)
            self.MailLabel.setTitle("\(detialsOfOfficeArray[0].CompanyEmail ?? "")", for: .normal)
            self.FBLabel.setTitle("\(detialsOfOfficeArray[0].BranchFB ?? "")", for: .normal)
            if self.isCompany == "1" {
                self.chooseOut.setTitle("اختار المكتب", for: .normal)
            }else {
                self.chooseOut.setTitle("اختار المهندس", for: .normal)
            }
            self.AboutTextView.text = resultAboutArray[0].ExperContent
            self.getMapOffline()
            tableView.reloadData()
        }
        
        OurProjectsSlider.delegate = self
        OurProjectsSlider.dataSource = self
        TeamWorkSlider.delegate = self
        TeamWorkSlider.dataSource = self
        
        if conditionService != "" {
            myView.isHidden = true
            DispatchQueue.main.async {
                self.myView.frame = CGRect.init(x: 0, y: self.tableView.contentOffset.y + (self.view.frame.height-80), width: self.view.frame.width, height: 0)
                self.tableView.bringSubview(toFront: self.myView)
                self.tableView.addSubview(self.myView)
            }
        }else {
            DispatchQueue.main.async {
                self.myView.frame = CGRect.init(x: 0, y: self.tableView.contentOffset.y + (self.view.frame.height-80), width: self.view.frame.width, height: 80)
                if #available(iOS 11, *) {
                    self.tableView.contentInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 70, right: 0)
                }else{
                    self.tableView.contentInset = UIEdgeInsets.init(top: 75, left: 0, bottom: 70, right: 0)
                }
                self.tableView.bringSubview(toFront: self.myView)
                self.tableView.addSubview(self.myView)
            }
        }
        
    }
    
    func addBackBarButtonItem() {
        let shareButton = UIButton(type: .system)
        shareButton.setTitle("عودة", for: .normal)
        shareButton.setImage(UIImage(named: "DBackBtn"), for: .normal)
        shareButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        shareButton.sizeToFit()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: shareButton)
    }
    
    @objc func backButtonPressed(){
        self.navigationController!.popViewController(animated: true)
    }
    
    func dataReady() {
        // Access the video objects that have been downloaded
        self.getTeamImagesArr = self.TeamModel.resultArray
        self.projectImagesArr = self.projectModel.resultArray
        if conditionService != "" {
            self.projectGalleryModel.append(self.projectImagesArr, index: CompanyInfoID)
            self.teamGalleryModel.append(self.getTeamImagesArr, index: CompanyInfoID)
        }else {
            let CompInfID = arrayOfResulr[index!].CompanyInfoID
            self.projectGalleryModel.append(self.projectImagesArr, index: CompInfID)
            self.teamGalleryModel.append(self.getTeamImagesArr, index: CompInfID)
        }
        
        // Tell the collection to reload
        TeamWorkSlider.reloadData()
        OurProjectsSlider.reloadData()
    }
    
    func GetAbout() {
        let sv = UIViewController.displaySpinner(onView: self.view)
        var CompInfID: String?
        let parameters : Parameters?
        if conditionService != "" {
            parameters = [
                "CompanyInfoID": CompanyInfoID
            ]
            CompInfID = CompanyInfoID
            print("comp: \(CompanyInfoID)")
        }else {
            parameters = [
                "CompanyInfoID": arrayOfResulr[index!].CompanyInfoID
            ]
            CompInfID = arrayOfResulr[index!].CompanyInfoID
            print("comp: \(arrayOfResulr[index!].CompanyInfoID)")
        }
        
        
        Alamofire.request("http://smusers.promit2030.com/Service1.svc/GetAbout", method: .get, parameters: parameters, encoding: URLEncoding.default).responseJSON { response in
            switch response.result {
            case .success:
                let json = JSON(response.result.value!)
                print(json)
                let aboutArray = AboutArray(AboutTitle: json["AboutTilte"].stringValue, AboutContent: json["AboutContent"].stringValue, ExperTitle: json["ExperienceTitle"].stringValue, ExperContent: json["ExperienceContent"].stringValue, CompanyInfoID: CompInfID!)
                self.resultAboutArray.append(aboutArray)
                for i in self.resultAboutArray {
                    self.aboutModel.append(i)
                }
                let AboutText = "\(json["ExperienceContent"].stringValue)"
                self.AboutTextView.text = AboutText
                print("Validation Successful")
                UIViewController.removeSpinner(spinner: sv)
            case .failure(let error):
                print(error)
                let alertAction = UIAlertController(title: "خطاء في الاتصال", message: "اعادة المحاولة", preferredStyle: .alert)
                
                alertAction.addAction(UIAlertAction(title: "نعم", style: .default, handler: { action in
                    self.GetAbout()
                }))
                
                alertAction.addAction(UIAlertAction(title: "رجوع", style: .cancel, handler: { action in
                    self.navigationController!.popViewController(animated: true)
                }))
                
                self.present(alertAction, animated: true, completion: nil)
                
            }
            
            //            self.ExperTitle = json["ExperienceTitle"].stringValue
            //            self.ExperContent = json["ExperienceContent"].stringValue
        }
    }
    
    @IBAction func MobileBtn(_ sender: UIButton) {
        var mobileText: String = (MobileLabel.titleLabel?.text!)!
        if mobileText.count == 10 {
            if mobileText.first! == "0" {
                if mobileText[mobileText.index(mobileText.startIndex, offsetBy: 1)] == "5" {
                    mobileText.remove(at: mobileText.startIndex)
                    mobileText.insert("6", at: mobileText.startIndex)
                    mobileText.insert("6", at: mobileText.startIndex)
                    mobileText.insert("9", at: mobileText.startIndex)
                    callNumber(phoneNumber: mobileText)
                }else {
                    callNumber(phoneNumber: mobileText)
                }
            }else {
                callNumber(phoneNumber: mobileText)
            }
        } else {
            callNumber(phoneNumber: mobileText)
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
    
    @IBAction func FaxBtn(_ sender: UIButton) {
        var faxText: String = (FaxLabel.titleLabel?.text!)!
        if faxText.count == 10 {
            if faxText.first! == "0" {
                if faxText[faxText.index(faxText.startIndex, offsetBy: 1)] == "5" {
                    faxText.remove(at: faxText.startIndex)
                    faxText.insert("6", at: faxText.startIndex)
                    faxText.insert("6", at: faxText.startIndex)
                    faxText.insert("9", at: faxText.startIndex)
                    callNumber(phoneNumber: faxText)
                }else {
                    callNumber(phoneNumber: faxText)
                }
            }else {
                callNumber(phoneNumber: faxText)
            }
        } else {
            callNumber(phoneNumber: faxText)
        }
    }
    
    @IBAction func MailBtn(_ sender: UIButton) {
        let email: String = (MailLabel.titleLabel?.text!)!
        if let url = URL(string: "mailto:\(email)") {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func FBBtn(_ sender: UIButton) {
        let facebookText: String = (FBLabel.titleLabel?.text!)!
        let url = URL(string: facebookText)!
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
    
    
    func openMapsForLocation() {
        let dLati = Lat
        let dLang = Long
        let location = CLLocation(latitude: dLati, longitude: dLang)
        print(location.coordinate)
        MKMapView.openMapsWith(location) { (error) in
            if error != nil {
                print("Could not open maps" + error!.localizedDescription)
            }
        }
    }
    
    
    
    func setContact(){
        let sv = UIViewController.displaySpinner(onView: self.view)
        let parameters : Parameters?
        if conditionService != "" {
            parameters = [
                "CompanyInfoID": CompanyInfoID
            ]
        }else {
            parameters = [
                "CompanyInfoID": arrayOfResulr[index!].CompanyInfoID
            ]
        }
        
        Alamofire.request("http://smusers.promit2030.com/Service1.svc/GetOfficeByCompanyInfoID", method: .get, parameters: parameters, encoding: URLEncoding.default).responseJSON { response in
            let json = JSON(response.result.value!)
            print(json)
            let appendDetialsOfOfficeArray = DetialsOfOfficeArray(Address: json["Address"].stringValue, BranchFB: json["BranchFB"].stringValue, BranchID: json["BranchID"].stringValue, BranchName: json["BranchName"].stringValue, ComapnyName: json["ComapnyName"].stringValue, CommercialNumber: json["CommercialNumber"].stringValue, CompanyEmail: json["CompanyEmail"].stringValue, CompanyInfoID: json["CompanyInfoID"].stringValue, CompanyMobile: json["CompanyMobile"].stringValue, Fax: json["Fax"].stringValue, Lat: json["Lat"].doubleValue, Long: json["Long"].doubleValue, LicenceNumber: json["LicenceNumber"].stringValue, Logo: json["Logo"].stringValue, OfficeWebsite: json["OfficeWebsite"].stringValue, Phone: json["Phone"].stringValue, PostNumber: json["PostNumber"].stringValue, PostNumberWasl: json["PostNumberWasl"].stringValue, PostSymbol: json["PostSymbol"].stringValue, Specialty: json["Specialty"].stringValue, Zoom: json["Zoom"].doubleValue)
            self.detialsOfOfficeArray.append(appendDetialsOfOfficeArray)
            for i in self.detialsOfOfficeArray {
                self.detialsOfOfficeModel.append(i)
            }
            self.Address = json["Address"].stringValue
            self.BranchFB = json["BranchFB"].stringValue
            self.BranchID = json["BranchID"].stringValue
            self.BranchName = json["BranchName"].stringValue
            self.ComapnyName = json["ComapnyName"].stringValue
            self.CommercialNumber = json["CommercialNumber"].stringValue
            self.CompanyEmail = json["CompanyEmail"].stringValue
            self.CompanyInfoID = json["CompanyInfoID"].stringValue
            self.CompanyMobile = json["CompanyMobile"].stringValue
            self.Fax = json["Fax"].stringValue
            self.Lat = json["Lat"].doubleValue
            self.Long = json["Long"].doubleValue
            self.LicenceNumber = json["LicenceNumber"].stringValue
            self.Logo = json["Logo"].stringValue
            self.OfficeWebsite = json["OfficeWebsite"].stringValue
            self.Phone = json["Phone"].stringValue
            self.PostNumber = json["PostNumber"].stringValue
            self.PostNumberWasl = json["PostNumberWasl"].stringValue
            self.PostSymbol = json["PostSymbol"].stringValue
            self.Specialty = json["Specialty"].stringValue
            self.Zoom = json["Zoom"].doubleValue
            UIViewController.removeSpinner(spinner: sv)
            self.CompanyNAmeLabel.text = self.ComapnyName
            self.addressLabel.text = self.Address
            self.MobileLabel.setTitle("\(self.CompanyMobile)", for: .normal)
            self.FaxLabel.setTitle("\(self.Fax)", for: .normal)
            self.MailLabel.setTitle("\(self.CompanyEmail)", for: .normal)
            self.FBLabel.setTitle("\(self.BranchFB)", for: .normal)
            if self.isCompany == "1" {
                self.chooseOut.setTitle("اختار المكتب", for: .normal)
            }else {
                self.chooseOut.setTitle("اختار المهندس", for: .normal)
            }
            self.get()
        }
    }
    
    func get() {
      
        
        //        let dZoom = Float(ZoomPrj) ?? 0.0
        mapView.animate(toBearing: 90)
        mapView.camera = GMSCameraPosition.camera(withLatitude: Lat, longitude: Long, zoom: 17)
        //        GMSMapView.map(withFrame: CGRect.zero, camera: mapView.camera)
        mapView.isMyLocationEnabled = true
        
        // Creates a marker in the center of the map.
        marker.position = CLLocationCoordinate2D(latitude: Lat, longitude: Long)
        
        marker.title = ComapnyName
        marker.map = mapView
        //        mapView.selectedMarker = marker
        
        mapView.delegate = self
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
    }
    
    func getMapOffline() {
        
        
        //        let dZoom = Float(ZoomPrj) ?? 0.0
        mapView.animate(toBearing: 90)
        mapView.camera = GMSCameraPosition.camera(withLatitude: detialsOfOfficeArray[0].Lat!, longitude: detialsOfOfficeArray[0].Long!, zoom: 17)
        //        GMSMapView.map(withFrame: CGRect.zero, camera: mapView.camera)
        mapView.isMyLocationEnabled = true
        
        // Creates a marker in the center of the map.
        marker.position = CLLocationCoordinate2D(latitude: detialsOfOfficeArray[0].Lat!, longitude: detialsOfOfficeArray[0].Long!)
        
        marker.title = ComapnyName
        marker.map = mapView
        //        mapView.selectedMarker = marker
        
        mapView.delegate = self
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //    override func willMove(toParentViewController parent: UIViewController?) {
    //        super.willMove(toParentViewController: parent)
    //        if parent == nil {
    //
    //            //restore the orignal title
    //            navigationController?.navigationBar.backItem?.title = backItemTitle
    //        }
    //    }
    
    
    @IBAction func MoreBtn(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Home", bundle:nil)
        let secondView = storyBoard.instantiateViewController(withIdentifier: "AboutCompanyTableViewController") as! AboutCompanyTableViewController
        if conditionService != "" {
            secondView.CompanyInfoID = self.CompanyInfoID
        }else {
            secondView.CompanyInfoID = self.arrayOfResulr[index!].CompanyInfoID
        }
        
        secondView.isCompany = isCompany
        self.navigationController?.pushViewController(secondView, animated: true)
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView){
        if scrollView == tableView {
            var frame: CGRect = self.myView.frame
            frame.origin.y = scrollView.contentOffset.y + self.view.frame.height - 80
            myView.frame = frame
            if #available(iOS 11, *) {
                var frameTitle: CGRect = self.myTitleView.frame
                frameTitle.origin.y = scrollView.contentOffset.y + 60
                myTitleView.frame = frameTitle
            }else {
                var frameTitle: CGRect = self.myTitleView.frame
                frameTitle.origin.y = scrollView.contentOffset.y + 60
                myTitleView.frame = frameTitle
            }
            
        }
    }
    
    //    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
    //        self.Local.frame = CGRect.init(x: 0, y: 0, width: self.view.frame.width, height: 1)
    //    }
    
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 4
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == OurProjectsSlider {
            return projectImagesArr.count
        }else {
            return getTeamImagesArr.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == OurProjectsSlider {
            let cell = OurProjectsSlider.dequeueReusableCell(withReuseIdentifier: "OurProjectsImagesCollectionViewCell", for: indexPath) as! OurProjectsImagesCollectionViewCell
            let img = projectImagesArr[indexPath.row].ProjectGalleryPath
            if let url = URL.init(string: img!) {
                cell.ImageView.hnk_setImageFromURL(url, placeholder: #imageLiteral(resourceName: "officePlaceholder"))
            } else{
                print("nil")
                cell.ImageView.image = #imageLiteral(resourceName: "officePlaceholder")
            }
            return cell
        }else {
            let cell = TeamWorkSlider.dequeueReusableCell(withReuseIdentifier: "TeamWorkImagesCollectionViewCell", for: indexPath) as! TeamWorkImagesCollectionViewCell
            let img = getTeamImagesArr[indexPath.row].CompanyGalleryPath
            if let url = URL.init(string: img!) {
                cell.ImageView.hnk_setImageFromURL(url, placeholder: #imageLiteral(resourceName: "officePlaceholder"))
            } else{
                print("nil")
                cell.ImageView.image = #imageLiteral(resourceName: "officePlaceholder")
            }
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == OurProjectsSlider {
            let storyBoard : UIStoryboard = UIStoryboard(name: "NewProject", bundle:nil)
            let secondView = storyBoard.instantiateViewController(withIdentifier: "OfficesGallaryViewController") as! OfficesGallaryViewController
            if conditionService != "" {
                secondView.CompanyInfoID = self.CompanyInfoID
                secondView.CompanyName = self.ComapnyName
                secondView.CompanyAddress = self.Address
                secondView.CompanyImage = self.Logo
                secondView.branchId = self.BranchID
                secondView.projectImagesArr = self.projectImagesArr
                secondView.conditionService = self.conditionService
                secondView.EmpMobile = self.CompanyMobile
                secondView.IsCompany = self.isCompany
                secondView.LatBranch = self.Lat
                secondView.LngBranch = self.Long
                secondView.ZoomBranch = String(self.Zoom)
            }else {
                secondView.CompanyInfoID = self.arrayOfResulr[index!].CompanyInfoID
                secondView.CompanyName = self.arrayOfResulr[index!].ComapnyName
                secondView.CompanyAddress = self.arrayOfResulr[index!].Address
                secondView.CompanyImage = self.arrayOfResulr[index!].Logo
                secondView.branchId = self.arrayOfResulr[index!].BranchID
                secondView.projectImagesArr = self.projectImagesArr
                secondView.conditionService = self.conditionService
                secondView.EmpMobile = self.arrayOfResulr[index!].CompanyMobile
                secondView.IsCompany = self.arrayOfResulr[index!].IsCompany
                secondView.LatBranch = self.arrayOfResulr[index!].Lat
                secondView.LngBranch = self.arrayOfResulr[index!].Long
                secondView.ZoomBranch = self.arrayOfResulr[index!].Zoom
            }
            self.navigationController?.pushViewController(secondView, animated: true)
        } else {
            let storyBoard : UIStoryboard = UIStoryboard(name: "NewProject", bundle:nil)
            let secondView = storyBoard.instantiateViewController(withIdentifier: "OfficesGallaryViewController") as! OfficesGallaryViewController
            if conditionService != "" {
                secondView.CompanyInfoID = self.CompanyInfoID
                secondView.CompanyName = self.ComapnyName
                secondView.CompanyAddress = self.Address
                secondView.CompanyImage = self.Logo
                secondView.branchId = self.BranchID
                secondView.getTeamImagesArr = self.getTeamImagesArr
                secondView.officeType = "Team"
                secondView.conditionService = self.conditionService
                secondView.EmpMobile = self.CompanyMobile
                secondView.IsCompany = self.isCompany
                secondView.LatBranch = self.Lat
                secondView.LngBranch = self.Long
                secondView.ZoomBranch = String(self.Zoom)
            }else{
                secondView.CompanyInfoID = self.arrayOfResulr[index!].CompanyInfoID
                secondView.CompanyName = self.arrayOfResulr[index!].ComapnyName
                secondView.CompanyAddress = self.arrayOfResulr[index!].Address
                secondView.CompanyImage = self.arrayOfResulr[index!].Logo
                secondView.branchId = self.arrayOfResulr[index!].BranchID
                secondView.getTeamImagesArr = self.getTeamImagesArr
                secondView.officeType = "Team"
                secondView.conditionService = self.conditionService
                secondView.EmpMobile = self.arrayOfResulr[index!].CompanyMobile
                secondView.IsCompany = self.arrayOfResulr[index!].IsCompany
                secondView.LatBranch = self.arrayOfResulr[index!].Lat
                secondView.LngBranch = self.arrayOfResulr[index!].Long
                secondView.ZoomBranch = self.arrayOfResulr[index!].Zoom
            }
            
            self.navigationController?.pushViewController(secondView, animated: true)
        }
        
    }
    @IBOutlet weak var chooseOut: UIButton!{
        didSet {
            DispatchQueue.main.async {
                self.chooseOut.layer.cornerRadius = 7.0
                self.chooseOut.layer.masksToBounds = true
            }
        }
    }
    
    @IBAction func ChooseThisBtn(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "NewProject", bundle:nil)
        let secondView = storyBoard.instantiateViewController(withIdentifier: "NewProjectATableViewController") as! NewProjectATableViewController
        secondView.CompanyInfoID = self.arrayOfResulr[index!].CompanyInfoID
        secondView.CompanyName = self.arrayOfResulr[index!].ComapnyName
        secondView.CompanyAddress = self.arrayOfResulr[index!].Address
        secondView.CompanyImage = self.arrayOfResulr[index!].Logo
        secondView.BranchID = self.arrayOfResulr[index!].BranchID
        secondView.EmpMobile = self.arrayOfResulr[index!].CompanyMobile
        secondView.IsCompany = self.arrayOfResulr[index!].IsCompany
        secondView.LatBranch = self.arrayOfResulr[index!].Lat
        secondView.LngBranch = self.arrayOfResulr[index!].Long
        secondView.ZoomBranch = self.arrayOfResulr[index!].Zoom
        self.navigationController?.pushViewController(secondView, animated: true)
    }
    
}
extension DetailsOfOfficeTableViewController: GMSMapViewDelegate {
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        openMapsForLocation()
        return true
    }
    
}
