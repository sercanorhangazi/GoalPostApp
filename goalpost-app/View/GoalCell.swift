//
//  GoalCell.swift
//  goalpost-app
//
//  Created by Sercan on 8.11.2017.
//  Copyright © 2017 Sercan Orhangazi. All rights reserved.
//

import UIKit

class GoalCell: UITableViewCell {

    // Outlets
    @IBOutlet weak var goalDescriptionLabel: UILabel!
    @IBOutlet weak var goalTermLabel: UILabel!
    @IBOutlet weak var goalProgressLabel: UILabel!
    @IBOutlet weak var goalCompleteView: UIView!
    
    func configureCell(goal : Goal) {
        self.goalDescriptionLabel.text = goal.goalDescription
        self.goalTermLabel.text = goal.goalType
        self.goalProgressLabel.text = "\(goal.goalProgressValue)"
        
        if goal.goalProgressValue == goal.goalCompletionValue {
            self.goalCompleteView.isHidden = false
        } else {
            self.goalCompleteView.isHidden = true
        }
    }

}
