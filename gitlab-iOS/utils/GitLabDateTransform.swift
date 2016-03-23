
//
//  GitLabDateTransform.swift
//  gitlab-iOS
//
//  Created by Xplorld on 2016/3/20.
//  Copyright © 2016年 dyweb. All rights reserved.
//

import UIKit
import ObjectMapper

//class GitLabDateTransform: DateFormatterTransform {
//    
//    init() {
//        let formatter = NSDateFormatter()
//        formatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
//        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
//        //                        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
//        
//        super.init(dateFormatter: formatter)
//    }
//    
//    
//}

class GitLabDateTransform: TransformType {
    typealias Object = NSDate
    typealias JSON = String
    
    let dateFormatters =
        ["yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ",
        "yyyy-MM-dd'T'HH:mm:ssZZZZZ",
        "yyyy-MM-dd'T'HH:mm:ss'Z'"]
        .map { format -> NSDateFormatter in
        let formatter = NSDateFormatter()
        formatter.dateFormat = format
        return formatter
    }
    
    
    func transformFromJSON(value: AnyObject?) -> NSDate? {
        if let dateString = value as? String {
            for formatter in dateFormatters {
                if let date = formatter.dateFromString(dateString) {
                    return date
                }
            }
        }
        return nil
    }
    
    func transformToJSON(value: NSDate?) -> String? {
        if let date = value {
            return dateFormatters.first?.stringFromDate(date)
        }
        return nil
    }
}