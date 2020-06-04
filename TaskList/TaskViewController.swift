//
//  ViewController.swift
//  TaskList
//
//  Created by Partha Sarathy on 6/3/20.
//  Copyright © 2020 Partha Sarathy. All rights reserved.
//

import UIKit

class TaskViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var bottomView: UIView!
    @IBOutlet var topView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "TaskTableViewCell", bundle: nil), forCellReuseIdentifier: "taskCell")
        topView.layer.cornerRadius = 26
        bottomView.layer.cornerRadius = 26
        // Do any additional setup after loading the view.
    }
    
    func addShadow() {
        topView.layer.cornerRadius = 10
        topView.layer.shadowColor = UIColor.black.cgColor
        topView.layer.shadowOpacity = 0.09
        topView.layer.shadowOffset = .init(width: 0.2, height: 0.9)
        topView.layer.shadowRadius = 15
    }
    

}


extension TaskViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath)   as! TaskTableViewCell
        return cell
    }
    
    
    
    
}

