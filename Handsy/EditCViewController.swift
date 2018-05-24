//
//  EditCViewController.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 8/7/17.
//  Copyright © 2017 Ahmed Wahdan. All rights reserved.
//

import UIKit
import MapKit
import GoogleMaps
import GooglePlaces

class EditCViewController: UIViewController, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
//    var marker: GMSMarker?
    var marker = GMSMarker()
    let zoomCamera = GMSCameraUpdate.zoomIn()

    var stringOfWordArray: [String] = []
    
    var BranchID: String = ""
    var BranchName: String = ""
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
    var LatPrj: String = ""
    var LicenceNum: String = ""
    var LngBranch: Double = 0.0
    var LngPrj: String = ""
    var Notes: String = ""
    var PlanId: String = ""
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
    var ZoomBranch: String = ""
    var ZoomPrj: String = ""
    var ProjectsImagePath: String = ""
    var ProjectsImageRotate: String = ""
    var ProjectsImageType: String = ""
    
    
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var addressLabel: UILabel!
    
    var resultsViewController: GMSAutocompleteResultsViewController?
    var searchController: UISearchController?
    var resultView: UITextView?
    
    
    var latu = ""
    var long = ""
    var zoom = ""
    
    //    var backItemTitle:String?
    
    
    @IBOutlet weak var chooseLocationLabel: UILabel! {
        didSet {
            DispatchQueue.main.async {
                self.chooseLocationLabel.circleView(UIColor.black, borderWidth: 1.0)
            }
        }
        
    }
    
    @IBOutlet weak var nextBtn: UIButton! {
        didSet {
            DispatchQueue.main.async {
                self.nextBtn.circleView(UIColor.black, borderWidth: 1.0)
            }
        }
    }
    
    @IBOutlet weak var backBtn: UIButton! {
        didSet {
            DispatchQueue.main.async {
                self.backBtn.circleView(UIColor.black, borderWidth: 1.0)
            }
        }
    }
    
    
    var sv = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sv = UIViewController.displaySpinner(onView: self.view)
        DispatchQueue.main.async {
            self.get()
        }
        assignbackground()
