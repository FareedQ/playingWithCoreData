//
//  ViewController.swift
//  Waiters
//
//  Created by Fareed Quraishi on 2016-11-15.
//  Copyright © 2016 Fareed Quraishi. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func addWaiter(_ sender: Any) {
        let alert = UIAlertController(title: "Add Waiter", message: "Enter a waiter's name", preferredStyle: .alert)
        
        alert.addTextField { (textField) in
        }
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
            let textField = alert.textFields![0]
            
            guard !(textField.text?.isEmpty)!,
                let name = textField.text else {
                    self.alert(title: "Error", message: "Please enter a waiter's name to be create a record.")
                    return
            }
            
            currentInstance.shared.saveWaiter(name: name)
            
            self.tableView.reloadData()
            
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (_) in
            //Do Nothing
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "waiterCell", for: indexPath) as? customCell {
            cell.label?.text = currentInstance.shared.ArrayOfWaiters[indexPath.row].name
            cell.accessoryType = .disclosureIndicator
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentInstance.shared.ArrayOfWaiters.count
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        currentInstance.shared.delete(index: indexPath.row, entity: .Waiter)
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentInstance.shared.loadShifts(index: indexPath.row)
        performSegue(withIdentifier: "EditShifts", sender: self)
    }
    
    @IBAction func unwindToMain(segue: UIStoryboardSegue) {
    }
}

