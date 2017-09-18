//
//  AuthService.swift
//  OnTheMap
//
//  Created by Carlos Lozano on 9/12/17.
//  Copyright © 2017 Carlos Lozano. All rights reserved.
//

import Foundation
import UIKit

class AuthService{

    var client: Client?
    
    var delegate: AppDelegate = (UIApplication.shared.delegate as! AppDelegate)
    
    init() {
        self.client = Client()
    }
    
    func performLogin(username:String, password:String,completionHandler: @escaping (NSError?)->Void){
    
        let body = "{\"udacity\": {\"username\": \"\(username)\", \"password\": \"\(password)\"}}"
        
        let parameters = [String: AnyObject]()
        
        let headers = [
            Client.requestConstants.headersKeys.udacity.accept: Client.requestConstants.headersValues.udacity.appJson,
            Client.requestConstants.headersKeys.udacity.contentType: Client.requestConstants.headersValues.udacity.appJson
        ]
        
        client?.post(postUrl: Client.requestConstants.authBaseUrl, postPath: Client.requestConstants.authPath, parameters: parameters, headers: headers, body: body){
                (response,error) in
            
                func prepareError(errorMessage: String){
                    let userInfo = [NSLocalizedDescriptionKey : "parse error: \(errorMessage)"]
                    completionHandler(NSError(domain: "get method", code: 1, userInfo: userInfo))
                }
            
                if error != nil {
                    completionHandler(error)
                }else{
                    let range = Range(5..<response!.count)
                    let newData = response?.subdata(in: range)
                    
                    do{
                        let result = (try JSONSerialization.jsonObject(with: newData!, options: .allowFragments) as? [String: AnyObject])
                        let session = result?["session"] as? [String : AnyObject]
                        let account = result?["account"] as? [String : AnyObject]
                        print(result)
                        
                        guard let sessionId = session?["id"] as? String else{
                            prepareError(errorMessage: "unable to find id in the response")
                            return
                        }
                        
                        guard let key = account?["key"] as? String else{
                            prepareError(errorMessage: "unable to find key in the response")
                            return
                        }
                     
                        self.getUserData(sessionId: sessionId, userId: key){
                            (error) in
                            completionHandler(nil)
                            
                        }
                        
                        
                    }catch{
                        prepareError(errorMessage: "response is not a parsable json")
                    }
                    
                }
            
            }
    
    }

    func performLogout(completitionHandler:@escaping ([String: AnyObject]?,NSError?)->Void){
        var parameters: [String: AnyObject]? = nil
        
        let headers = [
            Client.requestConstants.headersKeys.udacity.accept: Client.requestConstants.headersValues.udacity.appJson,
            Client.requestConstants.headersKeys.udacity.contentType: Client.requestConstants.headersValues.udacity.appJson
        ]
        var xsrfCookie: HTTPCookie? = nil
        let sharedCookieStorage = HTTPCookieStorage.shared
        for cookie in sharedCookieStorage.cookies! {
            if cookie.name == "XSRF-TOKEN"{
                xsrfCookie = cookie
            }
        }
        if let xsrfCookie = xsrfCookie {
           parameters = [
             "X-XSRF-TOKEN" : xsrfCookie.value as AnyObject
            ]
        }
        
        client?.delete(deleteUrl: Client.requestConstants.authBaseUrl, deletePath: Client.requestConstants.authPath, parameters: parameters!, headers: headers){
            (data,error) in
            
            if error != nil { // Handle error…
                return
            }
            do{
            
                let range = Range(5..<data!.count)
                let newData = data?.subdata(in: range) /* subset response data! */
                print(NSString(data: newData!, encoding: String.Encoding.utf8.rawValue)!)
                let result = (try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: AnyObject])
                completitionHandler(result,nil)
                
            }catch{
            
                completitionHandler(nil,error as NSError)
            
            }
          
            
            
        }
    
    
    }

    func getUserData(sessionId: String ,userId: String, completitionHandler: @escaping (NSError?)->Void){
       
        let path = "\(Client.requestConstants.userPath)\(userId)"
        let parameters = [String: AnyObject]()
        let headers = [String:String]()
  
        client?.getData(getUrl: Client.requestConstants.authBaseUrl, getPath: path, parameters: parameters, headers: headers){
            (data,error) in
            
            func prepareError(errorMessage: String){
                let userInfo = [NSLocalizedDescriptionKey : "parse error: \(errorMessage)"]
                completitionHandler(NSError(domain: "get method", code: 1, userInfo: userInfo))
            }
            
            do {
                
                let range = Range(5..<data!.count)
                let newData = data?.subdata(in: range)
                
                guard let response = try JSONSerialization.jsonObject(with: newData!, options: .allowFragments) as? [String:AnyObject] else{
                    prepareError(errorMessage: "response not in json format")
                    return
                }

                guard let userInfo = response["user"] as? [String:AnyObject] else{
                     prepareError(errorMessage: "unable to find user in response")
                    return
                }

                guard let firstName: String = userInfo["first_name"] as? String else{
                     prepareError(errorMessage: "unable to find first_name in response")
                    return
                }

                guard let lastName: String = userInfo["last_name"] as? String  else{
                    prepareError(errorMessage: "unable to find last_name in response")
                    return
                }

                self.delegate.user = User(firstName,lastName)
        
                
                let cookieProps: [HTTPCookiePropertyKey : Any] = [
                    HTTPCookiePropertyKey.path: "/",
                    HTTPCookiePropertyKey.name: "XSRF-TOKEN",
                    HTTPCookiePropertyKey.value: sessionId ?? "",
                    ]
                if let cookie = HTTPCookie(properties: cookieProps) {
                    HTTPCookieStorage.shared.setCookie(cookie)
                }
                
                completitionHandler(nil)
            }catch{
            
            }
            
        
        }
    }



}
