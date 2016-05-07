//
//  CommitNote.swift
//  gitlab-iOS
//
//  Created by Xplorld on 2016/5/7.
//  Copyright © 2016年 dyweb. All rights reserved.
//

import ObjectMapper
import Alamofire


class CommitNote : Mappable {
    var note:String?
    var author:User?
    var created_at:NSDate?
    required init?(_ map: Map) {}
    func mapping(map: Map) {
        note <- map["note"]
        author <- map["author"]
        created_at <- (map["created_at"],GitLabDateTransform())
    }
}

enum CommitNoteRouter : HostProvidedURLRequestConvertible {
    case Single(id:Int,sha:String)
    
    typealias ReturnType = CommitNote
    
    var path:String {
        let base = "/projects"
        switch self {
        case .Single(let id, let sha):
            return base + "/\(id)/repository/commits/\(sha)/comments"
        }
    }
    
    var parameters:[String:AnyObject]? {return nil }
    var method:Alamofire.Method {return Alamofire.Method.GET}
    
}