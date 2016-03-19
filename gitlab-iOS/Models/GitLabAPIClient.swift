//
//  GitLabAPIClient.swift
//  gitlab-iOS
//
//  Created by Xplorld on 2016/3/18.
//  Copyright © 2016年 dyweb. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper
import AlamofireObjectMapper
import SwiftyJSON
import PromiseKit

protocol HostProvidedURLRequestConvertible {
    typealias ReturnType : Mappable
    func request(host:NSURL) -> NSMutableURLRequest
}

let client = GitLabAPIClient()

class GitLabAPIClient {
    
    //these two strings are .gitignore'd. please fill in your own hosts and keys in 'DebugPrivateToken.swift'
    let host:NSURL = NSURL(string: DEBUG_HOST_STRING)!
    var secretKey:String = DEBUG_SECRET_KEY
    
    private func request<Router:HostProvidedURLRequestConvertible>(router:Router) -> Request {
        let req = router.request(host)
        req.setValue(secretKey, forHTTPHeaderField: "PRIVATE-TOKEN")
        return Alamofire.request(req).validate(statusCode: 200..<400)
    }
    
    func get<Router:HostProvidedURLRequestConvertible>(router:Router) -> Promise<Router.ReturnType> {
        return Promise { fulfill, reject in
            self.request(router).responseObject { (res:Response<Router.ReturnType, NSError>) -> Void in
                if let err = res.result.error {
                    reject(err)
                } else if let v = res.result.value {
                    fulfill(v)
                }
            }
        }
    }
    
    func getArray<Router:HostProvidedURLRequestConvertible>(router:Router) -> Promise<[Router.ReturnType]> {
        return Promise { fulfill, reject in
            self.request(router).responseArray { (res:Response<[Router.ReturnType], NSError>) -> Void in
                if let err = res.result.error {
                    reject(err)
                } else if let v = res.result.value {
                    fulfill(v)
                }
            }
        }
    }

//    
//    
//    //may need to introduce PromiseKit
//    func projects(router:ProjectRouter) -> Promise<[Project]> {
//        return Promise { fulfill, reject in
//            self.request(router).responseArray { (res:Response<[Project], NSError>) -> Void in
//                if let err = res.result.error {
//                    reject(err)
//                } else if let v = res.result.value {
//                    fulfill(v)
//                }
//            }
//        }
//    }
}

