//
//  GoalsVC.swift
//  goalpost-app
//
//  Created by Sercan on 8.11.2017.
//  Copyright © 2017 Sercan Orhangazi. All rights reserved.
//

import UIKit
import CoreData

class GoalsVC: UIViewController {

    // Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // Varibles
    var goals = [Goal]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isHidden = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.fetch { (success) in
            if success {
                if goals.count > 0 {
                    tableView.isHidden = false
                } else {
                    tableView.isHidden = true
                }
                tableView.reloadData()
            }
        }
    }

    @IBAction func addGoalButtonPressed(_ sender: Any) {
        guard let addNewGoalVC = storyboard?.instantiateViewController(withIdentifier: "AddNewGoalVC") else { return }
        presentDetail(addNewGoalVC)
    }
    
}

extension GoalsVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "goalCell", for: indexPath) as? GoalCell else { return UITableViewCell() }
        let goal = goals[indexPath.row]
        cell.configureCell(goal: goal)
        return cell
    }
}

extension GoalsVC {
    
    func fetch(completion : (_ complete : Bool) -> ()) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        let fetchRequest = NSFetchRequest<Goal>(entityName: "Goal")
        do {
            goals = try managedContext.fetch(fetchRequest)
            print("Fetching completed.")
            completion(true)
        } catch {
            debugPrint("Fetch error : \(error.localizedDescription)")
            completion(false)
        }
    }
    
}



















