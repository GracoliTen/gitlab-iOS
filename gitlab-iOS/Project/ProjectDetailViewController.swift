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
    case Members = 2
    
    static func fromRaw(rawValue:Int) -> ProjectDetailViewType {
        if rawValue < 0 || rawValue > 2 {
            return .Commits
        }
        return ProjectDetailViewType(rawValue: rawValue)!
    }
}

class ProjectDetailViewController: RYTableViewController {
    
    @IBOutlet weak var segments: UISegmentedControl!
    
    var project:Project! {
        didSet {
            self.navigationItem.title = project.name_with_namespace
            resetFetcher()
        }
    }
    
    func resetFetcher() {
         self.viewModels = [[]]
        let type = ProjectDetailViewType.fromRaw(segments?.selectedSegmentIndex ?? 0)
        fetcher = PagedTableViewFetcher { (page, count, handler) -> () in
            var params:[APIParameter] = [GLParam.Page(page)]
            if count != nil {
                params.append(GLParam.Length(count!))
            }
            switch type {
            case .Commits:
                client.getArray(CommitRouter.List(id: self.project.id).with(params)) .then { arr, res -> Void in
                    handler(res)
                    let section:[TableViewCellViewModel] = arr.map {CommitTableViewCellViewModel(commit: $0,project:self.project)}
                    self.viewModels[0].appendContentsOf(section)
                    } .error { (err:ErrorType) -> Void in
                        //make an errr HUD
                }
            case .Issues:
                client.getArray(IssueRouter.Project(self.project.id, nil, nil).with(params)) .then { arr, res -> Void in
                    handler(res)
                    let section:[TableViewCellViewModel] = arr.map {IssueTableViewCellViewModel(issue: $0)}
                    self.viewModels[0].appendContentsOf(section)
                    } .error { (err:ErrorType) -> Void in
                        //make an errr HUD
                }
            case .Members:
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        segments.addTarget(self, action: "segementValueChanged:", forControlEvents: UIControlEvents.ValueChanged)
    }
    
    func segementValueChanged(segment:UISegmentedControl) {
        resetFetcher()
    }
    
}
