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
    var email:String?
    
    required init?(_ map: Map) {}
    func mapping(map: Map) {
        id <- map["id"]
        username <- map["username"]
        name <- map["name"]
        state <- map["state"]
        avatar_url <- map["avatar_url"]
        created_at <- (map["created_at"],GitLabDateTransform())
        bio <- map["bio"]
        email <- map["email"]
        
        website_url <- map["website_url"]
        if website_url == nil {
            website_url <- map["web_url"]
        }
    }
}



enum UserRouter : HostProvidedURLRequestConvertible {
    case List
    case Single(Int)
    case Project(Int,Int?) //project_id, user_id
    
    typealias ReturnType = User
    
    var path:String {
        switch self {
        case .List:
            return "/users"
        case .Single(let id):
            return "/users/\(id)"
        case .Project(let id,let userid):
            var s = "/projects/\(id)/members"
            if let i = userid {s += "/\(i)"}
            return s
        }
    }
    
    
    func request(host:NSURL) -> NSMutableURLRequest {
        let request = NSMutableURLRequest(URL: host.URLByAppendingPathComponent(self.path))
        request.HTTPMethod = Alamofire.Method.GET.rawValue
        return Alamofire.ParameterEncoding.URL.encode(request, parameters: nil).0
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
