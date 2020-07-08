//
//  ViewController.swift
//  Get Fit
//
//  Created by Ewin Zuo on 6/27/20.
//  Copyright © 2020 Ewin Zuo. All rights reserved.
//

import UIKit

class ViewController: UIViewController, Updater {
    func updateFoodSugar(sugar: Double) {
        Constant.healthdata.foodSugar = sugar
    }
    
    func updateFoodProtein(protein: Double) {
        Constant.healthdata.foodProtein = protein
    }
    
    func updateFoodFat(fat: Double) {
        Constant.healthdata.foodFat = fat

    }
    
    func updateFoodCalories(calories: Double) {
        Constant.healthdata.foodCalories = calories
    }
    let segueID = "FoodSegue"
    var weight : Double?
    @IBOutlet weak var weightButton: UIButton!
    @IBOutlet weak var foodButton: UIButton!
    @IBOutlet weak var activityButton: UIButton!
    @IBOutlet weak var stepsLabel: UILabel!
    @IBOutlet weak var cardView: UIView!
    @IBAction func onWeightButtonPressed(_ sender: Any) {
        let alertController = UIAlertController(title: "Change Weight", message: "", preferredStyle: UIAlertController.Style.alert)

        let saveAction = UIAlertAction(title: "Save", style: UIAlertAction.Style.default, handler: { alert -> Void in
            self.weight = Double(alertController.textFields?[0].text ?? "0")
            self.weightButton.setTitle(String(self.weight!) + " lbs", for: .normal)


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
        cardView.roundCorners(cornerRadius: 10.0)
        Constant.healthdata.getTodaysSteps(completion: {(ans) -> Void in
            print(ans)
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
        overrideUserInterfaceStyle = UserDefaults.standard.bool(forKey: "darkModeOn") ? .dark : .light
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
