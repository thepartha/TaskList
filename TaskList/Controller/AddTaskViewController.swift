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
    
    @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
        cancel()
    }
    @IBOutlet var taskTextField: UITextField!
    @IBOutlet var reminder_icon: UIImageView!
    @IBOutlet var reminder_label: UILabel!
    @IBOutlet var duedate_icon: UIImageView!
    @IBOutlet var duedate_label: UILabel!
    @IBOutlet var remainderContainerView: UIView!
    @IBOutlet var backgroundView: UIView!
    
    @IBAction func setReminderTapped(_ sender: Any) {
     self.view.bringSubviewToFront(self.remainderContainerView)
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
            var containerFrame = self.remainderContainerView.frame
            containerFrame.origin.y -= containerFrame.height
            self.backgroundView.alpha = 0.3
            self.remainderContainerView.frame = containerFrame
        }) { (finished) in
        }
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
    
    override func viewWillAppear(_ animated: Bool) {
        // remainderContainerView.frame.origin.y = 100
    }
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addReminderSheet" {
            print("Inside sege")
            let vc = segue.destination as! AddActionsViewController
            vc.delegate = self
        }
    }
    
}


extension AddTaskViewController: reminderSheetDelegate {
    func laterToday() {
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let day = calendar.component(.day, from: date)
        print(day)
        if hour < 12 {
            print("Today: \(hour + 4) AM")
        } else if hour > 12 && hour + 4 >= 24{
            print("Today: 12 PM")
        } else if hour > 12 {
            print("Today: \((hour - 22) + 4)PM")
        }
        
    }
    
    func reminderDateSet(date: Date) {
        print("date")
    }
    
    func cancel() {
        print("cancel")
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
            var currentFrame = self.remainderContainerView.frame
            currentFrame.origin.y += currentFrame.height

            self.remainderContainerView.frame = currentFrame
            self.backgroundView.alpha = 0

        }) { (finished) in
            if finished {
                print("animation completed successully")
            }
        }
    }
    
    
}
