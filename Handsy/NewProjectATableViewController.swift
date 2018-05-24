//
//  NewProjectAViewController.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 7/24/17.
//  Copyright © 2017 Ahmed Wahdan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import MapKit

class NewProjectATableViewController: UITableViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var resultArray = [SelectSection]()
    var resultArray1 = [SelectSection]()
    var PrjTypeID = ""
    var BranchID = ""
    let pickerPlaceLable = UIPickerView()
    let pikerProjectLable = UIPickerView()
    var CompanyInfoID = ""
    var CompanyName = ""
    var CompanyAddress = ""
    var CompanyImage = ""
    var IsCompany = ""
    var LatBranch: Double = 0.0
    var LngBranch: Double = 0.0
    var EmpMobile = ""
    var ZoomBranch = ""
    var numberOfSak = ""
    var numberOfGat = ""
    var numberOfMo = ""
    var numberOfAl = ""
    var dateRghsa = ""
    var dateOfSak = ""
    var Notes = ""
    var spacePlace = ""
    
    
    @IBOutlet weak var nextBtn: UIButton! {
        didSet {
            DispatchQueue.main.async {
                self.nextBtn.circleView(UIColor.black, borderWidth: 1.0)
            }
        }
    }
    @IBOutlet weak var editOfficeOut: UIButton! {
        didSet {
            DispatchQueue.main.async {
                self.editOfficeOut.layer.cornerRadius = 7.0
            }
        }
    }
    
    @IBOutlet weak var alertProject: UILabel!
    
    
    @IBOutlet weak var chooseProjectLable: UITextField!
    
    
   
    
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var companyAddressLabel: UILabel!
    @IBOutlet weak var officeLogoImage: UIImageView!{
        didSet {
            DispatchQueue.main.async {
                self.officeLogoImage.layer.cornerRadius = 7.0
                self.officeLogoImage.layer.masksToBounds = true
            }
        }
    }
    
    @IBOutlet weak var NextView: UIView!
    
    let imageView = UIImageView(image: #imageLiteral(resourceName: "splash"))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GetProjecttypes()
        self.navigationItem.title = "بيانات الطلب"
//        self.navigationItem.hidesBackButton = true
        companyNameLabel.text = CompanyName
        companyAddressLabel.text = CompanyAddress
        let img = CompanyImage
        if let url = URL.init(string: img) {
            officeLogoImage.hnk_setImageFromURL(url, placeholder: #imageLiteral(resourceName: "officePlaceholder"))
        } else{
            print("nil")
            officeLogoImage.image = #imageLiteral(resourceName: "officePlaceholder")
        }
        self.view.sendSubview(toBack: self.imageView)
        assignbackground()
        pickerPlaceLable.delegate = self
        pickerPlaceLable.dataSource = self
        pikerProjectLable.delegate = self
        pikerProjectLable.dataSource = self
        chooseProjectLable.inputView = pikerProjectLable
        chooseProjectLable.setBottomBorderGray()
        
        DispatchQueue.main.async {
            self.NextView.frame = CGRect.init(x: 0 , y: self.tableView.frame.height-170, width: self.tableView.frame.width, height: 110)
            self.tableView.addSubview(self.NextView)
        }
        
        alertProject.isHidden = true
        
        let black = UIColor(red: 24.0/255.0, green: 23.0/255.0, blue: 23.0/255.0, alpha: 1.0)
        
        self.chooseProjectLable.AddImage(.left, imageName: "star", Frame: CGRect(x: 3, y: 0, width: 7, height: 7), backgroundColor: black)
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return resultArray1.count+1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            if row == 0{
                return "- اختر المشروع -"
            }else {
                return resultArray1[row-1].PrjTypeName
            }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
            if resultArray1.count != 0 {
                if row == 0 {
                    chooseProjectLable.text = nil
                }else {
                    chooseProjectLable.text = resultArray1[row-1].PrjTypeName
                    self.PrjTypeID = resultArray1[row-1].PrjTypeID
                }
                
            }
        self.view.endEditing(true)
    }
    
    
    @IBAction func Next(_ sender: UIButton) {
        let whitespaceSet = CharacterSet.whitespaces
        if chooseProjectLable.text != "" {
            let storyBoard : UIStoryboard = UIStoryboard(name: "NewProject", bundle:nil)
            let secondView = storyBoard.instantiateViewController(withIdentifier: "NewProjectCViewController") as! NewProjectCViewController
            self.navigationController?.pushViewController(secondView, animated: true)
            let selectProject = PrjTypeID
            
            secondView.selectSection = BranchID
            secondView.selectProject = selectProject
            secondView.numberOfSak = numberOfSak
            secondView.numberOfGat = numberOfGat
            secondView.numberOfMo = numberOfMo
            secondView.numberOfAl = numberOfAl
            secondView.spacePlace = spacePlace
            secondView.dateRagh = dateRghsa
            secondView.dateSk = dateOfSak
            secondView.note = Notes
            
            
        } else {
            if chooseProjectLable.text == "" {
                alertProject.isHidden = false
                chooseProjectLable.setBottomBorderRed()
                //                tableView.reloadRows(at: [IndexPath.init(row: 2, section: 0)], with: .automatic)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                DispatchQueue.main.async {
                    self.view.sendSubview(toBack: self.imageView)
                    self.assignbackground()
                }
            }
            
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
//        DispatchQueue.main.async {
//            self.tableView.reloadData()
//            self.view.sendSubview(toBack: self.imageView)
//            self.assignbackground()
//
//        }
        DispatchQueue.main.async {
            self.view.sendSubview(toBack: self.imageView)
            self.assignbackground()
        }
        return true
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
   
    
    //    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
    //        let rameview = UIView()
    //        rameview.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 300)
    //        self.tableView.tableFooterView = rameview
    //        return true
    //    }
    //
    //    func textFieldDidEndEditing(_ textField: UITextField) {
    //        self.tableView.tableFooterView = nil
    //    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
    }
    
    func assignbackground(){
        DispatchQueue.main.async {
            self.imageView.contentMode = .scaleAspectFill
            self.view.insertSubview(self.imageView, at: 0)
            self.imageView.translatesAutoresizingMaskIntoConstraints = false
            self.imageView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
            self.imageView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
            self.imageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
            self.imageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
            self.imageView.layoutIfNeeded()
        }
    }    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func GetProjecttypes() {
        
        let parameters: Parameters = [
            "branchID": BranchID
        ]
        
        Alamofire.request("http://smusers.promit2030.com/Service1.svc/GetProjecttypes", method: .get, parameters: parameters, encoding: URLEncoding.default).responseJSON { response in
            debugPrint(response)
            
            var arrayOfResulr = [SelectSection]()
            
            for json in JSON(response.result.value!).arrayValue {
                let nPostObj = SelectSection()
                
                nPostObj.PrjTypeName = json["PrjTypeName"].stringValue
                nPostObj.PrjTypeID = json["PrjTypeID"].stringValue
                arrayOfResulr.append(nPostObj)
                
            }
            
            self.resultArray1 = arrayOfResulr
            
            
        }
    }
    
    @IBAction func DetialsBtnAction(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "NewProject", bundle:nil)
        let secondView = storyBoard.instantiateViewController(withIdentifier: "DetailsOfOfficeTableViewController") as! DetailsOfOfficeTableViewController
        if IsCompany == "true" {
            secondView.isCompany = "1"
        } else {
            secondView.isCompany = "0"
        }
        secondView.CompanyInfoID = CompanyInfoID
        secondView.conditionService = "condition"
        secondView.LatBranch = LatBranch
        secondView.LngBranch = LngBranch
        self.navigationController?.pushViewController(secondView, animated: true)
    }
    
    
    @IBAction func directionBtn(_ sender: UIButton) {
        let location = CLLocation(latitude: LatBranch, longitude: LngBranch)
        print(location.coordinate)
        MKMapView.openMapsWith(location) { (error) in
            if error != nil {
                print("Could not open maps" + error!.localizedDescription)
            }
        }
    }
    
    @IBAction func CallMe(_ sender: UIButton) {
        let mobileNum = EmpMobile
        var mobile: String = (mobileNum)
        if mobile.count == 10 {
            if mobile.first! == "0" {
                if mobile[mobile.index(mobile.startIndex, offsetBy: 1)] == "5" {
                    mobile.remove(at: mobile.startIndex)
                    mobile.insert("6", at: mobile.startIndex)
                    mobile.insert("6", at: mobile.startIndex)
                    mobile.insert("9", at: mobile.startIndex)
                    callNumber(phoneNumber: mobile)
                } else {
                    callNumber(phoneNumber: mobile)
                }
            } else {
                callNumber(phoneNumber: mobile)
            }
        } else {
            callNumber(phoneNumber: mobile)
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
    
    @IBAction func chooseOfficeBtn(_ sender: UIButton) {
        self.navigationController!.popViewController(animated: true)
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView){
        assignbackground()
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
