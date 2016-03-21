//
//  LabelTinter.swift
//  gitlab-iOS
//
//  Created by Xplorld on 2016/3/21.
//  Copyright © 2016年 dyweb. All rights reserved.
//

import UIKit

class LabelTinter {
    class func darkRed() -> UIColor {
        return UIColor.hexToUIColor(0xad4363)
    }
    class func tintLabel(label:String) -> (String,UIColor) {
        switch label {
        case "bug", "error", "fail", "high":
            return (label,UIColor.redColor())
        case "enhancement", "android":
            return (label,UIColor.hexToUIColor(0x69d100)) //good green
        case "iOS", "apple", "iPhone", "iPad":
            return (label,UIColor.hexToUIColor(0x7f8c8d)) //apple grey
        default:
            return (label,UIColor.hexToUIColor(0x428bca)) //good blue
        }
    }
    class func tintLabels(labels:[String]) -> [(String,UIColor)] {
        return labels.map{self.tintLabel($0)}
    }
}

//from hex
extension UIColor {
    class func hexToUIColor(hex:UInt32) -> UIColor {
        
        return UIColor(
            red: CGFloat((hex & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((hex & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(hex & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}