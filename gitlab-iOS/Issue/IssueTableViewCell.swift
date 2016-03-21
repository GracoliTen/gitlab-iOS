//
//  IssueTableViewCell.swift
//  gitlab-iOS
//
//  Created by Xplorld on 2016/3/20.
//  Copyright © 2016年 dyweb. All rights reserved.
//

import UIKit

class IssueTableViewCell: UITableViewCell {
    @IBOutlet weak var avatarImageView: UIImageView!

    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var IDLabel: UILabel!
    @IBOutlet weak var tagsLabel: UILabel!
    @IBOutlet weak var assigneeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        avatarImageView.layer.cornerRadius = 5.0
        avatarImageView.clipsToBounds = true
    }
}

class IssueTableViewCellViewModel : NSObject, TableViewCellViewModel {
    
    let issue:Issue
    init(issue:Issue) {
        self.issue = issue
        super.init()
    }
    
    let cellIdentifier =  "IssueCell"
    
    func configureCell(cell:UITableViewCell) {
        let theCell = cell as! IssueTableViewCell
        theCell.titleLabel.text = issue.title
        theCell.IDLabel.text = "#\(issue.id)"
        theCell.assigneeLabel.text = issue.assignee?.name
        UIImage.imageFromURL(URL: issue.assignee?.avatar_url) {
            theCell.avatarImageView.image = $0
        }
        theCell.tagsLabel.text = issue.labels.reduce("[", combine: {$0+$1})+"]"
        
    }
    
    func didSelectCell() {
        let alarm = UIAlertController(title: "selected", message: "issue \(issue.id)", preferredStyle: .Alert)
        alarm.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))
        UIApplication.sharedApplication().keyWindow?.rootViewController?.presentViewController(alarm, animated: true, completion: nil)
    }
    
    var resetAfterSelect = true
}