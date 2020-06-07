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
    @IBOutlet var reminder_icon: UIImageView!
    @IBOutlet var reminder_label: UILabel!
    @IBOutlet var duedate_icon: UIImageView!
    @IBOutlet var duedate_label: UILabel!
    
    @IBAction func setReminderTapped(_ sender: Any) {
        let alertController = UIAlertController.init(title: "Reminder", message: "Set Reminder", preferredStyle: .actionSheet)
        let todayAction = UIAlertAction(title: "Today", style: .default) { (action) in
            print(action)
        }
        let tomorrowAction = UIAlertAction(title: "Tomorrow", style: .default) { (action) in
            print(action)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            print(action)
        }
        alertController.addAction(todayAction)
        alertController.addAction(tomorrowAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    @IBAction func setDuedateTapped(_ sender: Any) {
        
        
    }
    
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
