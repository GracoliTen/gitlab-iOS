//
//  User.swift
//  gitlab-iOS
//
//  Created by Xplorld on 2016/3/18.
//  Copyright © 2016年 dyweb. All rights reserved.
//

import ObjectMapper
import Alamofire

class User: Mappable {
    
    var id:Int = -1
    var username:String?
    var name:String?
    var state:String?
    var avatar_url:String?
    var created_at:NSDate?
    var bio:String?
    var website_url:String?
    
    required init?(_ map: Map) {}
    func mapping(map: Map) {
        id <- map["id"]
        username <- map["username"]
        name <- map["name"]
        state <- map["state"]
        avatar_url <- map["avatar_url"]
        created_at <- (map["created_at"],GitLabDateTransform())
        bio <- map["bio"]
        
        website_url <- map["website_url"]
        if website_url == nil {
            website_url <- map["web_url"]
        }
    }
}


//enum LoginRouter:HostProvidedURLRequestConvertible {
//    case Username(String,String)
//    case Email(String,String)
//    
//    func request(host:NSURL) -> NSMutableURLRequest {
//        let parameters:[String:String]
//        switch self {
//        case .Username(let name, let password):
//            parameters = ["login":name,"password":password]
//        case .Email(let email, let password):
//            parameters = ["email":email,"password":password]
//        }
//        let request = NSMutableURLRequest(URL: host.URLByAppendingPathComponent("/api/v3/"))
//        request.HTTPMethod = Alamofire.Method.POST.rawValue
//        return Alamofire.ParameterEncoding.URL.encode(request, parameters: parameters).0
//    }
//}
//
