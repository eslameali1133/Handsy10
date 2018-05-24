//
//  NeerOfficesViewController.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 12/14/17.
//  Copyright © 2017 Ahmed Wahdan. All rights reserved.
//

import UIKit
import MapKit
import Alamofire
import SwiftyJSON
import GooglePlaces

protocol BarBtnDelegate {
    func BarBtnSortExpDidChange(SortExp: String, companyTypeName: String)
}

class NeerOfficesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var NeerOfficesTableView: UITableView!
    var presentDelegate: PresentDelegate?
    
    var isCompany = ""
    var arrayOfResulr = [GetOfficesArray]()
    var filteredOffices = [GetOfficesArray]()
    var CompanyInfoID = ""
    var CompanyName = ""
    var CompanyAddress = ""
    var CompanyImage = ""
    var branchId = ""
    var newPlace: GMSPlace?
    var SortExp: String?
    
    var targetMyLocation: CLLocation?
    var resultMyLocation2: CLLocation?
    
    @IBOutlet weak var OfficeListEmptyLabel: UILabel!
    
    @IBOutlet weak var dissmisBtnOut: UIButton!
    
    @IBOutlet weak var confirmBtn: UIButton!{
        didSet {
            DispatchQueue.main.async {
                self.confirmBtn.layer.cornerRadius = 7.0
                self.confirmBtn.layer.masksToBounds = true
            }
        }
    }
    
    @IBOutlet var PopUpViewOut: UIView!
    @IBOutlet weak var AlertImage: UIImageView!
    
    @IBOutlet weak var mapBtnOut: UIView!{
        didSet {
            DispatchQueue.main.async {
                self.mapBtnOut.layer.cornerRadius = self.mapBtnOut.frame.width/2
                self.mapBtnOut.layer.masksToBounds = true
            }
        }
    }
    
    @IBOutlet weak var filterByOfficeOut: UIButton!{
        didSet {
            DispatchQueue.main.async {
                self.filterByOfficeOut.layer.cornerRadius = 7.0
                self.filterByOfficeOut.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                self.filterByOfficeOut.layer.borderWidth = 1.0
                self.filterByOfficeOut.layer.masksToBounds = true
                
            }
        }
    }
    
    @IBOutlet weak var filterOfficeTypeOut: UIButton!{
        didSet {
            DispatchQueue.main.async {
                self.filterOfficeTypeOut.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
                self.filterOfficeTypeOut.layer.cornerRadius = 7.0
                self.filterOfficeTypeOut.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                self.filterOfficeTypeOut.layer.borderWidth = 1.0
                self.filterOfficeTypeOut.layer.masksToBounds = true
                
            }
        }
    }
    @IBOutlet weak var filterOfficeByNeerOut: UIButton!{
        didSet {
            DispatchQueue.main.async {
                self.filterOfficeByNeerOut.backgroundColor = #colorLiteral(red: 0.831372549, green: 0.6862745098, blue: 0.2117647059, alpha: 1)
                self.filterOfficeByNeerOut.layer.cornerRadius = 7.0
                self.filterOfficeByNeerOut.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
                self.filterOfficeByNeerOut.layer.borderWidth = 1.0
                self.filterOfficeByNeerOut.layer.masksToBounds = true
                
            }
        }
    }
    var resultsViewController: GMSAutocompleteResultsViewController?
    var searchController: UISearchController?
    var resultView: UITextView?
    var address = ""
    var radius: CLLocationDistance = 560.0
    
    @IBOutlet weak var resaultsLabel: UILabel!
    var resultsText = "نتائج البحث : "
    var resultsText1 = ""
    var resultsText2 = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addBackBarButtonItem()
        if SortExp == "-1" || SortExp == "" || SortExp == nil{
            DispatchQueue.main.async {
                self.filterOfficeTypeOut.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
                self.filterOfficeTypeOut.layer.cornerRadius = 7.0
                self.filterOfficeTypeOut.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                self.filterOfficeTypeOut.layer.borderWidth = 1.0
                self.filterOfficeTypeOut.layer.masksToBounds = true
            }
            resaultsLabel.text = resultsText + resultsText1 + ", " + resultsText2
        }else {
            DispatchQueue.main.async {
                self.filterOfficeTypeOut.backgroundColor = #colorLiteral(red: 0.831372549, green: 0.6862745098, blue: 0.2117647059, alpha: 1)
                self.filterOfficeTypeOut.layer.cornerRadius = 7.0
                self.filterOfficeTypeOut.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
                self.filterOfficeTypeOut.layer.borderWidth = 1.0
                self.filterOfficeTypeOut.layer.masksToBounds = true
            }
            resaultsLabel.text = resultsText + resultsText1 + ", " + resultsText2
        }
        title = "القائمة"
        if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = false
        } else {
            // Fallback on earlier versions
        }
        self.navigationItem.hidesBackButton = true
        PopUpViewOut.isHidden = true
        DispatchQueue.main.async {
            self.PopUpViewOut.frame = CGRect.init(x: 0, y: 0, width: 338, height: 165)
            self.PopUpViewOut.center = self.view.center
            self.view.addSubview(self.PopUpViewOut)
        }
        //        addBackBarButtonItem()
        //        addFilterBarButtonItem()
        OfficeListEmptyLabel.isHidden = true
        AlertImage.isHidden = true
        
        NeerOfficesTableView.delegate = self
        NeerOfficesTableView.dataSource = self
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        resultsViewController = GMSAutocompleteResultsViewController()
        resultsViewController?.delegate = self
        
        searchController = UISearchController(searchResultsController: resultsViewController)
        searchController?.searchResultsUpdater = resultsViewController
        
        // Put the search bar in the navigation bar.
        searchController?.searchBar.sizeToFit()
        searchController?.searchBar.barStyle = .default
        searchController?.searchBar.barTintColor = UIColor(red: 212/250.0, green: 175/250.0, blue: 52/250.0, alpha: 1.0)
        if isCompany == "0" {
            searchController?.searchBar.placeholder = "بحث عن المهندسين بالمدينة"
            filterByOfficeOut.setTitle("المهندس", for: .normal)
        } else {
            searchController?.searchBar.placeholder = "بحث عن المكاتب بالمدينة"
            filterByOfficeOut.setTitle("المكتب", for: .normal)
        }
        //        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: (searchController?.searchBar)!)
        if resultMyLocation2 != nil {
            if SortExp == "-1" || SortExp == "" || SortExp == nil{
                self.GetOfficesByProvincesID(SortBy: "1", SortExp: "", condition: radius, sorted: "1")
            }else {
                self.GetOfficesByProvincesID(SortBy: "3", SortExp: SortExp!, condition: radius, sorted: "1")
            }
            if address == "" {
                searchController?.searchBar.text = resultsText1
            }else {
                searchController?.searchBar.text = address
            }
            print("add: \(address)")
        } else {
            if SortExp == "-1" || SortExp == "" || SortExp == nil{
                let myLocation = targetMyLocation!
                arrayOfResulr = arrayOfResulr.sorted(by: { $0.distance(to: myLocation) < $1.distance(to: myLocation) })
            }else {
                self.GetOfficesByProvincesID(SortBy: "3", SortExp: SortExp!, condition: 0.0, sorted: "")
            }
        }
        self.navigationItem.titleView = self.searchController?.searchBar
     
        // When UISearchController presents the results view, present it in
        // this view controller, not one further up the chain.
        definesPresentationContext = true
        
        // Prevent the navigation bar from being hidden when searching.
        searchController?.hidesNavigationBarDuringPresentation = false
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if arrayOfResulr.count == 0 {
            if isCompany == "0" {
                //                navigationItem.title = "\(0) مهندس"
                //                title = "\(0) مهندس"
                OfficeListEmptyLabel.text = "لا يوجد مهندس في الموقع الذي تم اختياره"
            } else {
                //                navigationItem.title = "\(0) مكتب هندسي"
                //                title = "\(0) مكتب هندسي"
                OfficeListEmptyLabel.text = "لا يوجد مكاتب في الموقع الذي تم اختياره"
            }
            OfficeListEmptyLabel.isHidden = false
            AlertImage.isHidden = false
            NeerOfficesTableView.isHidden = true
        }else {
            if isCompany == "0" {
                //                navigationItem.title = "\(arrayOfResulr.count) مهندس"
                //                title = "\(arrayOfResulr.count) مهندس"
                OfficeListEmptyLabel.text = "لا يوجد مهندس في الموقع الذي تم اختياره"
            } else {
                //                navigationItem.title = "\(arrayOfResulr.count) مكتب هندسي"
                //                title = "\(arrayOfResulr.count) مكتب هندسي"
                OfficeListEmptyLabel.text = "لا يوجد مكاتب في الموقع الذي تم اختياره"
            }
            OfficeListEmptyLabel.isHidden = true
            AlertImage.isHidden = true
            NeerOfficesTableView.isHidden = false
        }
        return arrayOfResulr.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 115
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var offices = GetOfficesArray()
        let cell = NeerOfficesTableView.dequeueReusableCell(withIdentifier: "NeerOfficesTableViewCell", for: indexPath) as! NeerOfficesTableViewCell
        offices = arrayOfResulr[indexPath.section]
        let img = offices.Logo
        if let url = URL.init(string: img) {
            cell.CompanyLogoImage.hnk_setImageFromURL(url, placeholder: #imageLiteral(resourceName: "officePlaceholder"))
        } else{
            print("nil")
            cell.CompanyLogoImage.image = #imageLiteral(resourceName: "officePlaceholder")
        }
        cell.OfficeName.text = offices.ComapnyName
        let lat = offices.Lat
        let lng = offices.Long
        let markerTarget = CLLocation(latitude: lat, longitude: lng)
        let distance : CLLocationDistance = markerTarget.distance(from: resultMyLocation2!)
        let newDistance: CLLocationDistance = markerTarget.distance(from: targetMyLocation!)
        if newDistance > 1000 {
            cell.NeerBeLabel.text = "يبعد عنك \(Int(newDistance/1000)) كيلو متر"
        }else{
            cell.NeerBeLabel.text = "يبعد عنك \(Int(newDistance)) متر"
        }
        
        cell.AddressLabel.text = offices.Address
        if isCompany == "0" {
            cell.chooseBtnOut.setTitle("اختار المهندس", for: .normal)
        }else{
            cell.chooseBtnOut.setTitle("اختار المكتب", for: .normal)
        }
        
        
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        //        if isCompany == "0" {
        //            navigationItem.title = "\(indexPath.count) مهندس"
        //        } else {
        //            navigationItem.title = "\(indexPath.count) مكتب هندسي"
        //        }
        return cell
    }
    @IBAction func sortByNeerBtn(_ sender: UIButton) {
        searchController?.searchBar.text = ""
        self.SortExp = nil
        if filterOfficeByNeerOut.backgroundColor == #colorLiteral(red: 0.831372549, green: 0.6862745098, blue: 0.2117647059, alpha: 1) {
            self.filterOfficeByNeerOut.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
            self.filterOfficeByNeerOut.layer.cornerRadius = 7.0
            self.filterOfficeByNeerOut.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.filterOfficeByNeerOut.layer.borderWidth = 1.0
            self.filterOfficeByNeerOut.layer.masksToBounds = true
            GetOfficesByProvincesID(SortBy: "1", SortExp: "", condition: 0.0, sorted: "")
        }else {
            self.filterOfficeByNeerOut.backgroundColor = #colorLiteral(red: 0.831372549, green: 0.6862745098, blue: 0.2117647059, alpha: 1)
            self.filterOfficeByNeerOut.layer.cornerRadius = 7.0
            self.filterOfficeByNeerOut.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
            self.filterOfficeByNeerOut.layer.borderWidth = 1.0
            self.filterOfficeByNeerOut.layer.masksToBounds = true
            GetOfficesByProvincesID(SortBy: "1", SortExp: "", condition: 0.0, sorted: "1")
        }
        self.filterOfficeTypeOut.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        self.filterOfficeTypeOut.layer.cornerRadius = 7.0
        self.filterOfficeTypeOut.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.filterOfficeTypeOut.layer.borderWidth = 1.0
        self.filterOfficeTypeOut.layer.masksToBounds = true
    }
    
    func GetOfficesByProvincesID(SortBy: String, SortExp: String, condition: CLLocationDistance, sorted: String){
        let sv = UIViewController.displaySpinner(onView: self.view)
        self.arrayOfResulr.removeAll()
        let Parameters: Parameters = [
            "isCompany": isCompany,
            "SortBy": SortBy,
            "SortExp": SortExp
        ]
        
        Alamofire.request("http://smusers.promit2030.com/Service1.svc/GetOffices", method: .get, parameters: Parameters, encoding: URLEncoding.default).responseJSON { response in
            debugPrint(response)
            print("disd: \(condition)")
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
                let l = json["Lat"].doubleValue
                let lng = json["Long"].doubleValue
                
                if sorted == "" {
                    
                }else {
                    let myLocation = self.targetMyLocation!
                    self.arrayOfResulr = self.arrayOfResulr.sorted(by: { $0.distance(to: myLocation) < $1.distance(to: myLocation) })
                }
                if condition == 0.0 {
                    self.arrayOfResulr.append(requestProjectObj)
                }else {
                    let targetComp = CLLocation(latitude: l, longitude: lng)
                    let distance : CLLocationDistance = targetComp.distance(from: self.resultMyLocation2!)
                    if distance <= condition {
                        self.arrayOfResulr.append(requestProjectObj)
                    }else {
                        print("dist: \(distance)")
                    }
                }
                
            }
            
//            if SortBy == "2" {
//                self.NeerOfficesTableView.reloadData()
//            } else {
//                let myLocation = self.targetMyLocation!
//                self.arrayOfResulr = self.arrayOfResulr.sorted(by: { $0.distance(to: myLocation) < $1.distance(to: myLocation) })
//                self.NeerOfficesTableView.reloadData()
//            }
            self.NeerOfficesTableView.reloadData()

            
            UIViewController.removeSpinner(spinner: sv)
        }
        
    }
    
    @IBAction func backToMapBtn(_ sender: UIButton) {
        if newPlace != nil {
            self.presentDelegate?.mapValueDidChange(resultMyLocation2: resultMyLocation2!, distance: radius, address: address, newPlace: newPlace!, SortExp: SortExp ?? "", resultsText: resaultsLabel.text!)
            self.dismiss(animated: false, completion: nil)
        }else if SortExp != nil || SortExp != "-1" || SortExp != "" {
            if resultMyLocation2 != nil && newPlace != nil {
                self.presentDelegate?.mapValueDidChange(resultMyLocation2: resultMyLocation2!, distance: radius, address: address, newPlace: newPlace!, SortExp: SortExp!, resultsText: resaultsLabel.text!)
            }else {
                self.presentDelegate?.newMapValueDidChange(address: address, SortExp: SortExp ?? "", resultsText: resaultsLabel.text!)
            }
            self.dismiss(animated: false, completion: nil)
        }else {
            self.dismiss(animated: false, completion: nil)
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
        if newPlace != nil {
            self.presentDelegate?.mapValueDidChange(resultMyLocation2: resultMyLocation2!, distance: radius, address: address, newPlace: newPlace!, SortExp: SortExp ?? "", resultsText: resaultsLabel.text!)
            self.dismiss(animated: false, completion: nil)
        }else if SortExp != nil || SortExp != "-1" || SortExp != "" {
            if resultMyLocation2 != nil && newPlace != nil {
                self.presentDelegate?.mapValueDidChange(resultMyLocation2: resultMyLocation2!, distance: radius, address: address, newPlace: newPlace!, SortExp: SortExp!, resultsText: resaultsLabel.text!)
            }else {
                self.presentDelegate?.newMapValueDidChange(address: address, SortExp: SortExp ?? "", resultsText: resaultsLabel.text!)
            }
            self.dismiss(animated: false, completion: nil)
        }else {
            self.dismiss(animated: false, completion: nil)
        }
    }
    
    
    @IBAction func companySearchBtn(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "NewProject", bundle: nil)
        let NavController = storyboard.instantiateViewController(withIdentifier: "NavSearchOfOffice") as! UINavigationController
        let secondView = NavController.viewControllers.first as! SearchByOfficeNameViewController
        secondView.type = "0"
        secondView.arrayOfResulr = self.arrayOfResulr
        secondView.targetMyLocation = self.targetMyLocation
        secondView.resultMyLocation2 = self.resultMyLocation2
        secondView.isCompany = self.isCompany
        self.present(NavController, animated: true, completion: nil)
    }
    
    @IBAction func ExpBtnAction(_ sender: UIButton) {
        let dvc = self.storyboard!.instantiateViewController(withIdentifier: "FilterCompanyTypeTableViewController") as! FilterCompanyTypeTableViewController
        
        dvc.barBtnDelegate = self
        dvc.modalPresentationStyle = .popover
        dvc.popoverPresentationController?.sourceView = sender
        dvc.popoverPresentationController?.sourceRect = CGRect(x: sender.frame.midX-100, y: sender.frame.maxY, width: 0, height: 0)
        dvc.popoverPresentationController?.delegate = self
        dvc.preferredContentSize = CGSize(width: self.view.frame.width - 20, height: 309)
        dvc.popoverPresentationController?.permittedArrowDirections = [.up]
        
        self.present(dvc, animated: true, completion: nil)
    }
    
    //    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //        let storyBoard : UIStoryboard = UIStoryboard(name: "NewProject", bundle:nil)
    //        let secondView = storyBoard.instantiateViewController(withIdentifier: "NewProjectATableViewController") as! NewProjectATableViewController
    //        secondView.CompanyInfoID = self.offices.CompanyInfoID
    //        self.navigationController?.pushViewController(secondView, animated: true)
    //    }
    
    
    @IBAction func CallMobile(_ sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: NeerOfficesTableView)
        let index = NeerOfficesTableView.indexPathForRow(at: point)?.section
        var mobile: String = ""
        mobile = (arrayOfResulr[index!].CompanyMobile)
        
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
        let point = sender.convert(CGPoint.zero, to: NeerOfficesTableView)
        let index = NeerOfficesTableView.indexPathForRow(at: point)?.section
        let storyBoard : UIStoryboard = UIStoryboard(name: "NewProject", bundle:nil)
        let secondView = storyBoard.instantiateViewController(withIdentifier: "DetailsOfOfficeTableViewController") as! DetailsOfOfficeTableViewController
        secondView.arrayOfResulr = self.arrayOfResulr
        secondView.index = index!
        secondView.CompanyInfoID = self.arrayOfResulr[index!].CompanyInfoID
        secondView.isCompany = self.isCompany
        
        self.navigationController?.pushViewController(secondView, animated: true)
    }
    
    @IBAction func directionBtn(_ sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: NeerOfficesTableView)
        let index = NeerOfficesTableView.indexPathForRow(at: point)?.section
        let dLati = arrayOfResulr[index!].Lat
        let dLang = arrayOfResulr[index!].Long
        let location = CLLocation(latitude: dLati, longitude: dLang)
        print(location.coordinate)
        MKMapView.openMapsWith(location) { (error) in
            if error != nil {
                print("Could not open maps" + error!.localizedDescription)
            }
        }
        
    }
    
    
    @IBAction func dissmisBtn(_ sender: UIButton) {
        NeerOfficesTableView.isUserInteractionEnabled = true
        PopUpViewOut.isHidden = true
    }
    
    
    @IBAction func confirmChooseThisBtn(_ sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: NeerOfficesTableView)
        let index = NeerOfficesTableView.indexPathForRow(at: point)?.section
        let storyBoard : UIStoryboard = UIStoryboard(name: "NewProject", bundle:nil)
        let secondView = storyBoard.instantiateViewController(withIdentifier: "NewProjectATableViewController") as! NewProjectATableViewController
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
        
        self.navigationController?.pushViewController(secondView, animated: true)
    }
    
    
    @IBAction func chooseBtn(_ sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: NeerOfficesTableView)
        let index = NeerOfficesTableView.indexPathForRow(at: point)?.section
        self.CompanyInfoID = self.arrayOfResulr[index!].CompanyInfoID
        self.CompanyName = self.arrayOfResulr[index!].ComapnyName
        self.CompanyAddress = self.arrayOfResulr[index!].Address
        self.CompanyImage = self.arrayOfResulr[index!].Logo
        self.branchId = self.arrayOfResulr[index!].BranchID
        let storyBoard : UIStoryboard = UIStoryboard(name: "NewProject", bundle:nil)
        let secondView = storyBoard.instantiateViewController(withIdentifier: "NewProjectATableViewController") as! NewProjectATableViewController
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
        self.navigationController?.pushViewController(secondView, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NeerOfficesTableView.isUserInteractionEnabled = true
        PopUpViewOut.isHidden = true
    }
    
    
}

