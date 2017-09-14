//
//  AuthService.swift
//  OnTheMap
//
//  Created by Carlos Lozano on 9/12/17.
//  Copyright © 2017 Carlos Lozano. All rights reserved.
//

import Foundation

class AuthService{

    var client: Client?
    
    init() {
        self.client = Client()
    }


    
    func performLogin(username:String, password:String,completionHandler: @escaping (Data?,NSError?)->Void){
    
        let body = "{\"udacity\": {\"username\": \"\(username)\", \"password\": \"\(password)\"}}"
        
        let parameters = [String: AnyObject]()
        
        let headers = [
            Client.requestConstants.headersKeys.udacity.accept: Client.requestConstants.headersValues.udacity.appJson,
            Client.requestConstants.headersKeys.udacity.contentType: Client.requestConstants.headersValues.udacity.appJson
        ]
        
        client?.post(getUrl: Client.requestConstants.authBaseUrl, getPath: Client.requestConstants.authPath, parameters: parameters, headers: headers, body: body){
                (response,error) in
            
                if error != nil {
                    completionHandler(nil,error)
                }else{
                    let range = Range(5..<response!.count)
                    let newData = response?.subdata(in: range)
                    
                    do{
                        let result = (try JSONSerialization.jsonObject(with: newData!, options: .allowFragments) as? [String: AnyObject])
                        let session = result?["session"] as? [String : AnyObject]
                        let id = session?["id"] as? String
                        let cookieProps: [HTTPCookiePropertyKey : Any] = [
                            HTTPCookiePropertyKey.path: "/",
                            HTTPCookiePropertyKey.name: "XSRF-TOKEN",
                            HTTPCookiePropertyKey.value: id,
                        ]
                        if let cookie = HTTPCookie(properties: cookieProps) {
                            HTTPCookieStorage.shared.setCookie(cookie)
                        }
                        completionHandler(id?.data(using: .utf8), nil)
                        
                        
                    }catch{
                        let userInfo = [NSLocalizedDescriptionKey : "parse error"]
                        completionHandler(nil, NSError(domain: "get method", code: 1, userInfo: userInfo))
                    }
                    
                }
            
            }
    
    }

    func performLogout(){
    
        
    
    
    }




}
