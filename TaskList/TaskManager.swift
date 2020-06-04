//
//  TaskManager.swift
//  TaskList
//
//  Created by partha on 6/4/20.
//  Copyright © 2020 Partha Sarathy. All rights reserved.
//

import Foundation

class TaskManager {
    var tasks: [Task] = []
    
    func AddTask(taskName: String) {
        let newTask = Task(taskTitle: taskName, taskDate: Date(), taskStatus: false)
        tasks.append(newTask)
    }
    
}
