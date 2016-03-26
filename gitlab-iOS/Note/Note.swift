//
//  Note.swift
//  gitlab-iOS
//
//  Created by Xplorld on 2016/3/23.
//  Copyright © 2016年 dyweb. All rights reserved.
//

import ObjectMapper
import Alamofire

class Note: Mappable {
    var id:Int = -1
    var body:String?
    var attachment:String?
    var author:User?
    var created_at:NSDate?
    var system:Bool = false
    var upvote:Bool = false
    var downvote:Bool = false
    var noteable_id:Int = -1
    var noteable_type:String?
    required init?(_ map: Map) {}
    func mapping(map: Map) {
        id <- map["id"]
        body <- map["body"]
        attachment <- map["attachment"]
        author <- map["author"]
        created_at <- (map["created_at"],GitLabDateTransform())
        system <- map["system"]
        upvote <- map["upvote"]
        downvote <- map["downvote"]
        noteable_id <- map["noteable_id"]
        noteable_type <- map["noteable_type"]
    }
}



enum  NoteRouter : HostProvidedURLRequestConvertible {
    case Issue(Int,Int) //project_ID, issue_ID
    
    
    typealias ReturnType = Note
    
    var path:String {
        switch self {
        case .Issue(let projectID, let issueID):
            return "/projects/\(projectID)/issues/\(issueID)/notes"
        }
    }
    var parameters:[String:AnyObject]? {return nil }
    var method:Alamofire.Method {return Alamofire.Method.GET}

    }
