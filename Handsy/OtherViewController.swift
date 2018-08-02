//
//  OtherViewController.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 7/31/17.
//  Copyright © 2017 Ahmed Wahdan. All rights reserved.
//

import UIKit
import Haneke

class OtherViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, DesplayImagesModelDelegate {
    
    
    var searchResu:[DesplayImagesArray] = [DesplayImagesArray]()
    
    let model: DesplayImagesModel = DesplayImagesModel()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        model.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func getprojID(proID: String) {
        model.GetImageprojectByProjID(projectID: proID, view: self.view)
    }
    
    func dataReady() {
        // Access the video objects that have been downloaded
        self.searchResu = self.model.resultArray
        // Tell the tableview to reload
        collectionView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchResu.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DesplayImagesCollectionViewCell", for: indexPath) as! DesplayImagesCollectionViewCell
        
        cell.layer.cornerRadius = 10
        cell.layer.borderColor = UIColor.clear.cgColor // set cell border color here
        cell.layer.masksToBounds = true
        
        let img = searchResu[indexPath.row].ProjectsImagePath
        let trimmedString = img.trimmingCharacters(in: .whitespaces)
        if let url = URL.init(string: img) {
            cell.imageView.hnk_setImageFromURL(url, placeholder: #imageLiteral(resourceName: "custlogo"))
        } else{
            print("nil")
        }
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
