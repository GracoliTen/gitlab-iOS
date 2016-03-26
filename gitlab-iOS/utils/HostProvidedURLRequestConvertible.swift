//
//  HostProvidedURLRequestConvertible.swift
//  gitlab-iOS
//
//  Created by Xplorld on 2016/3/24.
//  Copyright © 2016年 dyweb. All rights reserved.
//

import Alamofire
import ObjectMapper

func + <K,V>(left: Dictionary<K,V>?, right: Dictionary<K,V>?)
    -> Dictionary<K,V>?
{
    guard let left = left else {return nil}
    guard let right = right else {return left}
    var map = Dictionary<K,V>()
    for (k, v) in left {
        map[k] = v
    }
    for (k, v) in right {
        map[k] = v
    }
    return map
}

func +=<K, V> (inout left: [K : V], right: [K : V]) { for (k, v) in right { left[k] = v } }


protocol HostProvidedURLRequestConvertible {
    typealias ReturnType : Mappable
    //    typealias ViewModelType : TableViewCellViewModel
    var method:Alamofire.Method {get}
    var path:String {get}
    var parameters:[String:AnyObject]? {get}
}

extension HostProvidedURLRequestConvertible {
    func request(host:NSURL) -> NSMutableURLRequest {
        let request = NSMutableURLRequest(URL: host.URLByAppendingPathComponent(self.path))
        request.HTTPMethod = self.method.rawValue
        return Alamofire.ParameterEncoding.URL.encode(request, parameters: self.parameters).0
    }
    
//    func with(paras:[String:AnyObject]) -> RouterWithParas<Self> {
//        return RouterWithParas(router: self,paras: paras)
//    }
    func with(paras:[APIParameter]) -> RouterWrapper<Self> {
        return RouterWrapper(router: self).with(paras)
    }
    

    
}

class RouterWrapper<T:HostProvidedURLRequestConvertible> : HostProvidedURLRequestConvertible {
    
    var parameters:[String:AnyObject]? {
        return router.parameters + additionalParameters
    }
    typealias ReturnType = T.ReturnType
    var method:Alamofire.Method {return router.method}
    var path:String {return router.path}
    
    
    private let router:T
    init(router:T) {
        self.router = router
    }
    
    var additionalParameters:[String:AnyObject] = [:]

    //    swift dynamic dispatch will pick this method instead of protocol default implementation of `with`
    //    although this is not an overriding
    //    kinda hack?
    //    at least in Xcode 7.2 Swift 2
    func with(paras: [APIParameter]) -> Self {
        for (para) in paras {additionalParameters[para.key] = para.value}
        return self
    }
    // maybe should provide api from raw dict?
    //    func with(paras: [String : AnyObject]) -> Self {
    //        additionalParameters += paras
    //        return self
    //    }
}

protocol APIParameter {
    var key:String {get}
    var value:AnyObject {get}
}

//GitLabParameter
enum GLParam : APIParameter {
    case Page(Int)
    var key:String {
        switch self {
        case .Page(_):
            return "page"
        }
    }
    var value:AnyObject {
        switch self {
        case .Page(let p):
            return p
        }
    }
}



