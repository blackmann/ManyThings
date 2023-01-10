//
//  Migrator.swift
//  ManyThings
//
//  Created by De-Great Yartey on 10/01/2023.
//

import Foundation
import CoreData

struct Indexer {
  
  /// This code will ever be used once. The first version of ManyThings didn't have indices
  /// for `Todo`s. This sets them up.
  /// TODO: Remove after a number deploys
  static func setIndices(_ context: NSManagedObjectContext) {
    let fetchRequest = Todo.fetchRequest()
    fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \Todo.createdAt, ascending: false)]
        
    context.perform {
      do {
        let items = try fetchRequest.execute()
        
        if let first = items.first, first.index > -1 {
          return
        }
        
        var index: Int32 = 0
        items.forEach { item in
          item.setValue(index, forKey: "index")
          index += 1
        }
        
        try context.save()
      } catch {
        //
      }
    }
  }
  
  /// Call this when an item is removed. Shifts all items below up.
  static func shiftIndices(_ context: NSManagedObjectContext, from: Int32) {
    if from < 0 {
      return
    }
    
    let fetchRequest = Todo.fetchRequest()
    fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \Todo.index, ascending: true)]
    fetchRequest.predicate = NSPredicate(format: "index > %i", from)
    
    context.perform {
      do {
        let items = try fetchRequest.execute()
        items.forEach { item in
          item.index = item.index - 1
        }
        
        try context.save()
      } catch {
        //
      }
    }
  }
}
