//
//  ProjectDetailViewController.swift
//  gitlab-iOS
//
//  Created by Xplorld on 2016/3/20.
//  Copyright © 2016年 dyweb. All rights reserved.
//

import UIKit

enum ProjectDetailViewType : Int {
    case Commits = 0
    case Issues = 1
}

class ProjectDetailViewController: RYTableViewController {
    
    @IBOutlet weak var segments: UISegmentedControl!
    
    var project:Project! {
        didSet {
            self.navigationItem.title = project.name_with_namespace
        }
    }
    
    func reloadData() {
        let type = ProjectDetailViewType(rawValue: segments.selectedSegmentIndex)!
        
        switch type {
        case .Commits:
            client.getArray(CommitRouter.list(id: project.id)) .then { arr -> Void in
                let section = arr.map {CommitTableViewCellViewModel(commit: $0)}
                self.viewModels = [section]
                } .error { (err:ErrorType) -> Void in
                    //make an errr HUD
            }
        case .Issues:
            client.getArray(IssueRouter.project(project.id, nil, nil)) .then { arr -> Void in
                let section = arr.map {IssueTableViewCellViewModel(issue: $0)}
                self.viewModels = [section]
                } .error { (err:ErrorType) -> Void in
                    //make an errr HUD
            }

        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        segments.addTarget(self, action: "segementValueChanged:", forControlEvents: UIControlEvents.ValueChanged)
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 85
        reloadData()
        
    }
    
    func segementValueChanged(segment:UISegmentedControl) {
        reloadData()
    }
}
