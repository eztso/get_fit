//
//  PastDayReviewViewController.swift
//  Get Fit
//
//  Created by Michael Lee on 7/9/20.
//  Copyright © 2020 Ewin Zuo. All rights reserved.
//

import UIKit

class PastDayReviewViewController: UIViewController {

    @IBOutlet weak var dateLabel: CardUIView!
    @IBOutlet weak var stepsLabel: UIButton!
    @IBOutlet weak var calorieLabel: UIButton!
    @IBOutlet weak var distanceLabel: UIButton!
    @IBOutlet weak var weightLabel: UIButton!
    @IBOutlet weak var bmiLabel: UILabel!
    
    func formatUIView(view: UIView) {
        view.layer.cornerRadius = 10.0
        view.layer.masksToBounds = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        formatUIView(view: dateLabel)
        formatUIView(view: stepsLabel)
        formatUIView(view: calorieLabel)
        formatUIView(view: distanceLabel)
        formatUIView(view: weightLabel)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        overrideUserInterfaceStyle = UserDefaults.standard.bool(forKey: "darkModeOn") ? .dark : .light
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
