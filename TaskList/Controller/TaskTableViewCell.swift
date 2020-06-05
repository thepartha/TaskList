//
//  TaskTableViewCell.swift
//  TaskList
//
//  Created by Partha Sarathy on 6/3/20.
//  Copyright © 2020 Partha Sarathy. All rights reserved.
//

import UIKit

protocol taskTableViewCellDelegate {
    func taskChecked(cell: TaskTableViewCell)
}


class TaskTableViewCell: UITableViewCell {

    @IBOutlet var cellView: UIView!
    @IBOutlet var taskLabel: UILabel!
    @IBOutlet var checkBox: UIImageView!
    var delegate: taskTableViewCellDelegate!
    @IBAction func checkBoxTapped(_ sender: Any) {
        delegate.taskChecked(cell: self)
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cellView.layer.cornerRadius = 10
        cellView.layer.shadowColor = UIColor.black.cgColor
        cellView.layer.shadowOpacity = 0.05
        cellView.layer.shadowOffset = .zero
        cellView.layer.shadowRadius = 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
