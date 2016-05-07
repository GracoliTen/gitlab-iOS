//
//  CommitTableViewCell.swift
//  gitlab-iOS
//
//  Created by Xplorld on 2016/3/20.
//  Copyright © 2016年 dyweb. All rights reserved.
//

import UIKit
import DateTools

class CommitTableViewCell : UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var shaLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
}



class CommitTableViewCellViewModel : TableViewCellViewModel {
    
    let commit:Commit
    init(commit:Commit,project:Project?) {
        self.commit = commit
        self.commit.project = project
    }
    
    @objc let cellIdentifier =  "CommitCell"
    
    @objc func configureCell(cell:UITableViewCell) {
        let theCell = cell as! CommitTableViewCell
        theCell.titleLabel.text = commit.title
        theCell.shaLabel.text = commit.short_id
        theCell.authorLabel.text = commit.author_name
        theCell.timeLabel.text = commit.created_at?.timeAgoSinceNow()
    }
    
    @objc func didSelectCell(indexPath: NSIndexPath, controller: RYTableViewController) {
        let segue = "DetailToCommitSegue"
        controller.performSegueWithIdentifier(segue, sender: commit) {
            segue in
            let vc = segue.destinationViewController as! CommitDetailViewController
            vc.commit = self.commit
        }
    }
    @objc var resetAfterSelect = true
}