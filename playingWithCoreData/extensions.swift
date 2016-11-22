//
//  extensions.swift
//  playingWithCoreData
//
//  Created by Fareed Quraishi on 2016-11-17.
//  Copyright © 2016 Fareed Quraishi. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func alert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) {
            (a:UIAlertAction) -> Void in
        }
        alert.addAction(action)
        self.present(alert, animated: true) { }
    }
}

extension Date {
    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "hh:mm", options: 0, locale: Locale(identifier: "en-GB"))
        let dateString = dateFormatter.string(from: self)
        return dateString
    }
    
    func withoutSeconds() -> Date {
        let timeInterval = floor(self.timeIntervalSinceReferenceDate / 60.0) * 60.0
        return Date(timeIntervalSinceReferenceDate: timeInterval)
    }
}

