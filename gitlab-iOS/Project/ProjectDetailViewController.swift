//
//  ProjectDetailViewController.swift
//  gitlab-iOS
//
//  Created by Xplorld on 2016/3/20.
//  Copyright © 2016年 dyweb. All rights reserved.
//

import UIKit

class ProjectDetailViewController: RYTableViewController {
    var project:Project! {
        didSet {
            self.navigationItem.title = project.name_with_namespace
        }
    }
    
    func reloadData() {
        client.getArray(CommitRouter.list(id: project.id!)) .then { arr -> Void in
            let section = arr.map {CommitTableViewCellViewModel(commit: $0)}
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
