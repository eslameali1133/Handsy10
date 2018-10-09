//
//  NewProjectDViewController.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 7/25/17.
//  Copyright © 2017 Ahmed Wahdan. All rights reserved.
//

import UIKit
import ImagePicker
import Alamofire
import SwiftyJSON



class NewProjectDViewController: UIViewController, ImagePickerDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet var progressView: UIProgressView!
    @IBOutlet var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var uploadLabel: UILabel!
    
    var AddItemPhotos: [UIImage] = []
    
    var resultArray: [String] = []
    
    @IBOutlet var collectionView: UICollectionView!
    
    
    @IBOutlet weak var sendBtn: UIButton! {
        didSet {
            DispatchQueue.main.async {
                self.sendBtn.circleView(UIColor.black, borderWidth: 1.0)
            }
        }
    }
    
    @IBOutlet weak var backBtn: UIButton! {
        didSet {
            DispatchQueue.main.async {
                self.backBtn.circleView(UIColor.black, borderWidth: 1.0)
            }
        }
    }
    
    var selectSection = ""
    var selectProject = ""
    var numberOfSak = ""
    var numberOfGat = ""
    var numberOfMo = ""
    var numberOfAl = ""
    var spacePlace = ""
    var dateRagh = ""
    var dateSk = ""
    var note = ""
    var latu = ""
    var long = ""
    var zoom = ""
    var ProjectId = ""
    var BranchLat = ""
    var BranchLng = ""
    var EmpName = ""
    var Mobile = ""
    var EmpImage = ""
    var JobName = ""
    var BranchName = ""
    var zoomOffice = ""
    var conditionCamCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "وثائق و مستندات"
        self.navigationItem.hidesBackButton = true
        assignbackground()
        DispatchQueue.main.async {
            let width = ((self.collectionView.frame.width)/4)-13
            print("width= \(width)")
            let height = width
            let size = CGSize(width: width, height: height)
            (self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout).itemSize = size
        }
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.reloadData()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    @IBAction func sendRequest(_ sender: UIButton) {
        self.UploadImage()
      
        collectionView.isUserInteractionEnabled = false
        sendBtn.isEnabled = false
        backBtn.isEnabled = false
    }
    
    
    func setupPicker() {
        var config = Configuration()
        config.doneButtonTitle = "Finish"
        config.noImagesTitle = "Sorry! There are no images here!"
        config.recordLocation = false
        config.allowMultiplePhotoSelection = true
        
        let imagePicker = ImagePickerController()
        imagePicker.delegate = self
        imagePicker.imageLimit = 15
        present(imagePicker, animated: true, completion: nil)
    }
    
    func cancelButtonDidPress(_ imagePicker: ImagePickerController) {
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    func doneButtonDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        AddItemPhotos += images
        imagePicker.dismiss(animated: true, completion: nil)
        collectionView.reloadData()
    }
    
    func wrapperDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        AddItemPhotos += images
    }
    
    // MARK: UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return AddItemPhotos.count+1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: ImageCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as! ImageCollectionViewCell
        
        cell.layer.cornerRadius = 10
        cell.layer.borderColor = UIColor.clear.cgColor // set cell border color here
        cell.layer.masksToBounds = true
        
        if indexPath.row == 0 {
            cell.imageView.isHidden = true
            cell.PlusImage.image = UIImage(named: "addBtnFile")
            cell.PlusImage.contentMode = .scaleAspectFit
            cell.delete.isHidden = true
        } else{
            cell.imageView.isHidden = false
            cell.configurecell(AddItemPhotos[indexPath.row-1])
            cell.delete.isHidden = false
        }
        
        return cell
    }
    @IBAction func xdelet(_ sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: collectionView)
        let index = collectionView.indexPathForItem(at: point)?.row
        self.AddItemPhotos.remove(at: index!-1)
        collectionView.reloadData()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            self.setupPicker()
        } else {
            let storyBoard : UIStoryboard = UIStoryboard(name: "NewProject", bundle:nil)
            let secondView = storyBoard.instantiateViewController(withIdentifier: "GalaryViewController") as! GalaryViewController
            self.navigationController?.pushViewController(secondView, animated: true)
            let data = self.AddItemPhotos
            secondView.AddItemPhotos1 = data
            secondView.inde = indexPath
            secondView.collectionView?.reloadData()
        }
        
    }
    func popUpCamera() {
        if let conditionCamCount = UserDefaults.standard.string(forKey: "conditionCamCount"){
            if conditionCamCount == "0" {
                let alertAction = UIAlertController(title: "تفعيل الكاميرا", message: "اضغط موافقة لتتمكن من إرفاق المستندات والصور عن مشروعك", preferredStyle: .alert)
                
                alertAction.addAction(UIAlertAction(title: "موافقة", style: .default, handler: { action in
                    UserDefaults.standard.set("1", forKey: "conditionCamCount")
                    self.setupPicker()
                }))
                
                alertAction.addAction(UIAlertAction(title: "رجوع", style: .cancel, handler: { action in
                }))
                self.present(alertAction, animated: true, completion: nil)
            }else {
                self.setupPicker()
            }
        }else {
            if conditionCamCount == 0 {
                let alertAction = UIAlertController(title: "تفعيل الكاميرا", message: "اضغط موافقة لتتمكن من إرفاق المستندات والصور عن مشروعك", preferredStyle: .alert)
                
                alertAction.addAction(UIAlertAction(title: "موافقة", style: .default, handler: { action in
                    UserDefaults.standard.set("1", forKey: "conditionCamCount")
                    self.setupPicker()
                }))
                
                alertAction.addAction(UIAlertAction(title: "رجوع", style: .cancel, handler: { action in
                }))
                self.present(alertAction, animated: true, completion: nil)
            }
        }
        
    }
    @IBAction func BackBtn(_ sender: UIButton) {
        self.navigationController!.popViewController(animated: true)
    }
    
    func ProjectsDataSave(arrayOfImagesPaths: String) {
          let sv = UIViewController.displaySpinner(onView: self.view)
         self.uploadLabel.text = "جاري ارسال الطلب...."
        let headers: HTTPHeaders = [
           
            "Accept": "application/json"
        ]
        let Parameters: Parameters = [
            "custmoerId": UserDefaults.standard.string(forKey: "CustmoerId")!,
            "userId": UserDefaults.standard.string(forKey: "UserId")!,
            "branchId": selectSection,
            "ProjectTypeId": selectProject,
            "groundId": numberOfGat,
            "planId": numberOfMo,
            "space": spacePlace,
            "licenceNum": numberOfAl,
            "sakNum": numberOfSak,
            "dataSake": dateSk,
            "dateLicence": dateRagh,
            "lat": latu,
            "lng": long,
            "zoom": zoom,
            "notes": note,
            "images": arrayOfImagesPaths
        ]
        
        print(Parameters)
        Alamofire.request("http://smusers.promit2030.com/Service1.svc/ProjectsDataSave", method: .get, parameters: Parameters, encoding: URLEncoding.default,headers:headers).responseJSON { response in
            debugPrint(response)
            switch response.result {
            case .success:
                let json = JSON(response.result.value!)
                print(json)
                
                self.ProjectId = json["ProjectId"].stringValue
                self.BranchLat = json["BranchLat"].stringValue
                self.BranchLng = json["BranchLng"].stringValue
                self.EmpName = json["EmpName"].stringValue
                self.Mobile = json["Mobile"].stringValue
                self.EmpImage = json["EmpImage"].stringValue
                self.JobName = json["JobName"].stringValue
                self.BranchName = json["BranchName"].stringValue
                self.zoomOffice = json["Zoom"].stringValue
                
                let storyBoard : UIStoryboard = UIStoryboard(name: "ProjectsAndEdit", bundle:nil)
                let secondView = storyBoard.instantiateViewController(withIdentifier: "TheResponsibleEngineerViewController") as! TheResponsibleEngineerViewController
                secondView.BranchLat = self.BranchLat
                secondView.BranchLng = self.BranchLng
                secondView.zoomOffice = self.zoomOffice
                secondView.BranchName = self.BranchName
                secondView.EmpName = self.EmpName
                secondView.JobName = self.JobName
                secondView.Mobile = self.Mobile
                secondView.EmpImage = self.EmpImage
                secondView.ProjectId = self.ProjectId
                
                
                
                
                self.navigationController?.pushViewController(secondView, animated: true)
                UIViewController.removeSpinner(spinner: sv)
            case .failure(let error):
                UIViewController.removeSpinner(spinner: sv)
                print(error)
                let alertAction = UIAlertController(title: "خطاء في الاتصال", message: "اعادة المحاولة", preferredStyle: .alert)
                
                alertAction.addAction(UIAlertAction(title: "نعم", style: .default, handler: { action in
                    self.ProjectsDataSave(arrayOfImagesPaths:arrayOfImagesPaths)
                }))
                
                alertAction.addAction(UIAlertAction(title: "رجوع", style: .cancel, handler: { action in
                    self.collectionView.isUserInteractionEnabled = true
                    self.sendBtn.isEnabled = true
                    self.backBtn.isEnabled = true
                }))
                
                self.present(alertAction, animated: true, completion: nil)
                
            }
        }
        
    }
    
    var Add: [UIImage] = [#imageLiteral(resourceName: "Wahdan"),#imageLiteral(resourceName: "male")]
    //
    //    let img: UIImage = #imageLiteral(resourceName: "Wahdan")
    
    func UploadImage() {
        
        
        
        let url = "http://smusers.promit2030.com/api/ApiService/UploadProjectImage"
        let trimmedString = url.trimmingCharacters(in: .whitespaces)
        print(Add)
        print(AddItemPhotos)
        let headers: HTTPHeaders = [
            /* "Authorization": "your_access_token",  in case you need authorization header */
          "Content-type": "multipart/form-data"
        ]
      

        let parameters: Parameters = [
            "Image" : AddItemPhotos,
          
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
                        multipartFormData.append(imageData, withName: "Image", fileName: "Uploadimage\(arc4random_uniform(100))"+"\(index)"+".jpeg", mimeType: "image/jpeg")
                    }
                }
        },
            usingThreshold:UInt64.init(),
            to:trimmedString,
            method: .post,headers:headers,
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):

                    upload.uploadProgress(closure: { (progress) in
                        self.progressView.progress = 0.0
                        self.activityIndicatorView.startAnimating()
                        self.uploadLabel.text = "جاري الرفع...."
                        self.progressView.setProgress(Float(progress.fractionCompleted), animated: true)
                        print(progress)

                       

                    })
                   
                    upload.responseJSON { response in
                  debugPrint(response)
                        // If the request to get activities is succesfull, store them
                        if response.result.isSuccess{
                            print(response.debugDescription)
 let json = JSON(response.result.value!)
//                            for json in JSON(response.result.value!).arrayValue {
//
//                                self.resultArray.append(json["Image"].stringValue)
//
//                            }
                            print(json)

                            let stringRepresentation = json["Image"].stringValue
//                                self.resultArray.joined(separator: ",")
print(stringRepresentation)
                            self.ProjectsDataSave(arrayOfImagesPaths: stringRepresentation)
                 
                            // Else throw an error
                        } else {

                            var errorMessage = "ERROR MESSAGE: "
                            if let data = response.data {
                               
//                                 Print message
                                let responseJSON = try? JSON(data: data)
                                let alertController = UIAlertController(title: "خطأ في الاتصال!", message: "لم يتم ارسال الطلب\n برجاء المحاولة مرة اخرى", preferredStyle: .alert)
                                alertController.addAction(UIAlertAction(title: "اعادة المحاولة", style: .cancel, handler: { action in
                                    self.UploadImage()
                                    self.collectionView.isUserInteractionEnabled = false
                                    self.sendBtn.isEnabled = false
                                    self.backBtn.isEnabled = false
                                }))
                                self.present(alertController, animated: true, completion: nil)
//
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
                        self.UploadImage()
                        self.collectionView.isUserInteractionEnabled = false
                        self.sendBtn.isEnabled = false
                        self.backBtn.isEnabled = false
                    }))
                    self.present(alertController, animated: true, completion: nil)
                }
        }
        )


        
        
        
    }
    
    func UploadNameImages(array: String) {
        
        print(array)
        print(ProjectId)
        
        let parameters: Parameters = [
            "projectsImagePath" : array,
            "projectId" : ProjectId,
            "projectsImageType":"1",
            "ProjectsImageRotate":"1"
        ]
        
        Alamofire.request("http://smusers.promit2030.com/Service1.svc/UploadImage", method: .get, parameters: parameters, encoding: URLEncoding.default).responseJSON { response in
            debugPrint(response)
            let json = JSON(response.result.value!)
            if json.stringValue == "Done" {
                let storyBoard : UIStoryboard = UIStoryboard(name: "ProjectsAndEdit", bundle:nil)
                let secondView = storyBoard.instantiateViewController(withIdentifier: "TheResponsibleEngineerViewController") as! TheResponsibleEngineerViewController
                self.navigationController?.pushViewController(secondView, animated: true)
                secondView.BranchLat = self.BranchLat
                secondView.BranchLng = self.BranchLng
                secondView.zoomOffice = self.zoomOffice
                secondView.BranchName = self.BranchName
                secondView.EmpName = self.EmpName
                secondView.JobName = self.JobName
                secondView.Mobile = self.Mobile
                secondView.EmpImage = self.EmpImage
                secondView.ProjectId = self.ProjectId
                
            }
        }
    }
}






