//
//  CommitDetailViewController.swift
//  gitlab-iOS
//
//  Created by Xplorld on 2016/5/6.
//  Copyright © 2016年 dyweb. All rights reserved.
//

import UIKit

class CommitDetailViewController: RYTableViewController {
    var router:CommitNoteRouter!
    var commit:Commit! {
        didSet {
            viewModels = [
                [CommitDetailTableViewCellViewModel(commit: commit)],
                []
            ]
            router = CommitNoteRouter.Single(id: commit.project?.id ?? -1, sha: commit.id ?? "")
            fetcher = PagedTableViewFetcher(fetch: { (page, count, handler) -> () in
                client.getArray(self.router.withPage(page, count: count)) .then {
                    arr, res -> Void in
                    let section:[TableViewCellViewModel] = arr.map {CommitNoteTableViewCellViewModel(note: $0) }
                    handler(res)
                    self.viewModels[1].appendContentsOf(section)
                    } .error { (err:ErrorType) -> Void in
                        //make an errr HUD
                }
                
            })
        }
    }
}