extension NeerOfficesViewController: BarBtnDelegate {
    func BarBtnSortExpDidChange(SortExp: String, companyTypeName: String) {
        if SortExp == "-1" || SortExp == "" {
            GetOfficesByProvincesID(SortBy: "1", SortExp: "", condition: radius, sorted: "1")
            self.filterOfficeTypeOut.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
            self.filterOfficeTypeOut.layer.cornerRadius = 7.0
            self.filterOfficeTypeOut.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.filterOfficeTypeOut.layer.borderWidth = 1.0
            self.filterOfficeTypeOut.layer.masksToBounds = true
            resultsText2 = companyTypeName
            resaultsLabel.text = resultsText + resultsText1 + ", " + resultsText2
        }else {
            GetOfficesByProvincesID(SortBy: "3", SortExp: SortExp, condition: radius, sorted: "1")
            self.filterOfficeTypeOut.backgroundColor = #colorLiteral(red: 0.831372549, green: 0.6862745098, blue: 0.2117647059, alpha: 1)
            self.filterOfficeTypeOut.layer.cornerRadius = 7.0
            self.filterOfficeTypeOut.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
            self.filterOfficeTypeOut.layer.borderWidth = 1.0
            self.filterOfficeTypeOut.layer.masksToBounds = true
            resultsText2 = companyTypeName
            resaultsLabel.text = resultsText + resultsText1 + ", " + resultsText2
        }
        self.SortExp = SortExp
    }
}

