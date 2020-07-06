//
//  FoodVC.swift
//  Get Fit
//
//  Created by Ewin Zuo on 7/5/20.
//  Copyright © 2020 Ewin Zuo. All rights reserved.
//

import UIKit

class FoodVC: UIViewController {
    var delegate: Updater?
    
    @IBOutlet weak var sugarOutlet: UIButton!
    
    @IBOutlet weak var proteinOutlet: UIButton!
    @IBOutlet weak var calorieOutlet: UIButton!
    @IBOutlet weak var fatOutlet: UIButton!
    @IBAction func onSugarPressed(_ sender: Any) {
        let alertController = UIAlertController(title: "Change Sugar", message: "", preferredStyle: UIAlertController.Style.alert)
        
        let saveAction = UIAlertAction(title: "Save", style: UIAlertAction.Style.default, handler: { alert -> Void in
            Constant.healthdata.foodSugar = Double(alertController.textFields?[0].text ?? "0")
            self.sugarOutlet.setTitle("Sugar: " + String(Constant.healthdata.foodSugar!) + " grams", for: .normal)
            
            
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: {
            (action : UIAlertAction!) -> Void in })
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter Sugar"
        }
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    @IBAction func onCaloriesPressed(_ sender: Any) {
        let alertController = UIAlertController(title: "Change Calories", message: "", preferredStyle: UIAlertController.Style.alert)
        
        let saveAction = UIAlertAction(title: "Save", style: UIAlertAction.Style.default, handler: { alert -> Void in
            Constant.healthdata.foodCalories = Double(alertController.textFields?[0].text ?? "0")
            self.calorieOutlet.setTitle("Calories: " + String(Constant.healthdata.foodCalories!) + " kcal", for: .normal)
            
            
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: {
            (action : UIAlertAction!) -> Void in })
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter Calories (g)"
        }
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    @IBAction func onProteinPressed(_ sender: Any) {
        let alertController = UIAlertController(title: "Change Weight", message: "", preferredStyle: UIAlertController.Style.alert)
        
        let saveAction = UIAlertAction(title: "Save", style: UIAlertAction.Style.default, handler: { alert -> Void in
            Constant.healthdata.foodProtein = Double(alertController.textFields?[0].text ?? "0")
            self.proteinOutlet.setTitle("Protein: " + String(Constant.healthdata.foodProtein!) + " grams", for: .normal)
            
            
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: {
            (action : UIAlertAction!) -> Void in })
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter Protein (g)"
        }
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    @IBAction func onFatPressed(_ sender: Any) {
        let alertController = UIAlertController(title: "Change Fat", message: "", preferredStyle: UIAlertController.Style.alert)
        
        let saveAction = UIAlertAction(title: "Save", style: UIAlertAction.Style.default, handler: { alert -> Void in
            Constant.healthdata.foodFat = Double(alertController.textFields?[0].text ?? "0")
            self.fatOutlet.setTitle("Fat: " + String(Constant.healthdata.foodFat!) + " grams", for: .normal)
            
            
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: {
            (action : UIAlertAction!) -> Void in })
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter Fat"
        }
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let sugar = Constant.healthdata.foodSugar {
            self.sugarOutlet.setTitle("Sugar: " + String(sugar) + " grams", for: .normal)
        }
        if let calories = Constant.healthdata.foodCalories {
                  self.calorieOutlet.setTitle("Calories: " + String(calories) + " kcal", for: .normal)
              }
        if let protein = Constant.healthdata.foodProtein {
                  self.proteinOutlet.setTitle("Protein: " + String(protein) + " grams", for: .normal)
              }
        if let fat = Constant.healthdata.foodFat {
                  fatOutlet.setTitle("Fat: " + String(fat) + " grams", for: .normal)
              }
    }
    
    
    
    
    
    
}
