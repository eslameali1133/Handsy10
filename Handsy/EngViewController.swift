//
//  EngViewController.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 7/31/17.
//  Copyright © 2017 Ahmed Wahdan. All rights reserved.
//

import UIKit
import MapKit


class EngViewController: UIViewController, GMSMapViewDelegate {
    var BranchLat: CLLocationDegrees = 0.0
    var BranchLng: CLLocationDegrees = 0.0
    var BranchLatPass: Double = 0.0
    var BranchLngPass: Double = 0.0
    var BranchZoomPass = ""
    var BranchNamePass = ""
    var namePioPass = ""
    var nameEmpPass = ""
    var mobileEmpPass = ""
    
    
    @IBOutlet weak var mapView: GMSMapView!
    
    @IBOutlet weak var namePio: UILabel!
    @IBOutlet weak var nameEmp: UILabel!
    @IBOutlet weak var mobileEmp: UILabel!
    @IBOutlet weak var officeLocaton: UILabel!{
        didSet {
            DispatchQueue.main.async {
                self.officeLocaton.circleView(UIColor.black, borderWidth: 1.0)
            }
        }
        
    }

    
    @IBOutlet weak var call: UIButton! {
        didSet {
            DispatchQueue.main.async {
                self.call.circleView(UIColor.black, borderWidth: 1.0)
            }
        }
    }
    
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
        namePio.text = namePioPass
        nameEmp.text = nameEmpPass
        mobileEmp.text = mobileEmpPass
        mapView.delegate = self
        
        if mapView.mapType == .satellite {
            mapType.setImage(#imageLiteral(resourceName: "landscape-with-mountains"), for: .normal)
        }else {
            mapType.setImage(#imageLiteral(resourceName: "google-drive-image copy copy"), for: .normal)
        }
        let dLati = BranchLatPass
        let dLang = BranchLngPass
        let dZoom = Float(BranchZoomPass) ?? 0.0
        map(l: dLati, lng: dLang, Z: dZoom, title: BranchNamePass)
        // Do any additional setup after loading the view.
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
    
    
    func map(l: Double, lng: Double, Z: Float, title: String) {
        BranchLat = l
        BranchLng = lng
        mapView.camera = GMSCameraPosition.camera(withLatitude: l, longitude: lng, zoom: Z)
        mapView.delegate = self
        mapView.isMyLocationEnabled = true
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: l, longitude: lng)
        marker.title = title
        marker.map = mapView
        mapView.mapType = .terrain
    }
    
    @IBAction func directionsAction(_ sender: UIButton) {
        openMapsForLocation()
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
    @IBAction func CallMe(_ sender: UIButton) {
        var mobile = mobileEmp.text!
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
