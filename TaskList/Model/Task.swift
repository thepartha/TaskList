//
//  Task.swift
//  TaskList
//
//  Created by partha on 6/4/20.
//  Copyright © 2020 Partha Sarathy. All rights reserved.
//

import Foundation

struct Task {
    var taskTitle: String
    var taskStatus: Bool
    var id: String?
    var category: String
    var reminderDate: Date?
    var reminderSetFor: String?
}
