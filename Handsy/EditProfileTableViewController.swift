//
//  EditProfileTableViewController.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 8/17/17.
//  Copyright © 2017 Ahmed Wahdan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class EditProfileTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var imageProfile: AMCircleImageView!
    @IBOutlet weak var userName: DesignableUITextField!
    @IBOutlet weak var mobileNumber: UITextField!
    @IBOutlet weak var yellowViewOut: UIView!
    @IBOutlet weak var flagImage: UIImageView!{
        didSet {
            DispatchQueue.main.async {
                self.flagImage.layer.cornerRadius = 6.0
                self.flagImage.layer.masksToBounds = true
            }
        }
    }
    
//    @IBOutlet weak var Email: DesignableUITextField!
//    @IBOutlet weak var NationalId: DesignableUITextField!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var mobileLabel: UILabel!
//    @IBOutlet weak var emailLabel: UILabel!
//    @IBOutlet weak var NationalLabel: UILabel!
    
    
    @IBOutlet weak var EditWillDone: LoadingButton! {
        didSet {
            DispatchQueue.main.async {
                self.EditWillDone.circleView(UIColor.clear, borderWidth: 1.0)
            }
        }
    }
    
    var AddItemPhotos: [UIImage] = []
    var imagePath = ""
    var CustomerPhoto = URL(string: "")
    var code = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userName.text = UserDefaults.standard.string(forKey: "CustmoerName")
        let rightView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 10.0, height: 2.0))
        userName.rightView = rightView
        userName.rightViewMode = .always
        
        mobileNumber.text = UserDefaults.standard.string(forKey: "mobile")
//        Email.text = UserDefaults.standard.string(forKey: "Email")
        
