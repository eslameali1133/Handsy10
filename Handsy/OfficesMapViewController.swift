//
//  OfficesMapViewController.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 12/5/17.
//  Copyright © 2017 Ahmed Wahdan. All rights reserved.
//

import UIKit
import GooglePlaces
import Alamofire
import SwiftyJSON
import MapKit

protocol BarBtnMapDelegate {
    func BarBtnSortExpDidChange(SortExp: String, companyTypeName: String)
}
protocol PresentDelegate {
    func mapValueDidChange(resultMyLocation2: CLLocation, distance: CLLocationDistance, address: String, newPlace: GMSPlace, SortExp: String, resultsText: String)
    func newMapValueDidChange(address: String, SortExp: String, resultsText: String) 
}


class OfficesMapViewController: UIViewController, CLLocationManagerDelegate {
    let locationManager = CLLocationManager()
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var mapType: UIButton!{
        didSet {
            DispatchQueue.main.async {
                self.mapType.layer.shadowColor = UIColor.black.cgColor
                self.mapType.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
                self.mapType.layer.shadowRadius = 2.0
                self.mapType.layer.shadowOpacity = 0.5
                self.mapType.layer.borderColor = UIColor.black.cgColor
                self.mapType.layer.borderWidth = 0.5
                self.mapType.layer.cornerRadius = 7.0
                self.mapType.layer.masksToBounds = false
            }
        }
        
    }
    
    @IBOutlet weak var barOut: UIView!
    
    @IBOutlet weak var dissmisBtnOut: UIButton!
    @IBOutlet weak var confirmBtn: UIButton!{
        didSet {
            DispatchQueue.main.async {
                self.confirmBtn.layer.cornerRadius = 7.0
                self.confirmBtn.layer.masksToBounds = true
            }
        }
    }
    
    @IBOutlet weak var chooseBtnOut: UIButton!{
        didSet {
            DispatchQueue.main.async {
                self.chooseBtnOut.layer.cornerRadius = 7.0
                self.chooseBtnOut.layer.masksToBounds = true
            }
        }
    }
    @IBOutlet weak var listLabel: UILabel!
    @IBOutlet weak var listBtnOut: UIView!{
        didSet {
            DispatchQueue.main.async {
                self.listBtnOut.layer.cornerRadius = self.listBtnOut.frame.width/2
                self.listBtnOut.layer.masksToBounds = true
            }
        }
    }
    
    var resultsViewController: GMSAutocompleteResultsViewController?
    var searchController: UISearchController?
    var resultView: UITextView?
    var markerLoc = GMSMarker()
    var isCompany = ""
    var arrayOfResulr = [GetOfficesArray]()
    var indexi:Int?
    var address = ""
    //    var BiuldNum = ""
    //    var branchFB = ""
    //    var branchID = ""
    //    var branchName = ""
    //    var lat = ""
    //    var lang = ""
    //    var zoom = ""
    //    var compName = ""
    //    var commercialNum = ""
    //    var companyEmail = ""
    //    var companyMobile = ""
    //    var fax = ""
    //    var isSCE = ""
    //    var licenceNumber = ""
    //    var logo = ""
    
    @IBOutlet weak var myLocationBtnLabel: UIButton!
    
    @IBOutlet weak var listOfOfficesLabel: UIButton!
    
    @IBOutlet weak var PopUpView: UIView!
    @IBOutlet weak var CompanyLogoImage: AMCircleImageView!{
        didSet {
            DispatchQueue.main.async {
                self.CompanyLogoImage.layer.cornerRadius = 7.0
                self.CompanyLogoImage.layer.masksToBounds = true
                
            }
        }
    }
    @IBOutlet weak var CompanyNameLabel: UILabel!
    @IBOutlet weak var CallOutBtn: UIButton!{
        didSet {
            DispatchQueue.main.async {
                self.CallOutBtn.layer.cornerRadius = 7.0
                self.CallOutBtn.layer.masksToBounds = true
                
            }
        }
    }
    
    @IBOutlet weak var aboutCompanyBtnOut: UIButton!
    
    @IBOutlet weak var DetialsOfCompanyOut: UIButton!
    
