//
//  GalaryViewController.swift
//  
//
//  Created by Ahmed Wahdan on 7/26/17.
//
//

import UIKit

class GalaryViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate {
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    var AddItemPhotos: [DesplayImagesArray] = [DesplayImagesArray]()
    var AddItemPhotos1: [UIImage] = []
    var AddItemPhotos2: [GetProjectGallery] = [GetProjectGallery]()
    var AddItemPhotos3: [GetTeamGallery] = [GetTeamGallery]()
    var AddItem = ""
    var AddItem1 = ""
    var MyBackBt = ""
    var inde: IndexPath?
    var index: Int?
    var cond = ""
    var url: String = ""
    var documentInteractionController = UIDocumentInteractionController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        if MyBackBt != "" {
            self.navigationItem.title = "عرض المرفقات"
            let backButton = UIBarButtonItem(title: "المرفقات", style: .done, target: self, action: #selector(actionBtn))
            navigationItem.setLeftBarButton(backButton, animated: false)
        }
        DispatchQueue.main.async {
            let width = self.collectionView.frame.width
            let height = self.collectionView.frame.height
            let size = CGSize(width: width, height: height)
            (self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout).itemSize = size
        }
        DispatchQueue.main.async {
            if self.cond == "" {
                self.collectionView.scrollToItem(at: self.inde!, at: .centeredHorizontally, animated: false)
            }else {
                let indexPath = IndexPath.init(item: self.index!, section: 0)
                self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
            }
        }
        assignbackground()
        // Do any additional setup after loading the view.
         downloadPdf()
    }
    func downloadPdf()  {
        let download = UIButton(type: .custom)
        download.setImage(UIImage (named: "download-button-1"), for: .normal)
        download.tintColor = UIColor.white
       download.widthAnchor.constraint(equalToConstant: 30).isActive = true
         download.heightAnchor.constraint(equalToConstant: 30).isActive = true
        download.frame = CGRect(x: 0.0, y: 0.0, width: 35.0, height: 35.0)
        download.addTarget(self, action:#selector(downloadPdfButton), for: .touchUpInside)
        
        let barButtonItem2 = UIBarButtonItem(customView: download)
        barButtonItem2.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItems = [ barButtonItem2]
    }
    @objc func downloadPdfButton(sender: UIButton) {
        guard let url = URL(string: url) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            let tmpURL = FileManager.default.temporaryDirectory
                .appendingPathComponent(response?.suggestedFilename ?? "Contract.pdf")
            do {
                try data.write(to: tmpURL)
            } catch { print(error) }
            DispatchQueue.main.async {
                self.share(url: tmpURL)
            }
            }.resume()
    }
    func share(url: URL) {
        documentInteractionController.url = url
        documentInteractionController.uti = url.typeIdentifier ?? "public.data, public.content"
        documentInteractionController.name = url.localizedName ?? url.lastPathComponent
        documentInteractionController.presentOptionsMenu(from: view.frame, in: view, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        if cond == "" {
//            self.collectionView.scrollToItem(at: inde!, at: .centeredHorizontally, animated: false)
//        }else {
//            let indexPath = IndexPath.init(item: index!, section: 0)
//            self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
//        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func actionBtn (){
        self.navigationController?.popViewController(animated: false)
        //        let storyBoard : UIStoryboard = UIStoryboard(name: "ProjectsAndEdit", bundle:nil)
        //        let secondView = storyBoard.instantiateViewController(withIdentifier: "RequestProjectViewController") as! RequestProjectViewController
        //        let topController = UIApplication.topViewController()
        //        topController?.show(secondView, sender: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if cond == "" {
            if AddItem1 == ""{
                if AddItem == ""{
                    if AddItemPhotos1.count == 0 {
                        return AddItemPhotos.count
                    } else{
                        return AddItemPhotos1.count
                    }
                } else {
                    return AddItemPhotos2.count
                }
            } else {
                return AddItemPhotos3.count
            }
        } else {
            let total = (AddItemPhotos.count)+(AddItemPhotos1.count)
            return total
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GalaryCollectionViewCell", for: indexPath) as! GalaryCollectionViewCell
        url = AddItemPhotos[indexPath.row].ProjectsImagePath
        if cond == "" {
            if AddItem1 == "" {
                if AddItem == ""{
                    if AddItemPhotos1.count == 0 {
                        
                        let img = AddItemPhotos[indexPath.row].ProjectsImagePath
                        cell.configureCell(img)
                        //`
                        //            if let url = URL.init(string: img) {
                        //                cell.imageView.hnk_setImageFromURL(url, placeholder: #imageLiteral(resourceName: "custlogo"))
                        //            } else{
                        //                print("nil")
                        //            }
                    } else{
                        cell.configurecell(AddItemPhotos1[indexPath.row])
                    }
                } else {
                    let img = AddItemPhotos2[indexPath.row].ProjectGalleryPath
                    cell.configureCell(img!)
                }
            } else {
                let img = AddItemPhotos3[indexPath.row].CompanyGalleryPath
                cell.configureCell(img!)
            }
        } else {
            if indexPath.row < AddItemPhotos.count {
                let img = AddItemPhotos[indexPath.row].ProjectsImagePath
                cell.configureCell(img)
            }else {
                let row = (indexPath.row-AddItemPhotos.count)
                cell.configurecell(AddItemPhotos1[row])
            }
        }
        return cell
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
