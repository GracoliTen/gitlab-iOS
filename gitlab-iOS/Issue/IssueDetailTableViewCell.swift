//
//  IssueDetailTableViewCell.swift
//  gitlab-iOS
//
//  Created by Xplorld on 2016/3/23.
//  Copyright © 2016年 dyweb. All rights reserved.
//

import UIKit
import TagListView

class IssueDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var IDLabel: UILabel!
    @IBOutlet weak var creatorName: UILabel!
    @IBOutlet weak var createTime: UILabel!
    @IBOutlet weak var assigneeName: UILabel!
    @IBOutlet weak var updateTime: UILabel!
    @IBOutlet weak var tagListView: TagListView!
    @IBOutlet weak var detailLabel: UILabel!
}



class IssueDetailTableViewCellViewModel : TableViewCellViewModel {
    
    let issue:Issue
    init(issue:Issue) {
        self.issue = issue
    }
    
    @objc let cellIdentifier =  "IssueDetailCell"
    
    @objc func configureCell(cell:UITableViewCell) {
        let theCell = cell as! IssueDetailTableViewCell
        theCell.titleLabel.text = issue.title
        theCell.IDLabel.text = "#\(issue.iid)"
        theCell.creatorName.text = issue.author?.name
        theCell.createTime.text = issue.created_at?.timeAgoSinceNow()
        theCell.assigneeName.text = issue.assignee?.name
        theCell.updateTime.text = issue.updated_at?.timeAgoSinceNow()
        theCell.detailLabel.text = issue.desc
        
        theCell.tagListView.removeAllTags()
        for (title,color) in LabelTinter.tintLabels([issue.state.rawValue] + issue.labels) {
            theCell.tagListView.addTag(title).tagBackgroundColor = color
        }
    }
    
    @objc func didSelectCell(indexPath: NSIndexPath, controller: RYTableViewController) {
        
    }
    
    @objc var resetAfterSelect = true
}