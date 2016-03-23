//
//  IssueTableViewController.swift
//  gitlab-iOS
//
//  Created by Xplorld on 2016/3/23.
//  Copyright © 2016年 dyweb. All rights reserved.
//

import UIKit

class IssueTableViewController: RYTableViewController {
    var issue:Issue! {
        didSet {
            if let issue = issue {
                self.navigationItem.title = issue.title
            }
        }
    }
    
    func reloadData() {
        self.viewModels = [[IssueDetailTableViewCellViewModel(issue: issue)],[]]
        
        client.getArray(NoteRouter.Issue(issue.project_id, issue.id))
            .then { arr -> Void in
                let section = arr.map {
                    NoteTableViewCellViewModel(note: $0)
                }
                self.viewModels[1] = section
            }
            .error { (err:ErrorType) -> Void in
                //make an errr HUD
                print(err)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reloadData()
        tableView.estimatedRowHeight = 100
    }
    
}