    @IBOutlet weak var neerbeLabel: UILabel!
    
    var cirlce: GMSCircle!
    var targetMyLocation: CLLocation?
    var resultMyLocation2: CLLocation = CLLocation(latitude: 0.0, longitude: 0.0)
    var companyMobileLabel = ""
    
    @IBOutlet var PopUpViewOut: UIView!
    
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
    
    @IBOutlet weak var resaultsLabel: UILabel!
    var resultsText = "نتائج البحث : "
    var resultsText1 = ""
    var resultsText2 = ""
        
    override func viewDidLoad() {
        super.viewDidLoad()
        addBackBarButtonItem()
        if SortExp == "-1" || SortExp == "" || SortExp == nil{
            self.filterOfficeTypeOut.layer.cornerRadius = 7.0
            self.filterOfficeTypeOut.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.filterOfficeTypeOut.layer.borderWidth = 1.0
            self.filterOfficeTypeOut.layer.masksToBounds = true
        }else {
            self.filterOfficeTypeOut.backgroundColor = #colorLiteral(red: 0.831372549, green: 0.6862745098, blue: 0.2117647059, alpha: 1)
            self.filterOfficeTypeOut.layer.cornerRadius = 7.0
            self.filterOfficeTypeOut.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
            self.filterOfficeTypeOut.layer.borderWidth = 1.0
            self.filterOfficeTypeOut.layer.masksToBounds = true
        }
        title = "الخريطة" 
        if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = false
        } else {
            // Fallback on earlier versions
        }
        PopUpViewOut.isHidden = true
        DispatchQueue.main.async {
            self.PopUpViewOut.frame = CGRect.init(x: 0, y: 0, width: 338, height: 165)
            self.PopUpViewOut.center = self.view.center

            self.view.addSubview(self.PopUpViewOut)
        }
        self.CompanyLogoImage.layer.cornerRadius = 7.0
        print("isCo= \(isCompany)")
        if isCompany == "0" {
//            myLocationBtnLabel.setTitle("المهندسين بالقرب مني", for: .normal)
//            listOfOfficesLabel.setTitle("قائمة المهندسين", for: .normal)
            DetialsOfCompanyOut.setTitle("موقع المهندس", for: .normal)
            filterByOfficeOut.setTitle("المهندس", for: .normal)
            listLabel.text = "قائمة المهندسين"
//            OfficeBtnLabel.text = "صفحة المهندس"
            self.chooseBtnOut.setTitle("اختار المهندس", for: .normal)
        } else if isCompany == "1"{
//            myLocationBtnLabel.setTitle("المكاتب بالقرب مني", for: .normal)
//            listOfOfficesLabel.setTitle("قائمة المكاتب", for: .normal)
            DetialsOfCompanyOut.setTitle("موقع المكتب", for: .normal)
            filterByOfficeOut.setTitle("المكتب", for: .normal)
            listLabel.text = "قائمة المكاتب"
//            OfficeBtnLabel.text = "صفحة المكتب"
            self.chooseBtnOut.setTitle("اختار المكتب", for: .normal)
        }
        PopUpView.isHidden = true
        self.navigationItem.hidesBackButton = true
        mapView.delegate = self
        GetOfficesByProvincesID(SortBy: "1", SortExp: "")
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        //        mapView.delegate = self
        mapView.mapType = .terrain
        if mapView.mapType == .satellite {
            mapType.setImage(#imageLiteral(resourceName: "landscape-with-mountains"), for: .normal)
        }else {
            mapType.setImage(#imageLiteral(resourceName: "google-drive-image copy copy"), for: .normal)
        }
        // This makes the view area include the nav bar even though it is opaque.
        // Adjust the view placement down.
        self.extendedLayoutIncludesOpaqueBars = true
        self.edgesForExtendedLayout = .top
        
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
        } else {
            searchController?.searchBar.placeholder = "بحث عن المكاتب بالمدينة"
        }
        //        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: (searchController?.searchBar)!)
        self.navigationItem.titleView = self.searchController?.searchBar
//        if #available(iOS 11.0, *) {
//            self.navigationItem.searchController = searchController
//        } else {
//            // Fallback on earlier versions
//            self.navigationItem.titleView = self.searchController?.searchBar
//        }
        
        // When UISearchController presents the results view, present it in
        // this view controller, not one further up the chain.
        definesPresentationContext = true
        
        // Prevent the navigation bar from being hidden when searching.
        searchController?.hidesNavigationBarDuringPresentation = false
    }
    
    
    @IBAction func mapTypeAction(_ sender: UIButton) {
        if mapView.mapType == .satellite {
            mapType.setImage(#imageLiteral(resourceName: "google-drive-image copy copy"), for: .normal)
            mapView.mapType = .terrain
        }else {
            mapType.setImage(#imageLiteral(resourceName: "landscape-with-mountains"), for: .normal)
            mapView.mapType = .satellite
        }
    }
    
    
    func reverseGeocodeCoordinate(_ coordinate: CLLocationCoordinate2D) {
        
        // 1
        let geocoder = GMSGeocoder()
        
        // 2
        geocoder.reverseGeocodeCoordinate(coordinate) { response, error in
            if let address = response?.firstResult() {
                self.searchController?.searchBar.text = address.locality ?? self.resultsText1
                self.resultsText1 = address.locality ?? self.resultsText1
                self.resaultsLabel.text = self.resultsText + self.resultsText1 + ", " + self.resultsText2
                // 3
                let lines = address.lines!
                
                // 4
                UIView.animate(withDuration: 0.25) {
                    self.view.layoutIfNeeded()
                }
            }
        }
        
        // 1
        
        UIView.animate(withDuration: 0.25) {
            //2
            
            self.view.layoutIfNeeded()
        }
    }
    func GetOfficesByProvincesID(SortBy: String, SortExp: String){
        let sv = UIViewController.displaySpinner(onView: self.view)
        self.arrayOfResulr.removeAll()
        mapView.clear()
        let Parameters: Parameters = [
            "isCompany": isCompany,
            "SortBy": SortBy,
            "SortExp": SortExp
        ]
        var markersArray = [GMSMarker]()
        Alamofire.request("http://smusers.promit2030.com/Service1.svc/GetOffices", method: .get, parameters: Parameters, encoding: URLEncoding.default).responseJSON { response in
            debugPrint(response)
            
            var i = 0
            for json in JSON(response.result.value!).arrayValue {
                let requestProjectObj = GetOfficesArray()
                let markers = GMSMarker()
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
                let l = json["Lat"].doubleValue
                let lng = json["Long"].doubleValue
                let target = CLLocationCoordinate2D(latitude: l, longitude: lng)
                if self.radius == nil {
                    if l != 0.0 && lng != 0.0 {
                        markers.position = target
                        if self.isCompany == "0" {
                            markers.icon = #imageLiteral(resourceName: "EngMarkerIcon")
                        } else {
                            markers.icon = #imageLiteral(resourceName: "OfficeMarkerIcon")
                        }
                        markers.appearAnimation = .pop
                        markers.accessibilityLabel = "\(i)"
                        i+=1
                        markers.map = self.mapView
                        markersArray.append(markers)
                        self.arrayOfResulr.append(requestProjectObj)
                    }
                }else {
                    if l != 0.0 && lng != 0.0 {
                        let targetComp = CLLocation(latitude: l, longitude: lng)
                        let distance : CLLocationDistance = targetComp.distance(from: self.resultMyLocation2)
                        if distance <= self.radius! {
                            //                        print("ds: \(self.radius!)")
                            markers.position = target
                            if self.isCompany == "0" {
                                markers.icon = #imageLiteral(resourceName: "EngMarkerIcon")
                            } else {
                                markers.icon = #imageLiteral(resourceName: "OfficeMarkerIcon")
                            }
                            markers.appearAnimation = .pop
                            markers.accessibilityLabel = "\(i)"
                            i+=1
                            markers.map = self.mapView
                            markersArray.append(markers)
                            self.arrayOfResulr.append(requestProjectObj)
                        }else {
                            print("dist: \(distance)")
                        }
                    }
                    
                }
                
            }
            if self.radius == nil {
                
            }else {
                var bounds = GMSCoordinateBounds()
                for marker in markersArray
                {
                    bounds = bounds.includingCoordinate(marker.position)
                }
                let update = GMSCameraUpdate.fit(bounds, withPadding: 60)
                self.mapView.animate(with: update)
                self.cam = Double(self.mapView.camera.zoom)
                print("zoom: \(Double(self.mapView.camera.zoom))")
            }
            
            
            UIViewController.removeSpinner(spinner: sv)
        }
        
    }
    
    
    
    @IBAction func goCompanyDetialsBtn(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "NewProject", bundle:nil)
        let secondView = storyBoard.instantiateViewController(withIdentifier: "DetailsOfOfficeTableViewController") as! DetailsOfOfficeTableViewController
        secondView.arrayOfResulr = self.arrayOfResulr
        secondView.index = self.indexi
        secondView.isCompany = self.isCompany
        self.navigationController?.pushViewController(secondView, animated: true)
    }
    
    @IBAction func goListOfOfficesBtn(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "NewProject", bundle: nil)
        let NavController = storyboard.instantiateViewController(withIdentifier: "NeerViewNav") as! UINavigationController
        let secondView = NavController.viewControllers.first as! NeerOfficesViewController
        secondView.presentDelegate = self
        secondView.arrayOfResulr = self.arrayOfResulr
        secondView.targetMyLocation = self.targetMyLocation
        secondView.resultMyLocation2 = self.resultMyLocation2
        secondView.address = address
        secondView.radius = radius ?? 0.0
        secondView.isCompany = self.isCompany
        secondView.resultsText = resultsText
        secondView.resultsText1 = resultsText1
        secondView.resultsText2 = resultsText2
        if SortExp != nil {
            secondView.SortExp = self.SortExp!
        }else {
            secondView.SortExp = ""
        }
        
        self.present(NavController, animated: false, completion: nil)
    }
    
