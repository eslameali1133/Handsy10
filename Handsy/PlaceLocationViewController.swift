//
//  PlaceLocationViewController.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 8/23/17.
//  Copyright © 2017 Ahmed Wahdan. All rights reserved.
//

import UIKit
import MapKit

class PlaceLocationViewController: UIViewController, GMSMapViewDelegate {
    var LatBranch: Double = 0.0
    var LngBranch: Double = 0.0
        var AlertController: UIAlertController!
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var placeLocaton: UILabel!{
        didSet {
            DispatchQueue.main.async {
                self.placeLocaton.circleView(UIColor.black, borderWidth: 1.0)
            }
        }
        
    }
    let marker = GMSMarker()
    var latitudeDer: Double?
    var lngitudeDer: Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.mapType = .terrain
        mapView.delegate = self
        if mapView.mapType == .satellite {
            mapType.setImage(#imageLiteral(resourceName: "Group_1404"), for: .normal)
        }else {
            mapType.setImage(#imageLiteral(resourceName: "Group_1404-1"), for: .normal)
        }
        
//        mapView.isMyLocationEnabled = true
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
    
    @IBOutlet weak var mapType: UIButton!{
        didSet {
            DispatchQueue.main.async {
              
                self.mapType.layer.cornerRadius =  self.mapType.frame.width / 2
             
                
            }
        }
        
    }
    
    
    @IBAction func mapTypeAction(_ sender: UIButton) {
        if mapView.mapType == .satellite {
            mapType.setImage(#imageLiteral(resourceName: "Group_1404-1"), for: .normal)
            mapView.mapType = .terrain
        }else {
            mapType.setImage(#imageLiteral(resourceName: "Group_1404"), for: .normal)
            mapView.mapType = .satellite
        }
    }
    
    @IBOutlet weak var directionsOut: UIButton!{
        didSet {
            DispatchQueue.main.async {
                self.directionsOut.layer.cornerRadius = self.directionsOut.frame.width / 2
//                self.directionsOut.layer.masksToBounds = true
            }
        }
        
    }
    @IBAction func directionsAction(_ sender: UIButton) {
        self.LatBranch = latitudeDer!
        self.LngBranch = lngitudeDer!
        
        let dLati =  LatBranch
        let dLang = LngBranch
        
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
        
//        self.present(AlertController, animated: true, completion: nil)
        

    }
   
    func openMapsForLocation() {
        let location = CLLocation(latitude: latitudeDer!, longitude: lngitudeDer!)
        print(location.coordinate)
        MKMapView.openMapsWith(location) { (error) in
            if error != nil {
                print("Could not open maps" + error!.localizedDescription)
            }
        }
    }
    
    func map(l: Double, lng: Double, Z: Float) {
        print("\(Z)" + "zoom")
        let target = CLLocationCoordinate2D(latitude: l, longitude: lng)
        latitudeDer = l
        lngitudeDer = lng
        mapView.animate(toLocation: target)
        //        mapView.camera = GMSCameraPosition.camera(withTarget: target
        //            , zoom: Z)
        mapView.delegate = self
//        mapView.isMyLocationEnabled = true
        var zooml = Z
        if zooml == 0.0 {
            zooml = 17
            mapView.animate(toZoom: zooml)
        }else {
            mapView.animate(toZoom: Z)
        }
        marker.position = target
        marker.title = "موقع الارض"
        marker.map = mapView
        mapView.mapType = .terrain
    }
    
    func zoom(zoom: Float){
        if zoom == 0.0 {
            var zoomPlus = zoom
            zoomPlus = 17
            mapView.animate(toZoom: zoomPlus)
        }else {
            mapView.animate(toZoom: zoom)
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
