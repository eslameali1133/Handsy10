//
//  Extensions.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 8/6/17.
//  Copyright © 2017 Ahmed Wahdan. All rights reserved.
//

import Foundation
import MapKit
import CoreLocation

extension MKMapView {
    
    class func openMapsWith(_ location: CLLocation, completion: @escaping (_ error: NSError?)->()) {
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(location) { (placemarks, error) in
            if error != nil {
                completion(error as NSError?)
            } else {
                let placemark = MKPlacemark(placemark: placemarks!.first!)
                let mapItem = MKMapItem(placemark: placemark)
                mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving])
                completion(nil)
            }
        }
    }
    
    
    
}

extension UIViewController {
    func showAlert(title: String , message: String) {
        let alert = UIAlertController(title: title as String, message: message as String, preferredStyle:.alert)
        alert.addAction(UIAlertAction(title: "موافق", style: UIAlertActionStyle.cancel, handler:nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension String {
    static func encrypt1(str: String) -> String {
        return "5derdxfcghfdrt465r7t"
    }
    
    mutating func encrypt() {
        self = "5derdxfcghfdrt465r7t"
    }
}
