//
//  AddTaskViewController.swift
//  TaskList
//
//  Created by partha on 6/4/20.
//  Copyright © 2020 Partha Sarathy. All rights reserved.
//

import UIKit

protocol addTaskDelegate {
    func addTaskToTasks(taskname: String, reminderDate: Date)
    
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
    
    var reminderDate: Date?
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
        if let taskText = taskTextField.text, let reminderDate = reminderDate {
            delegate?.addTaskToTasks(taskname: taskText, reminderDate: reminderDate)
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
            let vc = segue.destination as! ReminderViewController
            vc.delegate = self
        }
    }
    
    func getWeekday(day: Int) -> String {
         switch day {
             case 1:
                 return "Sun"
             case 2:
                 return "Mon"
             case 3:
                 return"Tue"
             case 4:
                return "Wed"
             case 5:
                 return "Thu"
             case 6:
                 return "Fri"
             case 7:
                return "Sat"
             default:
                 return ""
             }
     }
    
}


extension AddTaskViewController: reminderSheetDelegate {
    func removeReminderDate() {
        reminderDate = nil
        reminder_label.text = "Set Reminder"
        reminder_label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        reminder_label.textColor = UIColor.init(named: "default-color")
        reminder_label.alpha = 0.5
        reminder_icon.image = UIImage(named: "reminder_notset")
        cancel()
    }
    
    
    func reminderDateSet(date: Date) {
        let date = date
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let day = calendar.component(.weekday, from: date)
             let weekday = getWeekday(day: day)
              if hour < 12 {
                reminder_label.text = "\(weekday): \(hour + 4) AM"
              } else if hour > 12 && hour + 4 >= 24{
                reminder_label.text = "\(weekday): 12 AM"
              } else if hour > 12 {
                 reminder_label.text = "\(weekday): \((hour - 22) + 4)PM"
              }
        reminder_label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        reminder_label.textColor = UIColor.init(named: "tasks-color")
        reminder_label.alpha = 1
        reminder_icon.image = UIImage(named: "reminder_set")
        cancel()
    }
    
    func cancel() {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
            var currentFrame = self.remainderContainerView.frame
            currentFrame.origin.y += currentFrame.height

            self.remainderContainerView.frame = currentFrame
            self.backgroundView.alpha = 0
            
        }) { (finished) in
            if finished {
            }
        }
    }
    
    
}