    @IBAction func endPopViewBtn(_ sender: UIButton) {
        PopUpView.isHidden = true
    }
    
    
    @IBAction func CallMe(_ sender: UIButton) {
        var mobile: String = (companyMobileLabel)
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
    
    @IBAction func directionsAction(_ sender: UIButton) {
        openMapsForLocation()
    }
    
    func openMapsForLocation() {
        let dLati = arrayOfResulr[indexi!].Lat
        let dLang = arrayOfResulr[indexi!].Long
        let location = CLLocation(latitude: dLati, longitude: dLang)
        print(location.coordinate)
        MKMapView.openMapsWith(location) { (error) in
            if error != nil {
                print("Could not open maps" + error!.localizedDescription)
            }
        }
    }
    @IBAction func companySearchBtn(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "NewProject", bundle: nil)
        let NavController = storyboard.instantiateViewController(withIdentifier: "NavSearchOfOffice") as! UINavigationController
        let secondView = NavController.viewControllers.first as! SearchByOfficeNameViewController
        secondView.type = "1"
        secondView.arrayOfResulr = self.arrayOfResulr
        secondView.targetMyLocation = self.targetMyLocation
        secondView.resultMyLocation2 = self.resultMyLocation2
        secondView.isCompany = self.isCompany
        self.present(NavController, animated: true, completion: nil)
    }
    
