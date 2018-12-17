//
//  OfficesGallaryViewController.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 12/17/17.
//  Copyright © 2017 Ahmed Wahdan. All rights reserved.
//

import UIKit

class OfficesGallaryViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var officesCallaryCollection: UICollectionView!
    
    var getTeamImagesArr:[GetTeamGallery] = [GetTeamGallery]()
    
    var projectImagesArr:[GetProjectGallery] = [GetProjectGallery]()
    @IBOutlet weak var myView: UIView!
    
    var officeType = ""
    var CompanyInfoID = ""
    var CompanyName = ""
    var CompanyAddress = ""
    var CompanyImage = ""
    var branchId = ""
    var conditionService = ""
    var IsCompany = ""
    var LatBranch: Double = 0.0
    var LngBranch: Double = 0.0
    var EmpMobile = ""
    var ZoomBranch = ""
    
    @IBOutlet weak var dissmisBtnOut: UIButton!
    @IBOutlet weak var confirmBtn: UIButton!{
        didSet {
            DispatchQueue.main.async {
                self.confirmBtn.layer.cornerRadius = 7.0
                self.confirmBtn.layer.masksToBounds = true
            }
        }
    }
    
    @IBOutlet var PopUpViewOut: UIView!
       @IBOutlet var LoginVIew: UIView!
    override func viewDidLoad() {
        
        LoginVIew.isHidden = true
        self.LoginVIew.frame = CGRect.init(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        self.LoginVIew.center = self.view.center
        self.view.addSubview(self.LoginVIew)
        
        
        super.viewDidLoad()
        if conditionService != "" {
            myView.isHidden = true
        }
        PopUpViewOut.isHidden = true
        DispatchQueue.main.async {
            self.PopUpViewOut.frame = CGRect.init(x: 0, y: 0, width: 338, height: 165)
            self.PopUpViewOut.center = self.view.center
            self.view.addSubview(self.PopUpViewOut)
        }
        addBackBarButtonItem()
        addShareBarButtonItem()
        myView.layer.cornerRadius = 10.0
        if officeType == "" {
            navigationItem.title = "مشاريع المكتب"
        } else {
            navigationItem.title = "فريق العمل"
        }
        officesCallaryCollection.delegate = self
        officesCallaryCollection.dataSource = self
        DispatchQueue.main.async {
            let width = (self.officesCallaryCollection.frame.width/2)-12
            print("width= \(width)")
            let height = width
            let size = CGSize(width: width, height: height)
            (self.officesCallaryCollection.collectionViewLayout as! UICollectionViewFlowLayout).itemSize = size
        }
        print(IsCompany)
        if IsCompany == "True" {
            self.chooseOut.setTitle("اختار المكتب", for: .normal)
        }else {
            self.chooseOut.setTitle("اختار المهندس", for: .normal)
        }
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    func addShareBarButtonItem() {
        let shareButton = UIButton(type: .system)
        shareButton.setImage(UIImage(named: "ShareBtn"), for: .normal)
        shareButton.addTarget(self, action: #selector(shareButtonPressed), for: .touchUpInside)
        shareButton.sizeToFit()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: shareButton)
    }
    
    @objc func shareButtonPressed() {
        let activityVC = UIActivityViewController(activityItems: ["http://promit2030.co/1"], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        self.present(activityVC, animated: true, completion: nil)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if officeType == "" {
            return projectImagesArr.count
        } else {
            return getTeamImagesArr.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = officesCallaryCollection.dequeueReusableCell(withReuseIdentifier: "OfficesGallaryCollectionViewCell", for: indexPath) as! OfficesGallaryCollectionViewCell
        if officeType == "" {
            let image = projectImagesArr[indexPath.row].ProjectGalleryPath
            cell.configureCell(image: image!)
        } else {
            let image = getTeamImagesArr[indexPath.row].CompanyGalleryPath
            cell.configureCell(image: image!)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if officeType == "" {
            let storyBoard : UIStoryboard = UIStoryboard(name: "NewProject", bundle:nil)
            let secondView = storyBoard.instantiateViewController(withIdentifier: "OfficesImagesViewController") as! OfficesImagesViewController
            secondView.CompanyInfoID = CompanyInfoID
            secondView.CompanyName = self.CompanyName
            secondView.CompanyAddress = self.CompanyAddress
            secondView.CompanyImage = self.CompanyImage
            secondView.branchId = self.branchId
            secondView.projectImagesArr = self.projectImagesArr
            secondView.index = indexPath
            secondView.conditionService = self.conditionService
            secondView.IsCompany = self.IsCompany
            secondView.EmpMobile = self.EmpMobile
            secondView.LatBranch = self.LatBranch
            secondView.LngBranch = self.LngBranch
            secondView.ZoomBranch = self.ZoomBranch
            
            self.navigationController?.pushViewController(secondView, animated: true)
        } else {
            let storyBoard : UIStoryboard = UIStoryboard(name: "NewProject", bundle:nil)
            let secondView = storyBoard.instantiateViewController(withIdentifier: "OfficesImagesViewController") as! OfficesImagesViewController
            secondView.CompanyInfoID = CompanyInfoID
            secondView.CompanyName = self.CompanyName
            secondView.CompanyAddress = self.CompanyAddress
            secondView.CompanyImage = self.CompanyImage
            secondView.branchId = self.branchId
            secondView.getTeamImagesArr = self.getTeamImagesArr
            secondView.officeType = "Team"
            secondView.index = indexPath
            secondView.conditionService = self.conditionService
            secondView.IsCompany = self.IsCompany
            secondView.EmpMobile = self.EmpMobile
            secondView.LatBranch = self.LatBranch
            secondView.LngBranch = self.LngBranch
            secondView.ZoomBranch = self.ZoomBranch
            self.navigationController?.pushViewController(secondView, animated: true)
        }
    }
    
    @IBOutlet weak var chooseOut: UIButton!{
        didSet {
            DispatchQueue.main.async {
                self.chooseOut.layer.cornerRadius = 7.0
                self.chooseOut.layer.masksToBounds = true
            }
        }
    }
    
    @IBAction func dissmisBtn(_ sender: UIButton) {
        PopUpViewOut.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        PopUpViewOut.isHidden = true
    }
    
    @IBAction func confirmChooseThisBtn(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "NewProject", bundle:nil)
        let secondView = storyBoard.instantiateViewController(withIdentifier: "NewProjectATableViewController") as! NewProjectATableViewController
        secondView.CompanyInfoID = self.CompanyInfoID
        secondView.CompanyName = self.CompanyName
        secondView.CompanyAddress = self.CompanyAddress
        secondView.CompanyImage = self.CompanyImage
        secondView.BranchID = self.branchId
        secondView.EmpMobile = self.EmpMobile
        secondView.IsCompany = self.IsCompany
        secondView.LatBranch = self.LatBranch
        secondView.LngBranch = self.LngBranch
        secondView.ZoomBranch = self.ZoomBranch
        self.navigationController?.pushViewController(secondView, animated: true)
    }
    
    
    @IBAction func EndLoginView(_ sender: Any) {
        LoginVIew.isHidden = true
    }
    @IBAction func GtoLoginBtn(_ sender: UIButton) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "NewLogin", bundle:nil)
        let secondView = storyBoard.instantiateViewController(withIdentifier: "NewLoginViewController") as! NewLoginViewController
        secondView.isComingFromProject = true
        secondView.CompanyInfoID = self.CompanyInfoID
        secondView.CompanyName = self.CompanyName
        secondView.CompanyAddress = self.CompanyAddress
        secondView.CompanyImage = self.CompanyImage
        secondView.BranchID = self.branchId
        secondView.EmpMobile = self.EmpMobile
        secondView.IsCompany = self.IsCompany
        secondView.LatBranch = self.LatBranch
        secondView.LngBranch = self.LngBranch
        secondView.ZoomBranch = self.ZoomBranch
        
        self.navigationController?.pushViewController(secondView, animated: true)
        
    }
    @IBAction func ChooseThisBtn(_ sender: UIButton) {
        let CustmoerId = UserDefaults.standard.string(forKey: "CustmoerId")
        if CustmoerId == nil
        {
            LoginVIew.isHidden = false
        }
        else
        {
        let storyBoard : UIStoryboard = UIStoryboard(name: "NewProject", bundle:nil)
        let secondView = storyBoard.instantiateViewController(withIdentifier: "NewProjectATableViewController") as! NewProjectATableViewController
        secondView.CompanyInfoID = self.CompanyInfoID
        secondView.CompanyName = self.CompanyName
        secondView.CompanyAddress = self.CompanyAddress
        secondView.CompanyImage = self.CompanyImage
        secondView.BranchID = self.branchId
        secondView.EmpMobile = self.EmpMobile
        secondView.IsCompany = self.IsCompany
        secondView.LatBranch = self.LatBranch
        secondView.LngBranch = self.LngBranch
        secondView.ZoomBranch = self.ZoomBranch
        self.navigationController?.pushViewController(secondView, animated: true)
        }
    }
    
}
