//
//  CardUIView.swift
//  Get Fit
//
//  Created by Ewin Zuo on 7/9/20.
//  Copyright © 2020 Ewin Zuo. All rights reserved.
//

import UIKit
@IBDesignable
class CardUIView: UIView {
    @IBOutlet weak var stepsTaken: UILabel!
    @IBOutlet weak var arrow: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    @IBInspectable var cornerRadius: CGFloat = 10.0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    @IBInspectable var borderWidth: CGFloat = 3.0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    @IBInspectable var borderColor: UIColor = UIColor(red: 0.96, green: 0.56, blue: 0.56, alpha: 1.00) {
        didSet {
            print("actually update color")
            print(borderColor)
            
            self.layer.borderColor = borderColor.cgColor
            self.stepsTaken.textColor = borderColor
            self.arrow.tintColor = borderColor
            self.titleLabel.textColor = borderColor
            if (borderColor == Constant.green) {
                print(self.arrow.image!)
                let symbol = UIImage(systemName: "arrow.up.circle")
                    self.arrow.image = symbol
            }
            print(self.layer.borderColor)
            
        }
    }
    func roundCorners() {
        self.layer.borderColor = Constant.red.cgColor
        self.layer.cornerRadius = 20.0
        self.layer.borderWidth = 3.0
    }
    
    
    
    
}
