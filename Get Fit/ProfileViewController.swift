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
    
    @IBOutlet weak var editNameButton: UIButton!
    @IBOutlet weak var editDobButton: UIButton!
    @IBOutlet weak var editHeightButton: UIButton!
    @IBOutlet weak var editEmailButton: UIButton!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dobLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
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
    
    @IBAction func editNameButtonPressed(_ sender: Any) {
        let alertController = UIAlertController(title: "Change Name", message: "", preferredStyle: UIAlertController.Style.alert)

        let saveAction = UIAlertAction(title: "Save", style: UIAlertAction.Style.default, handler: { alert -> Void in
            self.nameLabel.text = alertController.textFields?[0].text ?? self.nameLabel.text
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: {
            (action : UIAlertAction!) -> Void in })
        
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter Name"
        }

        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)

        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func editDobButtonPressed(_ sender: Any) {
    }
    
    @IBAction func editHeightButtonPressed(_ sender: Any) {
    }
    
    @IBAction func editEmailButtonPressed(_ sender: Any) {
        let alertController = UIAlertController(title: "Change Email", message: "", preferredStyle: UIAlertController.Style.alert)

        let saveAction = UIAlertAction(title: "Save", style: UIAlertAction.Style.default, handler: { alert -> Void in
            self.emailLabel.text = alertController.textFields?[0].text ?? self.emailLabel.text
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: {
            (action : UIAlertAction!) -> Void in })
        
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter Email"
        }

        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)

        self.present(alertController, animated: true, completion: nil)
    }
}