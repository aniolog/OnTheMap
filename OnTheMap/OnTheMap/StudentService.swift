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
    
    let headers = [
        Client.requestConstants.headersKeys.parse.apiKey : Client.requestConstants.headersValues.parse.apiKey,
        Client.requestConstants.headersKeys.parse.appId : Client.requestConstants.headersValues.parse.appId,
        Client.requestConstants.headersKeys.parse.contentType: Client.requestConstants.headersValues.udacity.appJson
    ]
    
    
    init() {
        client = Client()
    }
    
    
    func getStudentsPosition(handler completionHandler: @escaping (_ studentsList:[Student]?, _ error: NSError? ) ->Void)->Void{
        
        let parameters = [
            Client.requestConstants.parseUrlParamKeys.limit : "100" as AnyObject,
            Client.requestConstants.parseUrlParamKeys.orderBy: "-\(Client.jsonKeys.studentkeys.createdAt)" as AnyObject
        
        ]
        
        print(parameters)
        
        
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
                              
                                if !(studentDict[Client.jsonKeys.studentkeys.latitude] is NSNull)
                                {
                                    if !(studentDict[Client.jsonKeys.studentkeys.latitude] is NSNull){
                                           students.append(Student(studentData: studentDict))
                                    }
                                }
                            }
                            completionHandler(students, nil)
                        }
                }
        }
    
    
    func postStudent(_ student :Student,completionHandler: @escaping (String?,NSError?)->Void){
        
        let parameters = [String: AnyObject]()
        
        
        
        
        let studentBody =  "{\"uniqueKey\": \"1234\", \"firstName\": \"\(student.firstName!)\", \"lastName\": \"\(student.lastName!)\",\"mapString\": \"\(student.mapString!)\", \"mediaURL\": \"\(student.mediaURL!)\",\"latitude\": \(student.latitude!), \"longitude\": \(String(describing: student.longitude!))}"
        
        
        client.post(postUrl: Client.requestConstants.studentLocationBaseUrl, postPath: Client.requestConstants.studentLocationPath, parameters: parameters, headers: headers, body: studentBody){
            (response,error) in
            
            
            if error != nil{
                completionHandler(nil,error)
            }else{
                do{
                    let response = try JSONSerialization.jsonObject(with: response!, options: .allowFragments) as! [String: AnyObject]
                   // completionHandler("hola",nil)
                    print(response)
                }catch{
                    
                    completionHandler(nil,error as NSError)
                }
            }
            
        }
    
    }
    
    func putStudent(_ student :Student,completionHandler: @escaping (Student?,NSError?)->Void){
        
        
    }
    
}
