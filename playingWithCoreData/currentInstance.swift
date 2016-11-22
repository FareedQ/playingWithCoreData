//
//  currentInstance.swift
//  Waiters
//
//  Created by Fareed Quraishi on 2016-11-16.
//  Copyright © 2016 Fareed Quraishi. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class currentInstance {
    static let shared = currentInstance();
    
    private let WaitersModel: NSFetchRequest<Waiter> = Waiter.fetchRequest()
    private let ShiftModel: NSFetchRequest<Shift> = Shift.fetchRequest()
    var ArrayOfWaiters = [Waiter]()
    var ArrayOfShifts = [Shift]()
    private var selectedIndex = Int()
    
    func load(){
        do {
            ArrayOfWaiters = try getContext().fetch(WaitersModel)
        } catch {
            print(error)
        }
    }
    
    func loadShifts(index:Int) {
        selectedIndex = index
        loadShifts()
    }
    
    func delete(index:Int, entity:entities) {
        let context = getContext()
        do{
            switch entity {
            case .Waiter:
                context.delete(ArrayOfWaiters[index])
                try context.save()
                ArrayOfWaiters = try getContext().fetch(WaitersModel)
            case .Shift:
                context.delete(ArrayOfShifts[index])
                try context.save()
                ArrayOfWaiters = try getContext().fetch(WaitersModel)
                loadShifts()
            }
        } catch {
            print(error)
        }
    }
    
    func saveWaiter(name:String){
        save(data: name as AnyObject, entity: .Waiter, key: .Name)
        do {
            self.ArrayOfWaiters = try self.getContext().fetch(self.WaitersModel)
        } catch {
            print(error)
        }
    }
    
    func saveShift(name: String, start: Date, end: Date){
        
        var givenName = name
        if givenName.isEmpty {
            givenName = "Shift "
        }
        
        let context = self.getContext()
        let entity =  NSEntityDescription.entity(forEntityName: entities.Shift.Value(), in: context)
        let transc = NSManagedObject(entity: entity!, insertInto: context)
        transc.setValue(givenName, forKey: keys.Name.Value())
        transc.setValue(start, forKey: keys.Start.Value())
        transc.setValue(end, forKey: keys.End.Value())
        transc.setValue(ArrayOfWaiters[selectedIndex], forKey: keys.HasAWaiter.Value())
        do {
            try context.save()
            loadShifts()
        } catch {
            print(error)
        }
    }
    
    private func loadShifts(){
        ArrayOfShifts = ArrayOfWaiters[selectedIndex].hasShifts?.allObjects as! [Shift]
        orderShifts()
    }
    
    private func orderShifts(){
        ArrayOfShifts.sort { (shift1, shift2) -> Bool in
            if shift1.start?.compare(shift2.start as! Date) == .orderedSame {
                return shift1.end?.compare(shift2.end as! Date) == .orderedAscending
            }
            return shift1.start?.compare(shift2.start as! Date) == .orderedAscending
        }
    }
    
    private func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    
    private func save(data: AnyObject, entity: entities, key:keys) {
        let context = self.getContext()
        
        let entity =  NSEntityDescription.entity(forEntityName: entity.Value(), in: context)
        
        let transc = NSManagedObject(entity: entity!, insertInto: context)
        
        transc.setValue(data, forKey: key.Value())
        
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
}
