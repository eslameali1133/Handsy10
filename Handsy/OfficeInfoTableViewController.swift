//
//  OfficeInfoTableViewController.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 2/22/18.
//  Copyright © 2018 Ahmed Wahdan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import MapKit

class OfficeInfoTableViewController: UITableViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource, ProvincesModelDelegate, SectionModelDelegate {
    var countryArray: [ProvincesArray] = [ProvincesArray]()
    let model: ProvincesModel = ProvincesModel()
    var neighborhood: [SectionArray] = [SectionArray]()
    let sectionModel: SectionModel = SectionModel()
    var arrayofCompanyType = [CompanyType]()
    var arrayOfBranchNumbers = ["1","2","3","4","5","6","7","8","9"]
    
    var provincesID = ""
    var SectionID = ""
    
    var nameOfCountry = ""
    var nameOfNeighborhood = ""
    
    var CompanyTypeID = ""
    
    var mobile = ""
    var isCompany = ""
    let pickercountryTF = UIPickerView()
    let pikerneighborhoodTF = UIPickerView()
    let pikerCompanyTypeTF = UIPickerView()
    let pikerBranchCountTF = UIPickerView()
    
    @IBOutlet weak var nameOFOffice: UILabel!
    @IBOutlet weak var nameOFOfficeTF: DesignableUITextField!
    @IBOutlet weak var nameOfCountryTF: DesignableUITextField!
    @IBOutlet weak var nameNeighborhoodTF: DesignableUITextField!
    @IBOutlet weak var companyTypeTF: DesignableUITextField!
    @IBOutlet weak var branchCountTF: DesignableUITextField!
    
    @IBOutlet weak var nextBtn: LoadingButton!
    
    @IBOutlet weak var checkBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
          self.navigationController?.setNavigationBarHidden(false, animated: true)
//        self.navigationController?.title = "طلب انضمام مكتب هندسي"
//        self.navigationController?.navigationBar.topItem!.title = "some title"
//        self.title = "eslam"
//         self.navigationItem.title = "Your Textssss"
//         addBackBarButtonItem()
//         self.navigationItem.title = "طلب انضمام مكتب هندسي"
        GetCompanyType()
        self.nextBtn.isEnabled = false
        nameOFOfficeTF.setBottomBorderGray()
        nameOFOfficeTF.delegate = self
        nameOfCountryTF.setBottomBorderGray()
        nameOFOfficeTF.delegate = self
        nameNeighborhoodTF.setBottomBorderGray()
        nameNeighborhoodTF.delegate = self
        companyTypeTF.setBottomBorderGray()
        companyTypeTF.delegate = self
        branchCountTF.setBottomBorderGray()
        branchCountTF.delegate = self
        
        if isCompany == "1"{
            nameOFOffice.text = "اسم المكتب"
        }else {
            nameOFOffice.text = "اسم المهندس"
        }
        
