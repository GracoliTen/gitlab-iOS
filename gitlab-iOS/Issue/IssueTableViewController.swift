//
//  IssueTableViewController.swift
//  gitlab-iOS
//
//  Created by Xplorld on 2016/3/23.
//  Copyright © 2016年 dyweb. All rights reserved.
//

import UIKit

class IssueTableViewController: RYTableViewController {
    var router : NoteRouter!
    var issue:Issue! {
        didSet {
            if let issue = issue {
                self.navigationItem.title = issue.title
                router = NoteRouter.Issue(issue.project_id, issue.id)
                fetcher = PagedTableViewFetcher(fetch: { (page, count, handler) -> () in
                    var params:[APIParameter] = [GLParam.Page(page)]
                    if count != nil {
                        params.append(GLParam.Length(count!))
                    }
                    client.getArray(self.router.with(params))
                        .then { arr, res -> Void in
                            handler(res)
                            let section:[TableViewCellViewModel] = arr.map {
                                NoteTableViewCellViewModel(note: $0)
                            }
                            
                            self.viewModels[1].appendContentsOf(section)
                        }
                        .error { (err:ErrorType) -> Void in
                            //make an errr HUD
                            print(err)
                    }
                    
                })
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModels = [[IssueDetailTableViewCellViewModel(issue: issue)],[]]
    }
}
