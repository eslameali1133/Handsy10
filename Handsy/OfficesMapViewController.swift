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
    func BarBtnSortExpDidChange(SortExp: String, companyTypeName: String , RateNumber: String)
}
protocol PresentDelegate {
    func mapValueDidChange(resultMyLocation2: CLLocation, distance: CLLocationDistance, address: String, newPlace: GMSPlace, SortExp: String, resultsText: String,Rate: String,IsNear: Bool,IsSearch: Bool ,R1:String,R2:String)
    
    func newMapValueDidChange(address: String, SortExp: String, resultsText: String, Rate: String,IsNear: Bool,IsSearch: Bool,R1:String,R2:String)
}


class OfficesMapViewController: UIViewController, CLLocationManagerDelegate {
    let locationManager = CLLocationManager()
    
    @IBOutlet var LoginVIew: UIView!
    
    @IBOutlet weak var GtoLogin: UIButton!
    @IBAction func GtoLoginBtn(_ sender: Any) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "NewLogin", bundle:nil)
        let secondView = storyBoard.instantiateViewController(withIdentifier: "NewLoginViewController") as! NewLoginViewController
        secondView.isComingFromProject = true
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
    
    @IBAction func EndLoginView(_ sender: Any) {
        LoginVIew.isHidden = true
    }
    @IBOutlet weak var lbl_Rate: UILabel!
