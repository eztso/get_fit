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
    var challenge : Challenge?
    let segueID = "FoodSegue"
    @IBOutlet weak var weightButton: UIButton!
    @IBOutlet weak var foodButton: UIButton!
    @IBOutlet weak var activityButton: UIButton!
   
    @IBOutlet weak var cardView: CardUIView!
    
    @IBOutlet weak var challengeLabel: UILabel!
    
    @IBOutlet weak var challengeOutlet: UIButton!
    @IBOutlet weak var challengeViewOutlet: UIView!
    
    @IBAction func onChallengeButtonPressed(_ sender: Any) {
        Constant.healthdata.setTodaysChallenge(ch: challenge!.idx)
        challengeOutlet.isHidden = true
    }
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
    
    func sendNotifications(hour: Int) {
        // create an object that holds the data for our notification
        let numSteps: Int = Int(cardView.stepsTaken.text ?? "0") ?? 0
        if !UserDefaults.standard.bool(forKey: "notificationsOn") {
            return
        }
        
        let notification = UNMutableNotificationContent()
        
        if numSteps > 8000 {
            notification.title = "Great Job!"
            notification.body = "You walked \(numSteps) steps today!"
        }
        else {
            notification.title = "Stay Active!"
            notification.body = "You're \(8000 - numSteps) steps away from your goal"
            
        }
        
        var dateFire = Date()
        let calendar = NSCalendar(identifier: .gregorian)!;
        var fireComponents = calendar.components( [NSCalendar.Unit.day, NSCalendar.Unit.month, NSCalendar.Unit.year, NSCalendar.Unit.hour, NSCalendar.Unit.minute], from:dateFire)
        if (fireComponents.hour! > hour
            || (fireComponents.hour == hour) ) {

            dateFire = dateFire.addingTimeInterval(86400)  // Use tomorrow's date
            fireComponents = calendar.components( [NSCalendar.Unit.day, NSCalendar.Unit.month, NSCalendar.Unit.year, NSCalendar.Unit.hour, NSCalendar.Unit.minute], from:dateFire);
        }

        // set up the time
        fireComponents.hour = hour
        fireComponents.minute = 0
        dateFire = calendar.date(from: fireComponents)!


        let triggerDaily = Calendar.current.dateComponents([.hour, .minute, .second], from: dateFire)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDaily, repeats: true)
        
        // set up a request to tell iOS to submit the notification using that trigger
        let request = UNNotificationRequest(
            identifier: "GetFitStepNotification",
            content: notification,
            trigger: trigger)
        // submit the request to iOS
        UNUserNotificationCenter.current().add(request) {
            (error) in
            print("Request error: ",error as Any)
        }
    }
    
    func formatUIView(view: UIView) {
        view.layer.cornerRadius = 10.0
        view.layer.masksToBounds = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        cardView.roundCorners()
        Constant.healthdata.getTodaysSteps(completion: {(ans) -> Void in
            print(ans)
            DispatchQueue.main.async { () in
                print("steps" + String(ans))
                self.cardView.stepsTaken.text! = String(Int(ans))
            }

        })
        
        sendNotifications(hour: 12) // Send notifications at noon everyday
        formatUIView(view: weightButton)
        formatUIView(view: foodButton)
        formatUIView(view: activityButton)
        formatUIView(view: challengeViewOutlet)
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
           
                
            }
        )
        
        if Constant.healthdata.getHealthForDay().curChallenge == -1 {
                       challenge = Challenge()
            challengeLabel.text = challenge!.descriptions[challenge!.idx]
            challengeOutlet.isHidden = false
        }
        else if Constant.healthdata.getHealthForDay().curChallenge == -2 {
            challengeOutlet.isHidden = true
            challengeLabel.text = "completed todays challenge"
            
            
        }
        else {
            challengeOutlet.isHidden = true
            challenge = Challenge(idx: Constant.healthdata.getHealthForDay().curChallenge)
            challengeLabel.text = challenge!.descriptions[challenge!.idx]
            if (challenge!.checkCompletion()) {
                challenge!.idx = -2
                challengeLabel.text! = "Challenge completed"
                challengeLabel.numberOfLines = 0
                Constant.healthdata.addPoints()
                
            }
        }
            
        overrideUserInterfaceStyle = UserDefaults.standard.bool(forKey: "darkModeOn") ? .dark : .light
      
        var t = ""
        if Constant.healthdata.getHealthForDay().weight == 0  {
            t = "Enter Weight"
        }
        else {
            t = String(Constant.healthdata.getHealthForDay().weight!) + " lbs"
        }
        self.weightButton.setTitle(t, for: .normal)
            self.cardView.BMI.text = "BMI: " + String(Int(Constant.healthdata.getBMI()))
        self.cardView.pointsLabel.text = "Points: " + String(Constant.healthdata.getPoints())
            
        
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