//        self.navigationItem.hidesBackButton = true
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        DispatchQueue.main.async {
            self.searchBarFunc()
        }
        
        stringOfWordArray = ProjectsImagePath.components(separatedBy: ",")
        
        for word in stringOfWordArray {
            print(word)
        }
    }
    
    func searchBarFunc(){
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
        searchController?.searchBar.tintColor = #colorLiteral(red: 0.831372549, green: 0.6862745098, blue: 0.2039215686, alpha: 1)
        searchController?.searchBar.barTintColor = #colorLiteral(red: 0.06274509804, green: 0.06274509804, blue: 0.06274509804, alpha: 1)
        searchController?.searchBar.placeholder = "بحث عن موقع الأرض"
        
        let subView = UIView(frame: CGRect(x: 0, y: 62.0, width: self.view.frame.width, height: 45.0))
        
        subView.addSubview((searchController?.searchBar)!)
        view.addSubview(subView)
        
//        navigationItem.titleView = searchController?.searchBar
        
        // When UISearchController presents the results view, present it in
        // this view controller, not one further up the chain.
        definesPresentationContext = true
        
        // Prevent the navigation bar from being hidden when searching.
        searchController?.hidesNavigationBarDuringPresentation = false
    }
    
    
    
    @IBOutlet weak var directionsOut: UIButton!{
        didSet {
            DispatchQueue.main.async {
                self.directionsOut.layer.cornerRadius = 7.0
                self.directionsOut.layer.masksToBounds = true
                
            }
        }
        
    }
    
    @IBAction func directionsAction(_ sender: UIButton) {
        openMapsForLocation()
    }
    
    func openMapsForLocation() {
        let dLati = Double(LatPrj) ?? 0.0
        let dLang = Double(LngPrj) ?? 0.0
        let location = CLLocation(latitude: dLati, longitude: dLang)
        print(location.coordinate)
        MKMapView.openMapsWith(location) { (error) in
            if error != nil {
                print("Could not open maps" + error!.localizedDescription)
            }
        }
    }
    
    func get() {
        
        let dLati = Double(LatPrj) ?? 0.0
        let dLang = Double(LngPrj) ?? 0.0
//        let dZoom = Float(ZoomPrj) ?? 0.0
        let tar = CLLocation(latitude: dLati, longitude: dLang)
        mapView.camera = GMSCameraPosition(target: tar.coordinate, zoom: 17, bearing: 0, viewingAngle: 0)
        
        //        GMSMapView.map(withFrame: CGRect.zero, camera: mapView.camera)
        mapView.isMyLocationEnabled = true
        
        // Creates a marker in the center of the map.
        marker.position = CLLocationCoordinate2D(latitude: dLati, longitude: dLang)
        marker.title = BranchName
        marker.map = mapView
        
        mapView.delegate = self
        mapView.delegate = self
        if mapView.mapType == .satellite {
            mapType.setImage(#imageLiteral(resourceName: "landscape-with-mountains"), for: .normal)
        }else {
            mapType.setImage(#imageLiteral(resourceName: "google-drive-image copy copy"), for: .normal)
        }
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        UIViewController.removeSpinner(spinner: sv)
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
    
    
    @IBAction func mapTypeAction(_ sender: UIButton) {
        if mapView.mapType == .satellite {
            mapType.setImage(#imageLiteral(resourceName: "google-drive-image copy copy"), for: .normal)
            mapView.mapType = .terrain
        }else {
            mapType.setImage(#imageLiteral(resourceName: "landscape-with-mountains"), for: .normal)
            mapView.mapType = .satellite
        }
    }
    
    @IBAction func Back(_ sender: UIButton) {
        self.navigationController!.popViewController(animated: true)
    }
    
    @IBAction func Next(_ sender: UIButton) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "ProjectsAndEdit", bundle:nil)
        let secondView = storyBoard.instantiateViewController(withIdentifier: "EditProjectsDViewController") as! EditProjectsDViewController
        self.navigationController?.pushViewController(secondView, animated: true)
        
        secondView.BranchID = BranchID
        secondView.BranchName = BranchName
        secondView.CustmoerName = CustmoerName
        secondView.CustomerEmail = CustomerEmail
        secondView.CustomerMobile = CustomerMobile
        secondView.CustomerNationalId = CustomerNationalId
        secondView.DataSake = DataSake
        secondView.DateLicence = DateLicence
        secondView.EmpImage = EmpImage
        secondView.EmpMobile = EmpMobile
        secondView.EmpName = EmpName
        secondView.GroundId = GroundId
        secondView.IsDeleted = IsDeleted
        secondView.JobName = JobName
        secondView.LatBranch = LatBranch
        secondView.LatPrj = LatPrj
        secondView.LicenceNum = LicenceNum
        secondView.LngBranch = LngBranch
        secondView.LngPrj = LngPrj
        secondView.Notes = Notes
        secondView.PlanId = PlanId
        secondView.ProjectBildTypeId = ProjectBildTypeId
        secondView.ProjectEngComment = ProjectEngComment
        secondView.ProjectId = ProjectId
        secondView.ProjectStatusColor = ProjectStatusColor
        secondView.ProjectStatusID = ProjectStatusID
        secondView.ProjectStatusName = ProjectStatusName
        secondView.ProjectTitle = ProjectTitle
        secondView.ProjectTypeId = ProjectTypeId
        secondView.ProjectTypeName = ProjectTypeName
        secondView.SakNum = SakNum
        secondView.Space = Space
        secondView.Status = Status
        secondView.ZoomBranch = ZoomBranch
        secondView.ZoomPrj = zoom
        secondView.ProjectsImageRotate = ProjectsImageRotate
        secondView.ProjectsImageType = ProjectsImageType
        secondView.AddItemPhotos1 = stringOfWordArray
        
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
    func reverseGeocodeCoordinate(_ coordinate: CLLocationCoordinate2D) {
        
        // 1
        let geocoder = GMSGeocoder()
        
        // 2
        geocoder.reverseGeocodeCoordinate(coordinate) { response, error in
            if let address = response?.firstResult() {
                
                // 3
                let lines = address.lines!
                self.addressLabel.text = lines.joined(separator: "\n")
                
                // 4
                UIView.animate(withDuration: 0.25) {
                    self.view.layoutIfNeeded()
                }
            }
        }
        
        // 1
        let labelHeight = self.addressLabel.intrinsicContentSize.height
        self.mapView.padding = UIEdgeInsets(top: self.topLayoutGuide.length, left: 0, bottom: labelHeight, right: 0)
        
        UIView.animate(withDuration: 0.25) {
            //2
            
            self.view.layoutIfNeeded()
        }
    }
    
    func map(l: Double, lng: Double, Z: Float, title: String) {
        print("\(Z)" + "zoom")
        let target = CLLocationCoordinate2D(latitude: l, longitude: lng)
        mapView.animate(toLocation: target)
        mapView.delegate = self
        mapView.isMyLocationEnabled = true
        var zooml = Z
        if zooml == 0.0 {
            zooml = 20
            mapView.animate(toZoom: zooml)
        }else {
            mapView.animate(toZoom: Z)
        }
        self.latu = String(l)
        self.long = String(lng)
        self.zoom = "\(mapView.camera.zoom)"
        self.LatPrj = String(l)
        self.LngPrj = String(lng)
        self.ZoomPrj = "\(mapView.camera.zoom)"
        
        if self.marker == nil {
            self.marker = GMSMarker(position: target)
        } else {
            self.marker.position = target
        }
        
        marker.title = title
        marker.map = mapView
    }
}

// MARK: - GMSMapViewDelegate
extension EditCViewController : GMSAutocompleteResultsViewControllerDelegate, GMSMapViewDelegate {
    
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                           didAutocompleteWith place: GMSPlace) {
        searchController?.isActive = false
        // Do something with the selected place.
        print("Place name: \(place.name)")
        print("kldhskjdhksdhkjdhsjdk: \(place.coordinate)")
        
        map(l: place.coordinate.latitude, lng: place.coordinate.longitude, Z: 17.0, title: place.formattedAddress!)
        
        dismiss(animated: true, completion: nil)
    }
    
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                           didFailAutocompleteWithError error: Error){
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
    
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        reverseGeocodeCoordinate(position.target)
    }
    
    func mapView(_ mapView: GMSMapView, didLongPressAt coordinate: CLLocationCoordinate2D) {
        
        //        marker.icon = GMSMarker.markerImage(with: .black)
        
        print("Tapped at coordinate: " + String(coordinate.latitude) + " "
            + String(coordinate.longitude))
        
        // Zoom in one zoom level
        zoom = "\(zoomCamera)"
        print(zoom + "zoom")
        
        
        
        if self.marker == nil {
            self.marker = GMSMarker(position: coordinate)
        } else {
            self.marker.position = coordinate
        }
        
        marker.title = "New Location"
        marker.map = mapView
        self.LatPrj = String(coordinate.latitude)
        self.LngPrj = String(coordinate.longitude)
        self.ZoomPrj = "\(mapView.camera.zoom)"
    }
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        print("Tapped at coordinate: " + String(coordinate.latitude) + " "
            + String(coordinate.longitude))
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
    
    
    // locationManager(_:didUpdateLocations:) executes when the location manager receives new location data.
    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            
            // This updates the map’s camera to center around the user’s current location. The GMSCameraPosition class aggregates all camera position parameters and passes them to the map for display.
//            let dLati = Double(LatPrj) ?? 0.0
//            let dLang = Double(LngPrj) ?? 0.0
//            let tar = CLLocation(latitude: dLati, longitude: dLang)
//            mapView.camera = GMSCameraPosition(target: tar.coordinate, zoom: 17, bearing: 0, viewingAngle: 0)
            
            // Tell locationManager you’re no longer interested in updates; you don’t want to follow a user around as their initial location is enough for you to work with.
            
            // Create marker and set location
//            let lat = location.coordinate.latitude
//            let lon = location.coordinate.longitude
//            marker.position = tar.coordinate
//            marker.map = self.mapView
            
            locationManager.stopUpdatingLocation()
        }
        
    }
}
