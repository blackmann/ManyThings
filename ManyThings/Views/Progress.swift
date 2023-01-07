//
//  Progress.swift
//  ManyThings
//
//  Created by De-Great Yartey on 07/01/2023.
//

import Foundation
import SwiftUI

struct Progress: View {
  
  @FetchRequest private var items: FetchedResults<Todo>
  
  var category: String
  
  init(category: String) {
    self.category = category
    
    let fetchRequest = Todo.fetchRequest()
    fetchRequest.predicate = NSPredicate(format: "category == %@", category)
    fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \Todo.createdAt, ascending: false)]
    
    _items = FetchRequest(fetchRequest: fetchRequest, animation: .default.speed(2))
  }
  
  
  var body: some View {
    let total = getTotal()
    let done = getDone()
    
    let label = total == done ? "All Done": "Progress"
    ProgressView("\(label) \(done)/\(total)", value: Float(done), total: Float(total))
  }

  private func getTotal() -> Int {
    return items.count
  }
  
  private func getDone() -> Int {
    return items.filter {$0.done}.count
  }
}
