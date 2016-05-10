//
//  PagedTableViewFetcher.swift
//  gitlab-iOS
//
//  Created by Xplorld on 2016/5/6.
//  Copyright © 2016年 dyweb. All rights reserved.
//

import UIKit

class PagedTableViewFetcher {
    typealias HandlerType = ((page:Int, count:Int?, handler:((NSHTTPURLResponse)->Void)) -> ())
    var nextPage :Int = 0
    
    var pageLength : Int? = nil
    var noMore = false
    let fetch:HandlerType
    var fetching:Bool = false
    
    init(fetch:HandlerType) {
        self.fetch = fetch
    }
    
    func tryToFetchMore() {
        dispatch_async(dispatch_get_main_queue()) {
            
            if self.noMore || self.fetching { return }
            //do something with operation
            self.fetching = true
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
                self.fetch(page: self.nextPage, count: self.pageLength) { response in
                    let fields = response.allHeaderFields
                    if let XNextPageStr = fields["X-Next-Page"] as? String {
                        if let XNextPage = Int(XNextPageStr) {
                            self.nextPage = XNextPage
                        } else {
                            //field is ""
                            self.noMore = true
                        }
                    } else {
                        //did not provied this field
                        if let lengthStr = fields["Content-Length"] as? String,
                            let length = Int(lengthStr) where
                            length < 10 //"[]"
                        {
                            self.noMore = true
                        } else {
                            self.nextPage += 1
                        }
                    }
                    dispatch_async(dispatch_get_main_queue()) {
                        self.fetching = false
                    }
                }
            }
            
        }
    }
    
    
}




















