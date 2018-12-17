//
//  OtherViewCollectionViewController.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 1/6/18.
//  Copyright © 2018 Ahmed Wahdan. All rights reserved.
//

import UIKit
import Haneke


class OtherViewCollectionViewController: UICollectionViewController, DesplayImagesModelDelegate {
    var ProjectId = ""
    var searchResu:[DesplayImagesArray] = [DesplayImagesArray]()
    
    let model: DesplayImagesModel = DesplayImagesModel()
    
    let displayImagesModel: DisplayImagesModel = DisplayImagesModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            let width = ((self.collectionView?.frame.width)!/4)-13
            print("width= \(width)")
            let height = width
            let size = CGSize(width: width, height: height)
            (self.collectionView?.collectionViewLayout as! UICollectionViewFlowLayout).itemSize = size
        }
        DispatchQueue.main.async {
            if #available(iOS 11, *) {
                self.collectionView?.contentInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
            } else {
                self.collectionView?.contentInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
            }
            
        }
        model.delegate = self
        if Reachability.isConnectedToNetwork(){
            print("Internet Connection Available!")
            model.GetImageprojectByProjID(projectID: ProjectId, view: self.view)
        }else{
            displayImagesModel.loadItems()
            print("Internet Connection not Available!")
            if displayImagesModel.returnProjectDetials(at: ProjectId) != nil {
                let detials = displayImagesModel.returnProjectDetials(at: ProjectId)
                self.searchResu = [detials!]
                collectionView?.reloadData()
            }
        }
        // Do any additional setup after loading the view.
    }
    
    func getprojID(proID: String) {
        if Reachability.isConnectedToNetwork(){
            print("Internet Connection Available!")
            
            model.GetImageprojectByProjID(projectID: proID, view: self.view)
        }else{
            displayImagesModel.loadItems()
            print("Internet Connection not Available!")
            if displayImagesModel.returnProjectDetials(at: proID) != nil {
                let detials = displayImagesModel.returnProjectDetials(at: proID)
                self.searchResu = [detials!]
                collectionView?.reloadData()
            }
        }
    }
    
    func dataReady() {
        // Access the video objects that have been downloaded
        self.searchResu = self.model.resultArray
        for i in self.model.resultArray {
            self.displayImagesModel.append(i)
        }
        // Tell the tableview to reload
        collectionView?.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchResu.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DesplayImagesCollectionViewCell", for: indexPath) as! DesplayImagesCollectionViewCell
        
        cell.layer.cornerRadius = 10
        cell.layer.borderColor = UIColor.clear.cgColor // set cell border color here
        cell.layer.masksToBounds = true
        
        let img = searchResu[indexPath.row].ProjectsImagePath
        
        let trimmedString = img.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        print(trimmedString)
        if let url = URL.init(string: trimmedString!) {
            cell.imageView.hnk_setImageFromURL(url, placeholder: #imageLiteral(resourceName: "officePlaceholder"))
        } else{
            print("nil")
        }
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "NewProject", bundle:nil)
        let secondView = storyBoard.instantiateViewController(withIdentifier: "GalaryViewController") as! GalaryViewController
        secondView.MyBackBt = "back"
        self.navigationController?.pushViewController(secondView, animated: true)
        let data = self.searchResu
        secondView.AddItemPhotos = data
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
