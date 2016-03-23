//
//  MarkdownParser.swift
//  gitlab-iOS
//
//  Created by Xplorld on 2016/3/23.
//  Copyright © 2016年 dyweb. All rights reserved.
//

import UIKit
import XNGMarkdownParser


class MarkdownParser {
    static let sharedParser = MarkdownParser()
    
    func parse(aString:String?) -> NSAttributedString {
        guard let string = aString else {return NSAttributedString()}
        let attr = parser.attributedStringFromMarkdownString(string)
        
        return attr
    }
    
    private let parser = XNGMarkdownParser()
    private init() {
        
    }
}
