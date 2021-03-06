//
//  SectionDmamViewController.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 8/10/17.
//  Copyright © 2017 Ahmed Wahdan. All rights reserved.
//

import UIKit
import MapKit

class SectionDmamViewController: UIViewController, GMSMapViewDelegate {
    
    var BranchLat: CLLocationDegrees = 0.0
    var BranchLng: CLLocationDegrees = 0.0
    var mobileText: String = ""
    var faxText: String = ""
    var mailText: String = ""
    var facebookText: String = ""
    
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var Address: UILabel!
    @IBOutlet weak var mobile: UIButton!
    @IBOutlet weak var fax: UIButton!
    @IBOutlet weak var mail: UIButton!
    @IBOutlet weak var facebook: UIButton!
    @IBOutlet weak var directionsOut: UIButton!{
        didSet {
            DispatchQueue.main.async {
                self.directionsOut.layer.cornerRadius = 7.0
                self.directionsOut.layer.masksToBounds = true
                self.directionsOut.backgroundColor = UIColor(red: 17.0/255.0, green: 119.0/255.0, blue: 151.0/255.0, alpha: 0.5)
            }
        }
        
    }

    var LatBranch: Double = 0.0
    var LngBranch: Double = 0.0
    var AlertController: UIAlertController!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        mapType.backgroundColor = UIColor(red: 17.0/255.0, green: 119.0/255.0, blue: 151.0/255.0, alpha: 0.5)
        mapView.delegate = self
        if mapView.mapType == .satellite {
            mapType.setImage(#imageLiteral(resourceName: "landscape-with-mountains"), for: .normal)
        }else {
            mapType.setImage(#imageLiteral(resourceName: "google-drive-image copy copy"), for: .normal)
        }        // Do any additional setup after loading the view.
        
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
    
    @IBOutlet weak var mapType: UIButton!{
        didSet {
            DispatchQueue.main.async {
                self.mapType.layer.cornerRadius = 7.0
                self.mapType.layer.masksToBounds = true
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
    
    
    func map(l: Double, lng: Double, Z: Float) {
        BranchLat = l
        BranchLng = lng
        mapView.camera = GMSCameraPosition.camera(withLatitude: l, longitude: lng, zoom: Z)
        mapView.delegate = self
        mapView.isMyLocationEnabled = true
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: l, longitude: lng)
        marker.title = "الدمام"
        marker.map = mapView
        mapView.mapType = .satellite
    }
    
    
    @IBAction func MobileBtn(_ sender: UIButton) {
        
        if mobileText.characters.count == 10 {
            if mobileText.characters.first! == "0" {
                if mobileText.characters[mobileText.index(mobileText.characters.startIndex, offsetBy: 1)] == "5" {
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
        if faxText.characters.count == 10 {
            if faxText.characters.first! == "0" {
                if faxText.characters[faxText.index(faxText.characters.startIndex, offsetBy: 1)] == "5" {
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
        let email = mailText
        if let url = URL(string: "mailto:\(email)") {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func FBBtn(_ sender: UIButton) {
        let url = URL(string: facebookText)!
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
    
    @IBAction func directionsAction(_ sender: UIButton) {
        
        
        if Helper.isDeviceiPad() {
            
            if let popoverController = AlertController.popoverPresentationController {
                popoverController.sourceView = sender
            }
        }
        
        self.present(AlertController, animated: true, completion: nil)
//        let alertAction = UIAlertController(title: "اختر الخريطة", message: "", preferredStyle: .alert)
//
//        alertAction.addAction(UIAlertAction(title: "جوجل ماب", style: .default, handler: { action in
//            if UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!) {
//                UIApplication.shared.open(URL(string: "comgooglemaps://?center=\(self.BranchLat),\(self.BranchLng)&zoom=14&views=traffic&q=\(self.BranchLat),\(self.BranchLng)")!, options: [:], completionHandler: nil)
//            } else {
//                print("Can't use comgooglemaps://")
//                UIApplication.shared.open(URL(string: "http://maps.google.com/maps?q=\(self.BranchLat),\(self.BranchLng)&zoom=14&views=traffic")!, options: [:], completionHandler: nil)
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
    }
    
    func openMapsForLocation() {
        
        let location = CLLocation(latitude: BranchLat, longitude: BranchLng)
        print(location.coordinate)
        MKMapView.openMapsWith(location) { (error) in
            if error != nil {
                print("Could not open maps" + error!.localizedDescription)
            }
        }
    }
    
}
