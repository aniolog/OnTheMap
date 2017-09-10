//
//  StudentService.swift
//  OnTheMap
//
//  Created by Carlos Lozano on 9/10/17.
//  Copyright © 2017 Carlos Lozano. All rights reserved.
//

import Foundation


class StudentService {
    
    
    
    var client : Client
    
    init() {
        client = Client()
    }
    
    
    func getStudentsPosition(limit: Int, completionHandler: @escaping (_ studentsList:[Student]?, _ error: NSError? ) ->Void){
        
        let parameters = [
            Client.requestConstants.parseUrlParamKeys.limit : String(limit) as AnyObject]
        
        let headers = [
            Client.requestConstants.headersKeys.parse.apiKey : Client.requestConstants.headersValues.parse.apiKey,
            Client.requestConstants.headersKeys.parse.appId : Client.requestConstants.headersValues.parse.appId]
        
        client.get(getUrl: Client.requestConstants.studentLocationBaseUrl,
                   getPath: Client.requestConstants.studentLocationPath,
                   parameters: parameters,
                   headers: headers){
                     (data, error) in
        
                        if error !=  nil {
                           completionHandler(nil, error)
                        }else{
                            guard let results = data?[Client.jsonKeys.studentkeys.results] as? [[String: AnyObject]] else{
                                print("unable to parse it")
                                return
                            }
                        
                            var students: [Student] = [Student]()
                            
                            for studentDict in results{
                                students.append(Student(studentData: studentDict))
                            }
                            completionHandler(students, nil)
                        }
                }
    }
    
    
    
    
    
    
}