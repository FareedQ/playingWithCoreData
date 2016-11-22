//
//  extensions.swift
//  Waiters
//
//  Created by Fareed Quraishi on 2016-11-16.
//  Copyright © 2016 Fareed Quraishi. All rights reserved.
//

import Foundation
import CoreData
import UIKit

enum dataTypes {
    case String, Date
}

enum entities {
    case Waiter, Shift
    
    func Value() -> String {
        switch self {
        case .Waiter:
            return "Waiter"
        case .Shift:
            return "Shift"
        }
    }
}

enum keys {
    case Name, Start, End, HasAWaiter
    
    func Value() -> String {
        switch self {
        case .Name:
            return "name"
        case .Start:
            return "start"
        case .End:
            return "end"
        case .HasAWaiter:
            return "hasAWaiter"
        }
    }
}
