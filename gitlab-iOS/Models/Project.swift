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
    var id:Int = -1
    var description:String?
    var isPublic:Bool?
    var name:String?
    var name_with_namespace:String?
    var avatar_url:String?
    //TODO: seem to have problems
    var last_activity_at:NSDate?
    var star_count:Int?
    var forks_count:Int?
    var issues_enabled:Bool = false
    var merge_requests_enabled:Bool = false
    var builds_enabled:Bool = false
    var wiki_enabled:Bool = false
    var snippets_enabled:Bool = false
    var visibility_level:Bool = false
    var public_builds:Bool = false
    
    required init?(_ map: Map) {}
    func mapping(map: Map) {
        id <- map["id"]
        description <- map["description"]
        isPublic <- map["public"]
        name <- map["name"]
        name_with_namespace <- map["name_with_namespace"]
        avatar_url <- map["avatar_url"]
        last_activity_at <- (map["last_activity_at"],GitLabDateTransform())
        star_count <- map["star_count"]
        forks_count <- map["forks_count"]
        issues_enabled <- map["issues_enabled"]
        merge_requests_enabled <- map["merge_requests_enabled"]
        builds_enabled <- map["builds_enabled"]
        wiki_enabled <- map["wiki_enabled"]
        snippets_enabled <- map["snippets_enabled"]
        visibility_level <- map["visibility_level"]
        public_builds <- map["public_builds"]
    }
}

enum ProjectRouter : HostProvidedURLRequestConvertible {
    case accessable
    case owned
    case starred
    case id(Int)
    
    typealias ReturnType = Project
    
    var parameters:[String:AnyObject]? {return nil }
    var method:Alamofire.Method {return Alamofire.Method.GET}
    
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
    
}