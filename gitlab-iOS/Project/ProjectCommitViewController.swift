//
//  ProjectCommitViewController.swift
//  gitlab-iOS
//
//  Created by Xplorld on 2016/5/7.
//  Copyright © 2016年 dyweb. All rights reserved.
//

import UIKit

protocol ProjectChildViewController {
    var project:Project! { get set }
}

class ProjectCommitViewController: RYTableViewController, ProjectChildViewController {
    var project:Project! {
        didSet {
            resetFetcher()
        }
    }
    func resetFetcher() {
        self.viewModels = [[]]
        fetcher = PagedTableViewFetcher { (page, count, handler) -> () in
            var params:[APIParameter] = [GLParam.Page(page)]
            if count != nil {
                params.append(GLParam.Length(count!))
            }
                client.getArray(CommitRouter.List(id: self.project.id).with(params)) .then { arr, res -> Void in
                    handler(res)
                    let section:[TableViewCellViewModel] = arr.map {CommitTableViewCellViewModel(commit: $0,project:self.project)}
                    self.viewModels[0].appendContentsOf(section)
                    } .error { (err:ErrorType) -> Void in
                        //make an errr HUD
                }
        }
    }
    
}

class ProjectIssueViewController: RYTableViewController, ProjectChildViewController {
    var project:Project! {
        didSet {
            resetFetcher()
        }
    }
    func resetFetcher() {
        self.viewModels = [[]]
        fetcher = PagedTableViewFetcher { (page, count, handler) -> () in
            var params:[APIParameter] = [GLParam.Page(page)]
            if count != nil {
                params.append(GLParam.Length(count!))
            }
            client.getArray(IssueRouter.Project(self.project.id, nil, nil).with(params)) .then { arr, res -> Void in
                handler(res)
                let section:[TableViewCellViewModel] = arr.map {IssueTableViewCellViewModel(issue: $0)}
                self.viewModels[0].appendContentsOf(section)
                } .error { (err:ErrorType) -> Void in
                    //make an errr HUD
            }

        }
    }
    
}

class ProjectMemberViewController: RYTableViewController, ProjectChildViewController {
    var project:Project! {
        didSet {
            resetFetcher()
        }
    }
    func resetFetcher() {
        self.viewModels = [[]]
        fetcher = PagedTableViewFetcher { (page, count, handler) -> () in
            var params:[APIParameter] = [GLParam.Page(page)]
            if count != nil {
                params.append(GLParam.Length(count!))
            }
            client.getArray(UserRouter.Project(self.project.id, nil).with(params)) .then { arr, res -> Void in
                handler(res)
                let section:[TableViewCellViewModel] = arr.map {UserTableViewCellViewModel(user: $0)}
                self.viewModels[0].appendContentsOf(section)
                } .error { (err:ErrorType) -> Void in
                    //make an errr HUD
            }
        }
    }
    
}
