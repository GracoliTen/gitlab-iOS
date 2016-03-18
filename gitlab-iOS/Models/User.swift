//
//  User.swift
//  gitlab-iOS
//
//  Created by Xplorld on 2016/3/18.
//  Copyright © 2016年 dyweb. All rights reserved.
//

import ObjectMapper
import Alamofire

//class User: Mappable {
//
//}


//enum LoginRouter:HostProvidedURLRequestConvertible {
//    case Username(String,String)
//    case Email(String,String)
//    
//    func request(host:NSURL) -> NSMutableURLRequest {
//        let parameters:[String:String]
//        switch self {
//        case .Username(let name, let password):
//            parameters = ["login":name,"password":password]
//        case .Email(let email, let password):
//            parameters = ["email":email,"password":password]
//        }
//        let request = NSMutableURLRequest(URL: host.URLByAppendingPathComponent("/api/v3/"))
//        request.HTTPMethod = Alamofire.Method.POST.rawValue
//        return Alamofire.ParameterEncoding.URL.encode(request, parameters: parameters).0
//    }
//}
//