    @IBAction func ExpBtnAction(_ sender: UIButton) {
        let dvc = self.storyboard!.instantiateViewController(withIdentifier: "FilterCompanyTypeTableViewController") as! FilterCompanyTypeTableViewController
        
        dvc.barBtnMapDelegate = self
        dvc.modalPresentationStyle = .popover
        dvc.popoverPresentationController?.sourceView = sender
        dvc.popoverPresentationController?.sourceRect = CGRect(x: sender.frame.midX-100 , y: sender.frame.maxY, width: 0, height: 0)
        dvc.popoverPresentationController?.delegate = self
        dvc.preferredContentSize = CGSize(width: self.view.frame.width - 20, height: 309)
        dvc.popoverPresentationController?.permittedArrowDirections = [.up]
        
        self.present(dvc, animated: true, completion: nil)
    }
    
    @IBAction func myLocationBtn(_ sender: UIButton) {
        if filterOfficeByNeerOut.backgroundColor == #colorLiteral(red: 0.831372549, green: 0.6862745098, blue: 0.2117647059, alpha: 1) {
            self.filterOfficeByNeerOut.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
            self.filterOfficeByNeerOut.layer.cornerRadius = 7.0
            self.filterOfficeByNeerOut.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.filterOfficeByNeerOut.layer.borderWidth = 1.0
            self.filterOfficeByNeerOut.layer.masksToBounds = true
        } else {
            self.filterOfficeByNeerOut.backgroundColor = #colorLiteral(red: 0.831372549, green: 0.6862745098, blue: 0.2117647059, alpha: 1)
            self.filterOfficeByNeerOut.layer.cornerRadius = 7.0
            self.filterOfficeByNeerOut.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
            self.filterOfficeByNeerOut.layer.borderWidth = 1.0
            self.filterOfficeByNeerOut.layer.masksToBounds = true
        }
        gotoMyLocationAction(sender: sender)
    }
    
    func gotoMyLocationAction(sender: UIButton)
    {
        searchController?.searchBar.text = ""
        if arrayOfResulr.count != 0 {
            arrayOfResulr.removeAll()
        }
        mapView.clear()
        if SortExp == nil || SortExp == "-1" || SortExp == "" {
            GetOfficesByProvincesID(SortBy: "1", SortExp: "")
            self.filterOfficeTypeOut.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
            self.filterOfficeTypeOut.layer.cornerRadius = 7.0
            self.filterOfficeTypeOut.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.filterOfficeTypeOut.layer.borderWidth = 1.0
            self.filterOfficeTypeOut.layer.masksToBounds = true
        }else {
            GetOfficesByProvincesID(SortBy: "3", SortExp: SortExp!)
        }
        PopUpView.isHidden = true
        guard let lat = self.mapView.myLocation?.coordinate.latitude,
            let lng = self.mapView.myLocation?.coordinate.longitude else { return }
        resaultsLabel.text = resultsText + resultsText1 + ", " + resultsText2
        let camera = GMSCameraPosition.camera(withLatitude: lat ,longitude: lng , zoom: 12.0)
        self.mapView.animate(to: camera)
    }
    
    @IBAction func dissmisBtn(_ sender: UIButton) {
        PopUpViewOut.isHidden = true
        self.mapView.isUserInteractionEnabled = true
        self.barOut.isUserInteractionEnabled = true
        self.PopUpView.isUserInteractionEnabled = true
        self.searchController?.searchBar.isUserInteractionEnabled = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = false
        } else {
            // Fallback on earlier versions
        }
        PopUpViewOut.isHidden = true
        self.mapView.isUserInteractionEnabled = true
        self.barOut.isUserInteractionEnabled = true
        self.PopUpView.isUserInteractionEnabled = true
        self.searchController?.searchBar.isUserInteractionEnabled = true
        
    }
    
    @IBAction func confirmChooseThisBtn(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "NewProject", bundle:nil)
        let secondView = storyBoard.instantiateViewController(withIdentifier: "NewProjectATableViewController") as! NewProjectATableViewController
        secondView.CompanyInfoID = self.arrayOfResulr[indexi!].CompanyInfoID
        secondView.CompanyName = self.arrayOfResulr[indexi!].ComapnyName
        secondView.CompanyImage = self.arrayOfResulr[indexi!].Logo
        secondView.CompanyAddress = self.arrayOfResulr[indexi!].Address
        secondView.BranchID = self.arrayOfResulr[indexi!].BranchID
        secondView.EmpMobile = self.arrayOfResulr[indexi!].CompanyMobile
        secondView.IsCompany = self.arrayOfResulr[indexi!].IsCompany
        secondView.LatBranch = self.arrayOfResulr[indexi!].Lat
        secondView.LngBranch = self.arrayOfResulr[indexi!].Long
        secondView.ZoomBranch = self.arrayOfResulr[indexi!].Zoom
        self.navigationController?.pushViewController(secondView, animated: true)
    }
    
    @IBAction func ChooseThisBtn(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "NewProject", bundle:nil)
        let secondView = storyBoard.instantiateViewController(withIdentifier: "NewProjectATableViewController") as! NewProjectATableViewController
        secondView.CompanyInfoID = self.arrayOfResulr[indexi!].CompanyInfoID
        secondView.CompanyName = self.arrayOfResulr[indexi!].ComapnyName
        secondView.CompanyImage = self.arrayOfResulr[indexi!].Logo
        secondView.CompanyAddress = self.arrayOfResulr[indexi!].Address
        secondView.BranchID = self.arrayOfResulr[indexi!].BranchID
        secondView.EmpMobile = self.arrayOfResulr[indexi!].CompanyMobile
        secondView.IsCompany = self.arrayOfResulr[indexi!].IsCompany
        secondView.LatBranch = self.arrayOfResulr[indexi!].Lat
        secondView.LngBranch = self.arrayOfResulr[indexi!].Long
        secondView.ZoomBranch = self.arrayOfResulr[indexi!].Zoom
        self.navigationController?.pushViewController(secondView, animated: true)
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
        self.navigationController!.popViewController(animated: true)
    }
    var cam = 17.0
    var radius: CLLocationDistance?
    var SortExp: String?
}

