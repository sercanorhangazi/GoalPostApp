//
//  FinishGoalVC.swift
//  goalpost-app
//
//  Created by Sercan on 10.11.2017.
//  Copyright © 2017 Sercan Orhangazi. All rights reserved.
//

import UIKit

class FinishGoalVC: UIViewController, UITextFieldDelegate {

    // Outlets
    @IBOutlet weak var pointsTextField: UITextField!
    @IBOutlet weak var doneButton: UIButton!
    
    // Variables
    var goalDescription : String!
    var goalType : GoalType!
    
    func initData(description : String, type : GoalType) {
        self.goalDescription = description
        self.goalType = type
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        doneButton.bindToKeyboard()
        pointsTextField.delegate = self
    }
    
    @IBAction func doneButtonPressed(_ sender: Any) {
        guard let textFieldValue = pointsTextField.text else { return }
        guard let completionPoints = Int(textFieldValue) else { return }
        
    }
    
    
}
