//
//  Constants.swift
//  OnTheMap
//
//  Created by Carlos Lozano on 9/10/17.
//  Copyright © 2017 Carlos Lozano. All rights reserved.
//

import Foundation

extension Client{

    
    struct jsonKeys {
        struct studentkeys {
            static let objectID  = "objectId"
            static let uniqueKey = "uniqueKey"
            static let firstName = "firstName"
            static let lastName  = "lastName"
            static let mapString = "mapString"
            static let mediaURL  = "mediaURL"
            static let latitude  = "latitude"
            static let longitude = "longitude"
            static let createdAt = "createdAt"
            static let updatedAt = "updatedAt"
            static let results   = "results"
        }
    }
    
    struct requestConstants {
        
        struct parseUrlParamKeys{
            static let limit = "limit"
            static let skip  = "skip"
            static let orderBy = "order"
        }
        
        struct headersKeys {
            struct parse{
                static let appId  = "X-Parse-Application-Id"
                static let apiKey = "X-Parse-REST-API-Key"
                static let contentType = "Content-Type"
                static let accept = "Accept"
            }
            struct udacity{
                static let contentType = "Content-Type"
                static let accept = "Accept"
                static let xsrfToken = "XSRF-TOKEN"
            }
            
        }
        struct headersValues {
            struct parse{
                static let appId = "QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr"
                static let apiKey = "QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY"
            }
            struct udacity{
                static let appJson = "application/json"
            }
        }
        struct verbs {
            static let get    = "GET"
            static let post   = "POST"
            static let put    = "PUT"
            static let delete = "DELETE"
        }
        
        static let studentLocationBaseUrl = "parse.udacity.com"
        static let studentLocationPath = "/parse/classes/StudentLocation"
        static let authBaseUrl = "www.udacity.com"
        static let authPath = "/api/session"
        static let scheme = "https"
    }



}
