//
//  ContactUSViewController.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 8/10/17.
//  Copyright © 2017 Ahmed Wahdan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class ContactUSTableViewController: UITableViewController, GMSMapViewDelegate  {

    var BranchID = ""
    var BranchEmail = ""
    var BranchFB = ""
    var BranchFax = ""
    var BranchIsDeleted = ""
    var BranchLocation = ""
    var BranchName = ""
    var BranchPhone = ""
    var Lat = ""
    var Lng = ""
    var Zoom = ""

    var BranchID1 = ""
    var BranchEmail1 = ""
    var BranchFB1 = ""
    var BranchFax1 = ""
    var BranchIsDeleted1 = ""
    var BranchLocation1 = ""
    var BranchName1 = ""
    var BranchPhone1 = ""
    var Lat1 = ""
    var Lng1 = ""
    var Zoom1 = ""
    
    @IBOutlet weak var SectionDmam: UIView!
    @IBOutlet weak var SectionAlgteef: UIView!
    @IBAction func Segment(_ sender: AMWSegmentController) {
        switch Segm.selectedIndex
        {
        case 0:
            SectionDmam.isHidden = true
            SectionAlgteef.isHidden = false
        case 1:
            SectionDmam.isHidden = false
            SectionAlgteef.isHidden = true
        default:
            break;
        }
        
    }
    @IBOutlet weak var Segm: AMWSegmentController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        
        SectionDmam.layer.cornerRadius = 10
        SectionDmam.layer.borderColor = UIColor.black.cgColor // set SectionDmam border color here
        SectionDmam.layer.masksToBounds = true
        SectionAlgteef.layer.cornerRadius = 10
        SectionAlgteef.layer.borderColor = UIColor.black.cgColor // set SectionAlgteef border color here
        SectionAlgteef.layer.masksToBounds = true
        SectionDmam.isHidden = false
        SectionAlgteef.isHidden = true
        
        
        // Do any additional setup after loading the view.
        BranchesContacts()
        BranchesContacts2()
        
        assignbackground()
        
//        DispatchQueue.main.async {
//            let width = self.tableView.frame.width
//            let height = self.tableView.frame.height
//            let size = CGSize(width: width, height: height)
//            //            (self.tableView.tableViewLayout as! UITableViewFlowLayout).itemSize = size
//        }
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = self.tableView.frame.height

        return height
    }
    
    func vcConf2(){
        let dLati = Double(Lat1) ?? 0.0
        let dLang = Double(Lng1) ?? 0.0
        let dZoom = Float(Zoom1) ?? 0.0
        let vc2 = self.childViewControllers[1] as! SectionAlgteefViewController
//        vc2.mapView.delegate = self
//        vc2.mapView.camera = GMSCameraPosition.camera(withLatitude: dLati, longitude: dLang, zoom: dZoom)
////        GMSMapView.map(withFrame: CGRect.zero, camera: mapView.camera)
//        vc2.mapView.isMyLocationEnabled = true
//        // Creates a marker in the center of the map.
//        let marker = GMSMarker()
//        marker.position = CLLocationCoordinate2D(latitude: dLati, longitude: dLang)
//        marker.title = "القطيف"
//        marker.map = vc2.mapView
        
        vc2.mapView.delegate = vc2
        vc2.map(l: dLati, lng: dLang, Z: dZoom)
        vc2.Address.text = BranchLocation1
        vc2.mobile.setTitle(BranchPhone1, for: .normal)
        vc2.mobileText = BranchPhone1
        vc2.fax.setTitle(BranchFax1, for: .normal)
        vc2.faxText = BranchFax1
        vc2.mail.setTitle(BranchEmail1, for: .normal)
        vc2.mailText = BranchEmail1
        vc2.facebook.setTitle(BranchFB1, for: .normal)
        vc2.facebookText = BranchFB1

    }
    func vcConf(){
        let dLati = Double(Lat) ?? 0.0
        let dLang = Double(Lng) ?? 0.0
        let dZoom = Float(Zoom) ?? 0.0
        let vc = self.childViewControllers[0] as! SectionDmamViewController
//        vc.mapView.delegate = self
//        vc.mapView.camera = GMSCameraPosition.camera(withLatitude: dLati, longitude: dLang, zoom: dZoom)
////        //        GMSMapView.map(withFrame: CGRect.zero, camera: mapView.camera)
//        vc.mapView.isMyLocationEnabled = true
////
////        // Creates a marker in the center of the map.
//        let marker = GMSMarker()
//        marker.position = CLLocationCoordinate2D(latitude: dLati, longitude: dLang)
//        marker.title = "الدمام"
//        marker.map = vc.mapView
        
        vc.mapView.delegate = vc
        vc.map(l: dLati, lng: dLang, Z: dZoom)
        vc.Address.text = BranchLocation
        vc.mobile.setTitle(BranchPhone, for: .normal)
        vc.mobileText = BranchPhone
        vc.fax.setTitle(BranchFax, for: .normal)
        vc.faxText = BranchFax
        vc.mail.setTitle(BranchEmail, for: .normal)
        vc.mailText = BranchEmail
        vc.facebook.setTitle(BranchFB, for: .normal)
        vc.facebookText = BranchFB
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
    func BranchesContacts(){
        
        Alamofire.request("http://smusers.promit2030.co/Service1.svc/BranchesContacts?branchID=1", method: .get, encoding: URLEncoding.default).responseJSON { response in
            debugPrint(response)
            
            
            let json = JSON(response.result.value!)
            
            
            self.BranchID = json["BranchID"].stringValue
            self.BranchName = json["BranchName"].stringValue
            self.Lat = json["Lat"].stringValue
            self.Lng = json["Lng"].stringValue
            self.Zoom = json["Zoom"].stringValue
            self.BranchIsDeleted = json["BranchIsDeleted"].stringValue
            self.BranchLocation = json["BranchLocation"].stringValue
            self.BranchPhone = json["BranchPhone"].stringValue
            self.BranchFax = json["BranchFax"].stringValue
            self.BranchEmail = json["BranchEmail"].stringValue
            self.BranchFB = json["BranchFB"].stringValue
            self.vcConf()
            
        }
        
    }
    func BranchesContacts2(){
        
        Alamofire.request("http://smusers.promit2030.co/Service1.svc/BranchesContacts?branchID=2", method: .get, encoding: URLEncoding.default).responseJSON { response in
            debugPrint(response)
            
            
            let json = JSON(response.result.value!)
            
            
            self.BranchID1 = json["BranchID"].stringValue
            self.BranchName1 = json["BranchName"].stringValue
            self.Lat1 = json["Lat"].stringValue
            self.Lng1 = json["Lng"].stringValue
            self.Zoom1 = json["Zoom"].stringValue
            self.BranchIsDeleted1 = json["BranchIsDeleted"].stringValue
            self.BranchLocation1 = json["BranchLocation"].stringValue
            self.BranchPhone1 = json["BranchPhone"].stringValue
            self.BranchFax1 = json["BranchFax"].stringValue
            self.BranchEmail1 = json["BranchEmail"].stringValue
            self.BranchFB1 = json["BranchFB"].stringValue
            self.vcConf2()
        }
        
    }


}
