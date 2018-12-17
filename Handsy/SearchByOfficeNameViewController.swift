//
//  SearchByOfficeNameViewController.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 3/18/18.
//  Copyright © 2018 Ahmed Wahdan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import MapKit
import GooglePlaces

class SearchByOfficeNameViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
    
    
    @IBOutlet var LoginVIew: UIView!
    
    @IBOutlet weak var GtoLogin: UIButton!
    @IBAction func GtoLoginBtn(_ sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: resultsTableView)
        var index = resultsTableView.indexPathForRow(at: point)?.section
        
        if index == nil
        {
            index = 0
        }
        let storyBoard : UIStoryboard = UIStoryboard(name: "NewLogin", bundle:nil)
        let secondView = storyBoard.instantiateViewController(withIdentifier: "NewLoginViewController") as! NewLoginViewController
        secondView.isComingFromProject = true
        if isFiltering() {
            self.CompanyInfoID = self.filteredOffices[index!].CompanyInfoID
            self.CompanyName = self.filteredOffices[index!].ComapnyName
            self.CompanyAddress = self.filteredOffices[index!].Address
            self.CompanyImage = self.filteredOffices[index!].Logo
            self.branchId = self.filteredOffices[index!].BranchID
            secondView.CompanyInfoID = self.CompanyInfoID
            secondView.CompanyName = self.CompanyName
            secondView.CompanyAddress = self.CompanyAddress
            secondView.CompanyImage = self.CompanyImage
            secondView.BranchID = self.branchId
            secondView.EmpMobile = self.filteredOffices[index!].CompanyMobile
            secondView.IsCompany = self.filteredOffices[index!].IsCompany
            secondView.LatBranch = self.filteredOffices[index!].Lat
            secondView.LngBranch = self.filteredOffices[index!].Long
            secondView.ZoomBranch = self.filteredOffices[index!].Zoom
        }else{
            self.CompanyInfoID = self.arrayOfResulr[index!].CompanyInfoID
            self.CompanyName = self.arrayOfResulr[index!].ComapnyName
            self.CompanyAddress = self.arrayOfResulr[index!].Address
            self.CompanyImage = self.arrayOfResulr[index!].Logo
            self.branchId = self.arrayOfResulr[index!].BranchID
            secondView.CompanyInfoID = self.CompanyInfoID
            secondView.CompanyName = self.CompanyName
            secondView.CompanyAddress = self.CompanyAddress
            secondView.CompanyImage = self.CompanyImage
            secondView.BranchID = self.branchId
            secondView.EmpMobile = self.arrayOfResulr[index!].CompanyMobile
            secondView.IsCompany = self.arrayOfResulr[index!].IsCompany
            secondView.LatBranch = self.arrayOfResulr[index!].Lat
            secondView.LngBranch = self.arrayOfResulr[index!].Long
            secondView.ZoomBranch = self.arrayOfResulr[index!].Zoom
        }
        self.navigationController?.pushViewController(secondView, animated: true)
        
    }
    
    @IBAction func EndLoginView(_ sender: Any) {
        LoginVIew.isHidden = true
    }
    
    let locationManager = CLLocationManager()
    var arrayOfResulr = [GetOfficesArray]()
    var filteredOffices = [GetOfficesArray]()
    
    var isCompany = ""
    var CompanyInfoID = ""
    var CompanyName = ""
    var CompanyAddress = ""
    var CompanyImage = ""
    var branchId = ""
    var type = ""
    var reate = ""
    var LatBranch: Double = 0.0
    var LngBranch: Double = 0.0
    var targetMyLocation: CLLocation?
    var resultMyLocation2: CLLocation?
    var searchController = UISearchController(searchResultsController: nil)
    var AlertController: UIAlertController!
    @IBOutlet weak var resultsTableView: UITableView!
    @IBOutlet weak var OfficeListEmptyLabel: UILabel!
    
    
    @IBOutlet weak var AlertImage: UIImageView!
    
    @IBOutlet weak var mapBtnOut: UIView!{
        didSet {
            DispatchQueue.main.async {
                self.mapBtnOut.layer.cornerRadius = self.mapBtnOut.frame.width/2
                self.mapBtnOut.layer.masksToBounds = true
            }
        }
    }
    @IBOutlet weak var backLabel: UILabel!
    
    @IBOutlet weak var BackBtnOut: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LoginVIew.isHidden = true
        self.LoginVIew.frame = CGRect.init(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        self.LoginVIew.center = self.view.center
        self.view.addSubview(self.LoginVIew)
        
        addBackBarButtonItem()
        if type == "0" {
            if isCompany == "0" {
                backLabel.text = "قائمة المهندسين"
            }else {
                backLabel.text = "قائمة المكاتب"
            }
            BackBtnOut.setImage(#imageLiteral(resourceName: "officesTypeGold"), for: .normal)
            mapBtnOut.backgroundColor = #colorLiteral(red: 0.1843137255, green: 0.1803921569, blue: 0.1725490196, alpha: 1)
        }else {
            backLabel.text = "الخريطة"
            BackBtnOut.setImage(#imageLiteral(resourceName: "MapIcon"), for: .normal)
            mapBtnOut.backgroundColor = #colorLiteral(red: 0.1843137255, green: 0.1803921569, blue: 0.1725490196, alpha: 1)
        }
        resultsTableView.delegate = self
        resultsTableView.dataSource = self
        GetOfficesByProvincesID(SortBy: "1", SortExp: "")
        // Setup the Search Controller
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        if isCompany == "0" {
            searchController.searchBar.placeholder = "ابحث باسم المهندس"
        }else{
            searchController.searchBar.placeholder = "ابحث باسم المكتب"
        }
        
        navigationItem.titleView = searchController.searchBar
        //        if #available(iOS 11.0, *) {
        //            navigationItem.searchController = searchController
        //        } else {
        //            // Fallback on earlier versions
        //            navigationItem.titleView = searchController.searchBar
        //        }
        
        definesPresentationContext = true
        // Prevent the navigation bar from being hidden when searching.
        searchController.hidesNavigationBarDuringPresentation = false
        
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
    
    @IBOutlet weak var CallOfficebtn: UIButton!
    @IBOutlet weak var locationbtn: UIButton!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if arrayOfResulr.count == 0 {
            if isCompany == "0" {
                //                navigationItem.title = "\(0) مهندس"
                //                title = "\(0) مهندس"
                OfficeListEmptyLabel.text = "لا يوجد مهندسين"
            } else {
                //                navigationItem.title = "\(0) مكتب هندسي"
                //                title = "\(0) مكتب هندسي"
                OfficeListEmptyLabel.text = "لايوجد مكاتب"
            }
            OfficeListEmptyLabel.isHidden = false
            AlertImage.isHidden = false
            resultsTableView.isHidden = true
        }else {
            if isCompany == "0" {
                //                navigationItem.title = "\(arrayOfResulr.count) مهندس"
                //                title = "\(arrayOfResulr.count) مهندس"
                OfficeListEmptyLabel.text = "لا يوجد مهندسين"
            } else {
                //                navigationItem.title = "\(arrayOfResulr.count) مكتب هندسي"
                //                title = "\(arrayOfResulr.count) مكتب هندسي"
                OfficeListEmptyLabel.text = "لايوجد مكاتب"
            }
            OfficeListEmptyLabel.isHidden = true
            AlertImage.isHidden = true
            resultsTableView.isHidden = false
        }
        if isFiltering() {
            return filteredOffices.count
        }else {
            return arrayOfResulr.count
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 115
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let CustmoerId =    UserDefaults.standard.string(forKey: "CustmoerId")
        if CustmoerId == nil
        {
            return 140
        }
        else
        {
            return 170
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var offices = GetOfficesArray()
        let cell = resultsTableView.dequeueReusableCell(withIdentifier: "NeerOfficesTableViewCell", for: indexPath) as! NeerOfficesTableViewCell
        
        
        
        
        if isFiltering() {
            offices = filteredOffices[indexPath.section]
        } else {
            offices = arrayOfResulr[indexPath.section]
        }
        let img = offices.Logo
        let trimmedString = img.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        if let url = URL.init(string: trimmedString!) {
            cell.CompanyLogoImage.hnk_setImageFromURL(url, placeholder: #imageLiteral(resourceName: "officePlaceholder"))
        } else{
            print("nil")
            cell.CompanyLogoImage.image = #imageLiteral(resourceName: "officePlaceholder")
        }
        cell.OfficeName.setTitle(offices.ComapnyName, for: .normal)
        let lat = offices.Lat
        let lng = offices.Long
        let markerTarget = CLLocation(latitude: lat, longitude: lng)
        let distance : CLLocationDistance = markerTarget.distance(from: resultMyLocation2!)
        if targetMyLocation != nil {
            let newDistance: CLLocationDistance = markerTarget.distance(from: targetMyLocation!)
            if newDistance > 1000 {
                cell.NeerBeLabel.text = "يبعد عنك \(Int(newDistance/1000)) كيلو متر"
            }else{
                cell.NeerBeLabel.text = "يبعد عنك \(Int(newDistance)) متر"
            }
        }
        
        cell.AddressLabel.text = offices.Address
        if isCompany == "0" {
            cell.chooseBtnOut.setTitle("اختار المهندس", for: .normal)
        }else{
            cell.chooseBtnOut.setTitle("اختار المكتب", for: .normal)
        }
        
        print( offices.RateNumber)
        
        cell.Rate_Search.starsRating = Int(5 - offices.RateNumber)
        
        
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        let CustmoerId = UserDefaults.standard.string(forKey: "CustmoerId")
        if CustmoerId == nil
        {
            cell.AddresheightConstrain.constant = 0
            cell.CallBtn.isHidden = true
            cell.Locationbtn.isHidden = true
            cell.AddressLabel.isHidden = true
            
        }
        
        return cell
    }
    
    func GetOfficesByProvincesID(SortBy: String, SortExp: String){
        let sv = UIViewController.displaySpinner(onView: self.view)
        self.arrayOfResulr.removeAll()
        let Parameters: Parameters = [
            "isCompany": isCompany,
            "SortBy": SortBy,
            "SortExp": SortExp,
            "Rate":""
        ]
        print(Parameters)
        
        Alamofire.request("http://smusers.promit2030.co/api/ApiService/GetOffices", method: .get, parameters: Parameters, encoding: URLEncoding.default).responseJSON { response in
            debugPrint(response)
            
            for json in JSON(response.result.value!).arrayValue {
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
                requestProjectObj.ProjCount = json["ProjCount"].stringValue
                requestProjectObj.RateNumber = json["StarsCount"].double!
                if self.targetMyLocation != nil {
                    let myLocation = self.targetMyLocation!
                    self.arrayOfResulr = self.arrayOfResulr.sorted(by: { $0.distance(to: myLocation) < $1.distance(to: myLocation) })
                }
                self.arrayOfResulr.append(requestProjectObj)
            }
            
            if SortBy == "2" {
                self.resultsTableView.reloadData()
            } else {
                //                let myLocation = self.targetMyLocation!
                //                self.arrayOfResulr = self.arrayOfResulr.sorted(by: { $0.distance(to: myLocation) < $1.distance(to: myLocation) })
                self.resultsTableView.reloadData()
            }
            
            UIViewController.removeSpinner(spinner: sv)
        }
        
    }
    
    @IBAction func chooseBtn(_ sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: resultsTableView)
        var index = resultsTableView.indexPathForRow(at: point)?.section
        if index == nil
        {
            index = 0
        }
        let CustmoerId = UserDefaults.standard.string(forKey: "CustmoerId")
        if CustmoerId == nil
        {
            LoginVIew.isHidden = false
        }
        else
        {
            let storyBoard : UIStoryboard = UIStoryboard(name: "NewProject", bundle:nil)
            let secondView = storyBoard.instantiateViewController(withIdentifier: "NewProjectATableViewController") as! NewProjectATableViewController
            
            if isFiltering() {
                self.CompanyInfoID = self.filteredOffices[index!].CompanyInfoID
                self.CompanyName = self.filteredOffices[index!].ComapnyName
                self.CompanyAddress = self.filteredOffices[index!].Address
                self.CompanyImage = self.filteredOffices[index!].Logo
                self.branchId = self.filteredOffices[index!].BranchID
                secondView.CompanyInfoID = self.CompanyInfoID
                secondView.CompanyName = self.CompanyName
                secondView.CompanyAddress = self.CompanyAddress
                secondView.CompanyImage = self.CompanyImage
                secondView.BranchID = self.branchId
                secondView.EmpMobile = self.filteredOffices[index!].CompanyMobile
                secondView.IsCompany = self.filteredOffices[index!].IsCompany
                secondView.LatBranch = self.filteredOffices[index!].Lat
                secondView.LngBranch = self.filteredOffices[index!].Long
                secondView.ZoomBranch = self.filteredOffices[index!].Zoom
            }else{
                self.CompanyInfoID = self.arrayOfResulr[index!].CompanyInfoID
                self.CompanyName = self.arrayOfResulr[index!].ComapnyName
                self.CompanyAddress = self.arrayOfResulr[index!].Address
                self.CompanyImage = self.arrayOfResulr[index!].Logo
                self.branchId = self.arrayOfResulr[index!].BranchID
                secondView.CompanyInfoID = self.CompanyInfoID
                secondView.CompanyName = self.CompanyName
                secondView.CompanyAddress = self.CompanyAddress
                secondView.CompanyImage = self.CompanyImage
                secondView.BranchID = self.branchId
                secondView.EmpMobile = self.arrayOfResulr[index!].CompanyMobile
                secondView.IsCompany = self.arrayOfResulr[index!].IsCompany
                secondView.LatBranch = self.arrayOfResulr[index!].Lat
                secondView.LngBranch = self.arrayOfResulr[index!].Long
                secondView.ZoomBranch = self.arrayOfResulr[index!].Zoom
            }
            self.navigationController?.pushViewController(secondView, animated: true)
        }
        
        
        
    }
    
    // MARK: - Private instance methods
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        //        filteredOffices = arrayOfResulr.filter({( candy : GetOfficesArray) -> Bool in
        //            return candy.ComapnyName.lowercased().contains(searchText.lowercased())
        //        })
        SearchOfOfficesModel.SearchOffices(text: searchText, SortBy: "4", isCompany: isCompany, view: self.view) { (Results) in
            self.filteredOffices = Results
            self.resultsTableView.reloadData()
        }
    }
    
    @IBAction func CallMobile(_ sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: resultsTableView)
        let index = resultsTableView.indexPathForRow(at: point)?.section
        var mobile: String = ""
        if isFiltering() {
            mobile = (filteredOffices[index!].CompanyMobile)
        }else {
            mobile = (arrayOfResulr[index!].CompanyMobile)
        }
        
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
    
    @IBAction func goAboutBtn(_ sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: resultsTableView)
        var index = resultsTableView.indexPathForRow(at: point)?.section
        if index == nil
        {
            index = 0
        }
        let CustmoerId = UserDefaults.standard.string(forKey: "CustmoerId")
        if CustmoerId == nil
        {
            let storyBoard : UIStoryboard = UIStoryboard(name: "NewProject", bundle:nil)
            let secondView = storyBoard.instantiateViewController(withIdentifier: "DetailsOfOfficeTableViewControllerNot") as! DetailsOfOfficeTableViewControllerNot
            if isFiltering() {
                secondView.arrayOfResulr = self.filteredOffices
                secondView.index = index!
                secondView.CompanyInfoID = self.filteredOffices[index!].CompanyInfoID
                secondView.isCompany = self.isCompany
            }else {
                secondView.arrayOfResulr = self.arrayOfResulr
                secondView.index = index!
                secondView.CompanyInfoID = self.arrayOfResulr[index!].CompanyInfoID
                secondView.isCompany = self.isCompany
            }
            
            self.navigationController?.pushViewController(secondView, animated: true)
        }
        else
        {
            let storyBoard : UIStoryboard = UIStoryboard(name: "NewProject", bundle:nil)
            let secondView = storyBoard.instantiateViewController(withIdentifier: "DetailsOfOfficeTableViewController") as! DetailsOfOfficeTableViewController
            if isFiltering() {
                secondView.arrayOfResulr = self.filteredOffices
                secondView.index = index!
                secondView.CompanyInfoID = self.filteredOffices[index!].CompanyInfoID
                secondView.isCompany = self.isCompany
            }else {
                secondView.arrayOfResulr = self.arrayOfResulr
                secondView.index = index!
                secondView.CompanyInfoID = self.arrayOfResulr[index!].CompanyInfoID
                secondView.isCompany = self.isCompany
            }
            
            self.navigationController?.pushViewController(secondView, animated: true)
        }
        
        
        
    
    }
    
    @IBAction func directionBtn(_ sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: resultsTableView)
        let index = resultsTableView.indexPathForRow(at: point)?.section
        if isFiltering() {
            let dLati = filteredOffices[index!].Lat
            let dLang = filteredOffices[index!].Long
            self.LatBranch = dLati
            self.LngBranch = dLang
            if Helper.isDeviceiPad() {
                
                if let popoverController = AlertController.popoverPresentationController {
                    popoverController.sourceView = sender
                }
            }
            
            self.present(AlertController, animated: true, completion: nil)
           
        }else{
            let dLati = arrayOfResulr[index!].Lat
            let dLang = arrayOfResulr[index!].Long
            self.LatBranch = dLati
            self.LngBranch = dLang
            
            if Helper.isDeviceiPad() {
                
                if let popoverController = AlertController.popoverPresentationController {
                    popoverController.sourceView = sender
                }
            }
            
            self.present(AlertController, animated: true, completion: nil)
           
        }
        
    }
    func openMapsForLocation() {
        let dLati = self.LatBranch
        let dLang = self.LngBranch
        let location = CLLocation(latitude: dLati, longitude: dLang)
        print(location.coordinate)
        MKMapView.openMapsWith(location) { (error) in
            if error != nil {
                print("Could not open maps" + error!.localizedDescription)
            }
        }
    }
    func addBackBarButtonItem() { 
        let backButton = UIButton(type: .system)
        backButton.setImage(UIImage(named: "BackGray"), for: .normal)
        backButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        backButton.sizeToFit()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }
    
    @objc func backButtonPressed(){
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func backBtnAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
extension SearchByOfficeNameViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        // TODO
        filterContentForSearchText(searchController.searchBar.text!)
    }
}
