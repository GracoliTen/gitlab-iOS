//
//  NoteTableViewCell.swift
//  gitlab-iOS
//
//  Created by Xplorld on 2016/3/23.
//  Copyright © 2016年 dyweb. All rights reserved.
//

import UIKit
import DateTools

class NoteTableViewCell: UITableViewCell {
    
//    @IBOutlet weak var bodyLabel: UILabel!
    
    
    @IBOutlet weak var bodyTextView: UITextView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        avatarImageView.layer.cornerRadius = 5
        avatarImageView.clipsToBounds = true
    }
}
class NoteTableViewCellViewModel : TableViewCellViewModel {
    
    let note:Note
    init(note:Note) {
        self.note = note
    }
    
    @objc let cellIdentifier =  "NoteCell"
    
    @objc func configureCell(cell:UITableViewCell) {
        let theCell = cell as! NoteTableViewCell
        theCell.bodyTextView.attributedText = MarkdownParser.sharedParser.parse(note.body)
        theCell.timeLabel.text = note.created_at?.timeAgoSinceNow()
        theCell.nameLabel.text = note.author?.name
        theCell.usernameLabel.text = "@" + (note.author?.username ?? "")
        UIImage.imageFromURL(URL: note.author?.avatar_url) {
            theCell.avatarImageView.image = $0
        }
        
    }
    
    @objc func didSelectCell(indexPath: NSIndexPath, controller: RYTableViewController) {
        
    }
    
    @objc var resetAfterSelect = true
}