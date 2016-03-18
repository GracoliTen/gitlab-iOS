//
//  Project.swift
//  gitlab-iOS
//
//  Created by Xplorld on 2016/3/18.
//  Copyright © 2016年 dyweb. All rights reserved.
//
import ObjectMapper
import Alamofire

class Project : Mappable {
    var id:Int?
    var description:String?
    var isPublic:Bool?
    var name:String?
    var avatar_url:String?
    
    required init?(_ map: Map) {}
    func mapping(map: Map) {
        id <- map["id"]
        description <- map["description"]
        isPublic <- map["public"]
        name <- map["name"]
        avatar_url <- map["avatar_url"]
    }
}

enum ProjectRouter : HostProvidedURLRequestConvertible {
    case accessable
    case owned
    case starred
    case id(Int)
    
    var path:String {
        let base = "/projects"
        switch self {
        case .accessable:
            return base + "/"
        case .owned:
            return base + "/owned"
        case .starred:
            return base + "/starred"
        case .id(let i):
            return base + "/\(i)"
        }
    }
    
    func request(host:NSURL) -> NSMutableURLRequest {
        let request = NSMutableURLRequest(URL: host.URLByAppendingPathComponent(self.path))
        request.HTTPMethod = Alamofire.Method.GET.rawValue
        return Alamofire.ParameterEncoding.URL.encode(request, parameters: nil).0
    }
}