//
//  TheResponsibleEngineerViewController.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 8/1/17.
//  Copyright © 2017 Ahmed Wahdan. All rights reserved.
//

import UIKit
import MapKit

class TheResponsibleEngineerViewController: UIViewController, GMSMapViewDelegate {
    
    @IBOutlet weak var mapView: GMSMapView!
    
//    let locationManager = CLLocationManager()
//    let marker = GMSMarker()
    
    var ProjectId = ""
    var BranchLat = ""
    var BranchLng = ""
    var EmpName = ""
    var Mobile = ""
    var EmpImage = ""
    var JobName = ""
    var BranchName = ""
    var zoomOffice = ""
    var comingfromwithot = false
    var LatBranch: Double = 0.0
    var LngBranch: Double = 0.0
     var AlertController: UIAlertController!
    
    @IBOutlet weak var imageMaoType: UIImageView!
    @IBOutlet weak var jobTitle: UILabel!
    @IBOutlet weak var emplName: UILabel!
    @IBOutlet weak var empMobile: UILabel!
    @IBOutlet weak var EmpImagePro: AMCircleImageView!
    @IBOutlet weak var myLocationBtn: UIButton!{
        didSet {
            DispatchQueue.main.async {
                self.myLocationBtn.layer.cornerRadius = 13.0
                self.myLocationBtn.layer.masksToBounds = true
            }
        }
        
    }
    
    @IBOutlet weak var callBtn: UIButton!{
        didSet {
            DispatchQueue.main.async {
                self.callBtn.layer.cornerRadius = 20.0
                self.callBtn.layer.masksToBounds = true
            }
        }
        
    }
    @IBOutlet weak var directionsOut: UIButton!{
        didSet {
            DispatchQueue.main.async {
                self.directionsOut.layer.cornerRadius = 13.0
                self.directionsOut.layer.masksToBounds = true
            }
        }
        
    }
    
    @IBOutlet weak var officeLocation: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "تم ارسال المشروع بنجاح"
        
//          self.navigationItem.title = json["ComapnyName"].stringValue
        self.navigationItem.hidesBackButton = true
        mapView.delegate = self
        if mapView.mapType == .satellite {
//            mapType.setImage(#imageLiteral(resourceName: "landscape-with-mountains"), for: .normal)
            imageMaoType.image = #imageLiteral(resourceName: "Group_1404")
        }else {
             imageMaoType.image = #imageLiteral(resourceName: "Group_1404-1")
//            mapType.setImage(#imageLiteral(resourceName: "google-drive-image copy copy"), for: .normal)
        }
        DispatchQueue.main.async {
            self.callBtn.circleView(UIColor.black, borderWidth: 1.0)
            self.officeLocation.circleView(UIColor.black, borderWidth: 0.5)
            self.get()
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func get() {
        
//        jobTitle.text = JobName
        emplName.text = EmpName
        empMobile.text = Mobile
        let dLati = Double(BranchLat) ?? 0.0
        let dLang = Double(BranchLng) ?? 0.0
        let dZoom = Float(zoomOffice) ?? 17.0
        
        mapView.camera = GMSCameraPosition.camera(withLatitude: dLati, longitude: dLang, zoom: dZoom)
        mapView.animate(toZoom: dZoom)
//        GMSMapView.map(withFrame: CGRect.zero, camera: mapView.camera)
//        mapView.isMyLocationEnabled = true

        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: dLati, longitude: dLang)
        marker.title = BranchName
        marker.map = mapView
        
        let img = EmpImage
        let trimmedString = img.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        if let url = URL.init(string: trimmedString!) {
            EmpImagePro.hnk_setImageFromURL(url, placeholder: #imageLiteral(resourceName: "custlogo"))
        } else{
            print("nil")
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
//                self.mapType.layer.cornerRadius = 7.0
//                self.mapType.layer.masksToBounds = false
            }
        }
        
    }
    
    
    @IBAction func mapTypeAction(_ sender: UIButton) {
        if mapView.mapType == .satellite {
             imageMaoType.image = #imageLiteral(resourceName: "Group_1404-1")
            mapView.mapType = .terrain
        }else {
           imageMaoType.image = #imageLiteral(resourceName: "Group_1404")
            mapView.mapType = .satellite
        }
    }
    
