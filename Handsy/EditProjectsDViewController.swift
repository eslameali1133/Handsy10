//
//  EditProjectsDViewController.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 11/30/17.
//  Copyright © 2017 Ahmed Wahdan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import ImagePicker


class EditProjectsDViewController: UIViewController, ImagePickerDelegate, UICollectionViewDelegate, UICollectionViewDataSource, DesplayImagesModelDelegate {
    
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
    
    var searchResu:[DesplayImagesArray] = [DesplayImagesArray]()
    let model: DesplayImagesModel = DesplayImagesModel()

    @IBOutlet weak var collectionImages: UICollectionView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var LoadLabelOut: UILabel!
    
    var AddItemPhotos: [UIImage] = []
    var ArrayOfImages: [String] = []
    var resultArray: [String] = []
    var AddItemPhotos1: [String] = []
    
    var BranchID: String = ""
    var BranchName: String = ""
    var CustmoerName: String = ""
    var CustomerEmail: String = ""
    var CustomerMobile: String = ""
    var CustomerNationalId: String = ""
    var DataSake: String = ""
    var DateLicence: String = ""
    var EmpImage: String = ""
    var EmpMobile: String = ""
    var EmpName: String = ""
    var GroundId: String = ""
    var IsDeleted: String = ""
    var JobName: String = ""
    var LatBranch: Double = 0.0
    var LatPrj: String = ""
    var LicenceNum: String = ""
    var LngBranch: Double = 0.0
    var LngPrj: String = ""
    var Notes: String = ""
    var PlanId: String = ""
    var ProjectBildTypeId: String = ""
    var ProjectEngComment: String = ""
    var ProjectId: String = ""
    var ProjectStatusColor: String = ""
    var ProjectStatusID: String = ""
    var ProjectStatusName: String = ""
    var ProjectTitle: String = ""
    var ProjectTypeId: String = ""
    var ProjectTypeName: String = ""
    var SakNum: String = ""
    var Space: String = ""
    var Status: String = ""
    var ZoomBranch: String = ""
    var ZoomPrj: String = ""
    var ProjectsImagePath: String = ""
    var ProjectsImageRotate: String = ""
    var ProjectsImageType: String = ""
    
