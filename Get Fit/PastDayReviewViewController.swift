//
//  PastDayReviewViewController.swift
//  Get Fit
//
//  Created by Michael Lee on 7/9/20.
//  Copyright © 2020 Ewin Zuo. All rights reserved.
//

import UIKit
import CoreData

class PastDayReviewViewController: UIViewController {

    @IBOutlet weak var dateLabel: CardUIView!
    @IBOutlet weak var stepsLabel: UIButton!
    @IBOutlet weak var calorieLabel: UIButton!
    @IBOutlet weak var weightLabel: UIButton!
    @IBOutlet weak var bmiLabel: UILabel!
    
    var health: Health? = nil
    var steps: Double? = nil
    
    func formatUIView(view: UIView) {
        view.layer.cornerRadius = 10.0
        view.layer.masksToBounds = true
    }
    
    func getHeight() -> Double {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return 175}
        
        //We need to create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //Prepare the request of type NSFetchRequest  for the entity
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ProfileEntity")
        
        let predicate = NSPredicate(format: "user = %@", Constant.currentUser)
        fetchRequest.predicate = predicate
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            var str = "175"
            for data in result as! [NSManagedObject] {
                
                let val = data.value(forKey: "height")
                if val != nil {
                    str = val as! String
                }
                return Double(str )!
            }
        }catch {
            
            print("Failed")
        }
        return 175
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        formatUIView(view: dateLabel)
        formatUIView(view: stepsLabel)
        formatUIView(view: calorieLabel)
        formatUIView(view: weightLabel)
        
        stepsLabel.setTitle("You walked \(steps ?? 0) steps!", for: .normal)
        calorieLabel.setTitle("You ate \(health?.foodCalories ?? 0) calories!", for: .normal)
        weightLabel.setTitle("You weighted \(health?.weight ?? 0) lb!", for: .normal)
        
        let bmi = (703.0 * health!.weight!) / pow(getHeight() / 2.54, 2)
        bmiLabel.text = "BMI: \(String(format: "%.2f", bmi))"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        overrideUserInterfaceStyle = UserDefaults.standard.bool(forKey: "darkModeOn") ? .dark : .light
    }
}
