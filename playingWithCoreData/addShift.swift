//
//  addShift.swift
//  playingWithCoreData
//
//  Created by Fareed Quraishi on 2016-11-17.
//  Copyright © 2016 Fareed Quraishi. All rights reserved.
//

import Foundation
import UIKit

class addShift: ViewController, UITextFieldDelegate {
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var start: UIDatePicker!
    @IBOutlet weak var end: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        name.delegate = self
    }
    
    @IBAction func addShift(_ sender: Any) {
        if start.date.compare(end.date) == .orderedDescending || start.date.compare(end.date) == .orderedSame {
            alert(title: "Error", message: "Cannot have a start time equal or after the end time. Please adjust your selection.")
        } else {
            if let givenName = name.text {
                currentInstance.shared.saveShift(name: givenName, start: start.date.withoutSeconds(), end: end.date.withoutSeconds())
                performSegue(withIdentifier: "exit", sender: self)
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    
}