    @IBOutlet var popUp: UIView!
    @IBOutlet weak var endBtn: UIButton!{
        didSet {
            DispatchQueue.main.async {
                self.endBtn.circleView(UIColor.clear, borderWidth: 1.0)
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.async {
            let width = ((self.collectionImages.frame.width)/4)-13
            print("width= \(width)")
            let height = width
            let size = CGSize(width: width, height: height)
            (self.collectionImages.collectionViewLayout as! UICollectionViewFlowLayout).itemSize = size
        }
        popUp.isHidden = true
        
        assignbackground()
        self.navigationItem.title = "وثائق و مستندات"
        self.navigationItem.hidesBackButton = true
        collectionImages.delegate = self
        collectionImages.dataSource = self
        
        
        model.delegate = self
        model.GetImageprojectByProjID(projectID: ProjectId, view: self.view)
        
        collectionImages.reloadData()        
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
        collectionImages.reloadData()
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
        UploadImage()
        collectionImages.isUserInteractionEnabled = false
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
        
        collectionImages.reloadData()
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
        let result = searchResu.count+1
        let newimages = AddItemPhotos.count
        let total = result + newimages
        return total
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionImages.dequeueReusableCell(withReuseIdentifier: "EditDImagesCollectionViewCell", for: indexPath) as! EditDImagesCollectionViewCell
        cell.layer.cornerRadius = 10
        cell.layer.borderColor = UIColor.clear.cgColor // set cell border color here
        cell.layer.masksToBounds = true
        if indexPath.row == 0 {
            cell.imageView.isHidden = true
            cell.PlusImage.image = UIImage(named: "addBtnFile")
            cell.PlusImage.contentMode = .scaleAspectFit
            cell.delete.isHidden = true
        } else{
            cell.delete.isHidden = false
            cell.imageView.isHidden = false
            cell.PlusImage.isHidden = false
            if indexPath.row <= searchResu.count {
                let row = indexPath.row-1
                let img = searchResu[row].ProjectsImagePath
                let trimmedString = img.trimmingCharacters(in: .whitespaces)
                if let url = URL.init(string: trimmedString) {
                    cell.imageView.hnk_setImageFromURL(url, placeholder: #imageLiteral(resourceName: "custlogo"))
                } else{
                    print("nil")
                }
            } else {
                let row = (indexPath.row-searchResu.count)-1
                cell.imageView.image = AddItemPhotos[row]
            }
           
        }
        return cell
    }

    @IBAction func xdeletNewImages(_ sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: collectionImages)
        let index = collectionImages.indexPathForItem(at: point)?.row
        print("inde: \(index!-1)")
        if index! <= searchResu.count {
            let image = searchResu[index!-1].ProjectsImageID
            ArrayOfImages.append(image)
            self.searchResu.remove(at: index!-1)
            collectionImages.reloadData()
        } else {
            self.AddItemPhotos.remove(at: (index!-1)-searchResu.count)
            collectionImages.reloadData()
        }
    }
    
    @IBAction func Back(_ sender: UIButton) {
        self.navigationController!.popViewController(animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            setupPicker()
        }else {
            
            let storyBoard : UIStoryboard = UIStoryboard(name: "NewProject", bundle:nil)
            let secondView = storyBoard.instantiateViewController(withIdentifier: "GalaryViewController") as! GalaryViewController
            self.navigationController?.pushViewController(secondView, animated: true)
            let data = self.searchResu
            secondView.AddItemPhotos = data
            let data1 = self.AddItemPhotos
            secondView.AddItemPhotos1 = data1
            secondView.cond = "lol"
            secondView.index = indexPath.row-1
            secondView.collectionView?.reloadData()
            
        }
        
    }
    
    
    
    func ProjectsDataUpdate(ImagesNew: String, ImagesDelete: String) {
        
        print(ProjectId)
        
        let Parameters: Parameters = [
            "projectId": ProjectId,
            "branchId": BranchID,
            "ProjectTypeId": ProjectTypeId,
            "groundId": GroundId,
            "planId": PlanId,
            "space": Space,
            "licenceNum": LicenceNum,
            "sakNum": SakNum,
            "dataSake": DataSake,
            "dateLicence": DateLicence,
            "lat": LatPrj,
            "lng": LngPrj,
            "zoom": ZoomPrj,
            "notes": Notes,
            "ImagesNew": ImagesNew,
            "ImagesDelete": ImagesDelete
        ]
        
        Alamofire.request("http://smusers.promit2030.com/Service1.svc/ProjectsDataUpdate", method: .get, parameters: Parameters, encoding: URLEncoding.default).responseJSON { response in
            debugPrint(response)
            let json = JSON(response.result.value!)
            print(json)
            
            self.EmpName = json["EmpName"].stringValue
            self.EmpMobile = json["Mobile"].stringValue
            self.BranchName = json["BranchName"].stringValue
            self.LatBranch = json["BranchLat"].doubleValue
            self.LngBranch = json["BranchLng"].doubleValue
            self.JobName = json["JobName"].stringValue
            self.ZoomBranch = json["Zoom"].stringValue
            self.EmpImage = json["EmpImage"].stringValue
            
            self.popUp.isHidden = false
            
        }
        
    }
    
    @IBAction func AlertEdit(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "ProjectsAndEdit", bundle:nil)
        let secondView = storyBoard.instantiateViewController(withIdentifier: "TheResponsibleEngineerEditViewController") as! TheResponsibleEngineerEditViewController
        //        self.show(secondView, sender: true)
        let BranchLat: Double = Double(LatBranch)
        let BranchLng: Double = Double(LngBranch)
        secondView.ProjectId = self.ProjectId
        secondView.BranchLat = BranchLat
        secondView.BranchLng = BranchLng
        secondView.zoomOffice = ZoomBranch
        secondView.BranchName = self.BranchName
        secondView.EmpName = self.EmpName
        secondView.JobName = self.JobName
        secondView.Mobile = self.EmpMobile
        secondView.EmpImage = self.EmpImage
        let topController = UIApplication.topViewController()
        topController?.show(secondView, sender: true)
        
    }
    
    
    func UploadImage() {
        
        print(AddItemPhotos)
        
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
            to: "http://handasy.promit2030.com/UploadFile/api.php",
            method: .post,
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    
                    upload.uploadProgress(closure: { (progress) in
                        self.progressView.progress = 0.0
                        self.activityIndicatorView.startAnimating()
                        self.LoadLabelOut.text = "|  فضلاانتظر... جاري ارسال الطلب."
                        self.progressView.setProgress(Float(progress.fractionCompleted), animated: true)
                        print(progress)
                    })
                    
                    upload.responseJSON { response in
                        
                        // If the request to get activities is succesfull, store them
                        if response.result.isSuccess{
                            print(response.debugDescription)
                            
                            
                            for json in JSON(response.result.value!).arrayValue {
                                
                                self.resultArray.append(json["ImageName"].stringValue)
                                
                            }
                            
                            let stringRepresentation = self.resultArray.joined(separator: ",")
                            let ImagesDelete = self.ArrayOfImages.joined(separator: ",")
                            self.ProjectsDataUpdate(ImagesNew: stringRepresentation, ImagesDelete: ImagesDelete)
                            
                            // Else throw an error
                        } else {
                            
                            var errorMessage = "ERROR MESSAGE: "
                            if let data = response.data {
                                // Print message
                                let responseJSON = try? JSON(data: data)
                                let alertController = UIAlertController(title: "خطأ في الاتصال!", message: "لم يتم ارسال الطلب\n برجاء المحاولة مرة اخرى", preferredStyle: .alert)
                                alertController.addAction(UIAlertAction(title: "اعادة المحاولة", style: .cancel, handler: { action in
                                    self.UploadImage()
                                    self.collectionImages.isUserInteractionEnabled = false
                                    self.sendBtn.isEnabled = false
                                    self.backBtn.isEnabled = false
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
                        self.UploadImage()
                        self.collectionImages.isUserInteractionEnabled = false
                        self.sendBtn.isEnabled = false
                        self.backBtn.isEnabled = false
                    }))
                    self.present(alertController, animated: true, completion: nil)
                }
        }
        )
        
        
    }
    
}
