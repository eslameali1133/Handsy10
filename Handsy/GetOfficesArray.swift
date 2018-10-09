//
//  GetOfficesArray.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 12/4/17.
//  Copyright © 2017 Ahmed Wahdan. All rights reserved.
//

import UIKit

class GetOfficesArray: NSObject {
    var CompanyInfoID: String = ""
    var ComapnyName: String = ""
    var CompanyMobile: String = ""
    var Street: String = ""
    var BiuldNumber: String = ""
    var PostNumber: String = ""
    var PostSymbol: String = ""
    var PostNumberWasl: String = ""
    var Phone: String = ""
    var Fax: String = ""
    var Long: CLLocationDegrees = 0.0
    var Lat: CLLocationDegrees = 0.0
    var Zoom: String = ""
    var LicenceNumber: String = ""
    var CommercialNumber: String = ""
    var CompanyEmail: String = ""
    var IsCompany: String = ""
    var Specialty: String = ""
    var IsSCE: String = ""
    var Logo: String = ""
    var BranchFB = ""
    var BranchID = ""
    var Address = ""
    var ProjCount = ""
    var RateNumber = 0.0
    
    var location: CLLocation {
        return CLLocation(latitude: self.Lat, longitude: self.Long)
    }
    
    func distance(to location: CLLocation) -> CLLocationDistance {
        return location.distance(from: self.location)
    }

}
