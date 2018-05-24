//
//  NewProjectCViewController.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 7/25/17.
//  Copyright © 2017 Ahmed Wahdan. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces



class NewProjectCViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var AlertViewOut: UIView!
    
    let locationManager = CLLocationManager()
    var marker: GMSMarker?
    let zoomCamera = GMSCameraUpdate.zoomIn()
    
    var selectSection = ""
    var selectProject = ""
    var numberOfSak = ""
    var numberOfGat = ""
    var numberOfMo = ""
    var numberOfAl = ""
    var spacePlace = ""
    var dateRagh = ""
    var dateSk = ""
    var note = ""
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
    
    var resultsViewController: GMSAutocompleteResultsViewController?
    var searchController: UISearchController?
    var resultView: UITextView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        HideFunc()
//        if UserDefaults.standard.string(forKey: "alert") == nil {
//            AlertViewOut.isHidden = false
//            _ = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(HideFunc), userInfo: nil, repeats: false)
//        } else {
//            AlertViewOut.isHidden = true
//        }
        
        assignbackground()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        
//        self.navigationItem.hidesBackButton = true
        DispatchQueue.main.async {
            self.searchBarFunc()
        }
//        navigationController?.setNavigationBarHidden(true, animated: false)
        
        mapView.delegate = self
        if mapView.mapType == .satellite {
            mapType.setImage(#imageLiteral(resourceName: "landscape-with-mountains"), for: .normal)
        }else {
            mapType.setImage(#imageLiteral(resourceName: "google-drive-image copy copy"), for: .normal)
        }
    }
    
    func HideFunc() {
        let storyBoard : UIStoryboard = UIStoryboard(name: "NewProject", bundle: nil)
        let secondView = storyBoard.instantiateViewController(withIdentifier: "NewProjectMapAlertViewController") as! NewProjectMapAlertViewController
        secondView.modalPresentationStyle = .custom
        self.present(secondView, animated: false)
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
        
//        navigationItem.titleView = searchController?.searchBar
        
        let subView = UIView(frame: CGRect(x: 0, y: 62.0, width: self.view.frame.width, height: 45.0))
        
        subView.addSubview((searchController?.searchBar)!)
        view.addSubview(subView)
        
        // When UISearchController presents the results view, present it in
        // this view controller, not one further up the chain.
        definesPresentationContext = true
        
        // Prevent the navigation bar from being hidden when searching.
        searchController?.hidesNavigationBarDuringPresentation = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
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
    
    //    override func willMove(toParentViewController parent: UIViewController?) {
    //        super.willMove(toParentViewController: parent)
    //        if parent == nil {
    //
    //            //restore the orignal title
    //            navigationController?.navigationBar.backItem?.title = backItemTitle
    //        }
    //    }
    
    @IBAction func Next(_ sender: UIButton) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "NewProject", bundle:nil)
        let secondView = storyBoard.instantiateViewController(withIdentifier: "NewProjectDViewController") as! NewProjectDViewController
        secondView.selectSection = selectSection
        secondView.selectProject = selectProject
        secondView.numberOfSak = numberOfSak
        secondView.numberOfGat = numberOfGat
        secondView.numberOfMo = numberOfMo
        secondView.numberOfAl = numberOfAl
        secondView.spacePlace = spacePlace
        secondView.dateRagh = dateRagh
        secondView.dateSk = dateSk
        secondView.note = note
        secondView.latu = latu
        secondView.long = long
        secondView.zoom = zoom
        self.navigationController?.pushViewController(secondView, animated: true)
    }

    @IBAction func BackBtn(_ sender: UIButton) {
        self.navigationController!.popViewController(animated: true)
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
    
    func reverseGeocodeCoordinate2(_ coordinate: CLLocationCoordinate2D) {
        self.latu = String(coordinate.latitude)
        self.long = String(coordinate.longitude)
        print("la: \(self.latu)"+"lng: \(self.long)")
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
        
        if self.marker == nil {
            self.marker = GMSMarker(position: target)
        } else {
            self.marker?.position = target
        }
        
        marker!.title = title
        marker!.map = mapView
    }
}



// MARK: - GMSMapViewDelegate
extension NewProjectCViewController : GMSAutocompleteResultsViewControllerDelegate, GMSMapViewDelegate {
    
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                           didAutocompleteWith place: GMSPlace) {
        searchController?.isActive = false
        // Do something with the selected place.
        print("Place name: \(place.name)")
        print("kldhskjdhksdhkjdhsjdk: \(place.coordinate)")
        
        map(l: place.coordinate.latitude, lng: place.coordinate.longitude, Z: 17.0, title: place.formattedAddress!)
        
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
        reverseGeocodeCoordinate2(position.target)
    }
    func mapView(_ mapView: GMSMapView, didLongPressAt coordinate: CLLocationCoordinate2D) {
        
//        marker.icon = GMSMarker.markerImage(with: .black)
        
        print("Tapped at coordinate: " + String(coordinate.latitude) + " "
            + String(coordinate.longitude))
        
//        // Zoom in one zoom level
//        zoom = "\(zoomCamera)"
//        print(zoom + "zoom")
        
        
        
        if self.marker == nil {
            self.marker = GMSMarker(position: coordinate)
        } else {
            self.marker?.position = coordinate
        }
        
        marker!.title = "New Location"
        marker!.map = mapView
        self.latu = String(coordinate.latitude)
        self.long = String(coordinate.longitude)
        self.zoom = "\(mapView.camera.zoom)"
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
            
            mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 17, bearing: 0, viewingAngle: 0)
            
            // Tell locationManager you’re no longer interested in updates; you don’t want to follow a user around as their initial location is enough for you to work with.
            
            // Create marker and set location
            if self.marker == nil {
                self.marker = GMSMarker(position: location.coordinate)
            } else {
                self.marker?.position = location.coordinate
            }
            self.marker?.map = self.mapView
            
            locationManager.stopUpdatingLocation()
        }
        
    }
    
    
}
