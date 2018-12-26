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

extension UIImage {
    enum JPEGQuality: CGFloat {
        case lowest  = 0
        case low     = 0.25
        case medium  = 0.5
        case high    = 0.75
        case highest = 1
    }
    
    /// Returns the data for the specified image in JPEG format.
    /// If the image object’s underlying image data has been purged, calling this function forces that data to be reloaded into memory.
    /// - returns: A data object containing the JPEG data, or nil if there was a problem generating the data. This function may return nil if the image has no data or if the underlying CGImageRef contains data in an unsupported bitmap format.
    func jpeg(_ quality: JPEGQuality) -> Data? {
        return UIImageJPEGRepresentation(self, quality.rawValue)
    }
}
