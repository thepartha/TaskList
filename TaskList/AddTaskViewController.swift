//
//  AddTaskViewController.swift
//  TaskList
//
//  Created by partha on 6/4/20.
//  Copyright © 2020 Partha Sarathy. All rights reserved.
//

import UIKit

class AddTaskViewController: UIViewController {
    
    @IBOutlet var taskTextField: UITextField!
    
    @IBAction func addTask(_ sender: Any) {
        if let taskText = taskTextField.text {
            print(taskText)
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
}
