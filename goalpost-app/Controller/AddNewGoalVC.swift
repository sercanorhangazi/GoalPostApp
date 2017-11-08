//
//  AddNewGoalVC.swift
//  goalpost-app
//
//  Created by Sercan on 9.11.2017.
//  Copyright © 2017 Sercan Orhangazi. All rights reserved.
//

import UIKit

class AddNewGoalVC: UIViewController {

    // Outlets
    @IBOutlet weak var goalDescriptionTextView: UITextView!
    @IBOutlet weak var shortTermButton: UIButton!
    @IBOutlet weak var longTermButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    // Variables
    var selectedGoalType : GoalType = .shortTerm
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextButton.bindToKeyboard()
        shortTermButton.setSelectedColor()
        longTermButton.setDeselectedColor()
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        dismissDetail()
    }
    
    @IBAction func shortTermButtonPressed(_ sender: Any) {
        selectedGoalType = .shortTerm
        shortTermButton.setSelectedColor()
        longTermButton.setDeselectedColor()
    }
    
    @IBAction func longTermButtonPressed(_ sender: Any) {
        selectedGoalType = .longTerm
        longTermButton.setSelectedColor()
        shortTermButton.setDeselectedColor()
    }
    
    @IBAction func nextButtonPressed(_ sender: Any) {
    }
    

}
