//
//  PinLocationViewController.swift
//  OnTheMap
//
//  Created by Carlos Lozano on 9/13/17.
//  Copyright © 2017 Carlos Lozano. All rights reserved.
//

import UIKit
import MapKit

class PinLocationViewController: UIViewController {

    
    var student: Student?
    var geocoder: CLGeocoder?
    var activityIndicator: UIActivityIndicatorView?
    var service: StudentService?
    
    let completitionHandler = ()
    
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var map: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        service = StudentService()
        submitButton.isEnabled = false
        submitButton.layer.cornerRadius = 10
        activityIndicator = self.prepareActivityIndicator()
        activityIndicator?.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
        geocoder = CLGeocoder()
        geocoder?.geocodeAddressString((student?.mapString)!) {
            placeMarks, error in
            
            UIApplication.shared.endIgnoringInteractionEvents()
            self.activityIndicator?.stopAnimating()
            if error != nil{
                self.displayError(title: "Error", message: "the app failed to locate that address", dismissMessage:"Got it")
            }else{
                if let placeMark = placeMarks?[0], (placeMarks?.count)!>0{
                    self.submitButton.isEnabled=true
                    self.student?.latitude = placeMark.location?.coordinate.latitude
                    self.student?.longitude = placeMark.location?.coordinate.longitude
                    self.map.addAnnotation(OTMAnnotation(latitude: (self.student?.latitude!)!,longitude: (self.student?.longitude!)!,student: self.student!))
                    self.map.showAnnotations(self.map.annotations, animated: true)
                }
            }
        }
        
    }
    
    
    @IBAction func closeModal(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

    @IBAction func submitStudent(_ sender: Any) {
        service?.postStudent(self.student!){
            (response, error) in
            DispatchQueue.main.async {
                UIApplication.shared.endIgnoringInteractionEvents()
                if error != nil{
                    self.displayError(title: "Error", message: "the app failed to post your location", dismissMessage: "Got it")
                }else{
                    
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
        
        
    }
    
    
}
