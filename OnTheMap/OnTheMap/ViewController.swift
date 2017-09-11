//
//  ViewController.swift
//  OnTheMap
//
//  Created by Carlos Lozano on 9/10/17.
//  Copyright © 2017 Carlos Lozano. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var studentService : StudentService?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        studentService = StudentService()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("hola")

    }

}

