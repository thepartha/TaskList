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
    var backgroundView: UIView!
    @IBOutlet var remainderContainerView: UIView!
    
    @IBAction func setReminderTapped(_ sender: Any) {
        //self.view.bringSubviewToFront(self.remainderContainerView)
        //self.backgroundView.alpha = 0.2

        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
            var containerFrame = self.remainderContainerView.frame
            containerFrame.origin.y -= containerFrame.height
            

            self.remainderContainerView.frame = containerFrame
        }) { (finished) in
            print("animation completed")
        }
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
      //  remainderContainerView.frame.origin.y -= remainderContainerView.frame.height
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
        backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height))
        backgroundView.backgroundColor = .black
        backgroundView.alpha = 0.0
        
        view.addSubview(backgroundView)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
         remainderContainerView.frame.origin.y = 100
    }
        

    
}
