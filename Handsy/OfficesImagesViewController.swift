//
//  OfficesImagesViewController.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 12/17/17.
//  Copyright © 2017 Ahmed Wahdan. All rights reserved.
//

import UIKit

class OfficesImagesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var officesImagesCollection: UICollectionView!
    
    var getTeamImagesArr:[GetTeamGallery] = [GetTeamGallery]()
    
    var projectImagesArr:[GetProjectGallery] = [GetProjectGallery]()
    @IBOutlet weak var myView: UIView!
    
    var officeType = ""
    var CompanyInfoID = ""
    var CompanyName = ""
    var CompanyAddress = ""
    var CompanyImage = ""
    var branchId = ""
    var index: IndexPath?
    var conditionService = ""
    var IsCompany = ""
    
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
    
    override func viewDidLoad() {
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
        if officeType == "" {
            navigationItem.title = "مشاريع المكتب"
        } else {
            navigationItem.title = "فريق العمل"
        }
        officesImagesCollection.delegate = self
        officesImagesCollection.dataSource = self
        DispatchQueue.main.async {
            let width = self.view.frame.width
            let height = self.view.frame.height
            let size = CGSize(width: width, height: height)
            (self.officesImagesCollection.collectionViewLayout as! UICollectionViewFlowLayout).itemSize = size
        }
        DispatchQueue.main.async {
            self.officesImagesCollection.scrollToItem(at: self.index!, at: .centeredHorizontally, animated: false)
        }
        if IsCompany == "1" {
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
    @IBAction func closeBtnAction(_ sender: UIBarButtonItem) {
        self.navigationController!.popViewController(animated: true)
    }
    
    
    
    
    @IBAction func shareBtnAction(_ sender: UIBarButtonItem) {
        shareButtonPressed()
    }
    
    func shareButtonPressed() {
        let activityVC = UIActivityViewController(activityItems: ["http://promit2030.com/1"], applicationActivities: nil)
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
        let cell = officesImagesCollection.dequeueReusableCell(withReuseIdentifier: "OfficesImagesCollectionViewCell", for: indexPath) as! OfficesImagesCollectionViewCell
        if officeType == "" {
            let image = projectImagesArr[indexPath.row].ProjectGalleryPath
            cell.configureCell(image: image!)
        } else {
            let image = getTeamImagesArr[indexPath.row].CompanyGalleryPath
            cell.configureCell(image: image!)
        }
        return cell
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
        self.navigationController?.pushViewController(secondView, animated: true)
    }
    
    @IBAction func ChooseThisBtn(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "NewProject", bundle:nil)
        let secondView = storyBoard.instantiateViewController(withIdentifier: "NewProjectATableViewController") as! NewProjectATableViewController
        secondView.CompanyInfoID = self.CompanyInfoID
        secondView.CompanyName = self.CompanyName
        secondView.CompanyAddress = self.CompanyAddress
        secondView.CompanyImage = self.CompanyImage
        secondView.BranchID = self.branchId
        self.navigationController?.pushViewController(secondView, animated: true)
    }
    
    
    
}
