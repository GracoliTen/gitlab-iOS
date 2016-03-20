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



class CommitTableViewCellViewModel : NSObject, TableViewCellViewModel {
    
    let commit:Commit
    init(commit:Commit) {
        self.commit = commit
        super.init()
    }
    
    let cellIdentifier =  "CommitCell"
    
    func configureCell(cell:UITableViewCell) {
        let theCell = cell as! CommitTableViewCell
        theCell.titleLabel.text = commit.title
        theCell.shaLabel.text = commit.short_id
        theCell.authorLabel.text = commit.author_name
        theCell.timeLabel.text = commit.created_at?.timeAgoSinceNow()
    }
    
    func didSelectCell() {
        let alarm = UIAlertController(title: "selected", message: "commit \(commit.id)", preferredStyle: .Alert)
        alarm.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))
        UIApplication.sharedApplication().keyWindow?.rootViewController?.presentViewController(alarm, animated: true, completion: nil)
    }
    
    var resetAfterSelect = true
}