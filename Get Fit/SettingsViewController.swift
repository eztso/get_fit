//
//  SettingsViewController.swift
//  Get Fit
//
//  Created by Michael Lee on 7/7/20.
//  Copyright © 2020 Ewin Zuo. All rights reserved.
//

import UIKit
extension UIView {
    public func addViewBorder(borderColor:CGColor,borderWith:CGFloat,borderCornerRadius:CGFloat){
        self.layer.borderWidth = borderWith
        self.layer.borderColor = borderColor
        self.layer.cornerRadius = borderCornerRadius

    }
}

class SettingsViewController: UIViewController {
        
    @IBOutlet weak var notificationsSettingView: UIView!
    @IBOutlet weak var darkModeSettingView: UIView!
    @IBOutlet weak var dataRetentionSettingView: UIView!
    @IBOutlet weak var darkModeSwitch: UISwitch!
    @IBOutlet weak var notificationsSwitch: UISwitch!
    @IBOutlet weak var dataRetentionSwitch: UISwitch!
    
    func formatUIView(view: UIView) {
//        view.addViewBorder(borderColor: UIColor.gray.cgColor, borderWith: 1.5, borderCornerRadius: 1.5)
        view.layer.cornerRadius = 10.0
        view.layer.masksToBounds = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        formatUIView(view: notificationsSettingView)
        formatUIView(view: darkModeSettingView)
        formatUIView(view: dataRetentionSettingView)
        darkModeSwitch.isOn = UserDefaults.standard.bool(forKey: "darkModeOn")
        notificationsSwitch.isOn = UserDefaults.standard.bool(forKey: "notificationsOn")
        dataRetentionSwitch.isOn = UserDefaults.standard.bool(forKey: "dataRetentionOn")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        overrideUserInterfaceStyle = UserDefaults.standard.bool(forKey: "darkModeOn") ? .dark : .light
    }
    
    @IBAction func darkModeToggled(_ sender: Any) {
        let defaults = UserDefaults.standard
        defaults.set(darkModeSwitch.isOn, forKey: "darkModeOn")
        overrideUserInterfaceStyle = UserDefaults.standard.bool(forKey: "darkModeOn") ? .dark : .light
    }
    
    @IBAction func notificationsToggled(_ sender: Any) {
        let defaults = UserDefaults.standard
        defaults.set(notificationsSwitch.isOn, forKey: "notificationsOn")
    }
    
    @IBAction func dataRetentionToggled(_ sender: Any) {
        let defaults = UserDefaults.standard
        defaults.set(dataRetentionSwitch.isOn, forKey: "dataRetentionOn")
    }
}
