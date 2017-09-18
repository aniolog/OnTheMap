//
//  AuthViewController.swift
//  OnTheMap
//
//  Created by Carlos Lozano on 9/12/17.
//  Copyright © 2017 Carlos Lozano. All rights reserved.
//

import UIKit

class AuthViewController: UIViewController, UITextFieldDelegate {

    var service: AuthService?
    var studentService: StudentService?
    
    @IBOutlet weak var usernameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameField.delegate = self
        passwordField.delegate = self
        service = AuthService()
        studentService = StudentService()
        loginButton.layer.cornerRadius = 10
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.unsubscribeFromKeyboardNotifications()
    }
    
    
    @IBAction func performLogin(_ sender: Any) {
        let logedViewControllert = self.storyboard?.instantiateViewController(withIdentifier: "appRoot")
        enableUI(status: false)
        service?.performLogin(username: usernameField.text!, password: passwordField.text!){
            (error) in
            
            DispatchQueue.main.async {
                self.enableUI(status: true)
                if error != nil {
                    if error?.code == 0 {
                        self.displayError(title: "Error", message: "No internet connection", dismissMessage: "Got it")
                    }else{
                        self.displayError(title: "Error", message: "Invalid credentials", dismissMessage: "Got it")
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        usernameField.resignFirstResponder()
        passwordField.resignFirstResponder()
        
        if(textField == usernameField){
            passwordField.becomeFirstResponder()
        }else{
            performLogin(passwordField)
        }
        
        
        
        return true
    }
    
    
    
    func keyboardWillShow(_ notification:Notification) {
        if UIDevice.current.orientation.isLandscape{
         
                view.frame.origin.y = 0 - getKeyboardHeight(notification)
            
        }
    }
    
    
    
}
