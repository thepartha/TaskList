//
//  OverviewViewController.swift
//  TaskList
//
//  Created by Partha Sarathy on 6/5/20.
//  Copyright © 2020 Partha Sarathy. All rights reserved.
//

import UIKit

class OverviewViewController: UIViewController {
    
    var tasksCount: Int = 0
    var workTasksCount: Int = 0
    var otherTasksCount: Int = 0
    var personalTasksCount: Int = 0
    
    @IBOutlet var tasksCountLabel: UILabel!
    @IBOutlet var otherCountLabel: UILabel!
    @IBOutlet var personalCountLabel: UILabel!
    @IBOutlet var workCountLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tasksCountLabel.text = String(tasksCount)
        otherCountLabel.text = String(otherTasksCount)
        personalCountLabel.text = String(personalTasksCount)
        workCountLabel.text = String(workTasksCount)
       
    }
    
}
