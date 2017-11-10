//
//  FinishGoalVC.swift
//  goalpost-app
//
//  Created by Sercan on 10.11.2017.
//  Copyright © 2017 Sercan Orhangazi. All rights reserved.
//

import UIKit
import CoreData

let appDelegate = UIApplication.shared.delegate as? AppDelegate

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
    
    @IBAction func backButtonPressed(_ sender: Any) {
        dismissDetail()
    }
    
    @IBAction func doneButtonPressed(_ sender: Any) {
        if pointsTextField.text != "" {
            self.save { (success) in
                dismiss(animated: true, completion: nil)
            }
        }
        
    }
    
    func save(completion : (_ finished : Bool) -> ()) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        let goal = Goal(context: managedContext)
        
        goal.goalDescription = goalDescription
        goal.goalType = goalType.rawValue
        goal.goalCompletionValue = Int32(pointsTextField.text!)!
        goal.goalProgressValue = Int32(0)
        
        do {
            try managedContext.save()
            print("Saved")
            completion(true)
        } catch {
            debugPrint("Couldn't save : \(error.localizedDescription)")
            completion(false)
        }
    }
    
    
}
