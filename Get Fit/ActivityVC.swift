//
//  ActivityVC.swift
//  Get Fit
//
//  Created by Ewin Zuo on 7/5/20.
//  Copyright © 2020 Ewin Zuo. All rights reserved.
//

import UIKit

class ActivityVC: UIViewController {
    var dispatch = DispatchGroup()
    @IBOutlet weak var stepsOutlet: UIButton!
    @IBOutlet weak var milesOutlet: UIButton!
    var steps : Int?
    var miles: Double?  
    @IBAction func onStepsPressed(_ sender: Any) {
        let alertController = UIAlertController(title: "Add Steps", message: "", preferredStyle: UIAlertController.Style.alert)

            let saveAction = UIAlertAction(title: "Save", style: UIAlertAction.Style.default, handler: { alert -> Void in
                let steps = Double(alertController.textFields?[0].text ?? "0")
                self.steps = Int(steps!)
                Constant.healthdata.setTodaysSteps(steps: steps!)
                self.stepsOutlet.setTitle("Steps: " + String(self.steps!), for: .normal)
                


            })
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: {
                (action : UIAlertAction!) -> Void in })
            alertController.addTextField { (textField : UITextField!) -> Void in
                textField.placeholder = String(self.steps!) + " steps"
            }
            
            alertController.addAction(saveAction)
            alertController.addAction(cancelAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
    
    @IBAction func onMilesPressed(_ sender: Any) {
        let alertController = UIAlertController(title: "Add Walking Distance", message: "", preferredStyle: UIAlertController.Style.alert)

                   let saveAction = UIAlertAction(title: "Save", style: UIAlertAction.Style.default, handler: { alert -> Void in
                       let miles = Double(alertController.textFields?[0].text ?? "0")
                    self.miles = miles
                    self.milesOutlet.setTitle("Distance: " + String(miles!) + " Miles", for: .normal)
                    Constant.healthdata.setTodaysMiles(miles: miles!)


                   })
                   let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: {
                       (action : UIAlertAction!) -> Void in })
                   alertController.addTextField { (textField : UITextField!) -> Void in
                       textField.placeholder = String(self.miles!) + "miles"
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
        formatUIView(view: stepsOutlet)
        formatUIView(view: milesOutlet)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        overrideUserInterfaceStyle = UserDefaults.standard.bool(forKey: "darkModeOn") ? .dark : .light
        dispatch.enter()
        DispatchQueue.global(qos: .default).async { () in
           Constant.healthdata.getTodaysSteps(completion: {(ans) -> Void in
                                 self.steps = Int(ans)
            self.dispatch.leave();
                                   })
            
        }
        
        dispatch.enter()
           DispatchQueue.global(qos: .default).async { () in
              Constant.healthdata.getTodaysMiles(completion: {(ans) -> Void in
                                    self.miles = ans
               self.dispatch.leave();
                                      })
               
           }
           dispatch.wait()
        milesOutlet.setTitle("Distance: " + String(miles!) + " Miles", for: .normal)
        stepsOutlet.setTitle("Steps: " + String(steps!), for: .normal)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