extension NeerOfficesViewController: GMSAutocompleteResultsViewControllerDelegate {
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController, didAutocompleteWith place: GMSPlace) {
        searchController?.isActive = false
        // Do something with the selected place.
        print("Place name: \(place.name)")
        print("Place address: \(place.formattedAddress ?? "")")
        print("Place attributions: \(place.attributions)")
        newPlace = place
        
        let g = place.viewport?.northEast
        let targ = CLLocation(latitude: (g?.latitude)!, longitude: (g?.longitude)!)
        let f = place.viewport?.southWest
        let tarf = CLLocation(latitude: (f?.latitude)!, longitude: (f?.longitude)!)
        radius = targ.distance(from: tarf)
        let distance : CLLocationDistance = targ.distance(from: tarf)
        resultMyLocation2 = CLLocation(latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
        if arrayOfResulr.count > 0 {
            arrayOfResulr.removeAll()
            if SortExp == "-1" || SortExp == "" || SortExp == nil{
                self.GetOfficesByProvincesID(SortBy: "1", SortExp: "", condition: distance, sorted: "1")
            }else {
                self.GetOfficesByProvincesID(SortBy: "3", SortExp: SortExp!, condition: distance, sorted: "1")
            }
        } else {
            if SortExp == "-1" || SortExp == "" || SortExp == nil{
                self.GetOfficesByProvincesID(SortBy: "1", SortExp: "", condition: distance, sorted: "1")
            }else {
                self.GetOfficesByProvincesID(SortBy: "3", SortExp: SortExp!, condition: distance, sorted: "1")
            }
        }
        address = place.formattedAddress!
        searchController?.searchBar.text = place.formattedAddress
        resultsText1 = place.name
        resaultsLabel.text = resultsText + resultsText1 + ", " + resultsText2
    }
    
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController, didFailAutocompleteWithError error: Error){
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
}

extension NeerOfficesViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}

