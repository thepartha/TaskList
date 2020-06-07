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
    
    var tasksPendingCount: Int = 0
    var workTasksPendingCount: Int = 0
    var otherTasksPendingCount: Int = 0
    var personalTasksPendingCount: Int = 0 
    
    @IBOutlet var gridIcon: UIImageView!
    @IBOutlet var listIcon: UIImageView!
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
       
        listIcon.image = UIImage(named: "List_Icon")
        gridIcon.image = UIImage(named: "Grid_Icon_active")
        
        print("Total tasks: \(tasksCount) completed:\(tasksPendingCount)")
        print("Total work: \(workTasksCount) completed:\(workTasksPendingCount)")
        print("Total other: \(otherTasksCount) completed:\(otherTasksPendingCount)")
        print("Total personnal: \(personalTasksCount) completed:\(personalTasksPendingCount)")
    }
    
}
