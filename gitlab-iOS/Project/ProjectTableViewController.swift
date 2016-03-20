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
        self.tableView.estimatedRowHeight = 85
        reloadData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        guard (segue.identifier != nil) else {return}
        switch segue.identifier! {
        case "ProjectToDetailSegue":
            let vc = segue.destinationViewController as! ProjectDetailViewController
            vc.project = sender as! Project
        default:
            break
        }
    }
}
