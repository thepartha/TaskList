//
//  ViewController.swift
//  TaskList
//
//  Created by Partha Sarathy on 6/3/20.
//  Copyright © 2020 Partha Sarathy. All rights reserved.
//
//layerMaxXMaxYCorner - bottom right corner
//layerMaxXMinYCorner - top right corner
//layerMinXMaxYCorner - bottom left corner
//layerMinXMinYCorner - top left corner

import UIKit
import Firebase

class TaskViewController: UIViewController, taskTableViewCellDelegate {
    
    func taskChecked(cell: TaskTableViewCell) {
        let indexPath = tableView.indexPath(for: cell)
        let task: Task!
        let id: String!
        if let indexPath = indexPath {
            if indexPath.section == 0 {
                    let currentStatus = tasks[indexPath.row].taskStatus
                    tasks[indexPath.row].taskStatus = !currentStatus
                    task = tasks[indexPath.row]
                    id = tasks[indexPath.row].id
                db.collection("completed").addDocument(data: ["taskStatus" : task.taskStatus, "taskTitle": task.taskTitle, "taskDate" : Date().timeIntervalSince1970, "category" : currentCollection]) { (error) in
                            if let error = error {
                                print(error.localizedDescription)
                            } else {
                                self.db.collection("tasks").document(id).delete { (error) in
                                    if let error = error {
                                        print(error.localizedDescription)
                                    } else {
                                    }
                                }
                            }
                        }
            } else {
                let currentStatus = completedTasks[indexPath.row].taskStatus
                completedTasks[indexPath.row].taskStatus = !currentStatus
                task = completedTasks[indexPath.row]
                id = completedTasks[indexPath.row].id
                db.collection("completed").document(id).delete { (error) in
                          if let error = error {
                              print(error.localizedDescription)
                          } else {
                     
                              self.db.collection("tasks").addDocument(data: ["taskStatus" : task.taskStatus, "taskTitle": task.taskTitle, "taskDate" : Date().timeIntervalSince1970, "category" : self.currentCollection]) { (error) in
                                  if let error = error {
                                      print(error.localizedDescription)
                                  }
                              }
                          }
                      }
            }
        }

        countByCategory()
        tableView.reloadData()
        
        
    }
    
    @IBAction func overviewTapped(_ sender: Any) {
        performSegue(withIdentifier: "overViewSegue", sender: self)
    }
    
    @IBOutlet var todayLabel: UILabel!
    @IBOutlet var addIcon: UIImageView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var bottomView: UIView!
    @IBOutlet var topView: UIView!
    @IBOutlet var gridIcon: UIImageView!
    @IBOutlet var listIcon: UIImageView!
    
    var tasks: [Task] = []
    var completedTasks: [Task] = []
    var currentCollection: String = ""
    
    
    var workTasksCount: Int!
    var personalTasksCount: Int!
    var otherTasksCount: Int!
    var tasksCount: Int!
    
    var workTasksPendingCount: Int = 0
    var personalTasksPendingCount: Int = 0
    var otherTasksPendingCount: Int = 0
    var tasksPendingCount: Int = 0
    
    var weekDay: String = ""
    var month: String = ""
    var day: Int = 0
    
    @IBOutlet var allTasksButton: UIButton!
    @IBOutlet var workTasksButton: UIButton!
    @IBOutlet var personalTasksButton: UIButton!
    @IBOutlet var otherButtonTasks: UIButton!
    @IBOutlet var dateLabel: UILabel!
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
        self.tableView.sectionHeaderHeight = 70
        
        setupDate()
        currentCollection = "tasks"
        loadTasks(collection: currentCollection)
        
        //layerMaxXMaxYCorner - bottom right corner
        //layerMaxXMinYCorner - top right corner
        //layerMinXMaxYCorner - bottom left corner
        //layerMinXMinYCorner - top left corner
        
