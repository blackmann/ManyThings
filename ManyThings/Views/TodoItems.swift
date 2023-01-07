//
//  TodoItems.swift
//  ManyThings
//
//  Created by De-Great Yartey on 07/01/2023.
//

import Foundation
import SwiftUI

struct TodoItems: View {
  @FetchRequest private var items: FetchedResults<Todo>
  
  var category: String
  
  init(category: String) {
    self.category = category
    
    let fetchRequest = Todo.fetchRequest()
    fetchRequest.predicate = NSPredicate(format: "category == %@", category)
    fetchRequest.sortDescriptors = [
      NSSortDescriptor(keyPath: \Todo.done, ascending: true),
      NSSortDescriptor(keyPath: \Todo.createdAt, ascending: false)
    ]
    
    _items = FetchRequest(fetchRequest: fetchRequest, animation: .default.speed(2))
  }
  
  var body: some View {
    VStack(spacing: 0) {
      ForEach(items) {item in
        TodoItem(item: item)
      }
      
      if items.isEmpty {
        Text("You got nothing going for you! 🫡")
      }
    }
  }
}


struct TodoItems_Previews: PreviewProvider {
  static var previews: some View {
    TodoItems(category: Category.ideas.rawValue)
  }
}