//    @IBOutlet weak var lbl_City: UILabel!
    @IBOutlet weak var lbl_Type: UILabel!
    @IBOutlet weak var lbl_Near: UILabel!
    
    @IBOutlet weak var StaliteImage: UIImageView!
    
    
    @IBAction func HideBarBtn(_ sender: Any) {
        
         if filterByOfficeOut.isHidden == true
         {
             filterByOfficeOut.isHidden = false
            filterOfficeByNeerOut.isHidden = true
            
        }else
         {
        filterByOfficeOut.isHidden = true
             filterOfficeByNeerOut.isHidden = false
            
        }
        
    }
    @IBOutlet weak var HideBtn: UIButton! {
        didSet{
            HideBtn.layer.cornerRadius = self.HideBtn.frame.width / 2
        }
    }
    
    
    @IBOutlet weak var SearchNameView: UIView!
        {
        didSet{
            SearchNameView.layer.cornerRadius = 7
        }
    }
    
    @IBOutlet weak var Btn_Search: UIButton! {
        didSet{
            Btn_Search.layer.cornerRadius = 7
        }
    }
    
    
    @IBOutlet weak var mapView: GMSMapView!
    
    
    
    @IBOutlet weak var MYnewLoction: UIButton!{
        didSet {
            DispatchQueue.main.async {
//                self.MYnewLoction.layer.shadowColor = UIColor.black.cgColor
//                self.MYnewLoction.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
//                self.MYnewLoction.layer.shadowRadius = 2.0
//                self.MYnewLoction.layer.shadowOpacity = 0.5
//                //                self.mapType.layer.borderColor = UIColor.black.cgColor
//                //                self.mapType.layer.borderWidth = 0.5ZZZ
//                self.MYnewLoction.layer.cornerRadius = self.mapType.frame.width / 2
//                self.MYnewLoction.layer.masksToBounds = false
            }
        }
        
    }
    
    @IBOutlet weak var mapType: UIButton!{
        didSet {
            DispatchQueue.main.async {
//                self.mapType.layer.shadowColor = UIColor.black.cgColor
//                self.mapType.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
//                self.mapType.layer.shadowRadius = 2.0
//                self.mapType.layer.shadowOpacity = 0.5
//                self.mapType.layer.borderColor = UIColor.black.cgColor
//                self.mapType.layer.borderWidth = 0.5
//                self.mapType.layer.cornerRadius = self.mapType.frame.width / 2
//                self.mapType.layer.masksToBounds = false
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
    
    @IBOutlet weak var popup_CompanyName: UILabel!
    @IBOutlet weak var Rate_PopUp: RatingController!
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
    var rate_StarValue = ""
     var Exp_sort = ""
    var Rate_Sent = ""
    var Res_Sent = ""
    var companyNameT = ""
    var IsRsearch = false
    var IsNear = true
    var distanceSend = 0.0
    var searchtext = ""
    var latsearchvalue = 0.0
    var lngsearchvalue = 0.0
   var  currentlat =  0.0
    var currentlng =  0.0
    var LatBranch: Double = 0.0
    var LngBranch: Double = 0.0

    var AlertController: UIAlertController!
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
    
    @IBAction func FilterRate(_ sender: Any) {
        let dvc = self.storyboard!.instantiateViewController(withIdentifier: "FilterByRateVc") as! FilterByRateVc
        PopUpView.isHidden = true
       
        dvc.barBtnMapDelegate = self
          dvc.rateSelected = rate_StarValue
dvc.Expsort = Exp_sort
       dvc.CompanyName = companyNameT
        self.present(dvc, animated: true, completion: nil)
        
    }
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
    
    @IBOutlet weak var filterByOfficeOut: UIView!{
        didSet {
            DispatchQueue.main.async {
                self.filterByOfficeOut.layer.cornerRadius = 7.0
                self.filterByOfficeOut.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                self.filterByOfficeOut.layer.borderWidth = 1.0
                self.filterByOfficeOut.layer.masksToBounds = true
                
            }
        }
    }
    
    @IBOutlet weak var FilterbyRate: UIView!{
        didSet {
            DispatchQueue.main.async {
                self.FilterbyRate.layer.cornerRadius = 7.0
                self.FilterbyRate.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                self.FilterbyRate.layer.borderWidth = 1.0
                self.FilterbyRate.layer.masksToBounds = true
                
            }
        }
    }
    @IBOutlet weak var filterOfficeTypeOut: UIView!{
        didSet {
            DispatchQueue.main.async {
                self.filterOfficeTypeOut.layer.cornerRadius = 7.0
                self.filterOfficeTypeOut.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                self.filterOfficeTypeOut.layer.borderWidth = 1.0
                self.filterOfficeTypeOut.layer.masksToBounds = true
                
            }
        }
    }
    @IBOutlet weak var filterOfficeByNeerOut: UIView!{
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
    var conditionCount = 0
    
  @IBAction func gotoMyLocationActionbtncus(sender: UIButton)
    {
        guard let lat = self.mapView.myLocation?.coordinate.latitude,
            let lng = self.mapView.myLocation?.coordinate.longitude else { return }
        
        let camera = GMSCameraPosition.camera(withLatitude: lat ,longitude: lng , zoom: 12)
        self.mapView.animate(to: camera)
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
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
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
        
        
        LoginVIew.isHidden = true
        self.LoginVIew.frame = CGRect.init(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        self.LoginVIew.center = self.view.center
        self.view.addSubview(self.LoginVIew)
        
        HideBtn.isHidden = true
        
//        if self.view.frame.width == 375
//        {
//             HideBtn.isHidden = false
//        filterByOfficeOut.isHidden = true
//        }
//        
        addBackBarButtonItem()
        addFilterOfficeTypeOut()
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
//            filterByOfficeOut.setTitle("القائمه", for: .normal)
            listLabel.text = "ابحث باسم المهندس"
//            OfficeBtnLabel.text = "صفحة المهندس"
            self.chooseBtnOut.setTitle("اختار المهندس", for: .normal)
        } else if isCompany == "1"{
//            myLocationBtnLabel.setTitle("المكاتب بالقرب مني", for: .normal)
//            listOfOfficesLabel.setTitle("قائمة المكاتب", for: .normal)
            DetialsOfCompanyOut.setTitle("موقع المكتب", for: .normal)
//            filterByOfficeOut.setTitle("القائمه", for: .normal)
            listLabel.text = "ابحث باسم المكتب"
//            OfficeBtnLabel.text = "صفحة المكتب"
            self.chooseBtnOut.setTitle("اختار المكتب", for: .normal)
        }
        PopUpView.isHidden = true
        self.navigationItem.hidesBackButton = true
        self.locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
        GetOfficesByProvincesID(SortBy: "1", SortExp: "", Rate: "")
        
        mapView.delegate = self
        mapView.mapType = .terrain
        
       
        
        
        mapView.isMyLocationEnabled = true
//     mapView.settings.myLocationButton = true
      
        mapView.padding = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 10)
        
        if mapView.mapType == .satellite {
            StaliteImage.image = #imageLiteral(resourceName: "Group_1404")
//            mapType.setImage(#imageLiteral(resourceName: "Group_1404"), for: .normal)
        }else {
            StaliteImage.image = #imageLiteral(resourceName: "Group_1404-1")
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
        
        let CustmoerId = UserDefaults.standard.string(forKey: "CustmoerId")
        if CustmoerId == nil
        {
//           chooseBtnOut.isHidden = true
            popup_CompanyName.isHidden = true
            CallOutBtn.isHidden = true
            DetialsOfCompanyOut.isHidden = true
            addressheightCOns.constant = 0
            pop_heightCons.constant =   CGFloat(178 - 22)
          constrin_TopChose.constant = -55
        }
        // map
       
    }
    
    
//    func openMapsForLocationgoogle(Lat: Double, Lng: Double) {
//        let location = CLLocation(latitude: Lat, longitude: Lng)
//        if UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!) {
//            UIApplication.shared.open(URL(string: "comgooglemaps://?center=\(Lat),\(Lng)&zoom=14&views=traffic&q=\(Lat),\(Lng)")!, options: [:], completionHandler: nil)
//        }
//        else {
//            print("Can't use comgooglemaps://")
//            UIApplication.shared.open(URL(string: "http://maps.google.com/maps?q=\(Lat),\(Lng)&zoom=14&views=traffic")!, options: [:], completionHandler: nil)
//        }
//    }
//
    @IBOutlet weak var constrin_TopChose: NSLayoutConstraint!
    @IBOutlet weak var addressheightCOns: NSLayoutConstraint!
    @IBOutlet weak var pop_heightCons: NSLayoutConstraint!
    
//    func popUpLocation() {
//        if let conditionCount = UserDefaults.standard.string(forKey: "conditionCount"){
//            if conditionCount == "0" {
//                let alertAction = UIAlertController(title: "تفعيل الموقع", message: "اضغط موافقة لتتمكن من رؤية المكاتب والمهندسين على الخريطة والاختيار", preferredStyle: .alert)
//
//                alertAction.addAction(UIAlertAction(title: "موافقة", style: .default, handler: { action in
//                    UserDefaults.standard.set("1", forKey: "conditionCount")
//                }))
//
//                alertAction.addAction(UIAlertAction(title: "رجوع", style: .cancel, handler: { action in
//                    self.navigationController!.popViewController(animated: true)
//                }))
//                self.present(alertAction, animated: true, completion: nil)
//            }else{
//                self.locationManager.delegate = self
//                self.locationManager.requestWhenInUseAuthorization()
//            }
//        }else {
//            if conditionCount == 0 {
//                let alertAction = UIAlertController(title: "تفعيل الموقع", message: "اضغط موافقة لتتمكن من رؤية المكاتب والمهندسين على الخريطة والاختيار", preferredStyle: .alert)
//
//                alertAction.addAction(UIAlertAction(title: "موافقة", style: .default, handler: { action in
//                    UserDefaults.standard.set("1", forKey: "conditionCount")
//                    self.locationManager.delegate = self
//                    self.locationManager.requestWhenInUseAuthorization()
//                }))
//
//                alertAction.addAction(UIAlertAction(title: "رجوع", style: .cancel, handler: { action in
//                    self.navigationController!.popViewController(animated: true)
//                }))
//                self.present(alertAction, animated: true, completion: nil)
//            }
//        }
//
//    }
    
    func addFilterOfficeTypeOut() {
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
    }
    
    @IBAction func mapTypeAction(_ sender: UIButton) {
        if mapView.mapType == .satellite {
//            mapType.setImage(, for: .normal)
              StaliteImage.image = #imageLiteral(resourceName: "Group_1404-1")
            mapView.mapType = .terrain
        }else {
//            mapType.setImage(#imageLiteral(resourceName: "Group_1404"), for: .normal)
             StaliteImage.image = #imageLiteral(resourceName: "Group_1404")
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
//                self.resultsText1 = ""
         
                self.resaultsLabel.text = self.resultsText + self.resultsText1 + ", " + self.resultsText2 + "عدد المكاتب " +  "\(self.arrayOfResulr.count)"
                // 3
                let lines = address.lines!
                
                // 4
                UIView.animate(withDuration: 0.25) {
                    self.view.layoutIfNeeded()
                }
            }else {
                self.searchController?.searchBar.text = ""
                //                self.resultsText1 = address.locality ?? self.resultsText1
                self.resultsText1 = ""
                self.resaultsLabel.text = self.resultsText + self.resultsText1 + ", " + self.resultsText2 + "عدد المكاتب " +  "\(self.arrayOfResulr.count)"
            }
        }
        
        // 1
        
        UIView.animate(withDuration: 0.25) {
            //2
            
            self.view.layoutIfNeeded()
        }
    }
    func imageWithImage(image:UIImage, scaledToSize newSize:CGSize) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
    func GetOfficesByProvincesID(SortBy: String, SortExp: String,Rate: String){
        let sv = UIViewController.displaySpinner(onView: self.view)
        self.arrayOfResulr.removeAll()
        mapView.clear()
//        mapView.settings.myLocationButton = true
        let Parameters: Parameters = [
            "isCompany": isCompany,
            "SortBy": SortBy,
            "SortExp": SortExp,
            "Rate": Rate
        ]
        print(Parameters)
        var markersArray = [GMSMarker]()
        Alamofire.request("http://smusers.promit2030.co/api/ApiService/GetOffices", method: .get, parameters: Parameters, encoding: URLEncoding.default).responseJSON { response in
            debugPrint(response)
            switch response.result {
            case .success:
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
                            markers.icon = self.imageWithImage(image: #imageLiteral(resourceName: "Group_1398"), scaledToSize: CGSize(width: 30, height: 35))
                        } else {
                            markers.icon = self.imageWithImage(image: #imageLiteral(resourceName: "Group_869"), scaledToSize: CGSize(width: 30, height: 35))
                        }
                        markers.appearAnimation = .pop
                        markers.accessibilityLabel = "\(i)"
                        i+=1
                        markers.map = self.mapView
                        let targetComp = CLLocation(latitude: markers.position.latitude, longitude: markers.position.longitude)
                        let distance : CLLocationDistance = targetComp.distance(from: self.resultMyLocation2)
//                        if distance <= 30000 {
                            markersArray.append(markers)
                            print(requestProjectObj)
                            self.arrayOfResulr.append(requestProjectObj)
//                        }
                        
                    }
                }else {
                    if l != 0.0 && lng != 0.0 {
                        let targetComp = CLLocation(latitude: l, longitude: lng)
                        let distance : CLLocationDistance = targetComp.distance(from: self.resultMyLocation2)
                        if distance <= self.radius! {
                            //                        print("ds: \(self.radius!)")
                            markers.position = target
                            if self.isCompany == "0" {
                                markers.icon = self.imageWithImage(image: #imageLiteral(resourceName: "Group_1398"), scaledToSize: CGSize(width: 30, height: 35))
                            } else {
                                markers.icon = self.imageWithImage(image: #imageLiteral(resourceName: "Group_869"), scaledToSize: CGSize(width: 30, height: 35))
                            }
                            markers.appearAnimation = .pop
                            markers.accessibilityLabel = "\(i)"
                            i+=1
                            markers.map = self.mapView
                            markersArray.append(markers)
                            print(requestProjectObj)
                            self.arrayOfResulr.append(requestProjectObj)
                        }else {
                            print("dist: \(distance)")
                        }
                    }
                    
                }
                
            }
            if self.radius == nil {
                
            }else {
                print(self.latsearchvalue)
               print(self.lngsearchvalue)
            if markersArray.count != 0
            {
                let camera = GMSCameraPosition.camera(withLatitude:  markersArray[0].position.latitude, longitude:
                    markersArray[0].position.longitude, zoom: 12)
                 self.mapView.camera = camera
                }
            else{
                let camera = GMSCameraPosition.camera(withLatitude:  self.latsearchvalue, longitude:
                    self.lngsearchvalue, zoom: 12)
                 self.mapView.camera = camera
                }
            
                
                
//                var bounds = GMSCoordinateBounds()
//                for marker in markersArray
//                {
//                    bounds = bounds.includingCoordinate(marker.position)
//                }
//                // dynamic zoom
////                let update = GMSCameraUpdate.fit(bounds, withPadding: 10)
////                self.mapView.animate(with: update)
//                print(self.latsearchvalue)
//                    print(self.lngsearchvalue)
//
//                let target1 = CLLocationCoordinate2D(latitude: markersArray[0].position.latitude, longitude: markersArray[0].position.latitude)
//                self.mapView.camera = GMSCameraPosition.camera(withTarget: target1, zoom: 11)
////
//
//                self.mapView.settings.myLocationButton = true
//                self.cam = Double(self.mapView.camera.zoom)
                print("zoom: \(Double(self.mapView.camera.zoom))")
                
            }
            
            self.lbl_Rate.text = ""
            self.lbl_Type.text = ""
            self.lbl_Near.text = ""
            var stars = ""
        var numberoffice = ""
            var nearstring = ""
            var r1 = ""
            var r2 = ""
            
              self.resaultsLabel.text = ""
            if self.RateValue != ""{
                stars = " \(self.RateValue)نجوم  "
              
            }else
            {
              
            }
            
            if self.resultsText1 != ""{
                
                r1 = "\(self.resultsText1)"
            }
            else
            {
                
            }
            if self.resultsText2 != ""{
                r2 = "\(self.resultsText2)"
             
            }
            else
            {
               
            }
            if self.RateValue != ""{
                self.RateValue = "\(self.RateValue)"
            }
            if self.isCompany == "0" {
                if markersArray.count != 0
                {
                    numberoffice =  "\(markersArray.count) مهندس في : "
                }else
                {
                    numberoffice =  " لا يوجد مهندسين في :"
                }
            } else {
                if markersArray.count != 0
                {
                    numberoffice =  "\(markersArray.count) مكتب في : "
                }else
                {
                    numberoffice =  "لا يوجد مكاتب في :"
                }
            }
            if self.IsNear == true
             {
                nearstring = " بالقرب مني"
               
            }
            else
             {
                nearstring = ""
              
            }
            
            if  SortExp == ""
            {
                r2 = " كل التخصصات"
                
            }
            
            
            let attrs1 = [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 14), NSAttributedStringKey.foregroundColor : UIColor.black]
            
            let attrs2 = [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 14), NSAttributedStringKey.foregroundColor : UIColor.white]
            
            let attributedString1 = NSMutableAttributedString(string:numberoffice, attributes:attrs1)
           
            if stars != ""
            {
            self.lbl_Rate.text = "\(stars)-"
            }
           
            
            if nearstring != ""
            {
                if r2 != ""
                {
                    self.lbl_Type.text = "\(r2) -"
                }
                 self.lbl_Near.text = "\(nearstring)"
            }
        else
            {
                if r2 != ""
                {
                    self.lbl_Type.text = "\(r2)"
                }
            }
           
            

            self.resaultsLabel.attributedText = attributedString1
            
            
//            self.resaultsLabel.text = numberoffice + "," +
            UIViewController.removeSpinner(spinner: sv)
            case .failure(let error):
                print(error)
                UIViewController.removeSpinner(spinner: sv)
                let alertAction = UIAlertController(title: "خطاء في الاتصال", message: "اعادة المحاولة", preferredStyle: .alert)
                
                alertAction.addAction(UIAlertAction(title: "نعم", style: .default, handler: { action in
                    self.GetOfficesByProvincesID(SortBy: SortBy, SortExp: SortExp, Rate: Rate)
                }))
                
                alertAction.addAction(UIAlertAction(title: "رجوع", style: .cancel, handler: { action in
                    self.navigationController!.popViewController(animated: true)
                }))
                
                self.present(alertAction, animated: true, completion: nil)
                
            }
        }
        
    }
    
    
    
    @IBAction func goCompanyDetialsBtn(_ sender: UIButton) {
        let CustmoerId = UserDefaults.standard.string(forKey: "CustmoerId")
        if CustmoerId == nil
        {
            let storyBoard : UIStoryboard = UIStoryboard(name: "NewProject", bundle:nil)
            let secondView = storyBoard.instantiateViewController(withIdentifier: "DetailsOfOfficeTableViewControllerNot") as! DetailsOfOfficeTableViewControllerNot
            secondView.arrayOfResulr = self.arrayOfResulr
            secondView.index = self.indexi
            secondView.isCompany = self.isCompany
            self.navigationController?.pushViewController(secondView, animated: true)
        }
        else
        {
        let storyBoard : UIStoryboard = UIStoryboard(name: "NewProject", bundle:nil)
        let secondView = storyBoard.instantiateViewController(withIdentifier: "DetailsOfOfficeTableViewController") as! DetailsOfOfficeTableViewController
        secondView.arrayOfResulr = self.arrayOfResulr
        secondView.index = self.indexi
        secondView.isCompany = self.isCompany
        self.navigationController?.pushViewController(secondView, animated: true)
        }
    }
    
    @IBAction func goListOfOfficesBtn(_ sender: UIButton) {
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
    
    @IBAction func endPopViewBtn(_ sender: UIButton) {
        if let selectedMarker = mapView.selectedMarker {
            if self.isCompany == "0" {
                selectedMarker.icon = self.imageWithImage(image: #imageLiteral(resourceName: "Group_1398"), scaledToSize: CGSize(width: 30, height: 35))
            } else {
                selectedMarker.icon = self.imageWithImage(image: #imageLiteral(resourceName: "Group_869"), scaledToSize: CGSize(width: 30, height: 35))
            }
            cirlce.map = nil
        }
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
//    let AlertController: UIAlertController! = nil
    @IBAction func directionsAction(_ sender: UIButton) {
       
        let dLati = arrayOfResulr[indexi!].Lat
        let dLang = arrayOfResulr[indexi!].Long
        self.LatBranch = dLati
        self.LngBranch = dLang
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
        secondView.RateValue = RateValue
        secondView.IsRsearch = IsRsearch
        secondView.IsNear = IsNear
        secondView.distanceComing = distanceSend
        secondView.searchtext = (searchController?.searchBar.text)!
        if SortExp != nil {
            secondView.SortExp = self.SortExp!
            
        }else {
            secondView.SortExp = ""
        }
        
        
        self.present(NavController, animated: false, completion: nil)
        
        
    }
    // التخصصات
    @IBAction func ExpBtnAction(_ sender: UIButton) {
        let dvc = self.storyboard!.instantiateViewController(withIdentifier: "FilterCompanyTypeTableViewController") as! FilterCompanyTypeTableViewController
        
        dvc.barBtnMapDelegate = self
         dvc.reate = rate_StarValue
        dvc.modalPresentationStyle = .popover
        dvc.popoverPresentationController?.sourceView = sender
        dvc.popoverPresentationController?.sourceRect = CGRect(x: sender.frame.midX-100 , y: sender.frame.maxY, width: 0, height: 0)
        dvc.popoverPresentationController?.delegate = self
        dvc.preferredContentSize = CGSize(width: self.view.frame.width - 20, height: 185)
        dvc.popoverPresentationController?.permittedArrowDirections = [.up]
        
        self.present(dvc, animated: true, completion: nil)
    }
    
    @IBAction func myLocationBtn(_ sender: UIButton) {
       
        IsRsearch = false
        if filterOfficeByNeerOut.backgroundColor == #colorLiteral(red: 0.831372549, green: 0.6862745098, blue: 0.2117647059, alpha: 1) {
             IsNear = false
            self.filterOfficeByNeerOut.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
            self.filterOfficeByNeerOut.layer.cornerRadius = 7.0
            self.filterOfficeByNeerOut.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.filterOfficeByNeerOut.layer.borderWidth = 1.0
            self.filterOfficeByNeerOut.layer.masksToBounds = true
        } else {
             IsNear = true
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
        
        /// near
       
        print(RateValue)
        searchController?.searchBar.text = ""
        resultsText1 = ""
        if arrayOfResulr.count != 0 {
            arrayOfResulr.removeAll()
        }
        mapView.clear()
//         mapView.settings.myLocationButton = true
        if ((SortExp == nil || SortExp == "-1" || SortExp == "") && RateValue == "" )  {
            GetOfficesByProvincesID(SortBy: "1", SortExp: "", Rate: "")
            self.filterOfficeTypeOut.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
              self.FilterbyRate.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
            self.filterOfficeTypeOut.layer.cornerRadius = 7.0
            self.filterOfficeTypeOut.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.filterOfficeTypeOut.layer.borderWidth = 1.0
            self.filterOfficeTypeOut.layer.masksToBounds = true
        } else if((RateValue == "" || RateValue == nil) && (SortExp != "" || SortExp != nil)) {
            rate_StarValue = ""
            GetOfficesByProvincesID(SortBy: "3", SortExp: SortExp!, Rate: "")
           
            self.filterOfficeTypeOut.backgroundColor = #colorLiteral(red: 0.831372549, green: 0.6862745098, blue: 0.2117647059, alpha: 1)
            self.FilterbyRate.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
            self.FilterbyRate.layer.cornerRadius = 7.0
            self.FilterbyRate.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.FilterbyRate.layer.borderWidth = 1.0
            self.filterOfficeTypeOut.layer.cornerRadius = 7.0
            self.filterOfficeTypeOut.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
            self.filterOfficeTypeOut.layer.borderWidth = 1.0
            self.filterOfficeTypeOut.layer.masksToBounds = true
            resaultsLabel.text =  resultsText + resultsText1 + ", " + resultsText2 + "عدد المكاتب " + "\(self.arrayOfResulr.count)"
            Res_Sent = resultsText + ", " + resultsText2
            Exp_sort = SortExp!
            Rate_Sent = rate_StarValue
        }
        else if((SortExp == "" || SortExp == nil) && (RateValue != "" || RateValue == nil)) {
            rate_StarValue = RateValue
            GetOfficesByProvincesID(SortBy: "6", SortExp: SortExp!, Rate: RateValue)
          
            self.FilterbyRate.backgroundColor = #colorLiteral(red: 0.831372549, green: 0.6862745098, blue: 0.2117647059, alpha: 1)
            self.filterOfficeTypeOut.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
            self.FilterbyRate.layer.cornerRadius = 7.0
            self.FilterbyRate.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
            self.FilterbyRate.layer.borderWidth = 1.0
            self.FilterbyRate.layer.masksToBounds = true
            
            self.filterOfficeTypeOut.layer.cornerRadius = 7.0
            self.filterOfficeTypeOut.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.filterOfficeTypeOut.layer.borderWidth = 1.0
          
            resaultsLabel.text = resultsText + " تقيم " + RateValue + " نجوم "  + "عدد المكاتب " + "\(arrayOfResulr.count)"
            Res_Sent = resultsText + " تقيم " + RateValue + " نجوم "
           
        }
        else
        {
            GetOfficesByProvincesID(SortBy: "7", SortExp: SortExp!, Rate: RateValue)
            resaultsLabel.text = resultsText + "" + ", " + resultsText2 + "عدد المكاتب " + "\(arrayOfResulr.count)"
             rate_StarValue = RateValue
            rate_StarValue =  RateValue
            self.FilterbyRate.backgroundColor = #colorLiteral(red: 0.831372549, green: 0.6862745098, blue: 0.2117647059, alpha: 1)
            self.FilterbyRate.layer.cornerRadius = 7.0
            self.FilterbyRate.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
            self.FilterbyRate.layer.borderWidth = 1.0
            self.FilterbyRate.layer.masksToBounds = true
            self.filterOfficeTypeOut.backgroundColor = #colorLiteral(red: 0.831372549, green: 0.6862745098, blue: 0.2117647059, alpha: 1)
            self.filterOfficeTypeOut.layer.cornerRadius = 7.0
            self.filterOfficeTypeOut.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
            self.filterOfficeTypeOut.layer.borderWidth = 1.0
            self.filterOfficeTypeOut.layer.masksToBounds = true
            
            resaultsLabel.text = resultsText + ", " + resultsText2 + " تقيم " +  RateValue  + " نجوم " + "عدد المكاتب " + "\(arrayOfResulr.count)"
            Res_Sent = resultsText + resultsText1 + ", " + resultsText2 + " تقيم " +  RateValue  + " نجوم "
            
        }
        PopUpView.isHidden = true
        guard let lat = self.mapView.myLocation?.coordinate.latitude,
            let lng = self.mapView.myLocation?.coordinate.longitude else { return }
        
      
      
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
//        mapView.settings.myLocationButton = true
        self.mapView.isUserInteractionEnabled = true
        self.barOut.isUserInteractionEnabled = true
        self.PopUpView.isUserInteractionEnabled = true
        self.searchController?.searchBar.isUserInteractionEnabled = true
        
        
        // cile on my location
        
//        let circleCenter : CLLocationCoordinate2D  = CLLocationCoordinate2DMake(currentlat, currentlng);
//        let circ = GMSCircle(position: circleCenter, radius: 0.2 * 1)
//        circ.fillColor = UIColor(red: 0.0, green: 0.0, blue: 0.7, alpha: 0.1)
//        circ.strokeColor = UIColor(red: 0.0, green: 0.0, blue: 0.7, alpha: 0.1)
//        circ.strokeWidth = 1;
//        circ.map = self.mapView;

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
        let CustmoerId = UserDefaults.standard.string(forKey: "CustmoerId")
        if CustmoerId == nil
        {
            LoginVIew.isHidden = false
           
        }
        else {
        
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
//            self.navigationController?.show(secondView, sender: self)
//            self.present(secondView, animated: true, completion: nil)
        self.navigationController?.pushViewController(secondView, animated: true)
        }
    }
    
    
    func addBackBarButtonItem() {
        let backButton = UIButton(type: .system)
        backButton.setImage(UIImage(named: "BackGray"), for: .normal)
//        backButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
//        backButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
      
        backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        backButton.sizeToFit()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }
    
    @objc func backButtonPressed(){
        self.navigationController!.popViewController(animated: true)
    }
    var cam = 5.0
    var radius: CLLocationDistance?
    var SortExp: String?
     var RateValue = ""
}

// Handle the user's selection.
extension OfficesMapViewController: GMSAutocompleteResultsViewControllerDelegate, GMSMapViewDelegate {
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        let index:Int! = Int(marker.accessibilityLabel!)
        let camera = GMSCameraPosition.camera(withTarget: marker.position, zoom: 12)
//        Float(cam)
        self.mapView.animate(to: camera)
        indexi = index
        
        if marker == markerLoc {
            
        }else {
            let lat = marker.position.latitude
            let lng = marker.position.longitude
            let markerTarget = CLLocation(latitude: lat, longitude: lng)
            if targetMyLocation != nil {
                let distance : CLLocationDistance = markerTarget.distance(from: targetMyLocation!)
                if distance >= 1000 {
                    neerbeLabel.text = "يبعد عنك \(Int(distance/1000)) كيلو متر"
                }else {
                    neerbeLabel.text = "يبعد عنك \(Int(distance)) متر"
                }
                print("distance = \(Double(distance)) m")
            }
            
            print("arrc: \(arrayOfResulr.count)")
            if arrayOfResulr.count > index {
                CompanyNameLabel.text = arrayOfResulr[index].ComapnyName
                companyMobileLabel = arrayOfResulr[index].CompanyMobile
                
                popup_CompanyName.text = arrayOfResulr[index].Address
                print(arrayOfResulr[index].RateNumber)
                print(arrayOfResulr[index].Address)
                Rate_PopUp.setStarsRating(rating: Int(5 - arrayOfResulr[index].RateNumber))
                
              
                    //
                let img = arrayOfResulr[index].Logo
                let trimmedString = img.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
                if let url = URL.init(string: trimmedString!) {
                    CompanyLogoImage.hnk_setImageFromURL(url, placeholder: #imageLiteral(resourceName: "officePlaceholder"))
                } else{
                    print("nil")
                    CompanyLogoImage.image = #imageLiteral(resourceName: "officePlaceholder")
                }
            }else {
                let ind = (index - arrayOfResulr.count)+1
                print(arrayOfResulr.count)
                CompanyNameLabel.text = arrayOfResulr[index-ind].ComapnyName
                companyMobileLabel = arrayOfResulr[index-ind].CompanyMobile
                 popup_CompanyName.text = arrayOfResulr[index-ind].Address
                print(arrayOfResulr[index-ind].RateNumber)
                  Rate_PopUp.starsRating = Int(5 - arrayOfResulr[index-ind].RateNumber)
                let img = arrayOfResulr[index-ind].Logo
                let trimmedString = img.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
                if let url = URL.init(string: trimmedString!) {
                    CompanyLogoImage.hnk_setImageFromURL(url, placeholder: #imageLiteral(resourceName: "officePlaceholder"))
                } else{
                    print("nil")
                    CompanyLogoImage.image = #imageLiteral(resourceName: "officePlaceholder")
                }
            }
           
            // remove color from currently selected marker
            if let selectedMarker = mapView.selectedMarker {
                if self.isCompany == "0" {
                    selectedMarker.icon = self.imageWithImage(image: #imageLiteral(resourceName: "Group_1398"), scaledToSize: CGSize(width: 30, height: 35))
                } else {
                    selectedMarker.icon = self.imageWithImage(image: #imageLiteral(resourceName: "Group_869"), scaledToSize: CGSize(width: 30, height: 35))
                }
                selectedMarker.appearAnimation = .pop
                cirlce.map = nil
            } else {
            }
            // select new marker and make green
            mapView.selectedMarker = marker
            if self.isCompany == "0" {
                marker.icon =  self.imageWithImage(image: #imageLiteral(resourceName: "Group_1413"), scaledToSize: CGSize(width: 30, height: 35))
            } else {
                marker.icon = self.imageWithImage(image:  #imageLiteral(resourceName: "Group_1414"), scaledToSize: CGSize(width: 30, height: 35))
            }
            marker.appearAnimation = .pop
            if camera.zoom <= 10 {
                print("zoom: \(camera.zoom)")
                cirlce = GMSCircle(position: (mapView.selectedMarker?.position)!, radius: (8000))
            }else if camera.zoom <= 12 {
                print("zoom: \(camera.zoom)")
                cirlce = GMSCircle(position: (mapView.selectedMarker?.position)!, radius: (1000))
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
//         mapView.settings.myLocationButton = true
        if SortExp == nil || SortExp == "-1" || SortExp == "" || RateValue == "" || RateValue != ""{
            GetOfficesByProvincesID(SortBy: "1", SortExp: "", Rate: "")
        }
        else if((RateValue == "" || RateValue == nil) && (SortExp != "" || SortExp != nil)) {
        
            GetOfficesByProvincesID(SortBy: "3", SortExp: SortExp!, Rate: "")
        }
        else if((SortExp == "" || SortExp == nil) && (RateValue != "" || RateValue != nil)) {
            
            GetOfficesByProvincesID(SortBy: "6", SortExp: SortExp!, Rate: RateValue)
        }
        else
        {
          GetOfficesByProvincesID(SortBy: "7", SortExp: SortExp!, Rate: RateValue)
        }
        PopUpView.isHidden = true
        print(#function)
    }
    
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
//        reverseGeocodeCoordinate(position.target)
//        self.searchController?.searchBar.text = ""
//        //                self.resultsText1 = address.locality ?? self.resultsText1
//        self.resultsText1 = ""
//        self.resaultsLabel.text = self.resultsText + self.resultsText1 + ", " + self.resultsText2
       
        
        latsearchvalue = position.target.latitude
            lngsearchvalue = position.target.longitude
        resultMyLocation2 = CLLocation(latitude: position.target.latitude, longitude: position.target.longitude)
    }
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController, didAutocompleteWith place: GMSPlace) {
        ///// search
      
        IsRsearch = true
         print(RateValue)
        searchController?.isActive = false
        if filterOfficeByNeerOut.backgroundColor == #colorLiteral(red: 0.831372549, green: 0.6862745098, blue: 0.2117647059, alpha: 1) {
            self.filterOfficeByNeerOut.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
            self.filterOfficeByNeerOut.layer.cornerRadius = 7.0
            self.filterOfficeByNeerOut.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.filterOfficeByNeerOut.layer.borderWidth = 1.0
            self.filterOfficeByNeerOut.layer.masksToBounds = true
             IsNear = false
        }
        
        // Do something with the selected place.
        print("Place name: \(place.name)")
//        self.searchController?.searchBar.text = place.name
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
        let distance : GMSCoordinateBounds = GMSCoordinateBounds(coordinate: g!, coordinate: f!)
        let distance33 : CLLocationDistance = targ.distance(from: tarf)
        distanceSend = distance33
        let camera = mapView.camera(for: distance, insets: UIEdgeInsets())!
        //cam = Double(camera.zoom)
        cam = 5.0
        mapView.camera = camera
//        map(l: place.coordinate.latitude, lng: place.coordinate.longitude, Z: 17.0, title: place.formattedAddress!)
        resultMyLocation2 = CLLocation(latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
        address = place.formattedAddress!
        searchController?.searchBar.text = place.name
        resultsText1 = place.name
        
        if arrayOfResulr.count > 0 {
            arrayOfResulr.removeAll()
        }
        if ((SortExp == nil || SortExp == "-1" || SortExp == "") && RateValue == "" ) {
            
            GetOfficesByProvincesID(SortBy: "1", SortExp: "", Rate: "")
            self.FilterbyRate.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
            self.FilterbyRate.layer.cornerRadius = 7.0
            self.FilterbyRate.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.FilterbyRate.layer.borderWidth = 1.0
             self.FilterbyRate.layer.masksToBounds = true
            self.filterOfficeTypeOut.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
            self.filterOfficeTypeOut.layer.cornerRadius = 7.0
            self.filterOfficeTypeOut.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.filterOfficeTypeOut.layer.borderWidth = 1.0
            self.filterOfficeTypeOut.layer.masksToBounds = true
        } else if((RateValue == "" || RateValue == nil) && (SortExp != "" || SortExp != nil)) {
            
            rate_StarValue = ""
            GetOfficesByProvincesID(SortBy: "3", SortExp: SortExp!, Rate: "")
            
            self.filterOfficeTypeOut.backgroundColor = #colorLiteral(red: 0.831372549, green: 0.6862745098, blue: 0.2117647059, alpha: 1)
            self.FilterbyRate.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
            self.FilterbyRate.layer.cornerRadius = 7.0
            self.FilterbyRate.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.FilterbyRate.layer.borderWidth = 1.0
            self.filterOfficeTypeOut.layer.cornerRadius = 7.0
            self.filterOfficeTypeOut.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
            self.filterOfficeTypeOut.layer.borderWidth = 1.0
            self.filterOfficeTypeOut.layer.masksToBounds = true
            resaultsLabel.text = resultsText + resultsText1 + ", " + resultsText2 + "عدد المكاتب " + "\(arrayOfResulr.count)"
            Res_Sent = resultsText + resultsText1 + ", " + resultsText2
            Exp_sort = SortExp!
            Rate_Sent = rate_StarValue
        }
        else if((SortExp == "" || SortExp == nil) && (RateValue != "" || RateValue != nil)) {
            
            rate_StarValue = RateValue
            GetOfficesByProvincesID(SortBy: "6", SortExp: SortExp!, Rate: RateValue)
            
            self.FilterbyRate.backgroundColor = #colorLiteral(red: 0.831372549, green: 0.6862745098, blue: 0.2117647059, alpha: 1)
            self.filterOfficeTypeOut.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
            self.FilterbyRate.layer.cornerRadius = 7.0
            self.FilterbyRate.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
            self.FilterbyRate.layer.borderWidth = 1.0
            self.FilterbyRate.layer.masksToBounds = true
            
            self.filterOfficeTypeOut.layer.cornerRadius = 7.0
            self.filterOfficeTypeOut.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.filterOfficeTypeOut.layer.borderWidth = 1.0
            
            resaultsLabel.text = resultsText + " تقيم " + RateValue + " نجوم " + "عدد المكاتب " + "\(arrayOfResulr.count)"
            Res_Sent = resultsText + " تقيم " + RateValue + " نجوم "
        }
        else
        {
            GetOfficesByProvincesID(SortBy: "7", SortExp: SortExp!, Rate: RateValue)
            resaultsLabel.text = resultsText + "" + ", " + resultsText2 + "عدد المكاتب " + "\(arrayOfResulr.count)"
            rate_StarValue = RateValue
            rate_StarValue =  RateValue
            self.FilterbyRate.backgroundColor = #colorLiteral(red: 0.831372549, green: 0.6862745098, blue: 0.2117647059, alpha: 1)
            self.FilterbyRate.layer.cornerRadius = 7.0
            self.FilterbyRate.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
            self.FilterbyRate.layer.borderWidth = 1.0
            self.FilterbyRate.layer.masksToBounds = true
            self.filterOfficeTypeOut.backgroundColor = #colorLiteral(red: 0.831372549, green: 0.6862745098, blue: 0.2117647059, alpha: 1)
            self.filterOfficeTypeOut.layer.cornerRadius = 7.0
            self.filterOfficeTypeOut.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
            self.filterOfficeTypeOut.layer.borderWidth = 1.0
            self.filterOfficeTypeOut.layer.masksToBounds = true
            
            resaultsLabel.text = resultsText + resultsText1 + ", " + resultsText2 + " تقيم " +  RateValue  + " نجوم " + "عدد المكاتب " + "\(arrayOfResulr.count)"
            Res_Sent = resultsText + resultsText1 + ", " + resultsText2 + " تقيم " +  RateValue  + " نجوم "
        }
        PopUpView.isHidden = true
       
       
       
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
//            mapView.settings.myLocationButton = true
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
            currentlat = lat
currentlng = lng
            
            
//            let circleCenter : CLLocationCoordinate2D  = CLLocationCoordinate2DMake(lat, lng);
//            let circ = GMSCircle(position: circleCenter, radius: 0.9 * 1609.34)
//            circ.fillColor = UIColor(red: 0.0, green: 0.0, blue: 0.7, alpha: 0.1)
//            circ.strokeColor = UIColor(red: 0.0, green: 0.0, blue: 0.7, alpha: 0.1)
//            circ.strokeWidth = 2.5;
//            circ.map = self.mapView;
            
            // Create marker and set location
            locationManager.stopUpdatingLocation()
        }
    }
}

extension OfficesMapViewController: BarBtnMapDelegate {
    func BarBtnSortExpDidChange(SortExp: String, companyTypeName: String , RateNumber: String ) {
        mapView.clear()
//         mapView.settings.myLocationButton = true
        RateValue = RateNumber
        if SortExp == nil || SortExp == "-1" {
            GetOfficesByProvincesID(SortBy: "1", SortExp: "", Rate: "")
            self.filterOfficeTypeOut.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
            self.filterOfficeTypeOut.layer.cornerRadius = 7.0
            self.filterOfficeTypeOut.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.filterOfficeTypeOut.layer.borderWidth = 1.0
            self.filterOfficeTypeOut.layer.masksToBounds = true
            resultsText2 = companyTypeName
            resaultsLabel.text = resultsText + resultsText1 + ", " + resultsText2 + "عدد المكاتب " + "\(arrayOfResulr.count)"
            Res_Sent = resultsText + resultsText1 + ", " + resultsText2
            rate_StarValue = ""
             Exp_sort = SortExp
        }else {
            
            if(RateNumber == "" &&  SortExp != "")
            {
                
            
            GetOfficesByProvincesID(SortBy: "3", SortExp: SortExp, Rate: rate_StarValue)
            self.filterOfficeTypeOut.backgroundColor = #colorLiteral(red: 0.831372549, green: 0.6862745098, blue: 0.2117647059, alpha: 1)
            self.FilterbyRate.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
            self.FilterbyRate.layer.cornerRadius = 7.0
            self.FilterbyRate.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.FilterbyRate.layer.borderWidth = 1.0
            self.filterOfficeTypeOut.layer.cornerRadius = 7.0
            self.filterOfficeTypeOut.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
            self.filterOfficeTypeOut.layer.borderWidth = 1.0
            self.filterOfficeTypeOut.layer.masksToBounds = true
               rate_StarValue = ""
            resultsText2 = companyTypeName
                
                
            resaultsLabel.text = resultsText + resultsText1 + ", " + resultsText2 + "عدد المكاتب " + "\(arrayOfResulr.count)"
                Res_Sent = resultsText + resultsText1 + ", " + resultsText2
                 Exp_sort = SortExp
              
                Rate_Sent = rate_StarValue
                companyNameT = companyTypeName
            }
             else if (RateNumber != "" &&  SortExp == "")
            {
              Exp_sort = ""
                rate_StarValue = RateNumber
                GetOfficesByProvincesID(SortBy: "6", SortExp: SortExp, Rate: RateNumber)
                self.FilterbyRate.backgroundColor = #colorLiteral(red: 0.831372549, green: 0.6862745098, blue: 0.2117647059, alpha: 1)
                 self.filterOfficeTypeOut.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
                self.FilterbyRate.layer.cornerRadius = 7.0
                self.FilterbyRate.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
                self.FilterbyRate.layer.borderWidth = 1.0
                self.FilterbyRate.layer.masksToBounds = true
                
                self.filterOfficeTypeOut.layer.cornerRadius = 7.0
                self.filterOfficeTypeOut.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                self.filterOfficeTypeOut.layer.borderWidth = 1.0
                resultsText2 = companyTypeName
                resaultsLabel.text = resultsText + resultsText1 + " تقيم " + RateNumber + " نجوم " + "عدد المكاتب " + "\(arrayOfResulr.count)"
                Res_Sent = resultsText + " تقيم " + RateNumber + " نجوم "
            }
            else
            {
               
                
                if(SortExp != "" && RateNumber != "" )
                {
                GetOfficesByProvincesID(SortBy: "7", SortExp: SortExp, Rate: RateNumber)
                Exp_sort = SortExp
                    
                    Rate_Sent = RateNumber
                companyNameT = companyTypeName
                rate_StarValue = RateNumber
                self.FilterbyRate.backgroundColor = #colorLiteral(red: 0.831372549, green: 0.6862745098, blue: 0.2117647059, alpha: 1)
                self.FilterbyRate.layer.cornerRadius = 7.0
                self.FilterbyRate.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
                self.FilterbyRate.layer.borderWidth = 1.0
                self.FilterbyRate.layer.masksToBounds = true
                self.filterOfficeTypeOut.backgroundColor = #colorLiteral(red: 0.831372549, green: 0.6862745098, blue: 0.2117647059, alpha: 1)
                self.filterOfficeTypeOut.layer.cornerRadius = 7.0
                self.filterOfficeTypeOut.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
                self.filterOfficeTypeOut.layer.borderWidth = 1.0
                self.filterOfficeTypeOut.layer.masksToBounds = true
                resultsText2 = companyTypeName
                resaultsLabel.text = resultsText + resultsText1 + ", " + resultsText2 + " تقيم " + RateNumber  + " نجوم " + "عدد المكاتب " + "\(arrayOfResulr.count)"
                    Res_Sent = resultsText + resultsText1 + ", " + resultsText2 + " تقيم " + RateNumber  + " نجوم "
                }
                else{
                    self.FilterbyRate.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
                    self.FilterbyRate.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
                    self.FilterbyRate.layer.cornerRadius = 7.0
                    self.FilterbyRate.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                    self.FilterbyRate.layer.borderWidth = 1.0
                        self.filterOfficeTypeOut.layer.borderWidth = 1.0
                     self.filterOfficeTypeOut.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                 self.filterOfficeTypeOut.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
                    GetOfficesByProvincesID(SortBy: "1", SortExp: "", Rate: "")
                       resaultsLabel.text = ""
                    Res_Sent = ""
                      rate_StarValue = ""
                     Exp_sort = ""
                     }
                
            }
        }
        self.SortExp = SortExp
        self.Rate_Sent = RateNumber
    }
}

extension OfficesMapViewController: PresentDelegate {
    func mapValueDidChange(resultMyLocation2: CLLocation, distance: CLLocationDistance, address: String, newPlace: GMSPlace, SortExp: String, resultsText: String, Rate: String,IsNear: Bool,IsSearch: Bool,R1:String,R2:String) {
         Exp_sort = SortExp
         self.SortExp  = SortExp
        resultsText1 = R1
        resultsText2 = R2
        IsRsearch = true
        self.IsNear = false
          resaultsLabel.text = ""
         RateValue = Rate
          var resultsText = "نتائج البحث :"
        print(RateValue)
        searchController?.isActive = false
        if filterOfficeByNeerOut.backgroundColor == #colorLiteral(red: 0.831372549, green: 0.6862745098, blue: 0.2117647059, alpha: 1) {
            self.filterOfficeByNeerOut.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
            self.filterOfficeByNeerOut.layer.cornerRadius = 7.0
            self.filterOfficeByNeerOut.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.filterOfficeByNeerOut.layer.borderWidth = 1.0
            self.filterOfficeByNeerOut.layer.masksToBounds = true
            
        }
        searchController?.searchBar.text = address
        self.resultMyLocation2 = resultMyLocation2
        self.address = address
        let g = newPlace.viewport?.northEast
        let targ = CLLocation(latitude: (g?.latitude)!, longitude: (g?.longitude)!)
        let f = newPlace.viewport?.southWest
        let tarf = CLLocation(latitude: (f?.latitude)!, longitude: (f?.longitude)!)
        radius = targ.distance(from: tarf)
         let distance : CLLocationDistance = targ.distance(from: tarf)
        distanceSend = distance
//        let distance : GMSCoordinateBounds = GMSCoordinateBounds(coordinate: g!, coordinate: f!)
        mapView.clear()
//         mapView.settings.myLocationButton = true
        if ((SortExp == nil || SortExp == "-1" || SortExp == "") && Rate == "" ) {
            
            GetOfficesByProvincesID(SortBy: "1", SortExp: "", Rate: "")
            self.FilterbyRate.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
            self.FilterbyRate.layer.cornerRadius = 7.0
            self.FilterbyRate.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.FilterbyRate.layer.borderWidth = 1.0
            self.FilterbyRate.layer.masksToBounds = true
            self.filterOfficeTypeOut.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
            self.filterOfficeTypeOut.layer.cornerRadius = 7.0
            self.filterOfficeTypeOut.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.filterOfficeTypeOut.layer.borderWidth = 1.0
            self.filterOfficeTypeOut.layer.masksToBounds = true
        } else if((Rate == "" || Rate == nil) && (SortExp != "" || SortExp != nil)) {
            
            rate_StarValue = ""
             RateValue = ""
            GetOfficesByProvincesID(SortBy: "3", SortExp: SortExp, Rate: "")
            
            self.filterOfficeTypeOut.backgroundColor = #colorLiteral(red: 0.831372549, green: 0.6862745098, blue: 0.2117647059, alpha: 1)
            self.FilterbyRate.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
            self.FilterbyRate.layer.cornerRadius = 7.0
            self.FilterbyRate.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.FilterbyRate.layer.borderWidth = 1.0
            self.filterOfficeTypeOut.layer.cornerRadius = 7.0
            self.filterOfficeTypeOut.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
            self.filterOfficeTypeOut.layer.borderWidth = 1.0
            self.filterOfficeTypeOut.layer.masksToBounds = true
            resaultsLabel.text = resultsText + resultsText1 + ", " + resultsText2 + "عدد المكاتب " + "\(arrayOfResulr.count)"
            Res_Sent = resultsText + resultsText1 + ", " + resultsText2
            Exp_sort = SortExp
          
        }
        else if((SortExp == "" || SortExp == nil) && (Rate != "" || Rate != nil)) {
            
            rate_StarValue = Rate
             RateValue = Rate
            GetOfficesByProvincesID(SortBy: "6", SortExp: SortExp, Rate: Rate)
            
            self.FilterbyRate.backgroundColor = #colorLiteral(red: 0.831372549, green: 0.6862745098, blue: 0.2117647059, alpha: 1)
            self.filterOfficeTypeOut.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
            self.FilterbyRate.layer.cornerRadius = 7.0
            self.FilterbyRate.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
            self.FilterbyRate.layer.borderWidth = 1.0
            self.FilterbyRate.layer.masksToBounds = true
            
            self.filterOfficeTypeOut.layer.cornerRadius = 7.0
            self.filterOfficeTypeOut.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.filterOfficeTypeOut.layer.borderWidth = 1.0
            
            resaultsLabel.text = resultsText + " تقيم " + Rate + " نجوم " + "عدد المكاتب " + "\(arrayOfResulr.count)"
            Res_Sent = resultsText + " تقيم " + Rate + " نجوم "
        }
        else
        {
            GetOfficesByProvincesID(SortBy: "7", SortExp: SortExp, Rate: Rate)
           
            rate_StarValue = Rate
           
             RateValue = Rate
            self.FilterbyRate.backgroundColor = #colorLiteral(red: 0.831372549, green: 0.6862745098, blue: 0.2117647059, alpha: 1)
            self.FilterbyRate.layer.cornerRadius = 7.0
            self.FilterbyRate.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
            self.FilterbyRate.layer.borderWidth = 1.0
            self.FilterbyRate.layer.masksToBounds = true
            self.filterOfficeTypeOut.backgroundColor = #colorLiteral(red: 0.831372549, green: 0.6862745098, blue: 0.2117647059, alpha: 1)
            self.filterOfficeTypeOut.layer.cornerRadius = 7.0
            self.filterOfficeTypeOut.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
            self.filterOfficeTypeOut.layer.borderWidth = 1.0
            self.filterOfficeTypeOut.layer.masksToBounds = true
            print(resultsText1)
             print(resultsText2)
            resaultsLabel.text = resultsText + resultsText1 + ", " + resultsText2 + " تقيم " +  Rate  + " نجوم " + "عدد المكاتب " + "\(arrayOfResulr.count)"
            Res_Sent = resultsText + resultsText1 + ", " + resultsText2 + " تقيم " +  Rate  + " نجوم "
        }
        
      
        PopUpView.isHidden = true
    }
    func newMapValueDidChange(address: String, SortExp: String, resultsText: String, Rate: String,IsNear: Bool,IsSearch: Bool,R1:String,R2:String) {
          RateValue = Rate
         Exp_sort = SortExp
        self.SortExp  = SortExp
        resultsText1 = R1
        resultsText2 = R2
        self.address = address
        resaultsLabel.text = ""
        mapView.clear()
//         mapView.settings.myLocationButton = true
        var resultsText = "نتائج البحث :"
        if ((SortExp == nil || SortExp == "-1" || SortExp == "") && Rate == "" ) {
            
            GetOfficesByProvincesID(SortBy: "1", SortExp: "", Rate: "")
            self.FilterbyRate.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
            self.FilterbyRate.layer.cornerRadius = 7.0
            self.FilterbyRate.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.FilterbyRate.layer.borderWidth = 1.0
            self.FilterbyRate.layer.masksToBounds = true
            self.filterOfficeTypeOut.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
            self.filterOfficeTypeOut.layer.cornerRadius = 7.0
            self.filterOfficeTypeOut.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.filterOfficeTypeOut.layer.borderWidth = 1.0
            self.filterOfficeTypeOut.layer.masksToBounds = true
        } else if((Rate == "" || Rate == nil) && (SortExp != "" || SortExp != nil)) {
            
            rate_StarValue = ""
            GetOfficesByProvincesID(SortBy: "3", SortExp: SortExp, Rate: "")
              RateValue = ""
            self.filterOfficeTypeOut.backgroundColor = #colorLiteral(red: 0.831372549, green: 0.6862745098, blue: 0.2117647059, alpha: 1)
            self.FilterbyRate.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
            self.FilterbyRate.layer.cornerRadius = 7.0
            self.FilterbyRate.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.FilterbyRate.layer.borderWidth = 1.0
            self.filterOfficeTypeOut.layer.cornerRadius = 7.0
            self.filterOfficeTypeOut.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
            self.filterOfficeTypeOut.layer.borderWidth = 1.0
            self.filterOfficeTypeOut.layer.masksToBounds = true
            resaultsLabel.text = resultsText + resultsText1 + ", " + resultsText2 + "عدد المكاتب " + "\(arrayOfResulr.count)"
          
            Exp_sort = SortExp
            
        }
        else if((SortExp == "" || SortExp == nil) && (Rate != "" || Rate != nil)) {
            
            rate_StarValue = Rate
              RateValue = Rate
            GetOfficesByProvincesID(SortBy: "6", SortExp: SortExp, Rate: Rate)
            
            self.FilterbyRate.backgroundColor = #colorLiteral(red: 0.831372549, green: 0.6862745098, blue: 0.2117647059, alpha: 1)
            self.filterOfficeTypeOut.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
            self.FilterbyRate.layer.cornerRadius = 7.0
            self.FilterbyRate.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
            self.FilterbyRate.layer.borderWidth = 1.0
            self.FilterbyRate.layer.masksToBounds = true
            
            self.filterOfficeTypeOut.layer.cornerRadius = 7.0
            self.filterOfficeTypeOut.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.filterOfficeTypeOut.layer.borderWidth = 1.0
            
            resaultsLabel.text = resultsText + " تقيم " + Rate + " نجوم " + "عدد المكاتب " + "\(arrayOfResulr.count)"
            Res_Sent = resultsText + " تقيم " + Rate + " نجوم "
        }
        else
        {
            GetOfficesByProvincesID(SortBy: "7", SortExp: SortExp, Rate: Rate)
            
            rate_StarValue = Rate
            rate_StarValue =  Rate
            RateValue = Rate
            self.FilterbyRate.backgroundColor = #colorLiteral(red: 0.831372549, green: 0.6862745098, blue: 0.2117647059, alpha: 1)
            self.FilterbyRate.layer.cornerRadius = 7.0
            self.FilterbyRate.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
            self.FilterbyRate.layer.borderWidth = 1.0
            self.FilterbyRate.layer.masksToBounds = true
            self.filterOfficeTypeOut.backgroundColor = #colorLiteral(red: 0.831372549, green: 0.6862745098, blue: 0.2117647059, alpha: 1)
            self.filterOfficeTypeOut.layer.cornerRadius = 7.0
            self.filterOfficeTypeOut.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
            self.filterOfficeTypeOut.layer.borderWidth = 1.0
            self.filterOfficeTypeOut.layer.masksToBounds = true
            print(resultsText1)
              print(resultsText2)
              print(Rate)
            resaultsLabel.text = resultsText + resultsText1 + ", " + resultsText2 + " تقيم " +  Rate  + " نجوم " + "عدد المكاتب " + "\(arrayOfResulr.count)"
          
        }
      
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