        tableView.register(UINib(nibName: "TaskTableViewCell", bundle: nil), forCellReuseIdentifier: "taskCell")
        topView.layer.cornerRadius = 26
        bottomView.layer.cornerRadius = 26
        topView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        bottomView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        topNavButtons = [allTasksButton,workTasksButton,personalTasksButton,otherButtonTasks]
        allTasksButton.isSelected = true
        listIcon.image = UIImage(named: "List_Icon_Active")
        gridIcon.image = UIImage(named: "Grid_Icon")
        
        countByCategory()
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
        switch segue.identifier {
        case "overViewSegue":
            
            let viewController = segue.destination as? OverviewViewController
            viewController?.otherTasksCount = otherTasksCount
            viewController?.personalTasksCount = personalTasksCount
            viewController?.workTasksCount = workTasksCount
            viewController?.tasksCount = tasksCount
            viewController?.otherTasksPendingCount = otherTasksPendingCount
            viewController?.personalTasksPendingCount = personalTasksPendingCount
            viewController?.workTasksPendingCount = workTasksPendingCount
            viewController?.tasksPendingCount = tasksPendingCount
        case "addTask":
            let viewController = segue.destination as? AddTaskViewController
            viewController?.delegate = self
        default:
            return
        }
        
        
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
        db.collection("tasks").whereField("category", isEqualTo: collection).order(by: "taskDate").addSnapshotListener { (snapshot, error) in
            self.tasks = []
            if let error = error {
                print(error.localizedDescription)
            } else {
                if let snapshotDocuments = snapshot?.documents {
                    for document in snapshotDocuments{
                        print(snapshotDocuments.count)
                        let data = document.data()
                        if let taskTitle = data["taskTitle"] as? String,
                            let taskStatus = data["taskStatus"] as? Bool,
                            let taskCategory = data["category"] as? String
                        {
                            let task = Task(taskTitle: taskTitle, taskStatus: taskStatus, id: document.documentID, category: taskCategory)
                            self.tasks.append(task)
                        }
                        
                    }
                }
            }
            self.tableView.reloadData()

           
        }
        db.collection("completed").whereField("category", isEqualTo: collection).order(by: "taskDate").addSnapshotListener { (snapshot, error) in
            self.completedTasks = []
            if let error = error {
                print(error.localizedDescription)
            } else {
                if let snapshotDocuments = snapshot?.documents {
                    for document in snapshotDocuments {
                        let data = document.data()
                           if let taskTitle = data["taskTitle"] as? String,
                          let taskStatus = data["taskStatus"] as? Bool,
                            let taskCategory = data["category"] as? String {
                            let task = Task(taskTitle: taskTitle, taskStatus: taskStatus, id: document.documentID, category: taskCategory)
                            self.completedTasks.append(task)
                        }
                    }
                }
            }
            self.tableView.reloadData()
        }
            
    }
    
    func countByCategory(){
        countInit()
        db.collection("tasks").getDocuments { (snapshot, error) in
            if let error = error{
                print(error.localizedDescription)
            } else {
                if let snapshotDocuments = snapshot?.documents {
                    for docment in snapshotDocuments {
                        let data = docment.data()
                        if let taskCategory = data["category"] as? String {
                            switch taskCategory {
                            case "tasks":
                                self.tasksCount += 1
                            case "personal" :
                                self.personalTasksCount += 1
                            case "other":
                                self.otherTasksCount += 1
                            case "work" :
                                self.workTasksCount += 1
                            default:
                                print("No collected found")
                            }
                        }
                    }
                }
            }
        }
        db.collection("completed").getDocuments { (snapshot, error) in
                if let error = error{
                    print(error.localizedDescription)
                } else {
                    if let snapshotDocuments = snapshot?.documents {
                        for docment in snapshotDocuments {
                            let data = docment.data()
                            if let taskCategory = data["category"] as? String {
                                switch taskCategory {
                                case "tasks":
                                    self.tasksPendingCount += 1
                                case "personal" :
                                    self.personalTasksPendingCount += 1
                                case "other":
                                    self.otherTasksPendingCount += 1
                                case "work" :
                                    self.workTasksPendingCount += 1
                                default:
                                    print("No collected found")
                                }
                            }
                        }
                    }
                }
            }
        
        
    }
    
    func countInit(){
        workTasksCount = 0
        otherTasksCount = 0
        personalTasksCount = 0
        tasksCount = 0
    }
    
    func setupDate() {
        let date = Date()
        let calendar = Calendar.current
        
        let tempMonth = calendar.component(.month, from: date)
        let tempDay = calendar.component(.day, from: date)
        let tempWeekday = calendar.component(.weekday, from: date)
        
        day = tempDay
        switch tempMonth {
        case 1:
            month = "January"
        case 2 :
            month = "February"
        case 3:
            month = "March"
        case 4:
            month = "April"
        case 5:
            month = "May"
        case 6:
            month = "June"
        case 7:
            month = "July"
        case 8:
            month = "August"
        case 9:
            month = "September"
        case 10:
            month = "October"
        case 11:
            month = "November"
        case 12:
            month = "December"
        default:
            return
        }
        
        switch tempWeekday {
        case 1:
            weekDay = "Sunday"
        case 2:
            weekDay = "Monday"
        case 3:
            weekDay = "Tuesday"
        case 4:
            weekDay = "Wednesday"
        case 5:
            weekDay = "Thursday"
        case 6:
            weekDay = "Friday"
        case 7:
            weekDay = "Saturday"
        default:
            return
        }
        
        dateLabel.text = "\(weekDay), \(month) \(day)"
        
    }
    
}


