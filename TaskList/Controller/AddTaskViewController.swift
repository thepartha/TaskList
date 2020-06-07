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
    
    @IBOutlet var remainderContainerView: UIView!
    
    @IBAction func setReminderTapped(_ sender: Any) {
        
//        func openNapkins() {
//          UIView.animate(withDuration: 1.0, delay: 1.2, options: .curveEaseOut, animations: {
//            var fabricTopFrame = self.fabricTop.frame
//            fabricTopFrame.origin.y -= fabricTopFrame.size.height
//            
//            var fabricBottomFrame = self.fabricBottom.frame
//            fabricBottomFrame.origin.y += fabricBottomFrame.size.height
//            
//            self.fabricTop.frame = fabricTopFrame
//            self.fabricBottom.frame = fabricBottomFrame
//          }, completion: { finished in
//            print("Napkins opened!")
//          })
//          
//        }
//        
        remainderContainerView.frame.origin.y -= remainderContainerView.frame.height
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
        //print(remainderContainerView.frame.origin.y)
       // remainderContainerView.frame.origin.y = 100
        print(remainderContainerView.frame.origin.y)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
         remainderContainerView.frame.origin.y = 100
    }
        

    
}
