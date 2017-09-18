//
//  NamesViewController.swift
//  OnTheMap
//
//  Created by Carlos Lozano on 9/13/17.
//  Copyright © 2017 Carlos Lozano. All rights reserved.
//

import UIKit

class NamesViewController: UIViewController,UITextFieldDelegate {
    var delegate = (UIApplication.shared.delegate) as! AppDelegate
    
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var location: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var url: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nextButton.layer.cornerRadius = 10
        firstName.delegate = self
        lastName.delegate = self
        location.delegate = self
        url.delegate = self
        
        firstName.text = delegate.user?.firstName
        lastName.text = delegate.user?.lastName
        firstName.isEnabled = false
        lastName.isEnabled = false
        
        // Do any additional setup after loading the view.
    }

    @IBAction func closeModal(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let pinLocationVC: PinLocationViewController = (segue.destination as? PinLocationViewController)!
        let studentData  = [
            Client.jsonKeys.studentkeys.firstName: firstName.text as AnyObject,
            Client.jsonKeys.studentkeys.lastName: lastName.text as AnyObject,
            Client.jsonKeys.studentkeys.mapString: location.text as AnyObject,
            Client.jsonKeys.studentkeys.mediaURL: url.text as AnyObject
        ]
        pinLocationVC.student = Student(studentData: studentData)
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
    
    
    
    @IBAction func goToMapLocation(_ sender: Any) {
        
        self.performSegue(withIdentifier: "pinLocationSegue", sender: self)
    }
    
    
    func keyboardWillShow(_ notification:Notification) {
        if UIDevice.current.orientation.isLandscape{
            
            view.frame.origin.y = 0 - getKeyboardHeight(notification)
            
        }else{
            if(location.isEditing)||(url.isEditing){
                
                view.frame.origin.y = 0 - getKeyboardHeight(notification)
            }
        }
    }

}
