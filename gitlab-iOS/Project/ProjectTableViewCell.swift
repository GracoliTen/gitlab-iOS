//
//  ProjectTableViewCell.swift
//  gitlab-iOS
//
//  Created by Xplorld on 2016/3/19.
//  Copyright © 2016年 dyweb. All rights reserved.
//

import UIKit

class ProjectTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var descLabel: UILabel!
    
    @IBOutlet weak var starCountLabel: UILabel!
    
    @IBOutlet weak var forkCountLabel: UILabel!
    
}




class ProjectTableViewCellViewModel :  TableViewCellViewModel {
    
    let project:Project
    init(project:Project) {
        self.project = project
    }
    
    @objc let cellIdentifier =  "ProjectCell"
    
    @objc func configureCell(cell:UITableViewCell) {
        let theCell = cell as! ProjectTableViewCell
        theCell.nameLabel.text = project.name_with_namespace
        theCell.descLabel.text = project.description
        theCell.starCountLabel.text = "\(project.star_count ?? 0)"
        theCell.forkCountLabel.text = "\(project.forks_count ?? 0)"
    }
    
    @objc func didSelectCell(indexPath:NSIndexPath,controller:RYTableViewController) {
        let segue = "ProjectToDetailSegue"
        controller.performSegueWithIdentifier(segue, sender: project) {
            segue, sender in
            let vc = segue.destinationViewController as! ProjectDetailViewController
            vc.project = sender as! Project
        }
    }
    
    @objc var resetAfterSelect = true
}