//        NationalId.text = UserDefaults.standard.string(forKey: "NationalId")
        
        let firstElem = UserDefaults.standard.string(forKey: "CustomerPhoto")!
        let trimmedString = firstElem.trimmingCharacters(in: .whitespaces)
        if let url = URL.init(string: trimmedString) {
            print(url)
            imageProfile.hnk_setImageFromURL(url, placeholder: #imageLiteral(resourceName: "custlogo"))
        } else{
            print("nil")
        }
        
        
//        assignbackground()
        
//        Email.setBottomBorderGray()
//        NationalId.setBottomBorderGray()
        userName.setBottomBorderYellow()
//        NationalLabel.isHidden = true
        
        userLabel.textColor = UIColor.clear
        mobileLabel.textColor = UIColor.clear
//        emailLabel.textColor = UIColor.clear
        
        userName.delegate = self
        mobileNumber.delegate = self
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.black
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(donePicker))
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        mobileNumber.inputAccessoryView = toolBar
        // Do any additional setup after loading the view.
    }
    
    @objc func donePicker(){
        self.view.endEditing(true)
        let mobile = mobileNumber.text!
        if mobile.count == 10 {
            if mobile.first! == "0" {
                if mobile[mobile.index(mobile.startIndex, offsetBy: 1)] == "5" {
                    self.mobileLabel.textColor = UIColor.clear
                    self.EditWillDone.isEnabled = true
                }else {
                    self.EditWillDone.isEnabled = false
                    self.mobileLabel.text = "من فضلك تأكد من رقم الجوال"
                    self.mobileLabel.textColor = UIColor(red: 227/255.0, green: 75/255.0, blue: 59/255.0, alpha: 1.0)
                    self.mobileLabel.isHidden = false
                }
            }else {
                self.EditWillDone.isEnabled = false
                self.mobileLabel.text = "من فضلك تأكد من رقم الجوال"
                self.mobileLabel.textColor = UIColor(red: 227/255.0, green: 75/255.0, blue: 59/255.0, alpha: 1.0)
                self.mobileLabel.isHidden = false
            }
        }else {
            self.EditWillDone.isEnabled = false
            self.mobileLabel.text = "من فضلك تأكد من رقم الجوال"
            self.mobileLabel.textColor = UIColor(red: 227/255.0, green: 75/255.0, blue: 59/255.0, alpha: 1.0)
            self.mobileLabel.isHidden = false
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    @IBAction func TextFieldName(_ sender: UITextField) {
        print("text = \(userName.text!)")
        if validateName(text: userName.text!) {
            self.userLabel.textColor = UIColor.clear
             self.EditWillDone.isEnabled = true
        }else {
            self.EditWillDone.isEnabled = false
            userLabel.text = "فضلا ادخل اسمك"
            userLabel.textColor = UIColor(red: 227/255.0, green: 75/255.0, blue: 59/255.0, alpha: 1.0)
            userLabel.isHidden = false
        }
    }
    func validateName(text: String) -> Bool {
        var result = false
        let whitespaceSet = CharacterSet.whitespaces
        if !text.trimmingCharacters(in: whitespaceSet).isEmpty {
            result = true
        }
        return result
    }
    
    @IBAction func TextFieldDidEnd(_ sender: Any) {
        if validatePassword(text: mobileNumber.text!) {
            // correct password
            self.mobileLabel.textColor = UIColor.clear
            if mobileNumber.text?.count == 10 {
                self.EditWillDone.isEnabled = true
                self.view.endEditing(true)
            }
        } else {
            self.EditWillDone.isEnabled = false
            self.mobileLabel.textColor = UIColor(red: 227/255.0, green: 75/255.0, blue: 59/255.0, alpha: 1.0)
            self.mobileLabel.text = "من فضلك تأكد من رقم الجوال"
            self.mobileLabel.isHidden = false
        }
    }
    
    func validatePassword(text: String) -> Bool {
        var result = false
        if text.count == 1 {
            // test password
            if text.first == "0"{
                result = true
            }
        } else {
            if text.first == "0" {
                if text[text.index(text.startIndex, offsetBy: 1)] == "5" {
                    result = true
                }
                
            }
        }
        
        return result
    }
    
//    @IBAction func emailValidate(_ sender: DesignableUITextField) {
//        if validateEmail(Email.text!)
//        {
//            print("valid")
//        }
//        else
//        {
//
//            emailLabel.isHidden = false
//            print("NOT valid")
//        }
//
//    }
//
//
//    func validateEmail(_ candidate: String) -> Bool {
//        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
//        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: candidate)
//    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 4
    }
    
    @IBAction func UpdateImage(_ sender: UIButton) {
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = false
        let alert = UIAlertController(title: "اختر صورة شخصية", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "الكاميرا", style: .default, handler: { action in
            picker.sourceType = .camera
            picker.modalPresentationStyle = .fullScreen
            self.present(picker, animated: true)
        }))
        alert.addAction(UIAlertAction(title: "معرض الصور", style: .default, handler: { action in
            picker.sourceType = .photoLibrary
            picker.modalPresentationStyle = .fullScreen
            self.present(picker, animated: true)
        }))
        alert.addAction(UIAlertAction(title: "غلق", style: .destructive, handler: { action in
            
        }))
        
        self.present(alert, animated: true, completion: nil)
        //        if UIImagePickerController.isSourceTypeAvailable(.camera) {
        //            picker.sourceType = .camera
        //        } else {
        //            picker.sourceType = .photoLibrary
        //            picker.modalPresentationStyle = .fullScreen
        //        }
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [AnyHashable: Any]!) {
        //        imageProfile.contentMode = .scaleAspectFit
        
        let img = resizeImage(image: image)
        
        imageProfile.image = img
        
        AddItemPhotos.append(img)
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        //        let assetPath = info[UIImagePickerControllerReferenceURL] as! URL
        //        let imgName = assetPath.lastPathComponent
        
        if #available(iOS 11.0, *) {
            if let assetPath = info[UIImagePickerControllerImageURL] as? URL{
                let imgName = assetPath.lastPathComponent
                print(imgName)
                if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
                    imageProfile.image = pickedImage
                    print("image: \(pickedImage)")
                    CustomerPhoto = assetPath
                }
            }
        } else {
            // Fallback on earlier versions
        }
        dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
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
    func resizeImage(image: UIImage) -> UIImage {
        if image.size.height >= 1024 && image.size.width >= 1024 {
            
            UIGraphicsBeginImageContext(CGSize(width:1024, height:1024))
            image.draw(in: CGRect(x:0, y:0, width:1024, height:1024))
            
            let newImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            return newImage!
            
        }
        else if image.size.height >= 1024 && image.size.width < 1024
        {
            
            UIGraphicsBeginImageContext(CGSize(width:image.size.width, height:1024))
            image.draw(in: CGRect(x:0, y:0, width:image.size.width, height:1024))
            
            let newImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            return newImage!
            
        }
        else if image.size.width >= 1024 && image.size.height < 1024
        {
            
            UIGraphicsBeginImageContext(CGSize(width:1024, height:image.size.height))
            image.draw(in: CGRect(x:0, y:0, width:1024, height:image.size.height))
            
            let newImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            return newImage!
            
        }
        else
        {
            return image
        }
        
    }
    
    func CheckExistUsersData_Update() {
        let CustmoerId = UserDefaults.standard.string(forKey: "CustmoerId")
        let mobile = mobileNumber.text!
        let email = ""
        
        let parameters: Parameters = [
            "CustmoerId": CustmoerId!,
            "Mobile": mobile,
            "Email": email,
            "NationalId": ""
        ]
        
        Alamofire.request("http://smusers.promit2030.com/Service1.svc/CheckExistUsersData_Update", method: .get, parameters: parameters, encoding: URLEncoding.default).responseJSON { response in
            debugPrint(response)
            
            let json = JSON(response.result.value!)
            print(json)
            
//            let Email = json["Email"].stringValue
//            if Email == "false" {
//                self.Email.setBottomBorderRed()
//                self.emailLabel.textColor = UIColor(red: 227/255.0, green: 75/255.0, blue: 59/255.0, alpha: 1.0)
//                self.emailLabel.isHidden = false
//                self.emailLabel.text = "مسجل بالفعل"
//                let black = UIColor(red: 24.0/255.0, green: 23.0/255.0, blue: 23.0/255.0, alpha: 1.0)
//
//                self.Email.AddImage(.left, imageName: "round-error-symbol22", Frame: CGRect(x: 0, y: 0, width: 20, height: 20), backgroundColor: black)
//
//            }
            let Mobile = json["Mobile"].stringValue
            if Mobile == "false" {
                self.yellowViewOut.backgroundColor = UIColor(red: 230.0/255.0, green: 76.0/255.0, blue: 60.0/255.0, alpha: 1.0)
                self.mobileLabel.textColor = UIColor(red: 227/255.0, green: 75/255.0, blue: 59/255.0, alpha: 1.0)
                self.mobileLabel.isHidden = false
                self.mobileLabel.text = "مسجل بالفعل"
                let black = UIColor(red: 24.0/255.0, green: 23.0/255.0, blue: 23.0/255.0, alpha: 1.0)
                
                self.mobileNumber.AddImage(.right, imageName: "round-error-symbol22", Frame: CGRect(x: 0, y: 0, width: 20, height: 20), backgroundColor: black)
                
            }
//            let NationalId = json["NationalId"].stringValue
//            if NationalId == "false" {
//                self.NationalId.setBottomBorderRed()
//
//                self.NationalLabel.isHidden = false
//                self.NationalLabel.text = "مسجل بالفعل"
//                let black = UIColor(red: 24.0/255.0, green: 23.0/255.0, blue: 23.0/255.0, alpha: 1.0)
//
//                self.NationalId.AddImage(.left, imageName: "round-error-symbol22", Frame: CGRect(x: 0, y: 0, width: 20, height: 20), backgroundColor: black)
//
//            }
            if self.userName.text == "" {
                self.userName.setBottomBorderRed()
                self.userLabel.text = "فضلا ادخل اسمك"
                self.userLabel.textColor = UIColor(red: 227/255.0, green: 75/255.0, blue: 59/255.0, alpha: 1.0)
                self.userLabel.isHidden = false
                let black = UIColor(red: 24.0/255.0, green: 23.0/255.0, blue: 23.0/255.0, alpha: 1.0)
                
                self.userName.AddImage(.left, imageName: "round-error-symbol22", Frame: CGRect(x: 0, y: 0, width: 20, height: 20), backgroundColor: black)
            }
            
            if Mobile == "true" && self.userName.text != "" {
                self.UpdateCustomerProfile()
            }
            
        }
    }
    
    
    
    
    func UploadImage() {
        
        let parameters: Parameters = [
            "images[]" : AddItemPhotos,
            "token" : "abdoShabanTok"
        ]
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                
                for (key,value) in parameters {
                    if let value = value as? String {
                        multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
                    }
                }
                
                for (index ,image) in self.AddItemPhotos.enumerated() {
                    if  let imageData = UIImageJPEGRepresentation(image, 0.5){
                        multipartFormData.append(imageData, withName: "images[]", fileName: "images[]\(arc4random_uniform(100))"+"\(index)"+".jpeg", mimeType: "image/jpeg")
                    }
                }
        },
            usingThreshold:UInt64.init(),
            to: "http://handasy.promit2030.comm/UploadFile/apiEmp.php",
            method: .post,
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    self.UpdateCustomers(imagePath: self.imagePath)
                    upload.uploadProgress(closure: { (progress) in
                        print(progress)
                    })
                    
                    upload.responseJSON { response in
                        
                        // If the request to get activities is succesfull, store them
                        if response.result.isSuccess{
                            print(response.debugDescription)
                            
                            for json in JSON(response.result.value!).arrayValue {
                                let imageP = json["ImageName"].stringValue
                                self.imagePath = imageP
                                self.UpdateCustomers(imagePath: imageP)
                            }
                            
                            
                            //                            if self.imagePath != "" {
                            //                                print("wajs\(imageP)")
                            //                                self.UpdateCustomers(imageP: imageP)
                            //                            }else {
                            //                                print("wajsdak\(imageP)")
                            //                                self.UpdateCustomers(imageP: imageP)
                            //                            }
                            //                            for json in JSON(response.result.value!).arrayValue {
                            //
                            //                                self.resultArray.append(json["ImageName"].stringValue)
                            //
                            //                            }
                            //
                            //                            let stringRepresentation = self.resultArray.joined(separator: ",")
                            //
                            //                            self.UploadNameImages(array: stringRepresentation)
                            
                            // Else throw an error
                        } else {
                            //                            let sub = self.storyboard?.instantiateViewController(withIdentifier: "chooseOfficeViewController") as! chooseOfficeViewController
                            //                            sub.RegistrationDoneType = "Signl"
                            //                            sub.imagePath = self.imagePath
                            //                            sub.userName = self.userName.text!
                            //                            sub.email = self.Email.text!
                            //                            sub.NatId = self.NationalId.text!
                            //                            sub.mobile = self.mobileNumber.text!
                            //                            self.navigationController?.pushViewController(sub, animated: true)
                            var errorMessage = "ERROR MESSAGE: "
                            if let data = response.data {
                                // Print message
                                let responseJSON = try? JSON(data: data)
                                if let message: String = responseJSON!["error"]["message"].string {
                                    if !message.isEmpty {
                                        errorMessage += message
                                    }
                                }
                            }
                            print(errorMessage) //Contains General error message or specific.
                            print(response.debugDescription)
                        }
                        
                        
                    }
                case .failure(let encodingError):
                    print("FALLE ------------")
                    print(encodingError)
                }
        }
        )
        
        
    }
    
    
    
    @IBAction func EditDone(_ sender: UIButton) {
        if userName.text != "" {
            if mobileNumber.text != "" {
                EditWillDone.showLoading()
                CheckExistUsersData_Update()
            } else {
                mobileLabel.isHidden = false
            }
        } else {
            userLabel.isHidden = false
        }
    }
    
    func UpdateCustomers(imagePath: String) {
        let mobile = UserDefaults.standard.string(forKey: "mobile")!
        let NewMobileNumber = mobileNumber.text!
        if mobile == NewMobileNumber {
            let CustmoerId = UserDefaults.standard.string(forKey: "CustmoerId")!
            let UserId = UserDefaults.standard.string(forKey: "UserId")!
            let parameters: Parameters?
            parameters = [
                "CustmoerId": CustmoerId,
                "UserId": UserId,
                "CustmoerName": userName.text!,
                "Mobile": NewMobileNumber,
                "Email": "",
                "NationalId": "",
                "CustomerPhoto": imagePath,
                "CompanyInfoID": "1"
            ]
            
            Alamofire.request("http://smusers.promit2030.com/Service1.svc/UpdateCustomers", method: .get, parameters: parameters, encoding: URLEncoding.default).responseJSON { response in
                debugPrint(response)
                
                let json = JSON(response.result.value!)
                print(json)
                if json == "Done" {
                    self.GetEmptByMobileNum()
                    //                UserDefaults.standard.set(self.userName.text!, forKey: "CustmoerName")
                    //                UserDefaults.standard.set(self.mobileNumber.text! ,forKey: "mobile")
                    //                UserDefaults.standard.set(self.Email.text!, forKey: "Email")
                    //                UserDefaults.standard.set(imageP, forKey: "CustomerPhoto")
                    //                UserDefaults.standard.set(self.NationalId.text, forKey: "NationalId")
                    //
                    //
                    //                let sub = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
                    //                self.show(sub, sender: true)
                }
            }
        }else {
//            SendSmsCodeActivation()
            let storyBoard : UIStoryboard = UIStoryboard(name: "NewLogin", bundle:nil)
            let secondView = storyBoard.instantiateViewController(withIdentifier: "NewCheckCodeViewController") as! NewCheckCodeViewController
            secondView.mobile = self.mobileNumber.text!
            secondView.code = self.code
            secondView.UserName = self.userName.text!
            secondView.imagePath = self.imagePath
            secondView.conditionn = "lols"
            self.navigationController?.pushViewController(secondView, animated: true)
            self.EditWillDone.hideLoading()
        }
    }
    
    func SendSmsCodeActivation() {
        var mobileTest = mobileNumber.text!
        
        if mobileTest.count == 10 {
            if mobileTest.first! == "0" {
                if mobileTest[mobileTest.index(mobileTest.startIndex, offsetBy: 1)] == "5" {
//                    mobileTest.remove(at: mobileTest.startIndex)
//                    mobileTest.insert("6", at: mobileTest.startIndex)
//                    mobileTest.insert("6", at: mobileTest.startIndex)
//                    mobileTest.insert("9", at: mobileTest.startIndex)
                    print(mobileTest)
                    Alamofire.request("http://smusers.promit2030.com/Service1.svc/SendSmsCodeActivation?mobile=\(mobileTest)", method: .get).responseJSON { response in
                        debugPrint(response)
                        
                        let json = JSON(response.result.value!)
                        print(json)
                        
                        if json["Status"] == "OK" {
                            
                        }
                        self.code = json["Code"].stringValue
                        
                        let storyBoard : UIStoryboard = UIStoryboard(name: "NewLogin", bundle:nil)
                        let secondView = storyBoard.instantiateViewController(withIdentifier: "NewCheckCodeViewController") as! NewCheckCodeViewController
                        secondView.mobile = self.mobileNumber.text!
                        secondView.code = self.code
                        secondView.UserName = self.userName.text!
                        secondView.imagePath = self.imagePath
                        self.navigationController?.pushViewController(secondView, animated: true)
                        self.EditWillDone.hideLoading()
                    }
                    
                }
            }
        }
    }
    
    func GetEmptByMobileNum() {
        let mobile = UserDefaults.standard.string(forKey: "mobile")!
        Alamofire.request("http://smusers.promit2030.com/Service1.svc/GetEmptByMobileNum?mobileNum=\(mobile)", method: .get).responseJSON { response in
            debugPrint(response)
            
            let json = JSON(response.result.value!)
            print(json)
            
            if json["Mobile"].stringValue == "" {
                
                
                
            } else {
                self.PushInsertUpdate()
                UserDefaults.standard.set(json["UserId"].stringValue, forKey: "UserId")
                UserDefaults.standard.set(json["CustmoerName"].stringValue, forKey: "CustmoerName")
                UserDefaults.standard.set(json["Email"].stringValue, forKey: "Email")
                UserDefaults.standard.set(json["CustomerPhoto"].stringValue, forKey: "CustomerPhoto")
                UserDefaults.standard.set(json["Mobile"].stringValue, forKey: "mobile")
                let storyBoard : UIStoryboard = UIStoryboard(name: "Home", bundle:nil)
                let sub = storyBoard.instantiateViewController(withIdentifier: "AlertUpdateDateViewController") as! AlertUpdateDateViewController
                sub.modalPresentationStyle = .custom
                self.present(sub, animated: true)
                self.EditWillDone.hideLoading()
            }
            
        }
        
    }
    
    func PushInsertUpdate(){
        
        let CustmoerId = UserDefaults.standard.string(forKey: "CustmoerId")!
        let DeviceToken = UserDefaults.standard.string(forKey: "token")!
        let DeviceID = UserDefaults.standard.string(forKey: "udidKey")!
        let parameters: Parameters = [
            "CustmoerId":CustmoerId,
            "DeviceToken":DeviceToken,
            "TypeDevice":"1",
            "DeviceID":DeviceID
        ]
        
        Alamofire.request("http://smusers.promit2030.com/Service1.svc/PushInsertUpdate", method: .get, parameters: parameters, encoding: URLEncoding.default).responseJSON { response in
            let json = JSON(response.result.value!)
            print(json)
            
        }
    }
    
    func UpdateCustomerProfile() {
        let sv = UIViewController.displaySpinner(onView: self.view)
        let UserId = UserDefaults.standard.string(forKey: "UserId")!
        var parameters: Parameters = [:]
        let mobile = UserDefaults.standard.string(forKey: "mobile")!
        let NewMobileNumber = mobileNumber.text!
        if mobile == NewMobileNumber {
            if CustomerPhoto != nil {
                parameters = [
                    "UserId" : UserId,
                    "CustmoerName": userName.text!,
                    "CustomerPhoto": CustomerPhoto!,
                    "Mobile": NewMobileNumber
                ]
            }else {
                parameters = [
                    "UserId" : UserId,
                    "CustmoerName": userName.text!,
                    "CustomerPhoto": imagePath,
                    "Mobile": NewMobileNumber
                ]
            }
            
            Alamofire.upload(
                multipartFormData: { multipartFormData in
                    for (key,value) in parameters {
                        if let value = value as? String {
                            multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
                        }
                    }
                    if self.CustomerPhoto != nil {
                        multipartFormData.append(self.CustomerPhoto!, withName: "CustomerPhoto", fileName: "CustomerPhoto\(arc4random_uniform(100))"+".jpeg", mimeType: "image/jpeg")
                    }
            },
                usingThreshold:UInt64.init(),
                to: "http://smusers.promit2030.com/api/ApiService/UpdateCustomerProfile",
                method: .post,
                encodingCompletion: { encodingResult in
                    switch encodingResult {
                    case .success(let upload, _, _):
                        
                        upload.uploadProgress(closure: { (progress) in
                            print(progress)
                        })
                        upload.responseJSON { response in
                            // If the request to get activities is succesfull, store them
                            if response.result.isSuccess{
                                print(response.debugDescription)
                                
                                let json = JSON(response.result.value!)
                                print(json)
                                if json == "Done" {
                                    self.GetEmptByMobileNum()
                                }
                                
                                UIViewController.removeSpinner(spinner: sv)
                            } else {
                                var errorMessage = "ERROR MESSAGE: "
                                if let data = response.data {
                                    // Print message
                                    let responseJSON = try? JSON(data: data)
                                    let alertController = UIAlertController(title: "خطأ في الاتصال!", message: "لم يتم ارسال الطلب\n برجاء المحاولة مرة اخرى", preferredStyle: .alert)
                                    alertController.addAction(UIAlertAction(title: "اعادة المحاولة", style: .cancel, handler: { action in
                                        self.UpdateCustomerProfile()
                                        UIViewController.removeSpinner(spinner: sv)
                                    }))
                                    self.present(alertController, animated: true, completion: nil)
                                    
                                }
                                print(errorMessage) //Contains General error message or specific.
                                print(response.debugDescription)
                            }
                            
                            
                        }
                    case .failure(let encodingError):
                        print("FALLE ------------")
                        print(encodingError)
                        let alertController = UIAlertController(title: "خطأ في الاتصال!", message: "لم يتم ارسال الطلب\n برجاء المحاولة مرة اخرى", preferredStyle: .alert)
                        alertController.addAction(UIAlertAction(title: "اعادة المحاولة", style: .cancel, handler: { action in
                            self.UpdateCustomerProfile()
                            UIViewController.removeSpinner(spinner: sv)
                        }))
                        self.present(alertController, animated: true, completion: nil)
                    }
            }
            )
        }else {
//            SendSmsCodeActivation()
            let storyBoard : UIStoryboard = UIStoryboard(name: "NewLogin", bundle:nil)
            let secondView = storyBoard.instantiateViewController(withIdentifier: "NewCheckCodeViewController") as! NewCheckCodeViewController
            secondView.mobile = self.mobileNumber.text!
            secondView.code = self.code
            secondView.UserName = self.userName.text!
            secondView.CustomerPhotos = self.CustomerPhoto!
            secondView.imagePath = self.imagePath
            secondView.conditionn = "lols"
            self.navigationController?.pushViewController(secondView, animated: true)
            self.EditWillDone.hideLoading()
        }
    }
}