extension TaskViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return tasks.count
        } else {
            return completedTasks.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as! TaskTableViewCell;
        cell.delegate = self
        if indexPath.section == 0 {
            let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: tasks[indexPath.row].taskTitle)
            attributeString.removeAttribute(NSAttributedString.Key.strikethroughStyle, range: NSMakeRange(0, attributeString.length))
            
                cell.taskLabel.attributedText = attributeString
                cell.checkBox.image = UIImage(named: "Rectangle")

        } else {
            let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: completedTasks[indexPath.row].taskTitle)
            
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
            
            cell.taskLabel.attributedText = attributeString
          //  cell.taskLabel.text = completedTasks[indexPath.row].taskTitle
            
            if completedTasks[indexPath.row].taskStatus{
                switch currentCollection {
                case "tasks":
                    cell.checkBox.image = UIImage(named: "Selected")
                case "personal" :
                    cell.checkBox.image = UIImage(named: "selected_personal")
                case "other":
                    cell.checkBox.image = UIImage(named: "selected_other")
                case "work" :
                    cell.checkBox.image = UIImage(named: "selected_work")
                default:
                    print("No collected found")
                }
            }
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 30))
        view.backgroundColor = UIColor.init(named: "background-color")
        let headerLabel = UILabel(frame: CGRect(x: 20, y: 20, width: 300, height: 30))
        headerLabel.font = UIFont.systemFont(ofSize: 21, weight: .thin)
        if section == 0 {
            headerLabel.text = "Pending Tasks"
            headerLabel.textColor = UIColor.init(named: "default-color")
        } else {
            headerLabel.text = "Competed Tasks"
            headerLabel.textColor = UIColor.init(named: "tasks-color")
        }
        view.addSubview(headerLabel)
        return view
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if indexPath.section == 0 {
                if let id = tasks[indexPath.row].id {
                    db.collection("tasks").document(id).delete { (error) in
                        if let error = error {
                            print(error.localizedDescription)
                        } else {
                            print("delete successfully")
                            self.countByCategory()
                        }
                    }
                }
            } else {
                if let id = completedTasks[indexPath.row].id {
                    db.collection("completed").document(id).delete { (error) in
                        if let error = error {
                            print(error.localizedDescription)
                        } else {
                            print("delete successfully")
                            self.countByCategory()
                        }
                    }
                }
            }

        }
    }
}


extension TaskViewController: addTaskDelegate {
    
    func addTaskToTasks(taskname: String, reminderDate: Date) {
        db.collection("tasks").addDocument(data: ["taskTitle" : taskname, "taskDate" : Date().timeIntervalSince1970, "taskStatus" : false, "category" : currentCollection, "reminderDate": reminderDate]) { (error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("Task Added Successfully")
                self.countByCategory()
            }
        }
    }
}

