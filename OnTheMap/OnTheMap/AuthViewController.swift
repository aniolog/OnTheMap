//
//  AuthViewController.swift
//  OnTheMap
//
//  Created by Carlos Lozano on 9/12/17.
//  Copyright © 2017 Carlos Lozano. All rights reserved.
//

import UIKit

class AuthViewController: UIViewController {

    var service: AuthService?
    
    
    @IBOutlet weak var usernameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var invalidCredentialsLabel: UILabel!
    
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.invalidCredentialsLabel.isHidden = true
        service = AuthService()
        loginButton.layer.cornerRadius = 10
        
    }

    @IBAction func performLogin(_ sender: Any) {
        let logedViewControllert = self.storyboard?.instantiateViewController(withIdentifier: "appRoot")
        enableUI(status: false)
        service?.performLogin(username: usernameField.text!, password: passwordField.text!){
            (response,error) in
            
            DispatchQueue.main.async {
                self.enableUI(status: true)
                if error != nil {
                    self.invalidCredentialsLabel.isHidden = false
                    if error?.code == 0 {
                        self.invalidCredentialsLabel.text = "Error: no internet connection"
                    }else{
                        self.invalidCredentialsLabel.text = "Error: invalid credential"
                    }
                }else{
                    self.usernameField.text = ""
                    self.passwordField.text = ""
                    self.present(logedViewControllert!, animated: true, completion: nil)
                }
            }
        }
    }
    
    func enableUI(status: Bool){
        usernameField.isEnabled = status
        passwordField.isEnabled = status
        loginButton.isEnabled = status
    }
    
}
