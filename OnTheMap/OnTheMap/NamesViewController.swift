//
//  NamesViewController.swift
//  OnTheMap
//
//  Created by Carlos Lozano on 9/13/17.
//  Copyright © 2017 Carlos Lozano. All rights reserved.
//

import UIKit

class NamesViewController: UIViewController {

    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var location: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var url: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nextButton.layer.cornerRadius = 10
        
        // Do any additional setup after loading the view.
    }

    @IBAction func closeModal(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
    
    
    @IBAction func goToMapLocation(_ sender: Any) {
        
        self.performSegue(withIdentifier: "pinLocationSegue", sender: self)
    }

}