// Handle the user's selection.
extension OfficesMapViewController: GMSAutocompleteResultsViewControllerDelegate, GMSMapViewDelegate {
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        let index:Int! = Int(marker.accessibilityLabel!)
        let camera = GMSCameraPosition.camera(withTarget: marker.position, zoom: Float(cam))
        self.mapView.animate(to: camera)
        indexi = index
        
        if marker == markerLoc {
            
        }else {
            let lat = marker.position.latitude
            let lng = marker.position.longitude
            let markerTarget = CLLocation(latitude: lat, longitude: lng)
            let distance : CLLocationDistance = markerTarget.distance(from: targetMyLocation!)
            if distance >= 1000 {
                neerbeLabel.text = "يبعد عنك \(Int(distance/1000)) كيلو متر"
            }else {
                neerbeLabel.text = "يبعد عنك \(Int(distance)) متر"
            }
            print("distance = \(Double(distance)) m")
            print("arrc: \(arrayOfResulr.count)")
            if arrayOfResulr.count > index {
                CompanyNameLabel.text = arrayOfResulr[index].ComapnyName
                companyMobileLabel = arrayOfResulr[index].CompanyMobile
                let img = arrayOfResulr[index].Logo
                if let url = URL.init(string: img) {
                    CompanyLogoImage.hnk_setImageFromURL(url, placeholder: #imageLiteral(resourceName: "officePlaceholder"))
                } else{
                    print("nil")
                    CompanyLogoImage.image = #imageLiteral(resourceName: "officePlaceholder")
                }
            }else {
                let ind = (index - arrayOfResulr.count)+1
                CompanyNameLabel.text = arrayOfResulr[index-ind].ComapnyName
                companyMobileLabel = arrayOfResulr[index-ind].CompanyMobile
                let img = arrayOfResulr[index-ind].Logo
                if let url = URL.init(string: img) {
                    CompanyLogoImage.hnk_setImageFromURL(url, placeholder: #imageLiteral(resourceName: "officePlaceholder"))
                } else{
                    print("nil")
                    CompanyLogoImage.image = #imageLiteral(resourceName: "officePlaceholder")
                }
            }
           
            // remove color from currently selected marker
            if let selectedMarker = mapView.selectedMarker {
                if self.isCompany == "0" {
                    selectedMarker.icon = #imageLiteral(resourceName: "EngMarkerIcon")
                } else {
                    selectedMarker.icon = #imageLiteral(resourceName: "OfficeMarkerIcon")
                }
                selectedMarker.appearAnimation = .pop
                cirlce.map = nil
            } else {
            }
            // select new marker and make green
            mapView.selectedMarker = marker
            if self.isCompany == "0" {
                marker.icon = #imageLiteral(resourceName: "EngMarkerIconGreen")
            } else {
                marker.icon = #imageLiteral(resourceName: "OfficeMarkerIconGreen")
            }
            marker.appearAnimation = .pop
            if camera.zoom <= 10 {
                print("zoom: \(camera.zoom)")
                cirlce = GMSCircle(position: (mapView.selectedMarker?.position)!, radius: (8000))
            }else if camera.zoom <= 12 {
                print("zoom: \(camera.zoom)")
                cirlce = GMSCircle(position: (mapView.selectedMarker?.position)!, radius: (5000))
            } else {
                print("zoom: \(camera.zoom)")
                cirlce = GMSCircle(position: (mapView.selectedMarker?.position)!, radius: (100))
            }
            
            cirlce.fillColor = UIColor.green.withAlphaComponent(0.2)
            cirlce.strokeColor = UIColor.green.withAlphaComponent(0.3)
            cirlce.strokeWidth = 1
            cirlce.map = mapView
            PopUpView.isHidden = false
        }
        return true
    }
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        if arrayOfResulr.count != 0 {
            arrayOfResulr.removeAll()
        }
        mapView.clear()
        if SortExp == nil || SortExp == "-1" || SortExp == "" {
            GetOfficesByProvincesID(SortBy: "1", SortExp: "")
        }else {
            GetOfficesByProvincesID(SortBy: "3", SortExp: SortExp!)
        }
        PopUpView.isHidden = true
        print(#function)
    }
    
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        reverseGeocodeCoordinate(position.target)
        resultMyLocation2 = CLLocation(latitude: position.target.latitude, longitude: position.target.longitude)
    }
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController, didAutocompleteWith place: GMSPlace) {
        searchController?.isActive = false
        // Do something with the selected place.
        print("Place name: \(place.name)")
//        print("Place address: \(place.formattedAddress ?? "default")")
        address = place.formattedAddress!
//        print("Place attributions: \(place.attributions)")
        print("kldhskjdhksdhkjdhsjdk: \(place.coordinate)")
//        markerLoc.title = place.name
//        markerLoc.position = place.coordinate
//        markerLoc.map = self.mapView
        let g = place.viewport?.northEast
        let targ = CLLocation(latitude: (g?.latitude)!, longitude: (g?.longitude)!)
        let f = place.viewport?.southWest
        let tarf = CLLocation(latitude: (f?.latitude)!, longitude: (f?.longitude)!)
        radius = targ.distance(from: tarf)
//        let distance : GMSCoordinateBounds = GMSCoordinateBounds(coordinate: g!, coordinate: f!)
//        let camera = mapView.camera(for: distance, insets: UIEdgeInsets())!
//        cam = Double(camera.zoom)
//        mapView.camera = camera
//        map(l: place.coordinate.latitude, lng: place.coordinate.longitude, Z: 17.0, title: place.formattedAddress!)
        resultMyLocation2 = CLLocation(latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
        if arrayOfResulr.count > 0 {
            arrayOfResulr.removeAll()
        }
        if SortExp == nil || SortExp == "-1" || SortExp == "" {
            GetOfficesByProvincesID(SortBy: "1", SortExp: "")
        }else {
            GetOfficesByProvincesID(SortBy: "3", SortExp: SortExp!)
        }
        PopUpView.isHidden = true
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
    func map(l: Double, lng: Double, Z: Float, title: String) {
        print("\(Z)" + "zoom")
        let target = CLLocationCoordinate2D(latitude: l, longitude: lng)
        mapView.animate(toLocation: target)
        //        mapView.camera = GMSCameraPosition.camera(withTarget: target
        //            , zoom: Z)
        mapView.delegate = self
        mapView.isMyLocationEnabled = true
        var zooml = Z
        if zooml == 0.0 {
            zooml = 12
            mapView.animate(toZoom: zooml)
        }else {
            mapView.animate(toZoom: Z)
        }
        //        marker.position = target
        //        marker.title = title
        //        marker.map = mapView
        
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        // Here you verify the user has granted you permission while the app is in use.
        
        if status == .authorizedWhenInUse {
            
            // Once permissions have been established, ask the location manager for updates on the user’s location.
            
            locationManager.startUpdatingLocation()
            
            // GMSMapView has two features concerning the user’s location: myLocationEnabled draws a light blue dot where the user is located, while myLocationButton, when set to true, adds a button to the map that, when tapped, centers the map on the user’s location.
            
            mapView.isMyLocationEnabled = true
            mapView.settings.myLocationButton = true
            mapView.settings.zoomGestures = true
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            
            // This updates the map’s camera to center around the user’s current location. The GMSCameraPosition class aggregates all camera position parameters and passes them to the map for display.
            let lat = location.coordinate.latitude
            let lng = location.coordinate.longitude
            targetMyLocation = CLLocation(latitude: lat, longitude: lng)
            mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 12.0, bearing: 0, viewingAngle: 0)
            
            // Tell locationManager you’re no longer interested in updates; you don’t want to follow a user around as their initial location is enough for you to work with.
            
            // Create marker and set location
            locationManager.stopUpdatingLocation()
        }
    }
}

