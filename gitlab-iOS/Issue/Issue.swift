//
//  Issue.swift
//  gitlab-iOS
//
//  Created by Xplorld on 2016/3/20.
//  Copyright © 2016年 dyweb. All rights reserved.
//

import ObjectMapper
import Alamofire

//TODO
class Milestone: Mappable {
    required init?(_ map: Map) {}
    func mapping(map: Map) {}
}

class Issue : Mappable {
    
    var project_id:Int = -1
    var id:Int = -1 //id in whole system
    var iid:Int = -1 //id in project
    
    var title:String = ""
    var state:IssueState = .Opened
    var desc:String?

    var milestone:Milestone?
    var author:User?
    var assignee:User?
    var updated_at:NSDate?

    var created_at:NSDate?
    
    var labels:[String] = []
    
    required init?(_ map: Map) {}
    func mapping(map: Map) {
        state <- (map["state"],EnumTransform<IssueState>())
        desc <- map["description"]
        author <- map["author"]
        milestone <- map["milestone"]
        project_id <- map["project_id"]
        assignee <- map["assignee"]
        updated_at <- (map["updated_at"],GitLabDateTransform())
        id <- map["id"]
        title <- map["title"]
        created_at <- (map["created_at"],GitLabDateTransform())
        iid <- map["iid"]
        labels <- map["labels"]
    }
}

enum IssueState : String {
    case Opened = "opened"
    case Closed = "closed"
//    case All = ""
}

enum IssueRouter : HostProvidedURLRequestConvertible {
    case List(IssueState?, [String]?) //state,labels
    case Project(Int,IssueState?, [String]?) //projectID
    
    typealias ReturnType = Issue
    
    var path:String {
        switch self {
        case .List:
            return "/issues"
        case .Project(let id,_,_):
            return "/projects/\(id)/issues"
        }
    }
    
    var parameters:[String:AnyObject] {
        let state:IssueState?
        let labels:[String]?
        switch self {
        case .List(let s,let l):
            state = s
            labels = l
        case .Project(_,let s,let l):
            state = s
            labels = l
        }
        var p:[String:AnyObject] = [:]
        p["state"] = state?.rawValue
        p["labels"] = labels
        return p
    }
    
    func request(host:NSURL) -> NSMutableURLRequest {
        let request = NSMutableURLRequest(URL: host.URLByAppendingPathComponent(self.path))
        request.HTTPMethod = Alamofire.Method.GET.rawValue
        return Alamofire.ParameterEncoding.URL.encode(request, parameters: self.parameters).0
    }
}
