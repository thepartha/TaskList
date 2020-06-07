//
//  TestTableViewController.swift
//  TaskList
//
//  Created by Partha Sarathy on 6/6/20.
//  Copyright © 2020 Partha Sarathy. All rights reserved.
//

import UIKit

class TestTableViewController: UITableViewController{
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath)
        
        if indexPath.section == 0 {
            cell.textLabel?.text = "task Pending"
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var sectionHeader = ""
        if section == 0 {
            sectionHeader = "sda"
        } else {
            sectionHeader = "asdas"
        }
        return sectionHeader
    }
    
}
