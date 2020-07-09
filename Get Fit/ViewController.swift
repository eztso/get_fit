//
//  ViewController.swift
//  Get Fit
//
//  Created by Ewin Zuo on 6/27/20.
//  Copyright © 2020 Ewin Zuo. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, Updater {
    func updateFoodSugar(sugar: Double) {
        Constant.healthdata.setTodaysFoodSugar(fs: sugar)
    }
    
    func updateFoodProtein(protein: Double) {
        Constant.healthdata.setTodaysFoodProtein(fp: protein)
    }
    
    func updateFoodFat(fat: Double) {
        Constant.healthdata.setTodaysFoodFat(ff: fat)


    }
    
    func updateFoodCalories(calories: Double) {
        Constant.healthdata.setTodaysFoodCalories(fc: calories)
    }
    let segueID = "FoodSegue"
    @IBOutlet weak var weightButton: UIButton!
    @IBOutlet weak var foodButton: UIButton!
    @IBOutlet weak var activityButton: UIButton!
   
    @IBOutlet weak var cardView: CardUIView!
    
    @IBAction func onWeightButtonPressed(_ sender: Any) {
        let alertController = UIAlertController(title: "Change Weight", message: "", preferredStyle: UIAlertController.Style.alert)

        let saveAction = UIAlertAction(title: "Save", style: UIAlertAction.Style.default, handler: { alert -> Void in
            Constant.healthdata.setTodaysWeight(w : Double(alertController.textFields?[0].text ?? "0") ?? 0)
            
            self.weightButton.setTitle(String(Constant.healthdata.getHealthForDay().weight!) + " lbs", for: .normal)


        })
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: {
            (action : UIAlertAction!) -> Void in })
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter Weight"
        }
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        cardView.roundCorners()
        Constant.healthdata.getTodaysSteps(completion: {(ans) -> Void in
            print(ans)
            DispatchQueue.main.async { () in
                self.cardView.stepsTaken.text! = String(Int(ans))
            }

        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Constant.healthdata.getTodaysSteps(completion: {(ans) -> Void in
                 DispatchQueue.main.async { () in
                     self.cardView.stepsTaken.text! = String(Int(ans))
                    if Int(ans) > Constant.recSteps {
                        print("update color")
                        self.cardView.borderColor = Constant.green
                     
                      
                    }
                 }

             })
        
        overrideUserInterfaceStyle = UserDefaults.standard.bool(forKey: "darkModeOn") ? .dark : .light
      
        var t = ""
        if Constant.healthdata.getHealthForDay().weight == 0  {
            t = "Enter Weight"
        }
        else {
            t = String(Constant.healthdata.getHealthForDay().weight!) + " lbs"
        }
        self.weightButton.setTitle(t, for: .normal)
        
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == segueID,
            let dest = segue.destination as? FoodVC {
            dest.delegate = self
        }
    }


}

