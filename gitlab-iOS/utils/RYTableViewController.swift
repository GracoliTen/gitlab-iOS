//
//  RYTableViewController.swift
//  gitlab-iOS
//
//  Created by Xplorld on 2016/3/19.
//  Copyright © 2016年 dyweb. All rights reserved.
//

import UIKit

//TODO: (Table, Section) x (Headers, footers)
class RYTableViewController : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView : UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    var scrollLoadEnabled = true
    var fetcher:PagedTableViewFetcher! {
        didSet {
            tryToLoadMore()
        }
    }
    var loadMoreThreshold:CGFloat = 100
    
    
     override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44 //as default, enable self sizing
        tableView.reloadData()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    var viewModels:[[TableViewCellViewModel]] = [] {
        didSet {
            tableView?.reloadData()
        }
    }
    
      func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return viewModels.count
    }
    
      func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels[section].count
    }
    
      func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let viewModel = viewModels[indexPath.section][indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier(viewModel.cellIdentifier, forIndexPath: indexPath)
        viewModel.configureCell(cell)
        
        cell.layoutIfNeeded()
        return cell
    }
    
      func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let viewModel = viewModels[indexPath.section][indexPath.row]
        if (viewModel.resetAfterSelect ?? false) {
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
        }
        viewModel.didSelectCell?(indexPath,controller: self)
    }
    
      func scrollViewDidScroll(scrollView: UIScrollView) {
        if scrollLoadEnabled &&
            scrollView.contentSize.height - scrollView.frame.size.height - scrollView.contentOffset.y < loadMoreThreshold {
                tryToLoadMore()
        }
    }
    
    //TODO:is is sufficient to
    //1. identify each action only by segue identifier?
    //2. allow only one action for each segue?
    //is it necessery to make it a Promise?
    private var seguePreparationActions:[String:((UIStoryboardSegue,AnyObject?)->Void)] = [:]
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        super.prepareForSegue(segue, sender: sender)
        if let id = segue.identifier,
            let action = seguePreparationActions[id] {
                action(segue,sender)
                seguePreparationActions[id] = nil
        }
    }
    func performSegueWithIdentifier(identifier: String,sender:AnyObject?, action:((UIStoryboardSegue,AnyObject?)->Void)) {
        seguePreparationActions[identifier] = action
        self.performSegueWithIdentifier(identifier, sender: sender)
    }
    
    func tryToLoadMore() {
        fetcher?.tryToFetchMore()
    }
}