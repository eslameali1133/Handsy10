//
//  BranchesViewController.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 11/29/17.
//  Copyright © 2017 Ahmed Wahdan. All rights reserved.
//

import UIKit
import MapKit

class BranchesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, GetBranchesModelDelegate, GMSMapViewDelegate {
    @IBOutlet weak var BranchesTableView: UITableView!
    
    var searchResu:[BranchesContactsArr] = [BranchesContactsArr]()
    
    let model: GetBranchesModel = GetBranchesModel()
    var marker = GMSMarker()

    override func viewDidLoad() {
        super.viewDidLoad()
        BranchesTableView.delegate = self
        BranchesTableView.dataSource = self
        
        model.delegate = self
        model.BranchesContacts(view: self.view, companyInfoID: "")
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dataReady() {
        // Access the video objects that have been downloaded
        self.searchResu = self.model.resultArray
        // Tell the tableview to reload
        self.BranchesTableView.reloadData()
    }
    

    func numberOfSections(in tableView: UITableView) -> Int {
        return searchResu.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return searchResu[section].isSelectable ? 1 : 0
        } else {
            return searchResu[section].isSelected ? 1 : 0
        }
    }
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = BranchesTableView.dequeueReusableCell(withIdentifier: "BranchSectionTableViewCell") as! BranchSectionTableViewCell
        cell.BranchName.text = searchResu[section].BranchName
        cell.contentView.backgroundColor = UIColor(red: 58/255.0, green: 59/255.0, blue: 60/255.0, alpha: 1.0)
        if section == 0 {
            if self.searchResu[section].isSelectable == true {
                cell.expandImage.image = #imageLiteral(resourceName: "up-chevron")
            } else {
                cell.expandImage.image = #imageLiteral(resourceName: "down-chevron")
            }
        } else {
            if self.searchResu[section].isSelected == false {
                cell.expandImage.image = #imageLiteral(resourceName: "down-chevron")
            } else {
                cell.expandImage.image = #imageLiteral(resourceName: "up-chevron")
            }
        }
        
        let tapGest = UITapGestureRecognizer(target: self, action: #selector(self.didSelectASection))
        cell.contentView.addGestureRecognizer(tapGest)
        cell.contentView.tag = section
        cell.layer.cornerRadius = 7
        cell.layer.borderColor = UIColor(red: 58/255.0, green: 59/255.0, blue: 60/255.0, alpha: 1.0).cgColor // set cell border color here
        cell.layer.masksToBounds = true
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 497
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = BranchesTableView.dequeueReusableCell(withIdentifier: "BranchTableViewCell", for: indexPath) as! BranchTableViewCell
        cell.BranchName.text = searchResu[indexPath.section].BranchName
        cell.Address.text = searchResu[indexPath.section].BranchLocation
        cell.facebook.setTitle(searchResu[indexPath.section].BranchFB, for: .normal)
        cell.fax.setTitle(searchResu[indexPath.section].BranchFax, for: .normal)
        cell.mail.setTitle(searchResu[indexPath.section].BranchEmail, for: .normal)
        cell.mobile.setTitle(searchResu[indexPath.section].BranchPhone, for: .normal)
        
        let BranchLat = searchResu[indexPath.section].Lat
        let l = Double(BranchLat) ?? 0.0
        let BranchLan = searchResu[indexPath.section].Lng
        let lng = Double(BranchLan) ?? 0.0
        let zoom = searchResu[indexPath.section].Zoom
        let Z = Float(zoom) ?? 0.0
        
        cell.mapView.camera = GMSCameraPosition.camera(withLatitude: l, longitude: lng, zoom: Z)
        cell.mapView.delegate = self
        cell.mapView.isMyLocationEnabled = true
        marker.position = CLLocationCoordinate2D(latitude: l, longitude: lng)
        marker.title = searchResu[indexPath.section].BranchName
        marker.map = cell.mapView
        cell.mapView.mapType = .satellite
        
        cell.layer.cornerRadius = 7
        cell.layer.borderColor = UIColor(red: 58/255.0, green: 59/255.0, blue: 60/255.0, alpha: 1.0).cgColor // set cell border color here
        cell.layer.masksToBounds = true
        return cell
    }
    
    
    @objc func didSelectASection(tapGest: UITapGestureRecognizer) {
        let section = tapGest.view!.tag
        if section == 0 {
            let obj = self.searchResu[section]
            self.searchResu[section].isSelectable = !obj.isSelectable
            
        } else {
            let obj = self.searchResu[section]
            self.searchResu[section].isSelected = !obj.isSelected
        }
        self.BranchesTableView.reloadData()
    }
    
    @IBAction func directionsAction(_ sender: UIButton) {
        let index = sender.tag
        let BranchLat = searchResu[index].Lat
        let l = Double(BranchLat) ?? 0.0
        let BranchLan = searchResu[index].Lng
        let lng = Double(BranchLan) ?? 0.0
        openMapsForLocation(BranchLat: l, BranchLng: lng)
    }
    
    func openMapsForLocation(BranchLat: Double, BranchLng: Double) {
        let location = CLLocation(latitude: BranchLat, longitude: BranchLng)
        print(location.coordinate)
        MKMapView.openMapsWith(location) { (error) in
            if error != nil {
                print("Could not open maps" + error!.localizedDescription)
            }
        }
    }
}
