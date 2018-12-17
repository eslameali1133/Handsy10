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
    var CompanyName1 = ""
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
   var flag = false
    var comfrom = false
   
    
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
    
    
    @IBOutlet weak var chooseProjectLable: UITextField!{
        didSet {
            chooseProjectLable.layer.borderWidth = 1.0
            chooseProjectLable.layer.borderColor = #colorLiteral(red: 0.2, green: 0.5647058824, blue: 0.3882352941, alpha: 1)
            chooseProjectLable.layer.cornerRadius = 6.0
        }
    }
    
    @IBOutlet weak var descriptionTV: UITextView!{
        didSet {
            descriptionTV.layer.borderWidth = 1.0
            descriptionTV.layer.borderColor = #colorLiteral(red: 0.2, green: 0.5647058824, blue: 0.3882352941, alpha: 1)
            descriptionTV.layer.cornerRadius = 6.0
        }
    }
    
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
     var AlertController: UIAlertController!
    override func viewDidLoad() {
        super.viewDidLoad()
        GetProjecttypes()
        self.navigationItem.title = "مشروع جديد"
//        self.navigationItem.hidesBackButton = true
        companyNameLabel.text = CompanyName
        companyAddressLabel.text = CompanyAddress
        let img = CompanyImage
        let trimmedString = img.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        if let url = URL.init(string: trimmedString!) {
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
//        chooseProjectLable.setBottomBorderYellow()
        
//        DispatchQueue.main.async {
//            self.NextView.frame = CGRect.init(x: 0 , y: self.tableView.frame.height-170, width: self.tableView.frame.width, height: 110)
//            self.tableView.addSubview(self.NextView)
//        }
        
        alertProject.isHidden = true
        
        let black = UIColor(red: 24.0/255.0, green: 23.0/255.0, blue: 23.0/255.0, alpha: 1.0)
        
        self.chooseProjectLable.AddImage(.left, imageName: "star", Frame: CGRect(x: 3, y: 0, width: 7, height: 7), backgroundColor: black)
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.black
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.bordered, target: self, action: #selector(AlertDesignOkViewController.donePicker))
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        descriptionTV.inputAccessoryView = toolBar
        
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "رجوع", style: UIBarButtonItemStyle.bordered, target: self, action: #selector(backAction(sender:)))
        self.navigationItem.leftBarButtonItem = newBackButton
        
        
        
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
    
    
    func backAction(sender: UIBarButtonItem) {
       
        if comfrom == true
        {
              comfrom = false
           
            let storyBoard : UIStoryboard = UIStoryboard(name: "NewHome", bundle:nil)
            let sub = storyBoard.instantiateViewController(withIdentifier: "NewMain") as! NewTabBarViewController
 sub.freshLaunch = true
            let appDelegate = UIApplication.shared.delegate as! AppDelegate

            appDelegate.window?.rootViewController = sub
//
         
//            let storyBoard : UIStoryboard = UIStoryboard(name: "NewProject", bundle:nil)
//            let secondView = storyBoard.instantiateViewController(withIdentifier: "OfficeFillterViewController") as! OfficeFillterViewController
//            let topController = UIApplication.topViewController()
//            topController?.show(secondView, sender: true)
            //            self.navigationController?.pushViewController(secondView, animated: true)
           
        }
        else
        {
        self.navigationController?.popViewController(animated: true)
        }
    }
    
    @objc func donePicker(){
        self.view.endEditing(true)
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
                        chooseProjectLable.setBottomBorderGray()
                    chooseProjectLable.textColor = UIColor.white
                    chooseProjectLable.text = resultArray1[row-1].PrjTypeName
                    self.PrjTypeID = resultArray1[row-1].PrjTypeID
                    flag = true
                }
                
            }
        self.view.endEditing(true)
    }
    
    
    @IBAction func Next(_ sender: UIButton) {
        let whitespaceSet = CharacterSet.whitespaces
        print(chooseProjectLable.text!)
        if (flag == true){
            let storyBoard : UIStoryboard = UIStoryboard(name: "NewProject", bundle:nil)
            let secondView = storyBoard.instantiateViewController(withIdentifier: "NewProjectCViewController") as! NewProjectCViewController
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
            secondView.note = descriptionTV.text!
            secondView.comwithoutlogin = comfrom
            self.navigationController?.pushViewController(secondView, animated: true)
        } else {
            if chooseProjectLable.text == "" {
                chooseProjectLable.text = "من فضلك اختر مشروع"
                chooseProjectLable.textColor = UIColor.red
                flag = false
//                alertProject.isHidden = false
                chooseProjectLable.setBottomBorderRed()
                //                tableView.reloadRows(at: [IndexPath.init(row: 2, section: 0)], with: .automatic)
//                DispatchQueue.main.async {
//                    self.tableView.reloadData()
//                }
//
//                viewDidLoad()
//                DispatchQueue.main.async {
//                    self.view.sendSubview(toBack: self.imageView)
//                    self.assignbackground()
//                    self.tableView.reloadData()
//                }
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
        return 3
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
        if indexPath.row == 1 {
            return tableView.frame.height/2.3
        }else {
            return 50
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 1 {
            return tableView.frame.height/2.3
        }else {
            return UITableViewAutomaticDimension
        }
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
        
        Alamofire.request("http://smusers.promit2030.co/Service1.svc/GetProjecttypes", method: .get, parameters: parameters, encoding: URLEncoding.default).responseJSON { response in
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
       
        let dLati =  LatBranch
        let dLang = LngBranch
        
        
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
//
//        self.present(AlertController, animated: true, completion: nil)
        if Helper.isDeviceiPad() {
            
            if let popoverController = AlertController.popoverPresentationController {
                popoverController.sourceView = sender
            }
        }
        
        self.present(AlertController, animated: true, completion: nil)
        
    }
    
    func openMapsForLocation() {
        let dLati = LatBranch
        let dLang = LngBranch
        let location = CLLocation(latitude: dLati, longitude: dLang)
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
        if comfrom == true
        {
            comfrom = false
            
            let storyBoard : UIStoryboard = UIStoryboard(name: "NewHome", bundle:nil)
            let sub = storyBoard.instantiateViewController(withIdentifier: "NewMain") as! NewTabBarViewController
            sub.freshLaunch = true
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            
            appDelegate.window?.rootViewController = sub
        }
        else
        {
            self.navigationController?.popViewController(animated: true)
        }
        
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
