//
//  RYTableViewController.swift
//  gitlab-iOS
//
//  Created by Xplorld on 2016/3/19.
//  Copyright © 2016年 dyweb. All rights reserved.
//

import UIKit

//TODO: (Table, Section) x (Headers, footers)
class RYTableViewController : UITableViewController {
    var viewModels:[[TableViewCellViewModel]] = [] {
        didSet {tableView.reloadData()}
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return viewModels.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels[section].count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let viewModel = viewModels[indexPath.section][indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier(viewModel.cellIdentifier, forIndexPath: indexPath)
        viewModel.configureCell(cell)
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let height = viewModels[indexPath.section][indexPath.row].heightForCell
        return height ?? super.tableView(tableView, heightForRowAtIndexPath:indexPath)
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let viewModel = viewModels[indexPath.section][indexPath.row]
        if (viewModel.resetAfterSelect ?? false) {
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
        }
        viewModel.didSelectCell?()
    }
    
}