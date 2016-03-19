//
//  TableViewCellViewModel.swift
//  gitlab-iOS
//
//  Created by Xplorld on 2016/3/19.
//  Copyright © 2016年 dyweb. All rights reserved.
//

import UIKit


@objc protocol TableViewCellViewModel {
    var cellIdentifier : String {get}
    
    optional var resetAfterSelect : Bool {get}
    
    func configureCell(cell:UITableViewCell)
    
    optional var heightForCell : CGFloat {get}
    
    optional func didSelectCell()
    
    
}