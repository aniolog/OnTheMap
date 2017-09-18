//
//  TableTableViewController.swift
//  OnTheMap
//
//  Created by Carlos Lozano on 9/10/17.
//  Copyright © 2017 Carlos Lozano. All rights reserved.
//

import UIKit

class TableTableViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    let identifier:String = "cell"
    var delegate: AppDelegate = (UIApplication.shared.delegate as! AppDelegate)
    
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        prepareNavigationBarButtons()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let studentsData:[Student] = delegate.students else{
            loadAllStudents()
            return
        }
        
        self.delegate.students = studentsData
        self.table.reloadData()
    }
    
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return delegate.students!.count
    }

    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier)!
        let student = self.delegate.students?[indexPath.row]
        cell.textLabel?.text = "\(student?.firstName ?? " ") \(student?.lastName ?? " ")"
        cell.imageView?.image = UIImage(named: "icon_pin")
        
        
        return cell
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        UIApplication.shared.openURL(URL(string: (delegate.students?[indexPath.row].mediaURL!)!)!)
    }

    func loadAllStudents(){
        delegate.loadStudents(){
            (error) in
            DispatchQueue.main.async {
                if error != nil{
                    self.displayError(title: "Download failed", message: "the app failed to download the first 100 students", dismissMessage: "Got it")
                }else{
                    self.table.reloadData()
                }
            }
        }
    }
    
}
