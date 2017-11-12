//
//  GoalsVC.swift
//  goalpost-app
//
//  Created by Sercan on 8.11.2017.
//  Copyright © 2017 Sercan Orhangazi. All rights reserved.
//

import UIKit
import CoreData

var deletedGoalIndex : Int32?

class GoalsVC: UIViewController {

    // Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var undoView: UIView!
    
    // Varibles
    var goals = [Goal]()
    var isUndoVisible = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        deleteAll()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isHidden = false

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        isUndoVisible = false
        fetchCoreDataObjects()
        tableView.reloadData()
    }
    
    func fetchCoreDataObjects() {
        self.fetch { (success) in
            if success {
                if goals.count > 0 {
                    tableView.isHidden = false
                } else {
                    tableView.isHidden = true
                }
            }
        }
    }

    @IBAction func addGoalButtonPressed(_ sender: Any) {
        guard let addNewGoalVC = storyboard?.instantiateViewController(withIdentifier: "AddNewGoalVC") else { return }
        presentDetail(addNewGoalVC)
    }
    
    @IBAction func undoButtonPressed(_ sender: Any) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        managedContext.undoManager?.undo()
        fetchCoreDataObjects()
        tableView.reloadData()
        hideUndoBar()
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
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "DELETE") { (rowAction, indexPath) in
            self.removeGoal(atIndexPath: indexPath)
            self.fetchCoreDataObjects()
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
        }
        let addAction = UITableViewRowAction(style: .normal, title: "ADD") { (rowAction, indexPath) in
            self.setProgress(atIndexPath: indexPath)
            tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
        }
        
        deleteAction.backgroundColor  = #colorLiteral(red: 0.5807225108, green: 0.066734083, blue: 0, alpha: 1)
        addAction.backgroundColor = #colorLiteral(red: 0, green: 0.8455702662, blue: 0.3863083124, alpha: 1)
        
        if goals[indexPath.row].goalCompletionValue == goals[indexPath.row].goalProgressValue {
            return [deleteAction]
        } else {
            return [deleteAction, addAction]
        }
    }
}

extension GoalsVC {
    func fetch(completion : (_ complete : Bool) -> ()) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        let fetchRequest = NSFetchRequest<Goal>(entityName: "Goal")
        do {
            goals = try managedContext.fetch(fetchRequest)
            goals = goals.sorted { $0.index < $1.index }
            completion(true)
        } catch {
            debugPrint("Fetch error : \(error.localizedDescription)")
            completion(false)
        }
    }
    
    func removeGoal(atIndexPath indexPath : IndexPath) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        deletedGoalIndex = Int32(indexPath.row)
        managedContext.undoManager = UndoManager()
        managedContext.delete(goals[indexPath.row])
        do {
            try managedContext.save()
            self.showUndoBar()
        } catch {
            debugPrint("Deleting error : \(error.localizedDescription)")
        }
    }
    
    func setProgress(atIndexPath indexPath : IndexPath) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        let selectedGoal = goals[indexPath.row]
        if selectedGoal.goalProgressValue < selectedGoal.goalCompletionValue {
            selectedGoal.goalProgressValue = selectedGoal.goalProgressValue + 1
        } else {
            return
        }
        
        do {
            try managedContext.save()
        } catch {
            debugPrint("Couldn't set progress. \(error.localizedDescription)")
        }
    }
    
    func deleteAll()
    {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Goal")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        do
        {
            try managedContext.execute(deleteRequest)
            try managedContext.save()
        }
        catch
        {
            debugPrint ("Couldn't Deleted : \(error.localizedDescription)")
        }
    }
}

extension GoalsVC {
    func showUndoBar() {
        if isUndoVisible == false {
            let v = self.undoView.frame
            UIView.animate(withDuration: 0.3) {
                self.undoView.frame = CGRect(x: v.origin.x, y: v.origin.y - 50, width: v.width, height: v.height)
                
                self.isUndoVisible = true
            }
        }
    }
    func hideUndoBar() {
        let v = self.undoView.frame
        UIView.animate(withDuration: 0.3) {
            self.undoView.frame = CGRect(x: v.origin.x, y: v.origin.y + 50, width: v.width, height: v.height)
        }
        isUndoVisible = false
    }
}



















