//
//  OnTheMapAnnotation.swift
//  OnTheMap
//
//  Created by Carlos Lozano on 9/10/17.
//  Copyright © 2017 Carlos Lozano. All rights reserved.
//

import Foundation
import MapKit


class OTMAnnotation: NSObject,MKAnnotation {
 
    var title: String?
    var coordinate: CLLocationCoordinate2D
    var student: Student
 
    init(latitude: Double, longitude: Double ,student: Student) {
        
        self.title = "\(student.firstName!) \(student.lastName!)"
        self.coordinate = CLLocationCoordinate2D(latitude:latitude, longitude: longitude)
        self.student = student
        super.init()
    }

    var subtitle: String?{
        return student.mediaURL
    }
}
