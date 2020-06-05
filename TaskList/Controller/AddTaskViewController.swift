//
//  AddTaskViewController.swift
//  TaskList
//
//  Created by partha on 6/4/20.
//  Copyright © 2020 Partha Sarathy. All rights reserved.
//

import UIKit


protocol addTaskDelegate {
    func addTaskToTasks(taskname: String)
}

class AddTaskViewController: UIViewController {
    
    var delegate: addTaskDelegate?
    
    @IBOutlet var taskTextField: UITextField!
 
    
    @IBAction func addTask(_ sender: Any) {
        if let taskText = taskTextField.text {
            delegate?.addTaskToTasks(taskname: taskText)
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
