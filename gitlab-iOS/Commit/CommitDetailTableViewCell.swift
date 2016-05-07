//
//  CommitDetailTableViewCell.swift
//  gitlab-iOS
//
//  Created by Xplorld on 2016/5/6.
//  Copyright © 2016年 dyweb. All rights reserved.
//

import UIKit
import DateTools

class CommitDetailTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var shortSHALabel: UILabel!
    @IBOutlet weak var SHALabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var messageLabel: UILabel!
    
    
}


class CommitDetailTableViewCellViewModel :  TableViewCellViewModel {
    
    let commit:Commit
    init(commit:Commit) {
        self.commit = commit
    }
    
    @objc let cellIdentifier =  "CommitDetailCell"

    @objc func configureCell(cell:UITableViewCell) {
        let theCell = cell as! CommitDetailTableViewCell
        theCell.titleLabel.text = commit.title
        theCell.shortSHALabel.text = commit.short_id
        theCell.SHALabel.text = commit.id
        theCell.authorLabel.text = commit.author_name
        theCell.emailLabel.text = commit.author_email
        theCell.dateLabel.text = commit.created_at?.timeAgoSinceNow()
        theCell.messageLabel.text = commit.message
        
    }
    
    @objc func didSelectCell(indexPath:NSIndexPath,controller:RYTableViewController) {
        //do nothing
           }
    
    @objc var resetAfterSelect = true
}
