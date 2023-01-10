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
  @Environment(\.managedObjectContext) var context
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
                                             first: item == items.first,
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
    guard valid, let hover = self.hover, let dragging = self.dragging else {
      self.resetDrag()
      return
    }
    
    let fetchRequest = Todo.fetchRequest()
    fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \Todo.index, ascending: true)]
    
    // only the topmost item can have .hoverUpper, so there an extra shift down
    // because the top item moved down
    let extraMove: Int32 = hover.position == .hoverUpper ? 1 : 0
    context.perform {
      do {
        let todos = try fetchRequest.execute()
        todos.forEach { item in
          item.index = item.index + extraMove
          // move anything below `dragging` up, to fill up its space
           if item.index > dragging.index {
            item.index = item.index - 1
           }
          
          // move everything below the placeholder down one level to make space
          // for `dragging` to be inserted
           if item.index > hover.item.index {
            item.index = item.index + 1
           }
        }
        
        // `extraMove * 2`, why? because `dragging` needs to move down first if
        // the first item dropped down.
        // ie, if extraMove == 1, extraMove += 1
        // if extraMove == 0 (no moving down)
        dragging.index = hover.item.index + 1 - (extraMove * 2)
        
        try context.save()
      } catch {
        //
        print(error)
      }
    }
    
    self.resetDrag()
  }
  
  private func resetDrag() {
    self.hover = nil
    self.dragging = nil
  }
}

struct TodoDropDelegate: DropDelegate {
  var todo: Todo
  var first: Bool
  @Binding var dragging: Todo?
  @Binding var hover: Hover?
  var onDrop: (Bool) -> ()
  
  
  func dropExited(info: DropInfo) {
    self.hover = nil
  }
  
  func dropUpdated(info: DropInfo) -> DropProposal? {
    // the height of a row is around 30 units, so I'm hardcoding to upper region as 10
    // also, you can only place above the first item
    if (first && info.location.y <= 10) {
      self.hover = Hover(item: self.todo, position: .hoverUpper)
    } else if (info.location.y > 10) {
      self.hover = Hover(item: self.todo, position: .hoverLower)
    }
    
    return DropProposal(operation: .move)
  }
  
  
  func performDrop(info: DropInfo) -> Bool {
    guard let dragging = self.dragging, dragging != todo, !dragging.done else {
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
