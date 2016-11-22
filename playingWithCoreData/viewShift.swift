//
//  editShift.swift
//  Waiters
//
//  Created by Fareed Quraishi on 2016-11-15.
//  Copyright © 2016 Fareed Quraishi. All rights reserved.
//

import UIKit
import CoreData

class viewShift: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return currentInstance.shared.ArrayOfShifts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "shiftCell", for: indexPath) as? customCell {
            guard let name = currentInstance.shared.ArrayOfShifts[indexPath.row].name, let start = currentInstance.shared.ArrayOfShifts[indexPath.row].start as? Date,
                let end = currentInstance.shared.ArrayOfShifts[indexPath.row].end as? Date else {
                    return UITableViewCell()
            }
            cell.textLabel?.text = "\(name): " + start.toString() + " - " + end.toString()
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        currentInstance.shared.delete(index: indexPath.row, entity: .Shift)
        if currentInstance.shared.ArrayOfShifts.count == 0 {
            performSegue(withIdentifier: "exit", sender: self)
        }
        tableView.reloadData()
    }
    
    @IBAction func unwindToViewShift(segue: UIStoryboardSegue) {
    }

}
