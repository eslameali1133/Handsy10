//
//  NewFilterMabViewController.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 3/14/18.
//  Copyright © 2018 Ahmed Wahdan. All rights reserved.
//

import UIKit
import GooglePlaces
import Alamofire
import SwiftyJSON
import MapKit

class NewFilterMapViewController: UIViewController, CLLocationManagerDelegate {
    let locationManager = CLLocationManager()
    
    @IBOutlet var tabBarView: UIView!
    
    @IBOutlet weak var mapView: GMSMapView!
    
    var resultsViewController: GMSAutocompleteResultsViewController?
    var searchController: UISearchController?
    var resultView: UITextView?
    var targetMyLocation: CLLocation?
    var resultMyLocation2: CLLocation = CLLocation(latitude: 0.0, longitude: 0.0)
    var address = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = true
            navigationItem.largeTitleDisplayMode = .automatic
            let CustomViewButton: UIBarButtonItem = UIBarButtonItem(customView: tabBarView)
            self.navigationItem.leftBarButtonItem = CustomViewButton
        } else {
            // Fallback on earlier versions
        }
//        self.extendedLayoutIncludesOpaqueBars = true
//        self.edgesForExtendedLayout = .top
        
        resultsViewController = GMSAutocompleteResultsViewController()
        resultsViewController?.delegate = self
        
        searchController = UISearchController(searchResultsController: resultsViewController)
        searchController?.searchResultsUpdater = resultsViewController
        
        // Put the search bar in the navigation bar.
        searchController?.searchBar.sizeToFit()
        searchController?.searchBar.barStyle = .default
        searchController?.searchBar.barTintColor = UIColor(red: 212/250.0, green: 175/250.0, blue: 52/250.0, alpha: 1.0)
        searchController?.searchBar.placeholder = "بحث عن المكاتب بالمدينة"
        //        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: (searchController?.searchBar)!)
        if #available(iOS 11.0, *) {
//            let CustomViewButton: UIBarButtonItem = UIBarButtonItem(customView: tabBarView)
            self.navigationItem.titleView = tabBarView
            navigationItem.searchController = searchController

        } else {
            // Fallback on earlier versions
        }
        // When UISearchController presents the results view, present it in
        // this view controller, not one further up the chain.
        definesPresentationContext = true
        
        // Prevent the navigation bar from being hidden when searching.
        searchController?.hidesNavigationBarDuringPresentation = false
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func reverseGeocodeCoordinate(_ coordinate: CLLocationCoordinate2D) {
        
        // 1
        let geocoder = GMSGeocoder()
        
        // 2
        geocoder.reverseGeocodeCoordinate(coordinate) { response, error in
            if let address = response?.firstResult() {
                
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

}

// Handle the user's selection.
extension NewFilterMapViewController: GMSAutocompleteResultsViewControllerDelegate, GMSMapViewDelegate {
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        let index:Int! = Int(marker.accessibilityLabel!)
        let camera = GMSCameraPosition.camera(withTarget: marker.position, zoom: 17.0)
        self.mapView.animate(to: camera)
        return true
    }
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        
        mapView.clear()
    }
    
    
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        reverseGeocodeCoordinate(position.target)
        resultMyLocation2 = CLLocation(latitude: position.target.latitude, longitude: position.target.longitude)
    }
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                           didAutocompleteWith place: GMSPlace) {
        searchController?.isActive = false
        // Do something with the selected place.
        print("Place name: \(place.name)")
        //        print("Place address: \(place.formattedAddress ?? "default")")
        address = place.formattedAddress!
        //        print("Place attributions: \(place.attributions)")
        print("kldhskjdhksdhkjdhsjdk: \(place.coordinate)")
        
        
        map(l: place.coordinate.latitude, lng: place.coordinate.longitude, Z: 17.0, title: place.formattedAddress!)
        resultMyLocation2 = CLLocation(latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
        
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
            zooml = 20
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
            mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 17.0, bearing: 0, viewingAngle: 0)
            
            // Tell locationManager you’re no longer interested in updates; you don’t want to follow a user around as their initial location is enough for you to work with.
            
            // Create marker and set location
            
            locationManager.stopUpdatingLocation()
        }
        
    }
}