        pickercountryTF.delegate = self
        pickercountryTF.dataSource = self
        pikerneighborhoodTF.delegate = self
        pikerneighborhoodTF.dataSource = self
        pikerCompanyTypeTF.delegate = self
        pikerCompanyTypeTF.dataSource = self
        pikerBranchCountTF.delegate = self
        pikerBranchCountTF.dataSource = self
        nameOfCountryTF.inputView = pickercountryTF
        nameNeighborhoodTF.inputView = pikerneighborhoodTF
        companyTypeTF.inputView = pikerCompanyTypeTF
        branchCountTF.inputView = pikerBranchCountTF
        model.delegate = self
        model.GetProvincesReg(view: self.view, VC: self)
        sectionModel.delegate = self
        
    }
    
    func addBackBarButtonItem() {
        let shareButton = UIButton(type: .system)
        shareButton.setTitle("عودة", for: .normal)
        shareButton.setImage(UIImage(named: "DBackBtn"), for: .normal)
        shareButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        shareButton.sizeToFit()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: shareButton)
    }
    
    @objc func backButtonPressed(){
        self.navigationController!.popViewController(animated: true)
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if isCompany == "1" {
            if indexPath.row == 5 {
                return 0.0
            } else if indexPath.row == 6{
                return 98
            } else {
                return 85
            }
        }else {
            if indexPath.row == 5 {
                return 35
            } else if indexPath.row == 6{
                return 98
            } else {
                return 85
            }
        }
    }
    
    @IBAction func TFAction(_ sender: UITextField) {
        if isCompany == "1" {
            if validatePassword(text: nameOFOfficeTF.text!) && validatePassword(text: nameOfCountryTF.text!) && validatePassword(text: nameNeighborhoodTF.text!) && validatePassword(text: companyTypeTF.text!) && validatePassword(text: branchCountTF.text!){
                nextBtn.isEnabled = true
            }else {
                nextBtn.isEnabled = false
            }
        }else {
            if validatePassword(text: nameOFOfficeTF.text!) && validatePassword(text: nameOfCountryTF.text!) && validatePassword(text: nameNeighborhoodTF.text!) && validatePassword(text: companyTypeTF.text!) && validatePassword(text: branchCountTF.text!){
                if checkBtn.currentImage == #imageLiteral(resourceName: "acceptCheck") {
                    nextBtn.isEnabled = true
                }
            }else {
                nextBtn.isEnabled = false
            }
        }

    }
    
    
    func validatePassword(text: String) -> Bool {
        var result = false
        let whitespaceSet = CharacterSet.whitespaces
        if !text.trimmingCharacters(in: whitespaceSet).isEmpty {
            result = true
        }
        return result
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == pickercountryTF {
            return countryArray.count+1
        } else if pickerView == pikerCompanyTypeTF {
            return arrayofCompanyType.count+1
        } else if pickerView == pikerBranchCountTF {
            return arrayOfBranchNumbers.count+1
        } else {
            return neighborhood.count+1
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == pickercountryTF {
            if row == 0{
                return "- اختر المدينة -"
            }else {
                return countryArray[row-1].ProvincesName
            }
        } else if pickerView == pikerCompanyTypeTF {
            if row == 0{
                return "- اختر التخصص -"
            }else {
                return arrayofCompanyType[row-1].CompanyTypeName
            }
        } else if pickerView == pikerBranchCountTF {
            if row == 0{
                return "- اختر عدد الافرع -"
            }else {
                return arrayOfBranchNumbers[row-1]
            }
        } else {
            if nameOfCountryTF.text == "" {
                nameNeighborhoodTF.textColor = UIColor.red
                nameNeighborhoodTF.text = "برجاء إختيار المدينة اولا"
                nameNeighborhoodTF.isEnabled = false
            } else {
                nameNeighborhoodTF.textColor = UIColor.white
                nameNeighborhoodTF.text = ""
                nameNeighborhoodTF.isEnabled = true
            }
            if row == 0{
                return "- اختر الحي -"
            }else {
                return neighborhood[row-1].SectionName
            }
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == pickercountryTF {
            if countryArray.count != 0 {
                if row == 0 {
                    nameOfCountryTF.text = nil
                    nameNeighborhoodTF.text = nil
                }else {
                    nameOfCountryTF.text = countryArray[row-1].ProvincesName
                    self.nameOfCountry = countryArray[row-1].ProvincesName
                    provincesID = countryArray[row-1].ProvincesID
                    sectionModel.GetProvincesReg(view: self.view, provincesID: provincesID, VC: self)
                    nameNeighborhoodTF.textColor = UIColor.white
                    nameNeighborhoodTF.text = ""
                    nameNeighborhoodTF.isEnabled = true
                    if (nameNeighborhoodTF.text != "") && (nameOfCountryTF.text != "") && (nameOFOfficeTF.text != "") {
                        self.nextBtn.isEnabled = true
                    }else {
                        self.nextBtn.isEnabled = false
                    }
                }
            }
        } else if pickerView == pikerCompanyTypeTF {
            if arrayofCompanyType.count != 0 {
                if row == 0 {
                    companyTypeTF.text = nil
                }else {
                    companyTypeTF.text = arrayofCompanyType[row-1].CompanyTypeName
                    CompanyTypeID = arrayofCompanyType[row-1].CompanyTypeID
                }
            }
        } else if pickerView == pikerBranchCountTF {
            if row == 0 {
                branchCountTF.text = nil
            }else {
                branchCountTF.text = arrayOfBranchNumbers[row-1]
            }
        } else {
            if neighborhood.count != 0 {
                if row == 0 {
                    nameNeighborhoodTF.text = nil
                }else {
                    nameNeighborhoodTF.text = neighborhood[row-1].SectionName
                    self.nameOfNeighborhood = neighborhood[row-1].SectionName
                    SectionID = neighborhood[row-1].SectionID
                    if (nameNeighborhoodTF.text != "") && (nameOfCountryTF.text != "") && (nameOFOfficeTF.text != "") {
                        self.nextBtn.isEnabled = true
                    }else {
                        self.nextBtn.isEnabled = false
                    }
                }
                
            }
        }
        
        self.view.endEditing(true)
    }
    
    func dataReady() {
        // Access the video objects that have been downloaded
        self.countryArray = self.model.provincesArray
        // Tell the tableview to reload
        //        tableView.reloadData()
    }
    
    func addData() {
        self.neighborhood = self.sectionModel.sectionArray
    }
    
    func GetCompanyType(){
        let sv = UIViewController.displaySpinner(onView: self.view)
        self.arrayofCompanyType.removeAll()
        
        Alamofire.request("http://smusers.promit2030.co/Service1.svc/GetCompanyType", method: .get, encoding: URLEncoding.default).responseJSON { response in
            debugPrint(response)
            switch response.result {
            case .success:
                for json in JSON(response.result.value!).arrayValue {
                    let requestProjectObj = CompanyType()
                    requestProjectObj.CompanyTypeID = json["CompanyTypeID"].stringValue
                    requestProjectObj.CompanyTypeName = json["CompanyTypeName"].stringValue
                    
                    self.arrayofCompanyType.append(requestProjectObj)
                }
                self.tableView.reloadData()
                UIViewController.removeSpinner(spinner: sv)
            case .failure(let error):
                print(error)
                UIViewController.removeSpinner(spinner: sv)
                let alertAction = UIAlertController(title: "خطاء في الاتصال", message: "اعادة المحاولة", preferredStyle: .alert)
                
                alertAction.addAction(UIAlertAction(title: "نعم", style: .default, handler: { action in
                    self.GetCompanyType()
                }))
                
                alertAction.addAction(UIAlertAction(title: "رجوع", style: .cancel, handler: { action in
                    self.navigationController!.popViewController(animated: true)
                }))
                
                self.present(alertAction, animated: true, completion: nil)
                
            }
        }
        
    }
    @IBAction func checkAction(_ sender: UIButton) {
        if checkBtn.currentImage == #imageLiteral(resourceName: "unCheck") {
            checkBtn.setImage(#imageLiteral(resourceName: "acceptCheck"), for: .normal)
            if validatePassword(text: nameOFOfficeTF.text!) && validatePassword(text: nameOfCountryTF.text!) && validatePassword(text: nameNeighborhoodTF.text!) && validatePassword(text: companyTypeTF.text!) && validatePassword(text: branchCountTF.text!){
                nextBtn.isEnabled = true
            }else {
                nextBtn.isEnabled = false
            }
        }else {
            checkBtn.setImage(#imageLiteral(resourceName: "unCheck"), for: .normal)
            nextBtn.isEnabled = false
        }
    }
    
    @IBAction func NextStepAction(_ sender: LoadingButton) {
        self.nextBtn.showLoading()
        self.nextBtn.isEnabled = false
        if (nameNeighborhoodTF.text != "") && (nameOfCountryTF.text != "") && (nameOFOfficeTF.text != "") && (companyTypeTF.text != "") && (branchCountTF.text != "") {
            let storyBoard : UIStoryboard = UIStoryboard(name: "SignUpOffice", bundle:nil)
            let secondView = storyBoard.instantiateViewController(withIdentifier: "SetLocationOfOfficeViewController") as! SetLocationOfOfficeViewController
            secondView.mobile = self.mobile
            secondView.isCompany = self.isCompany
            secondView.ComapnyName = self.nameOFOfficeTF.text!
            secondView.SectionID = self.SectionID
            secondView.companyTypeID = CompanyTypeID
            secondView.bracnhCount = self.branchCountTF.text!
            self.navigationController?.pushViewController(secondView, animated: true)
            self.nextBtn.hideLoading()
        }else {
            self.nextBtn.isEnabled = true
            self.nextBtn.hideLoading()
        }
    }
    
}
