//
//  ProjectTableViewController.swift
//  gitlab-iOS
//
//  Created by Xplorld on 2016/3/19.
//  Copyright © 2016年 dyweb. All rights reserved.
//

import UIKit

class ProjectTableViewController: RYTableViewController {
    
    func reloadData() {
        client.getArray(ProjectRouter.accessable) .then { arr -> Void in
            let section = arr.map {ProjectTableViewCellViewModel(project: $0)}
            self.viewModels = [section]
            } .error { (err:ErrorType) -> Void in
                //make an errr HUD
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reloadData()
    }
}
