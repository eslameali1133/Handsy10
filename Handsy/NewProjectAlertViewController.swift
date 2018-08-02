//
//  NewProjectAlertViewController.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 1/20/18.
//  Copyright © 2018 Ahmed Wahdan. All rights reserved.
//

import UIKit

class NewProjectAlertViewController: UIViewController {
    @IBOutlet weak var ImageFinger: UIImageView!
    @IBOutlet weak var NewProjectLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.NewProjectLabel.alpha = 0
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapDismiss(_:)))
        view.addGestureRecognizer(tap)
    }
    
    @objc func tapDismiss(_ sender: UITapGestureRecognizer) {
        self.dismiss(animated: false, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.ImageFinger.center.y -= (self.view.bounds.height)-(self.view.bounds.height-100)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 1.0, delay: 0.3, options: [.repeat],
                           animations: {
                            self.ImageFinger.center.y += 100
            },
                           completion: nil
            )
            UIView.animate(withDuration: 1.0, delay: 0.3, usingSpringWithDamping: 0.6, initialSpringVelocity: 10, options: [.curveEaseOut], animations: {
                
                let translation = CGAffineTransform(translationX: 0, y: 0)
                let scale = CGAffineTransform(scaleX: 1, y: 1)
                
                self.NewProjectLabel.transform = translation.concatenating(scale)
                self.NewProjectLabel.alpha = 1
                
            }, completion: nil
            )
        }
    }

}
