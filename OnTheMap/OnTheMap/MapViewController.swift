//
//  MapViewController.swift
//  OnTheMap
//
//  Created by Carlos Lozano on 9/10/17.
//  Copyright © 2017 Carlos Lozano. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController,MKMapViewDelegate {

    @IBOutlet weak var map: MKMapView!
    
    var students = [Student]()
    var delegate: AppDelegate = (UIApplication.shared.delegate as! AppDelegate)
    let identifier = "pin"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        map.delegate = self
        
        //Mark: left button
        let leftButton = UIButton.init(type: .custom)
        leftButton.setImage(UIImage(named: "icon_back-arrow"), for: UIControlState.normal)
        leftButton.addTarget(self, action: #selector(self.pinUser), for: UIControlEvents.touchUpInside)
        leftButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        leftButton.imageView?.contentMode = .scaleAspectFit
        let leftBarButton = UIBarButtonItem(customView: leftButton)
        self.navigationItem.leftBarButtonItem = leftBarButton
        
        // Mark: right button
        let rightButton = UIButton.init(type: .custom)
        rightButton.setImage(UIImage(named: "icon_world"), for: UIControlState.normal)
        rightButton.addTarget(self, action: #selector(self.pinUser), for: UIControlEvents.touchUpInside)
        rightButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        rightButton.imageView?.contentMode = .scaleAspectFit
        let rightBarButton = UIBarButtonItem(customView: rightButton)
        self.navigationItem.rightBarButtonItem = rightBarButton
        
        self.navigationItem.title = "On the map"
        
        
    }

    func pinUser(){
    
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let studentsData:[Student] = delegate.students, delegate.students != nil else{
            loadAllStudents()
            return
        }
        self.students = studentsData
        self.createAllStudentAnnotations(self.students)

        
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? OTMAnnotation {
            var view: MKPinAnnotationView
            if let dequedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView{
                dequedView.annotation = annotation
                view = dequedView
            
            }else{
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.canShowCallout = true
                view.calloutOffset = CGPoint(x: -5, y: 5)
                let infoButton = OTMInfoButton(type: .detailDisclosure)
                infoButton.url = annotation.student.mediaURL
                infoButton.addTarget(self, action: #selector(self.goToStudentPage), for: .touchUpInside)

                
                view.rightCalloutAccessoryView = infoButton
                
            }
            return view
            
        }
        
        return nil
    }
    
    
    func goToStudentPage(sender: OTMInfoButton){
        UIApplication.shared.openURL(URL(string: sender.url!)!)
    }
    
    func createAllStudentAnnotations(_ students:[Student]){
        for student in students{
            if student.latitude != nil && student.longitude != nil{
                self.map.addAnnotation(OTMAnnotation(latitude: student.latitude!,longitude: student.longitude!,student: student))
            }
        }
    
    }
    
    
    func loadAllStudents(){
        self.map.removeAnnotations(self.map.annotations)
        delegate.loadStudents(){
            (students, error) in
            DispatchQueue.main.async {
                if error != nil{
                    let alert = UIAlertController(title: "Download failed", message:
                        "the app failed to download the first 100 student", preferredStyle: .alert)
                    let dismissAction = UIAlertAction(title: "Got it", style: .default){ action in}
                    alert.addAction(dismissAction)
                    self.present(alert, animated: true, completion: nil)
                }else{
                    self.students = students!
                    self.createAllStudentAnnotations(self.students)
                    
                }
            }
        }
    
    }
    
    
}
