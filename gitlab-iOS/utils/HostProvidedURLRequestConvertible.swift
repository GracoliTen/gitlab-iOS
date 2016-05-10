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
    guard let left = left else {return right}
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
    associatedtype ReturnType : Mappable
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
    func with(paras:[APIParameter]) -> RouterWrapper<Self> {
        return RouterWrapper(router: self,paras: paras)
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
    init(router:T,paras: [APIParameter]) {
        self.router = router
        for (para) in paras {additionalParameters[para.key] = para.value}
    }
    func with(paras:[APIParameter]) -> Self {
        for (para) in paras {additionalParameters[para.key] = para.value}
        return self
    }
    
    var additionalParameters:[String:AnyObject] = [:]

}

protocol APIParameter {
    var key:String {get}
    var value:AnyObject {get}
}

//GitLabParameter
enum GLParam : APIParameter {
    case Page(Int)
    case Length(Int)
    var key:String {
        switch self {
        case .Page(_):
            return "page"
        case .Length(_):
            return "per_page"
        }
        
    }
    var value:AnyObject {
        switch self {
        case .Page(let p):
            return p
        case .Length(let p):
            return p
        }
    }
}

extension HostProvidedURLRequestConvertible {
    func withPage(page:Int,count:Int?) -> RouterWrapper<Self> {
        var params:[APIParameter] = [GLParam.Page(page)]
        if count != nil {
            params.append(GLParam.Length(count!))
        }
        return with(params)
    }
}


