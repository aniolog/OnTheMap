//
//  PinLocationViewController.swift
//  OnTheMap
//
//  Created by Carlos Lozano on 9/13/17.
//  Copyright © 2017 Carlos Lozano. All rights reserved.
//

import UIKit

class PinLocationViewController: UIViewController {

    @IBOutlet weak var submitButton: UIButton!
    
    var student: Student?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        submitButton.layer.cornerRadius = 10
    }
    
    
    @IBAction func closeModal(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

    
}
