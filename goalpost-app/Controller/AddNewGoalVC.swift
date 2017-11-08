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
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func shortTermButtonPressed(_ sender: Any) {
    }
    
    @IBAction func longTermButtonPressed(_ sender: Any) {
    }
    
    @IBAction func nextButtonPressed(_ sender: Any) {
    }
    

}
