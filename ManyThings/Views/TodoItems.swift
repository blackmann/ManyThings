//
//  TodoItems.swift
//  ManyThings
//
//  Created by De-Great Yartey on 07/01/2023.
//

import Foundation
import SwiftUI

struct Hover {
  var item: Todo
  var position: DragMode // simply reusing
}

struct TodoItems: View {
  
  @FetchRequest private var items: FetchedResults<Todo>
  
  @State private var dragging: Todo? = nil
  @State private var hover: Hover? = nil
  
  var category: String
  
  init(category: String) {
    self.category = category
    
    let fetchRequest = Todo.fetchRequest()
    fetchRequest.predicate = NSPredicate(format: "category == %@", category)
    fetchRequest.sortDescriptors = [
      NSSortDescriptor(keyPath: \Todo.done, ascending: true),
      NSSortDescriptor(keyPath: \Todo.index, ascending: true)
    ]
    
    _items = FetchRequest(fetchRequest: fetchRequest, animation: .default.speed(2))
  }
  
  var body: some View {
    VStack(spacing: 0) {
      ForEach(items) {item in
        TodoItem(item: item, dragMode: self.getDragMode(item: item))
          .onDrag {
            self.dragging = item
            return NSItemProvider(object: item.id.debugDescription as NSString)
          }
          .onDrop(of: [.text],
                  delegate: TodoDropDelegate(todo: item,
                                             dragging: self.$dragging,
                                             hover: self.$hover) { completeDrop(valid: $0) })
      }
      
      if items.isEmpty {
        Text("You got nothing going for you! 🫡")
      }
    }
  }
  
  private func getDragMode(item: Todo) -> DragMode {
    guard let dragging = self.dragging else {
      return .none
    }
    
    if dragging.id == item.id {
      return .active
    }
    
    guard let hover = self.hover, hover.item == item else {
      return .none
    }
    
    return hover.position
  }
  
  private func completeDrop(valid: Bool) {
    guard let hover = self.hover, let dragging = self.dragging else {
      return
    }
    
    if valid {
      // if
    }
    
    self.hover = nil
    self.dragging = nil
  }
}

struct TodoDropDelegate: DropDelegate {
  var todo: Todo
  @Binding var dragging: Todo?
  @Binding var hover: Hover?
  var onDrop: (Bool) -> ()
  
  
  func dropExited(info: DropInfo) {
    self.hover = nil
  }
  
  func dropUpdated(info: DropInfo) -> DropProposal? {
    // the height of a row is around 30 units, so I'm hardcoding to upper region as 10
    if (info.location.y <= 10) {
      self.hover = Hover(item: self.todo, position: .hoverUpper)
    } else {
      self.hover = Hover(item: self.todo, position: .hoverLower)
    }
    
    return DropProposal(operation: .move)
  }
  
  
  func performDrop(info: DropInfo) -> Bool {
    guard let dragging = self.dragging, dragging != todo else {
      self.onDrop(false)
      return false
    }
    
    self.onDrop(true)
    return true
  }
}


struct TodoItems_Previews: PreviewProvider {
  static var previews: some View {
    TodoItems(category: Category.ideas.rawValue)
  }
}
