//
//  TheResponsibleEngineerEditViewController.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 8/26/17.
//  Copyright © 2017 Ahmed Wahdan. All rights reserved.
//

import UIKit
import MapKit

class TheResponsibleEngineerEditViewController: UIViewController, GMSMapViewDelegate {
    
    @IBOutlet weak var mapView: GMSMapView!
    
    //    let locationManager = CLLocationManager()
    //    let marker = GMSMarker()
    
    var ProjectId = ""
    var BranchLat: Double = 0.0
    var BranchLng: Double = 0.0
    var EmpName = ""
    var Mobile = ""
    var EmpImage = ""
    var JobName = ""
    var BranchName = ""
    var zoomOffice = ""
    
    @IBOutlet weak var jobTitle: UILabel!
    @IBOutlet weak var emplName: UILabel!
    @IBOutlet weak var empMobile: UILabel!
    @IBOutlet weak var EmpImagePro: AMCircleImageView!
    
    @IBOutlet weak var callBtn: UIButton!{
            didSet {
                DispatchQueue.main.async {
                    self.callBtn.circleView(UIColor.clear, borderWidth: 1.0)
                    self.officeLocation.circleView(UIColor.clear, borderWidth: 0.5)
                    self.get()
                }
            }
        }
    
    @IBOutlet weak var officeLocation: UILabel!
    
    @IBOutlet weak var directionsOut: UIButton!{
        didSet {
            DispatchQueue.main.async {
                self.directionsOut.layer.cornerRadius = 7.0
                self.directionsOut.layer.masksToBounds = true
                
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "المهندس المسؤول"
        self.navigationItem.hidesBackButton = true
        mapView.delegate = self
        
        mapView.delegate = self
        if mapView.mapType == .satellite {
            mapType.setImage(#imageLiteral(resourceName: "landscape-with-mountains"), for: .normal)
        }else {
            mapType.setImage(#imageLiteral(resourceName: "google-drive-image copy copy"), for: .normal)
        }
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func get() {
        
        jobTitle.text = JobName
        emplName.text = EmpName
        empMobile.text = Mobile
        let dLati = Double(BranchLat) ?? 0.0
        let dLang = Double(BranchLng) ?? 0.0
        let dZoom = Float(zoomOffice) ?? 0.0
        
        if dZoom == 0.0 {
            mapView.camera = GMSCameraPosition.camera(withLatitude: dLati, longitude: dLang, zoom: 17.0)
        } else {
            mapView.camera = GMSCameraPosition.camera(withLatitude: dLati, longitude: dLang, zoom: dZoom)
        }
        
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
    
    @IBAction func EndViewBtn(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "NewHome", bundle: nil)
        let secondView = storyBoard.instantiateViewController(withIdentifier: "NewProjectDetialsFilterTableViewController") as! NewProjectDetialsFilterTableViewController
        secondView.ProjectId = self.ProjectId
        secondView.nou = "LOl"
        self.navigationController?.pushViewController(secondView, animated: true)
    }    
    
    @IBAction func directionsAction(_ sender: UIButton) {
        let dLati = Double(BranchLat) ?? 0.0
        let dLang = Double(BranchLng) ?? 0.0
        let alertAction = UIAlertController(title: "اختر الخريطة", message: "", preferredStyle: .alert)
        
        alertAction.addAction(UIAlertAction(title: "جوجل ماب", style: .default, handler: { action in
            if UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!) {
                UIApplication.shared.open(URL(string: "comgooglemaps://?center=\(dLati),\(dLang)&zoom=14&views=traffic&q=\(dLati),\(dLang)")!, options: [:], completionHandler: nil)
            } else {
                print("Can't use comgooglemaps://")
                UIApplication.shared.open(URL(string: "http://maps.google.com/maps?q=\(dLati),\(dLang)&zoom=14&views=traffic")!, options: [:], completionHandler: nil)
            }
        }))
        
        alertAction.addAction(UIAlertAction(title: "الخرائط", style: .default, handler: { action in
            self.openMapsForLocation()
        }))
        
        alertAction.addAction(UIAlertAction(title: "رجوع", style: .cancel, handler: { action in
        }))
        self.present(alertAction, animated: true, completion: nil)
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