extension OfficesMapViewController: BarBtnMapDelegate {
    func BarBtnSortExpDidChange(SortExp: String, companyTypeName: String) {
        mapView.clear()
        if SortExp == nil || SortExp == "-1" || SortExp == "" {
            GetOfficesByProvincesID(SortBy: "1", SortExp: "")
            self.filterOfficeTypeOut.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
            self.filterOfficeTypeOut.layer.cornerRadius = 7.0
            self.filterOfficeTypeOut.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.filterOfficeTypeOut.layer.borderWidth = 1.0
            self.filterOfficeTypeOut.layer.masksToBounds = true
            resultsText2 = companyTypeName
            resaultsLabel.text = resultsText + resultsText1 + ", " + resultsText2
        }else {
            GetOfficesByProvincesID(SortBy: "3", SortExp: SortExp)
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

extension OfficesMapViewController: PresentDelegate {
    func mapValueDidChange(resultMyLocation2: CLLocation, distance: CLLocationDistance, address: String, newPlace: GMSPlace, SortExp: String, resultsText: String) {
        searchController?.searchBar.text = address
        self.resultMyLocation2 = resultMyLocation2
        self.address = address
        let g = newPlace.viewport?.northEast
        let targ = CLLocation(latitude: (g?.latitude)!, longitude: (g?.longitude)!)
        let f = newPlace.viewport?.southWest
        let tarf = CLLocation(latitude: (f?.latitude)!, longitude: (f?.longitude)!)
        radius = targ.distance(from: tarf)
//        let distance : GMSCoordinateBounds = GMSCoordinateBounds(coordinate: g!, coordinate: f!)
        mapView.clear()
        if SortExp == nil || SortExp == "-1" || SortExp == "" {
            GetOfficesByProvincesID(SortBy: "1", SortExp: "")
        }else {
            GetOfficesByProvincesID(SortBy: "3", SortExp: SortExp)
        }
        resaultsLabel.text = resultsText
        PopUpView.isHidden = true
    }
    func newMapValueDidChange(address: String, SortExp: String, resultsText: String) {
        self.address = address
        mapView.clear()
        if SortExp == nil || SortExp == "-1" || SortExp == "" {
            GetOfficesByProvincesID(SortBy: "1", SortExp: "")
        }else {
            GetOfficesByProvincesID(SortBy: "3", SortExp: SortExp)
            self.filterOfficeTypeOut.backgroundColor = #colorLiteral(red: 0.831372549, green: 0.6862745098, blue: 0.2117647059, alpha: 1)
            self.filterOfficeTypeOut.layer.cornerRadius = 7.0
            self.filterOfficeTypeOut.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
            self.filterOfficeTypeOut.layer.borderWidth = 1.0
            self.filterOfficeTypeOut.layer.masksToBounds = true
        }
        resaultsLabel.text = resultsText
    }
}

extension OfficesMapViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}


class Place {
    var latitude: CLLocationDegrees = 0.0
    var longitude: CLLocationDegrees = 0.0
    
    var location: CLLocation {
        return CLLocation(latitude: self.latitude, longitude: self.longitude)
    }
    
    func distance(to location: CLLocation) -> CLLocationDistance {
        return location.distance(from: self.location)
    }
}
