//
//  LoginViewController.swift
//  Get Fit
//
//  Created by Michael Lee on 7/8/20.
//  Copyright © 2020 Ewin Zuo. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController {
    let loginSegueIdentifier: String = "LoginSegueIdentifier"
    let signInIndex: Int = 0
    let signUpIndex: Int = 1
    
    @IBOutlet weak var loginSegmentControl: UISegmentedControl!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var confirmPasswordLabel: UILabel!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var skipLoginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loginSegmentControl.selectedSegmentIndex = 0
        loginSegmentControl.sendActions(for: UIControl.Event.valueChanged)
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
    @IBAction func onSegmentChange(_ sender: Any) {
        if loginSegmentControl.selectedSegmentIndex == signInIndex {
            confirmPasswordLabel.isHidden = true
            confirmPasswordTextField.isHidden = true
            skipLoginButton.isHidden = false
            signInButton.setTitle("Sign In", for: .normal)
        }
        else {
            confirmPasswordLabel.isHidden = false
            confirmPasswordTextField.isHidden = false
            skipLoginButton.isHidden = true
            signInButton.setTitle("Sign Up", for: .normal)
        }
    }
    
    func trySignIn() {
        guard let username = userNameTextField.text,
               let password = passwordTextField.text,
               !username.isEmpty,
               !password.isEmpty
         else {
            statusLabel.text = "Enter both a username and password"
            return
        }
        
        Auth.auth().signIn(withEmail: username, password: password) {
            user, error in
            if let error = error, user == nil {
                self.statusLabel.lineBreakMode = .byWordWrapping
                self.statusLabel.numberOfLines = 0
                self.statusLabel.text = error.localizedDescription
            }
            else {
                self.performSegue(withIdentifier: self.loginSegueIdentifier, sender: nil)
            }
        }
    }
    
    func trySignUp() {
        guard let username = userNameTextField.text,
              let password = passwordTextField.text,
               !username.isEmpty,
               !password.isEmpty
         else {
            statusLabel.text = "Enter a username and password"
            return
        }
        guard let confirmedPassword = confirmPasswordTextField.text,
               !confirmedPassword.isEmpty
        else {
            statusLabel.text = "Confirm your password"
            return
        }
        if password != confirmedPassword {
            statusLabel.text = "Passwords do not match"
            return
        }

        Auth.auth().createUser(withEmail: username, password: password) { user, error in
            if error == nil {
                Auth.auth().signIn(withEmail: username,
                                   password: password)
                self.performSegue(withIdentifier: self.loginSegueIdentifier, sender: nil)
            }
            else {
                self.statusLabel.lineBreakMode = .byWordWrapping
                self.statusLabel.numberOfLines = 0
                self.statusLabel.text = error!.localizedDescription
            }
        }
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//
//        // If we are changing text, we want to pass the default
//        // value of the input text field
//        if segue.identifier == loginSegueIdentifier,
//            let targetViewController = segue.destination as? ViewController {
//            targetViewController.currentUserId = userNameTextField.text!
//        }
//    }
    @IBAction func skipLoginButtonPressed(_ sender: Any) {
        self.performSegue(withIdentifier: self.loginSegueIdentifier, sender: nil)
    }
    
    @IBAction func signInButtonPressed(_ sender: Any) {
        if loginSegmentControl.selectedSegmentIndex == signInIndex {
            trySignIn()
        }
        else {
            trySignUp()
        }
    }
    
    // Taken from Professor Bulko's Swift Snippets page
    // The following code removes the software keyboard when the background is tapped
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}
