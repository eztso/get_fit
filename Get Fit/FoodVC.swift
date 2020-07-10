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
            Constant.healthdata.setTodaysFoodSugar(fs: Double(alertController.textFields?[0].text ?? "0") ?? 0)
            self.sugarOutlet.setTitle("Sugar: " + String(Constant.healthdata.getHealthForDay().foodSugar!) + " grams", for: .normal)
            
            
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: {
            (action : UIAlertAction!) -> Void in })
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter Sugar"
            textField.keyboardType = .numberPad
        }
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    @IBAction func onCaloriesPressed(_ sender: Any) {
        let alertController = UIAlertController(title: "Change Calories", message: "", preferredStyle: UIAlertController.Style.alert)
        
        let saveAction = UIAlertAction(title: "Save", style: UIAlertAction.Style.default, handler: { alert -> Void in
            Constant.healthdata.setTodaysFoodCalories(fc:  Double(alertController.textFields?[0].text ?? "0") ?? 0)
            self.calorieOutlet.setTitle("Calories: " + String(Constant.healthdata.getHealthForDay().foodCalories!) + " kcal", for: .normal)
            
            
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: {
            (action : UIAlertAction!) -> Void in })
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter Calories (g)"
            textField.keyboardType = .numberPad
        }
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    @IBAction func onProteinPressed(_ sender: Any) {
        let alertController = UIAlertController(title: "Change Weight", message: "", preferredStyle: UIAlertController.Style.alert)
        
        let saveAction = UIAlertAction(title: "Save", style: UIAlertAction.Style.default, handler: { alert -> Void in
            Constant.healthdata.setTodaysFoodProtein(fp: Double(alertController.textFields?[0].text ?? "0") ?? 0)
            self.proteinOutlet.setTitle("Protein: " + String(Constant.healthdata.getHealthForDay().foodProtein!) + " grams", for: .normal)
            
            
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: {
            (action : UIAlertAction!) -> Void in })
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter Protein (g)"
            textField.keyboardType = .numberPad
        }
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    @IBAction func onFatPressed(_ sender: Any) {
        let alertController = UIAlertController(title: "Change Fat", message: "", preferredStyle: UIAlertController.Style.alert)
        
        let saveAction = UIAlertAction(title: "Save", style: UIAlertAction.Style.default, handler: { alert -> Void in
            Constant.healthdata.setTodaysFoodFat(ff: Double(alertController.textFields?[0].text ?? "0") ?? 0)
            self.fatOutlet.setTitle("Fat: " + String(Constant.healthdata.getHealthForDay().foodFat!) + " grams", for: .normal)
            
            
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: {
            (action : UIAlertAction!) -> Void in })
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter Fat"
            textField.keyboardType = .numberPad
        }
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func formatUIView(view: UIView) {
        view.layer.cornerRadius = 10.0
        view.layer.masksToBounds = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        formatUIView(view: calorieOutlet)
        formatUIView(view: sugarOutlet)
        formatUIView(view: proteinOutlet)
        formatUIView(view: fatOutlet)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false

        if let sugar = Constant.healthdata.getHealthForDay().foodSugar {
            self.sugarOutlet.setTitle("Sugar: " + String(sugar) + " grams", for: .normal)
        }
        if let calories = Constant.healthdata.getHealthForDay().foodCalories {
                  self.calorieOutlet.setTitle("Calories: " + String(calories) + " kcal", for: .normal)
              }
        if let protein = Constant.healthdata.getHealthForDay().foodProtein {
                  self.proteinOutlet.setTitle("Protein: " + String(protein) + " grams", for: .normal)
              }
        if let fat = Constant.healthdata.getHealthForDay().foodFat {
                  fatOutlet.setTitle("Fat: " + String(fat) + " grams", for: .normal)
              }
        overrideUserInterfaceStyle = UserDefaults.standard.bool(forKey: "darkModeOn") ? .dark : .light
    }
}
