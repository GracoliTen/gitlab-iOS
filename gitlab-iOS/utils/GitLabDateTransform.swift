//
//  GitLabDateTransform.swift
//  gitlab-iOS
//
//  Created by Xplorld on 2016/3/20.
//  Copyright © 2016年 dyweb. All rights reserved.
//

import UIKit
import ObjectMapper

class GitLabDateTransform: DateFormatterTransform {
    
    init() {
        let formatter = NSDateFormatter()
        formatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        //                        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        
        super.init(dateFormatter: formatter)
        
        naturalFormatter.unitsStyle = NSDateComponentsFormatterUnitsStyle.Full
        naturalFormatter.includesApproximationPhrase = true
        naturalFormatter.includesTimeRemainingPhrase = false
        naturalFormatter.allowedUnits = [NSCalendarUnit.WeekOfMonth , NSCalendarUnit.Day , NSCalendarUnit.Hour , NSCalendarUnit.Minute]

    }
    
    let naturalFormatter = NSDateComponentsFormatter()
    
    
    func toNaturalString(value: NSDate?) -> String {
        guard let date = value else {return ""}
        return naturalFormatter.stringFromDate(date, toDate: NSDate()) ?? ""
    }
    
}
