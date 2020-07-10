//
//  ProfileViewController.swift
//  Get Fit
//
//  Created by Michael Lee on 7/7/20.
//  Copyright © 2020 Ewin Zuo. All rights reserved.
//

import UIKit
import CoreData

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
    
    private var datePicker: UIDatePicker?
    
    let signOutSegueIdentifier: String = "SignOutSegueIdentifier"
    
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
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //We need to create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //Prepare the request of type NSFetchRequest  for the entity
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ProfileEntity")

        let predicate = NSPredicate(format: "user = %@", Constant.currentUser)
        fetchRequest.predicate = predicate

        do {
            let result = try managedContext.fetch(fetchRequest)
            for data in result as! [NSManagedObject] {
                nameLabel.text = (data.value(forKey: "name") as? String)
                dobLabel.text = data.value(forKey: "dob") as? String
                heightLabel.text = data.value(forKey: "height") as? String
                emailLabel.text = data.value(forKey: "email") as? String
                var storedImageData = data.value(forKey: "pic")
                if storedImageData != nil {
                    profilePicImageView.image = UIImage(data: storedImageData as! Data)
                }
            }
        }catch {
            print("Failed")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        overrideUserInterfaceStyle = UserDefaults.standard.bool(forKey: "darkModeOn") ? .dark : .light
    }
    
    func userProfilePicUpdate(key: String, newVal: Data?) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ProfileEntity")

        let predicate = NSPredicate(format: "user = %@", Constant.currentUser)
        fetchRequest.predicate = predicate
        
        do {
            let result = try context.fetch(fetchRequest) as! [NSManagedObject]
            if result.isEmpty {
                let person = NSEntityDescription.insertNewObject(
                    forEntityName: "ProfileEntity", into:context)
                
                // Set the attribute values
                person.setValue(newVal, forKey: key)
                person.setValue(Constant.currentUser, forKey: "user")
                do {
                    try context.save()
                    
                } catch let error as NSError {
                    print("Could not save. \(error), \(error.userInfo)")
                }
            }
            else {
                let person: NSManagedObject = result[0]
                person.setValue(newVal, forKey: key)
                do {
                    try context.save()
                    
                } catch let error as NSError {
                    print("Could not save. \(error), \(error.userInfo)")
                }
            }
        }catch {
            
            print("Failed")
        }
    }
    
    func userProfileUpdate(key: String, newVal: String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ProfileEntity")

        let predicate = NSPredicate(format: "user = %@", Constant.currentUser)
        fetchRequest.predicate = predicate
        
        do {
            let result = try context.fetch(fetchRequest) as! [NSManagedObject]
            if result.isEmpty {
                let person = NSEntityDescription.insertNewObject(
                    forEntityName: "ProfileEntity", into:context)
                
                // Set the attribute values
                person.setValue(newVal, forKey: key)
                person.setValue(Constant.currentUser, forKey: "user")
                do {
                    try context.save()
                    
                } catch let error as NSError {
                    print("Could not save. \(error), \(error.userInfo)")
                }
            }
            else {
                let person: NSManagedObject = result[0]
                person.setValue(newVal, forKey: key)
                do {
                    try context.save()
                    
                } catch let error as NSError {
                    print("Could not save. \(error), \(error.userInfo)")
                }
            }
        }catch {
            
            print("Failed")
        }
    }
    
    @IBAction func editNameButtonPressed(_ sender: Any) {
        let alertController = UIAlertController(title: "Change Name", message: "", preferredStyle: UIAlertController.Style.alert)

        let saveAction = UIAlertAction(title: "Save", style: UIAlertAction.Style.default, handler: { alert -> Void in
            self.nameLabel.text = alertController.textFields?[0].text ?? self.nameLabel.text
            self.userProfileUpdate(key: "name", newVal: self.nameLabel.text!)
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
        let alertController = UIAlertController(title: "Change Date of Birth", message: "", preferredStyle: UIAlertController.Style.alert)

        let saveAction = UIAlertAction(title: "Save", style: UIAlertAction.Style.default, handler: { alert -> Void in
            self.dobLabel.text = alertController.textFields?[0].text ?? self.dobLabel.text
            self.userProfileUpdate(key: "dob", newVal: self.dobLabel.text!)
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: {
            (action : UIAlertAction!) -> Void in })
        
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter Date of Birth"
        }

        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)

        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func editHeightButtonPressed(_ sender: Any) {
        let alertController = UIAlertController(title: "Change Height", message: "", preferredStyle: UIAlertController.Style.alert)

        let saveAction = UIAlertAction(title: "Save", style: UIAlertAction.Style.default, handler: { alert -> Void in
            self.heightLabel.text = alertController.textFields?[0].text ?? self.heightLabel.text
            self.userProfileUpdate(key: "height", newVal: self.heightLabel.text!)
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: {
            (action : UIAlertAction!) -> Void in })
        
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter Height"
        }

        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)

        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func editEmailButtonPressed(_ sender: Any) {
        let alertController = UIAlertController(title: "Change Email", message: "", preferredStyle: UIAlertController.Style.alert)

        let saveAction = UIAlertAction(title: "Save", style: UIAlertAction.Style.default, handler: { alert -> Void in
            self.emailLabel.text = alertController.textFields?[0].text ?? self.emailLabel.text
            self.userProfileUpdate(key: "email", newVal: self.emailLabel.text!)
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
    
    @IBAction func signOutButtonPressed(_ sender: Any) {
        let alertController = UIAlertController(title: "Sign-Out", message: "Are you sure you want to sign out?", preferredStyle: UIAlertController.Style.alert)

        let saveAction = UIAlertAction(title: "Sign Out", style: UIAlertAction.Style.default, handler: { alert -> Void in
            Constant.currentUser = Constant.defaultUser
            self.performSegue(withIdentifier: self.signOutSegueIdentifier, sender: nil)
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: {
            (action : UIAlertAction!) -> Void in })

        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)

        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func uploadImagePicked(_ sender: Any) {
        ImagePickerManager().pickImage(self){ image in
            self.userProfilePicUpdate(key: "pic", newVal: image.pngData())
        }
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
         
         //We need to create a context from this container
         let managedContext = appDelegate.persistentContainer.viewContext
         
         //Prepare the request of type NSFetchRequest  for the entity
         let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ProfileEntity")

         let predicate = NSPredicate(format: "user = %@", Constant.currentUser)
         fetchRequest.predicate = predicate

         do {
             let result = try managedContext.fetch(fetchRequest)
             for data in result as! [NSManagedObject] {
                profilePicImageView.image = UIImage(data: data.value(forKey: "pic") as! Data)
             }
         }catch {
             print("Failed")
         }
    }
}
