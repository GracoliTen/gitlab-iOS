//
//  ViewController.swift
//  gitlab-iOS
//
//  Created by Xplorld on 2016/3/18.
//  Copyright © 2016年 dyweb. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        readProjects()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func readProjects() {
        let client = GitLabAPIClient()
        client.getArray(ProjectRouter.owned).then  { (projects:[Project],res:NSHTTPURLResponse) -> Void in
            let alarm = UIAlertController(title: "got \(projects.count) projects", message: "they are: \n \(projects)", preferredStyle: .Alert)
            alarm.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))
            self.presentViewController(alarm, animated: true, completion: nil)
            } .error { (err:ErrorType) -> Void in
                let alarm = UIAlertController(title: "Error", message: "Something happened: \(err)", preferredStyle: .Alert)
                alarm.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))
                self.presentViewController(alarm, animated: true, completion: nil)
                
        }
    }
    
}

