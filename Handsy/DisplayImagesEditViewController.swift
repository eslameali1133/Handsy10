//
//  DisplayImagesEditViewController.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 8/26/17.
//  Copyright © 2017 Ahmed Wahdan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Haneke

class DisplayImagesEditViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, DesplayImagesModelDelegate {
    
    
    var searchResu:[DesplayImagesArray] = [DesplayImagesArray]()
    
    let model: DesplayImagesModel = DesplayImagesModel()
    
    @IBOutlet var collectionView: UICollectionView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        model.delegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchResu.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DisplayImageEditCollectionViewCell", for: indexPath) as! DisplayImageEditCollectionViewCell
        cell.layer.cornerRadius = 10
        cell.layer.borderColor = UIColor.clear.cgColor // set cell border color here
        cell.layer.masksToBounds = true
        
        let img = searchResu[indexPath.row].ProjectsImagePath
        
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
        self.navigationController?.pushViewController(secondView, animated: true)
        let data = self.searchResu
        secondView.AddItemPhotos = data
        secondView.inde = indexPath
        secondView.collectionView?.reloadData()
        
    }

    
    @IBAction func xdelet(_ sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: collectionView)
        let index = collectionView.indexPathForItem(at: point)?.row
        let image = searchResu[index!].ProjectsImageID
        ImageDelete(projectsImageID: image)
        self.searchResu.remove(at: index!)
        collectionView.reloadData()
    }

    func ImageDelete(projectsImageID: String) {
        let parameters: Parameters = [
            "projectsImageID": projectsImageID
        ]
        
        Alamofire.request("http://smusers.promit2030.com/Service1.svc/ImageDelete", method: .get, parameters: parameters, encoding: URLEncoding.default).responseJSON { response in
            debugPrint(response)
        }
    }

}
