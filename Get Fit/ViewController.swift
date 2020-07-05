//
//  ViewController.swift
//  Get Fit
//
//  Created by Ewin Zuo on 6/27/20.
//  Copyright © 2020 Ewin Zuo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var stepsLabel: UILabel!
    @IBOutlet weak var cardView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        cardView.roundCorners(cornerRadius: 10.0)
        Constant.healthdata.getTodaysSteps(completion: {(ans) -> Void in
            DispatchQueue.main.async { () in
                self.stepsLabel.text! = String(Int(ans))    
            }

        })
            
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Constant.healthdata.getTodaysSteps(completion: {(ans) -> Void in
                 DispatchQueue.main.async { () in
                     self.stepsLabel.text! = String(Int(ans))
                 }

             })
    }


}
extension UIView {
    func roundCorners(cornerRadius: Double) {
        
        self.layer.cornerRadius = CGFloat(cornerRadius)
//        self.layer.shadowColor = UIColor.darkGray.cgColor
//        self.layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
//        self.layer.shadowRadius = 0
//        self.layer.shadowOpacity = 0.5
        self.layer.borderWidth = 3
        self.layer.borderColor = UIColor(red: 0.96, green: 0.56, blue: 0.56, alpha: 1.00).cgColor
    }
    
}
