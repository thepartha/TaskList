//
//  ViewController.swift
//  TaskList
//
//  Created by Partha Sarathy on 6/3/20.
//  Copyright © 2020 Partha Sarathy. All rights reserved.
//

import UIKit
import Firebase

class TaskViewController: UIViewController, taskTableViewCellDelegate {
    
    func taskChecked(cell: TaskTableViewCell) {
        let indexPath = tableView.indexPath(for: cell)
        let currentStatus = tasks[indexPath!.row].taskStatus
        tasks[indexPath!.row].taskStatus = !currentStatus
        let newStatus = tasks[indexPath!.row].taskStatus
        if newStatus {
            cell.checkBox.image = UIImage(named: "Selected")
        } else {
            cell.checkBox.image = UIImage(named: "Rectangle")
        }
        
    }
    
    
    @IBOutlet var todayLabel: UILabel!
    @IBOutlet var addIcon: UIImageView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var bottomView: UIView!
    @IBOutlet var topView: UIView!
    
    var tasks: [Task] = []
    var workTasks: [Task] = []
    var personalTasks: [Task] = []
    var otherTasks: [Task] = []
    var currentCollection: String = ""
    
    @IBOutlet var allTasksButton: UIButton!
    @IBOutlet var workTasksButton: UIButton!
    @IBOutlet var personalTasksButton: UIButton!
    @IBOutlet var otherButtonTasks: UIButton!
    
    var topNavButtons: [UIButton] = []
    
    @IBAction func allTasksTapped(_ sender: UIButton) {
        if let title = sender.titleLabel?.text {
                updateNavUI(sender: title)
        }
       currentCollection = "tasks"
        tableView.reloadData()
         loadTasks(collection: currentCollection)
    }
    
    @IBAction func workTasksTapped(_ sender: UIButton) {
        if let title = sender.titleLabel?.text {
                      updateNavUI(sender: title)
              }
        currentCollection = "work"
        tableView.reloadData()
        loadTasks(collection: currentCollection)
    }
    
    @IBAction func personalTasksTapped(_ sender: UIButton) {
        if let title = sender.titleLabel?.text {
                      updateNavUI(sender: title)
              }
        currentCollection = "personal"
        tableView.reloadData()
        loadTasks(collection: currentCollection)
    }
    
    @IBAction func otherTasksTapped(_ sender: UIButton) {
        if let title = sender.titleLabel?.text {
                      updateNavUI(sender: title)
              }
        currentCollection = "other"
        tableView.reloadData()
        loadTasks(collection: currentCollection)
    }
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentCollection = "tasks"
        loadTasks(collection: "tasks")
        tableView.register(UINib(nibName: "TaskTableViewCell", bundle: nil), forCellReuseIdentifier: "taskCell")
        topView.layer.cornerRadius = 26
        bottomView.layer.cornerRadius = 26
        topNavButtons = [allTasksButton,workTasksButton,personalTasksButton,otherButtonTasks]
        allTasksButton.isSelected = true
        // Do any additional setup after loading the view.
    }
    
    func addShadow() {
        topView.layer.cornerRadius = 10
        topView.layer.shadowColor = UIColor.black.cgColor
        topView.layer.shadowOpacity = 0.09
        topView.layer.shadowOffset = .init(width: 0.2, height: 0.9)
        topView.layer.shadowRadius = 15
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let viewController = segue.destination as? AddTaskViewController
        viewController?.delegate = self
    }
    
    @IBAction func addTask(_ sender: Any) {
        performSegue(withIdentifier: "addTask", sender: self)
    }
    
    func updateNavUI(sender: String){
        for button in topNavButtons {
         button.isSelected = false
       }
        switch sender {
        case "All Tasks":
            allTasksButton.isSelected = true
            addIcon.image = UIImage(named: "AddIcon")
            todayLabel.textColor = UIColor.init(named: "tasks-color")
        case "Work":
            workTasksButton.isSelected = true
            addIcon.image = UIImage(named: "AddIcon_Work")
            todayLabel.textColor = UIColor.init(named: "work-color")
        case "Personal" :
            personalTasksButton.isSelected = true
            addIcon.image = UIImage(named: "AddIcon_Personal")
            todayLabel.textColor = UIColor.init(named: "personal-color")
        case "Other":
            otherButtonTasks.isSelected = true
            addIcon.image = UIImage(named: "AddIcon_other")
            todayLabel.textColor = UIColor.init(named: "other-color")
        default:
            return
        }
        
    }
    
    
    func loadTasks(collection: String){
        db.collection(collection).order(by: "taskDate").addSnapshotListener { (snapshot, error) in
     switch collection {
     case "tasks":
        self.tasks = []
     case "personal" :
        self.personalTasks = []
     case "other":
        self.otherTasks = []
     case "work" :
        self.workTasks = []
     default:
         return
     }
            
            if let error = error {
                print(error.localizedDescription)
            } else {
                if let snapshotDocuments = snapshot?.documents {
                    for document in snapshotDocuments{
                        let data = document.data()
                        if let taskTitle = data["taskTitle"] as? String,
                        let taskStatus = data["taskStatus"] as? Bool
                            {
                            let task = Task(taskTitle: taskTitle, taskStatus: taskStatus, id: document.documentID)
                                switch collection {
                                case "tasks":
                                    self.tasks.append(task)
                                case "personal" :
                                    self.personalTasks.append(task)
                                case "other":
                                    self.otherTasks.append(task)
                                case "work" :
                                    self.workTasks.append(task)
                                default:
                                    return
                                }
                        }
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
    
   
    
}


extension TaskViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch currentCollection {
        case "tasks":
           return self.tasks.count
        case "personal" :
            return self.personalTasks.count
        case "other":
            return self.otherTasks.count
        case "work" :
           return self.workTasks.count
        default:
            return 0
        }
     
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath)   as! TaskTableViewCell;        cell.delegate = self
        switch currentCollection {
             case "tasks":
                cell.taskLabel.text = tasks[indexPath.row].taskTitle
             case "personal" :
                 cell.taskLabel.text = personalTasks[indexPath.row].taskTitle
             case "other":
                 cell.taskLabel.text = otherTasks[indexPath.row].taskTitle
             case "work" :
                cell.taskLabel.text = workTasks[indexPath.row].taskTitle
             default:
                print("No collection found")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if let id = getDoucmentId(indexPath: indexPath) {
                db.collection(currentCollection).document(id).delete { (error) in
                    if let error = error {
                        print(error.localizedDescription)
                    } else {
                        print("delete successfully")
                    }
                }
            }
            
            
       
        }
    }
    
    func getDoucmentId(indexPath: IndexPath) -> String?{
        var id = ""
        switch currentCollection {
             case "tasks":
                id = tasks[indexPath.row].id!
             case "personal" :
                id = personalTasks[indexPath.row].id!
             case "other":
                id = otherTasks[indexPath.row].id!
             case "work" :
                id = workTasks[indexPath.row].id!
             default:
                id = ""
        }
        return id
    }

}


extension TaskViewController: addTaskDelegate {
    func addTaskToTasks(taskname: String) {
        
        db.collection(currentCollection).addDocument(data: ["taskTitle" : taskname, "taskDate" : Date().timeIntervalSince1970, "taskStatus" : false]) { (error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                DispatchQueue.main.async {
                    
                }
            }
        }
        
        
    }
    
    
}

