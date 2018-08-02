//
//  TeamWorkCollectionViewController.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 8/8/17.
//  Copyright © 2017 Ahmed Wahdan. All rights reserved.
//

import UIKit
import Haneke


class TeamWorkCollectionViewController: UICollectionViewController, TeamWorkModelDelegate {
    
    var getTeamImagesArr:[GetTeamGallery] = [GetTeamGallery]()
    
    let TeamModel: TeamWorkModel = TeamWorkModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        assignbackground()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        TeamModel.delegate = self
        TeamModel.GetAllCompanyGallery(view: self.view, companyInfoID: "")
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func dataReady() {
        // Access the video objects that have been downloaded
        self.getTeamImagesArr = self.TeamModel.resultArray
        // Tell the tableview to reload
        collectionView?.reloadData()
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return getTeamImagesArr.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TeamWorkCollectionViewCell", for: indexPath) as! TeamWorkCollectionViewCell
    
        cell.layer.cornerRadius = 10
        cell.layer.borderColor = UIColor.black.cgColor // set cell border color here
        cell.layer.masksToBounds = true
    
        // Configure the cell
        
        let firstElem = getTeamImagesArr[indexPath.row].CompanyGalleryPath!
        let trimmedString = firstElem.trimmingCharacters(in: .whitespaces)
        if let url = URL.init(string: trimmedString) {
            print(url)
            cell.imageView.hnk_setImageFromURL(url)
        } else{
            print("nil")
        }
        
//        cell.configurecell(array[indexPath.row])
    
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "NewProject", bundle:nil)
        let secondView = storyBoard.instantiateViewController(withIdentifier: "GalaryViewController") as! GalaryViewController
        self.navigationController?.pushViewController(secondView, animated: true)
        secondView.AddItem1 = "dya"
        secondView.AddItemPhotos3 = getTeamImagesArr
        secondView.inde = indexPath
        secondView.collectionView?.reloadData()
        
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

}
