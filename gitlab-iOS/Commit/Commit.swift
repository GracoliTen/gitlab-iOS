//
//  Commit.swift
//  gitlab-iOS
//
//  Created by Xplorld on 2016/3/20.
//  Copyright © 2016年 dyweb. All rights reserved.
//

import ObjectMapper
import Alamofire

class Commit : Mappable {
    var id:String?
    var short_id:String?
    var title:String?
    var author_name:String?
    var author_email:String?
    var created_at:NSDate?
    var message:String?
    
    required init?(_ map: Map) {}
    func mapping(map: Map) {
        id <- map["id"]
        short_id <- map["short_id"]
        title <- map["title"]
        author_name <- map["author_name"]
        author_email <- map["author_email"]
        created_at <- (map["created_at"],GitLabDateTransform())
        message <- map["message"]
    }
}


enum CommitRouter : HostProvidedURLRequestConvertible {
    case list(id:Int) //id
    case single(id:Int,sha:String)
    
    typealias ReturnType = Commit
    
    var path:String {
        let base = "/projects"
        switch self {
        case .list(let id):
            return base + "/\(id)/repository/commits"
        case .single(let id, let sha):
            return base + "/\(id)/repository/commits/\(sha)"
        }
    }
    
    func request(host:NSURL) -> NSMutableURLRequest {
        let request = NSMutableURLRequest(URL: host.URLByAppendingPathComponent(self.path))
        request.HTTPMethod = Alamofire.Method.GET.rawValue
        return Alamofire.ParameterEncoding.URL.encode(request, parameters: nil).0
    }
}