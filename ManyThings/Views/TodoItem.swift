//
//  TodoItem.swift
//  ManyThings
//
//  Created by De-Great Yartey on 07/01/2023.
//

import Foundation
import SwiftUI

struct TodoItem: View {
  @Environment(\.managedObjectContext) var context
  
  @ObservedObject var item: Todo
  
  var body: some View {
    HStack {
      Image(systemName: item.done ? "x.square" : "square")
        .fontWeight(.medium)
      
      Text(item.title!)
      Spacer()
    }
    .strikethrough(item.done)
    .frame(maxWidth: .infinity)
    .backgroundOnHover(foregroundColor: item.done ? .secondary : .primary)
    .contextMenu {
      Button(role: .destructive, action: {}) {
        Text("Delete")
      }
      
      Button(role: .destructive, action: {}) {
        Text("Move to Planned")
      }
      
      Button(role: .destructive, action: {}) {
        Text("Move to ideas")
      }
    }
    .onTapGesture {
      item.setValue(!item.done, forKey: "done")
      do {
        try context.save()
      } catch {
        //
      }
    }

  }
}

struct TodoItem_Previews: PreviewProvider {
  
  struct TodoItemDemo: View {
    
    var body: some View {
      List {
        
      }
    }
  }
  
  static var previews: some View {
    TodoItemDemo()
      .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
  }
}
