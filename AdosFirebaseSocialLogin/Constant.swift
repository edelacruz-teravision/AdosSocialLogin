//
//  Constant.swift
//  AdosFirebaseSocialLogin
//
//  Created by Eduardo de la Cruz on 22/9/17.
//  Copyright © 2017 Eduardo De La Cruz. All rights reserved.
//

import Foundation

struct INSTAGRAM_IDS
{
    static let INSTAGRAM_AUTHURL = "https://api.instagram.com/oauth/authorize/"
    
    static let INSTAGRAM_APIURl  = "https://api.instagram.com/v1/users/"
    
    static let INSTAGRAM_CLIENT_ID  = "REPLACE_YOUR_CLIENT_ID_HERE"
    
    static let INSTAGRAM_CLIENTSERCRET = "REPLACE_YOUR_CLIENT_SECRET_HERE"
    
    static let INSTAGRAM_REDIRECT_URI = "REPLACE_YOUR_REDIRECT_URI_HERE"
    
    static let INSTAGRAM_ACCESS_TOKEN =  "access_token"
    
    static let INSTAGRAM_SCOPE = "likes+comments+relationships"    
}

struct ServerData
{
    static let clientId : String = "2"
    
    static let clientSecret : String = "Uv2Fsi9uW8qv8ueIJlGSjiOTtJRihNHKryEVvlo9"
    
    static let adosUrl : String = "https://webbrokerbeta.teravisiontech.com:8188/oauth/token"
    
    static let grantType : String = "password"
    
    static let deviceToken : String = "device_token"
}
