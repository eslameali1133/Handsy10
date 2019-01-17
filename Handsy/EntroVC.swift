//
//  EntroVC.swift
//  Handsy
//
//  Created by apple on 10/29/18.
//  Copyright © 2018 Ahmed Wahdan. All rights reserved.
//

import UIKit
struct Pagemodel {
    
    let ImageName: String
    let Title: String
    let SubTitle: String
    
}
class EntroVC: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    
    let PagesData = [Pagemodel(ImageName: "Group_1386-1", Title: "عرض المكاتب والمهندسين القريبين مني وإرسال طلب مشروع", SubTitle: "يتم عرض كل المكاتب والمهندسين القريبين من منطقتك أو بالبحث عنهم في أي منطقه حسب التقييم والأقرب والتخصص المطلوب وارسال طلب مشروع."),Pagemodel(ImageName: "Group_1383-1", Title: "عرض سجل المشاريع", SubTitle: "عرض كافة المشاريع وحالاتها ، والاتصال والتنقل لموقع الجهة والمحادثة الفورية ، وعرض الاشعارات وتقييم المشروع فور الانتهاء."),Pagemodel(ImageName: "Group_1388-1", Title: "تفاصيل المشروع", SubTitle: "عرض اسم المهندس المسؤول ووسيلة التواصل والموقع وكذلك ماليات المشروع والمدفوعات والعقد ، وعرض التصاميم والزيارات وملفات المشروع ووثائقه."),Pagemodel(ImageName: "Group_1393-1", Title: "تصاميم وزيارات المشروع", SubTitle: "يتم ارسال التصميم من المهندس الي العميل ويمكن للعميل عرضه وطلب التعديل عليه واعادة ارساله مرة أخرى لحين الموافقة عليه , وارسال موعد زيارة ويمكن للعميل الموافقة عليه او تاجيله ويضع المهندس تقرير الزيارة ."),Pagemodel(ImageName: "Group_1396-1", Title: "المحادثة الفورية مع المهندس وعرض اشعارات المشروع", SubTitle: "يمكن للعميل التحدث الفوري مع المهندس من خلال المحادثة وارسال الملفات والصور والموقع والنقاش حول تصميم مشروع وزياراته ,وعرض اشعارات المشروع.")]
    
    @IBOutlet weak var CollectView: UICollectionView!
    
    @IBOutlet weak var PageCpntroller: UIPageControl!
    @IBOutlet weak var PreBtn: UIButton!
    @IBOutlet weak var NextBtn: UIButton!
    var comingmain = false 
    var flag = false
    var flagPre = false
    var flagfirsttimeTa5te = true
    var countTa5 = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        PageCpntroller.numberOfPages = PagesData.count
        CollectView.delegate = self
        CollectView.dataSource = self
        CollectView?.isPagingEnabled = true
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        viewDidLoad()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
var count = 0
var countnext = 0
    @IBAction func Next(_ sender: UIButton) {
        flagfirsttimeTa5te = false
        countnext = 0
    flagPre = false
        if (count == 0)
        {
            PreBtn.setTitle("السابق", for: .normal)
        }
        count += 1
        let nextIndex = min(PageCpntroller.currentPage + 1 , PagesData.count - 1)
        
        
        if flag == false
        {
            if  nextIndex == 4
            {
                NextBtn.setTitle("ابدا من هنا", for: .normal)
                let indexpath = IndexPath(item: nextIndex, section: 0)
                PageCpntroller.currentPage = nextIndex
                CollectView?.scrollToItem(at: indexpath, at: .centeredHorizontally, animated: true)
                flag = true
            }
            else
            {
                let indexpath = IndexPath(item: nextIndex, section: 0)
                PageCpntroller.currentPage = nextIndex
                CollectView?.scrollToItem(at: indexpath, at: .centeredHorizontally, animated: true)
            }
            
        }
        else
        {
            
          
            if comingmain == true
            {
                comingmain = false
                let storyBoard : UIStoryboard = UIStoryboard(name: "NewHome", bundle:nil)
                let sub = storyBoard.instantiateViewController(withIdentifier: "NewMain") as! NewTabBarViewController
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                
                appDelegate.window?.rootViewController = sub
                
            }
            else
            {
                let storyBoard : UIStoryboard = UIStoryboard(name: "NewHome", bundle:nil)
                let sub = storyBoard.instantiateViewController(withIdentifier: "MainTabLogot") as! MainTabLogot
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.window?.rootViewController = sub
            }
        }
        
    }
    
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  PagesData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EntroCell", for: indexPath) as! EntroCell
        // this variable  declar in  view(pagecell) used  to set data
        cell.Image.image = UIImage(named: PagesData[indexPath.item].ImageName)
        
        if self.view.frame.width == 375
        {
            cell.lbl_Title.font = cell.lbl_Title.font.withSize(16)
            cell.Lbl_Desc.font = cell.Lbl_Desc.font.withSize(14)
            cell.TopConstrain.constant = 55
        }
        
        cell.lbl_Title.text = PagesData[indexPath.item].Title
        cell.Lbl_Desc.text = PagesData[indexPath.item].SubTitle
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        coordinator.animate(alongsideTransition: { (_) in
            self.CollectView.invalidateIntrinsicContentSize()
            
            let indexpath = IndexPath(item: self.PageCpntroller.currentPage, section: 0)
            self.CollectView?.scrollToItem(at: indexpath, at: .centeredHorizontally, animated: true)
            
        }, completion:{(_) in})
    }
    
    // used to change pagercontroll to current pagr
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let x =  targetContentOffset.pointee.x
        print(Int(x / view.frame.width))
        PageCpntroller.currentPage = Int(x / view.frame.width)
        flagfirsttimeTa5te = false
        if (Int(x / view.frame.width) == 0)
        {
            flagfirsttimeTa5te = true
             PreBtn.setTitle("تخطى", for: .normal)
            NextBtn.setTitle("التالي", for: .normal)
        }
        if (Int(x / view.frame.width) == 1)
        {
            PreBtn.setTitle("السابق", for: .normal)
            NextBtn.setTitle("التالي", for: .normal)
        }
        if (Int(x / view.frame.width) == 4)
        {
            flag = true
            PreBtn.setTitle("السابق", for: .normal)
            NextBtn.setTitle("ابدا من هنا", for: .normal)
        }
    }
    
    @IBAction func Preve(){
        count = 0
        flag = false
        if (countnext == 0)
        {
            NextBtn.setTitle("التالي", for: .normal)
        }
        countnext += 1
        let nextIndex = max(PageCpntroller.currentPage - 1 , 0)
        print(nextIndex)
        let indexpath = IndexPath(item: nextIndex, section: 0)
        
        if flagPre == true
        {
            if comingmain == true
            {
                comingmain = false
                let storyBoard : UIStoryboard = UIStoryboard(name: "NewHome", bundle:nil)
                let sub = storyBoard.instantiateViewController(withIdentifier: "NewMain") as! NewTabBarViewController
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                
                appDelegate.window?.rootViewController = sub
                
                
            }
            else
            {
            let storyBoard : UIStoryboard = UIStoryboard(name: "NewHome", bundle:nil)
            let sub = storyBoard.instantiateViewController(withIdentifier: "MainTabLogot") as! MainTabLogot
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.rootViewController = sub
            }
            
        }
        else
        {
            
            if nextIndex == 0
            {
               if flagfirsttimeTa5te == true
                {
                    self.flagfirsttimeTa5te = false
                    
                    if comingmain == true
                    {
                        comingmain = false
                        let storyBoard : UIStoryboard = UIStoryboard(name: "NewHome", bundle:nil)
                        let sub = storyBoard.instantiateViewController(withIdentifier: "NewMain") as! NewTabBarViewController
                        let appDelegate = UIApplication.shared.delegate as! AppDelegate
                        
                        appDelegate.window?.rootViewController = sub
                        
                        
                    }
                    else
                    {
                        let storyBoard : UIStoryboard = UIStoryboard(name: "NewHome", bundle:nil)
                        let sub = storyBoard.instantiateViewController(withIdentifier: "MainTabLogot") as! MainTabLogot
                        let appDelegate = UIApplication.shared.delegate as! AppDelegate
                        appDelegate.window?.rootViewController = sub
                    }
                    
                    
                }
                PreBtn.setTitle("تخطى", for: .normal)
                flagPre = true
                PageCpntroller.currentPage = nextIndex
                CollectView?.scrollToItem(at: indexpath, at: .centeredHorizontally, animated: true)
                
            }
            else
            {
                PreBtn.setTitle("السابق", for: .normal)
                PageCpntroller.currentPage = nextIndex
                CollectView?.scrollToItem(at: indexpath, at: .centeredHorizontally, animated: true)
                
                
            }
        }
    }
    
    
}
