//
//  Student.swift
//  OnTheMap
//
//  Created by Carlos Lozano on 9/10/17.
//  Copyright © 2017 Carlos Lozano. All rights reserved.
//

import Foundation


struct Student {
    
    var objectID  : String
    var uniqueKey : String?
    var firstName : String?
    var lastName  : String?
    var mapString : String?
    var mediaURL  : String?
    var latitude  : Double?
    var longitude : Double?
    var createdAt : String
    var updatedAt : String
    
    
    
    init(studentData : [String: AnyObject]) {
        objectID  = studentData[Client.jsonKeys.studentkeys.objectID] as! String
        uniqueKey = studentData[Client.jsonKeys.studentkeys.uniqueKey] as? String
        firstName = studentData[Client.jsonKeys.studentkeys.firstName] as? String
        lastName  = studentData[Client.jsonKeys.studentkeys.lastName] as? String
        mapString = studentData[Client.jsonKeys.studentkeys.mapString] as? String
        mediaURL  = studentData[Client.jsonKeys.studentkeys.mediaURL] as? String
        latitude  = studentData[Client.jsonKeys.studentkeys.latitude] as? Double
        longitude = studentData[Client.jsonKeys.studentkeys.longitude] as? Double
        createdAt = studentData[Client.jsonKeys.studentkeys.createdAt] as! String
        updatedAt = studentData[Client.jsonKeys.studentkeys.updatedAt] as! String
    }

}
