//
//  ProjectTableViewController.swift
//  gitlab-iOS
//
//  Created by Xplorld on 2016/3/19.
//  Copyright © 2016年 dyweb. All rights reserved.
//

import UIKit

class ProjectTableViewController: RYTableViewController {
    let router = ProjectRouter.accessable
    override func viewDidLoad() {
        super.viewDidLoad()
        fetcher = PagedTableViewFetcher(fetch: { (page, count, handler) -> () in
            client.getArray(self.router.withPage(page, count: count)) .then { arr, res -> Void in
                let section:[TableViewCellViewModel] = arr.map {ProjectTableViewCellViewModel(project: $0)}
                handler(res)
                if self.viewModels.count == 0 {
                    self.viewModels = [section]
                } else {
                    self.viewModels[self.viewModels.count - 1].appendContentsOf(section)
                }
                
                } .error { (err:ErrorType) -> Void in
                    //make an errr HUD
            }
        })
    }
}
