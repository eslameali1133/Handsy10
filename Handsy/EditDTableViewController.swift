//
//  EditDTableViewController.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 10/9/17.
//  Copyright © 2017 Ahmed Wahdan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import ImagePicker

class EditDTableViewController: UITableViewController, ImagePickerDelegate, UICollectionViewDelegate, UICollectionViewDataSource, DesplayImagesModelDelegate {
    
    
    var searchResu:[DesplayImagesArray] = [DesplayImagesArray]()
    
    let model: DesplayImagesModel = DesplayImagesModel()
    
    @IBOutlet weak var displayImages: UICollectionView!
    @IBOutlet weak var newImages: UICollectionView!
    
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var progressView: UIProgressView!
    
    var AddItemPhotos: [UIImage] = []
    var AddItemPhotos1: [String] = []
    
    
    var ArrayOfImages: [String] = []
    var resultArray: [String] = []
    
    
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        assignbackground()
        self.navigationItem.title = "وثائق و مستندات"
        self.navigationItem.hidesBackButton = true
        displayImages.delegate = self
        displayImages.dataSource = self
        newImages.delegate = self
        newImages.dataSource = self
        
        
        model.delegate = self
        model.GetImageprojectByProjID(projectID: ProjectId, view: self.view)
        
        newImages.reloadData()
        displayImages.reloadData()
        
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
        displayImages.reloadData()
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
        displayImages.isUserInteractionEnabled = false
        newImages.isUserInteractionEnabled = false
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
        
        newImages.reloadData()
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
        if collectionView == self.displayImages {
            return searchResu.count
        }
        
        return AddItemPhotos.count+1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.newImages {
            let cell: ImagesEditCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImagesEditCollectionViewCell", for: indexPath) as! ImagesEditCollectionViewCell
            
            cell.layer.cornerRadius = 10
            cell.layer.borderColor = UIColor.clear.cgColor // set cell border color here
            cell.layer.masksToBounds = true
            
            if indexPath.row == 0 {
                cell.imageView.image = UIImage(named: "plus")
                cell.imageView.contentMode = .scaleAspectFit
                cell.delete.isHidden = true
            } else{
                cell.configurecell(AddItemPhotos[indexPath.row-1])
                cell.delete.isHidden = false
            }
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DisplayImageEditCollectionViewCell", for: indexPath) as! DisplayImageEditCollectionViewCell
            cell.layer.cornerRadius = 10
            cell.layer.borderColor = UIColor.clear.cgColor // set cell border color here
            cell.layer.masksToBounds = true
            
            let img = searchResu[indexPath.row].ProjectsImagePath
            let trimmedString = img.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
            if let url = URL.init(string: trimmedString!) {
                cell.imageView.hnk_setImageFromURL(url, placeholder: #imageLiteral(resourceName: "custlogo"))
            } else{
                print("nil")
            }
            
            return cell
        }
    }
    
    @IBAction func xdeletNewImages(_ sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: newImages)
        let index = newImages.indexPathForItem(at: point)?.row
        self.AddItemPhotos.remove(at: index!-1)
        newImages.reloadData()
    }
    
    @IBAction func xdeletDisplayImages(_ sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: displayImages)
        let index = displayImages.indexPathForItem(at: point)?.row
        let image = searchResu[index!].ProjectsImageID
        ArrayOfImages.append(image)
        self.searchResu.remove(at: index!)
        displayImages.reloadData()
        
    }
    
    
    @IBAction func Back(_ sender: UIButton) {
        self.navigationController!.popViewController(animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.row == 0 && collectionView == self.newImages {
            setupPicker()
        } else if collectionView == self.displayImages{
            let storyBoard : UIStoryboard = UIStoryboard(name: "NewProject", bundle:nil)
            let secondView = storyBoard.instantiateViewController(withIdentifier: "GalaryViewController") as! GalaryViewController
            self.navigationController?.pushViewController(secondView, animated: true)
            let data = self.searchResu
            secondView.AddItemPhotos = data
            secondView.inde = indexPath
            secondView.collectionView?.reloadData()
        } else{
            
            let storyBoard : UIStoryboard = UIStoryboard(name: "NewProject", bundle:nil)
            let secondView = storyBoard.instantiateViewController(withIdentifier: "GalaryViewController") as! GalaryViewController
            self.navigationController?.pushViewController(secondView, animated: true)
            let data = self.AddItemPhotos
            secondView.AddItemPhotos1 = data
            secondView.inde = indexPath
            secondView.collectionView?.reloadData()
        }
        
    }
    
    
    
    func ProjectsDataUpdate(ImagesNew: String, ImagesDelete: String) {
        
        print(ProjectId)
        self.activityIndicatorView.stopAnimating()
        
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
        
        Alamofire.request("http://smusers.promit2030.co/Service1.svc/ProjectsDataUpdate", method: .get, parameters: Parameters, encoding: URLEncoding.default).responseJSON { response in
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
            
            let storyBoard : UIStoryboard = UIStoryboard(name: "ProjectsAndEdit", bundle:nil)
            let secondView = storyBoard.instantiateViewController(withIdentifier: "EditeAlertViewController") as! EditeAlertViewController
            secondView.modalPresentationStyle = .custom
            let topController = UIApplication.topViewController()
            topController?.show(secondView, sender: true)
//            self.present(secondView, animated: true)
            secondView.ProjectId = self.ProjectId
            secondView.BranchLat = self.LatBranch
            secondView.BranchLng = self.LngBranch
            secondView.zoomOffice = self.ZoomBranch
            secondView.BranchName = self.BranchName
            secondView.EmpName = self.EmpName
            secondView.JobName = self.JobName
            secondView.Mobile = self.EmpMobile
            secondView.EmpImage = self.EmpImage
            
        }
        
    }
    
    //
    
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
            to: "http://handasy.promit2030.co/UploadFile/api.php",
            method: .post,
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    
                    upload.uploadProgress(closure: { (progress) in
                        self.progressView.progress = 0.0
                        self.activityIndicatorView.startAnimating()
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
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