    @IBAction func requestViewBtn(_ sender: UIButton) {
//        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//        let secondView = storyBoard.instantiateViewController(withIdentifier: "RequestProjectViewController") as! RequestProjectViewController
//        self.navigationController?.pushViewController(secondView, animated: true)
    }

    
    
    @IBAction func openMyProject(_ sender: UIButton) {
        if comingfromwithot == true{
            comingfromwithot = false
            comingnotification = true
            ProIDGloable = self.ProjectId
            trypNotification = "1"
            let storyBoard : UIStoryboard = UIStoryboard(name: "NewHome", bundle:nil)
            let sub = storyBoard.instantiateViewController(withIdentifier: "NewMain") as! NewTabBarViewController
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            
            appDelegate.window?.rootViewController = sub
            
        }
        else
        {
        let storyBoard : UIStoryboard = UIStoryboard(name: "NewHome", bundle: nil)
        let secondView = storyBoard.instantiateViewController(withIdentifier: "NewProjectDetialsFilterTableViewController") as! NewProjectDetialsFilterTableViewController
        secondView.ProjectId = self.ProjectId
        secondView.nou = "LOl"
        secondView.comafterlogin = true
        self.navigationController?.pushViewController(secondView, animated: true)
        }
    }
    
    
    @IBAction func directionsAction(_ sender: UIButton) {
        let dLati = Double(BranchLat) ?? 0.0
        let dLang = Double(BranchLng) ?? 0.0
        self.LatBranch = dLati
        self.LngBranch = dLang
        if Helper.isDeviceiPad() {
            
            if let popoverController = AlertController.popoverPresentationController {
                popoverController.sourceView = sender
            }
        }
        
        self.present(AlertController, animated: true, completion: nil)
        
    }
    
    func openMapsForLocation() {
        let dLati = Double(BranchLat) ?? 0.0
        let dLang = Double(BranchLng) ?? 0.0
        let location = CLLocation(latitude: dLati, longitude: dLang)
        print(location.coordinate)
        MKMapView.openMapsWith(location) { (error) in
            if error != nil {
                print("Could not open maps" + error!.localizedDescription)
            }
        }
    }
    
    @IBAction func CallMe(_ sender: UIButton) {
        var mobile = empMobile.text!
        
        if mobile.count == 10 {
            if mobile.first! == "0" {
                if mobile[mobile.index(mobile.startIndex, offsetBy: 1)] == "5" {
                    mobile.remove(at: mobile.startIndex)
                    mobile.insert("6", at: mobile.startIndex)
                    mobile.insert("6", at: mobile.startIndex)
                    mobile.insert("9", at: mobile.startIndex)
                    callNumber(phoneNumber: mobile)
                }
            }
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
//// MARK: - CLLocationManagerDelegate
////You create a MapViewController extension that conforms to CLLocationManagerDelegate.
//extension TheResponsibleEngineerViewController: CLLocationManagerDelegate {
//    // locationManager(_:didChangeAuthorizationStatus:) is called when the user grants or revokes location permissions.
//    
//    
//    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//        // Here you verify the user has granted you permission while the app is in use.
//        
//        if status == .authorizedWhenInUse {
//            
//            // Once permissions have been established, ask the location manager for updates on the user’s location.
//            
//            locationManager.startUpdatingLocation()
//            
//            // GMSMapView has two features concerning the user’s location: myLocationEnabled draws a light blue dot where the user is located, while myLocationButton, when set to true, adds a button to the map that, when tapped, centers the map on the user’s location.
//            
//            mapView.isMyLocationEnabled = true
//            mapView.settings.myLocationButton = false
//        }
//    }
//    
//    
//    // locationManager(_:didUpdateLocations:) executes when the location manager receives new location data.
//    
//    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        if let location = locations.first {
//            
//            // This updates the map’s camera to center around the user’s current location. The GMSCameraPosition class aggregates all camera position parameters and passes them to the map for display.
//            
//            mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
//            
//            // Tell locationManager you’re no longer interested in updates; you don’t want to follow a user around as their initial location is enough for you to work with.
//            
//            // Create marker and set location
//            let lat = location.coordinate.latitude
//            let lon = location.coordinate.longitude
//            marker.position = CLLocationCoordinate2DMake(lat, lon)
//            marker.map = self.mapView
//            marker.title = "الدمام"
//            
//            locationManager.stopUpdatingLocation()
//        }
//        
//    }
//    
//}
