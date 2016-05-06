//
//  GitLabAPIClient.swift
//  gitlab-iOS
//
//  Created by Xplorld on 2016/3/18.
//  Copyright © 2016年 dyweb. All rights reserved.
//

//import UIKit
//import ObjectMapper
//import SwiftyJSON

import Alamofire
import AlamofireObjectMapper

import PromiseKit

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
    
    func cancellableGet<Router:HostProvidedURLRequestConvertible>(router:Router) -> (Promise<Router.ReturnType>,()->Void) {
        let (promise, fulfill, reject) = Promise<Router.ReturnType>.pendingPromise()
        
        let request = self.request(router)
        request.responseObject { (res:Response<Router.ReturnType, NSError>) -> Void in
            if let err = res.result.error {
                reject(err)
            } else if let v = res.result.value {
                fulfill(v)
            }
        }
        
        let cancel = {
            request.cancel()
            reject(NSError(domain: PMKErrorDomain, code: PMKOperationCancelled, userInfo: nil))
        }
        return (promise,cancel)
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
    
    func cancellableGetArray<Router:HostProvidedURLRequestConvertible>(router:Router) -> (Promise<[Router.ReturnType]>,()->Void) {
        let (promise, fulfill, reject) = Promise<[Router.ReturnType]>.pendingPromise()
        
        let request = self.request(router)
        request.responseArray { (res:Response<[Router.ReturnType], NSError>) -> Void in
            if let err = res.result.error {
                reject(err)
            } else if let v = res.result.value {
                fulfill(v)
            }
        }
        
        let cancel = {
            request.cancel()
            reject(NSError(domain: PMKErrorDomain, code: PMKOperationCancelled, userInfo: nil))
        }
        return (promise,cancel)
    }
    
    func getArray<Router:HostProvidedURLRequestConvertible>(router:Router) -> Promise<([Router.ReturnType],NSHTTPURLResponse)> {
        return Promise { fulfill, reject in
            self.request(router).responseArray { (res:Response<[Router.ReturnType], NSError>) -> Void in
                if let err = res.result.error {
                    reject(err)
                } else if let v = res.result.value {
                    fulfill((v,res.response!))
                }
            }
        }
    }
}

