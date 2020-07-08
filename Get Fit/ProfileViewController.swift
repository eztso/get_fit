//
//  ProfileViewController.swift
//  Get Fit
//
//  Created by Michael Lee on 7/7/20.
//  Copyright © 2020 Ewin Zuo. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var profilePicImageView: UIImageView!
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var dobView: UIView!
    @IBOutlet weak var heightView: UIView!
    @IBOutlet weak var emailView: UIView!
    
    func formatUIView(view: UIView) {
        view.layer.cornerRadius = 10.0
        view.layer.masksToBounds = true
    }
    
    func makeImageViewCicular(image: UIImageView) {
        image.layer.borderWidth = 1
        image.layer.masksToBounds = false
        image.layer.borderColor = UIColor.black.cgColor
        image.layer.cornerRadius = profilePicImageView.frame.height/2
        image.clipsToBounds = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        makeImageViewCicular(image: profilePicImageView)
        formatUIView(view: nameView)
        formatUIView(view: dobView)
        formatUIView(view: heightView)
        formatUIView(view: emailView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        overrideUserInterfaceStyle = UserDefaults.standard.bool(forKey: "darkModeOn") ? .dark : .light
    }
}
