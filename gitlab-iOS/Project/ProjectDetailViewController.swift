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
    case Settings = 3
}

class ProjectDetailViewController: UIViewController {
    
    @IBOutlet weak var commitsView: UIView!
    @IBOutlet weak var issuesView: UIView!
    @IBOutlet weak var membersView: UIView!
    @IBOutlet weak var settingsView: UIView!
    
    @IBOutlet weak var segments: UISegmentedControl!
    
    
    var project:Project! {
        didSet {
            guard project !== oldValue else {return }
            updateData()
        }
    }
    func updateData() {
        self.navigationItem.title = project.name_with_namespace
        for controller in childViewControllers {
            var child = controller as! ProjectChildViewController
            child.project = project
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        segments.addTarget(self, action: "segementValueChanged:", forControlEvents: UIControlEvents.ValueChanged)
        updateData()
        segments.selectedSegmentIndex = 0
        segementValueChanged(segments)
    }
    
    func segementValueChanged(segment:UISegmentedControl) {
        let views = [commitsView, issuesView, membersView, settingsView]
        for view in views {
            view.hidden = true
        }
        views[segments.selectedSegmentIndex].hidden = false
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let child = segue.destinationViewController as? ProjectChildViewController {
            let vc = child as! UIViewController
            addChildViewController(vc)
            vc.didMoveToParentViewController(self)
        }
    }
}
