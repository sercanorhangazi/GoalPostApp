//
//  AddNewGoalVC.swift
//  goalpost-app
//
//  Created by Sercan on 9.11.2017.
//  Copyright © 2017 Sercan Orhangazi. All rights reserved.
//

import UIKit

class AddNewGoalVC: UIViewController, UITextViewDelegate {

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
        goalDescriptionTextView.delegate = self
        shortTermButton.setSelectedColor()
        longTermButton.setDeselectedColor()
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        dismissDetail()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        goalDescriptionTextView.text = ""
        goalDescriptionTextView.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
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
        if goalDescriptionTextView.text != "" && goalDescriptionTextView.text != "What is your goal?" {
            guard let finishGoalVC = storyboard?.instantiateViewController(withIdentifier: "finishGoalVC") as? FinishGoalVC else { return }
            finishGoalVC.initData(description: goalDescriptionTextView.text, type: selectedGoalType)
            presentDetail(finishGoalVC)
        }
    }
    
    
    
    
    
    
    
    
    

}
