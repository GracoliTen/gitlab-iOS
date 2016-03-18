//
//  GitLabAPIClient.swift
//  gitlab-iOS
//
//  Created by Xplorld on 2016/3/18.
//  Copyright © 2016年 dyweb. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import SwiftyJSON

protocol HostProvidedURLRequestConvertible {
    func request(host:NSURL) -> NSMutableURLRequest
}



class GitLabAPIClient {
    
    //these two strings are .gitignore'd. please fill in your own hosts and keys in 'DebugPrivateToken.swift'
    let host:NSURL = NSURL(string: DEBUG_HOST_STRING)!
    var secretKey:String = DEBUG_SECRET_KEY
    
    func request(router:HostProvidedURLRequestConvertible) -> Request {
        let req = router.request(host)
        req.setValue(secretKey, forHTTPHeaderField: "PRIVATE-TOKEN")
        return Alamofire.request(req).validate(statusCode: 200..<400)
    }
    
    
    //may need to introduce PromiseKit
    func projects(router:ProjectRouter,completionHandler:([Project]->Void)) {
        self.request(router).responseArray { (res:Response<[Project], NSError>) -> Void in
            if let err = res.result.error {
                print(err)
            } else {
            completionHandler(res.result.value!)
            }
        }
    }
    
}
