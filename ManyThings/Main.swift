//
//  App.swift
//  ManyThings
//
//  Created by De-Great Yartey on 07/01/2023.
//

import Foundation
import SwiftUI

struct Main: View {
  @Environment(\.managedObjectContext) private var context
  @AppStorage("activeTab") private var activeTab = Category.now.rawValue
  @State var entry = ""
  
  var body: some View {
    VStack(alignment: .leading) {
      Tabs(activeTab: $activeTab)
      
      TextField("What to do", text: $entry)
        .textFieldStyle(.roundedBorder)
        .onSubmit {
          self.addTodo()
        }
      
      ProgressView("Progress 3/10", value: 3, total: 10)
      
      TodoItems(category: activeTab)
      
      Divider()
    }.padding(.all, 8)
  }
  
  private func addTodo() {
    withAnimation(.easeOut(duration: 0.2)) {
      let todo = Todo(context: context)
      todo.title = self.entry
      todo.category = self.activeTab
      todo.createdAt = Date()
      
      do {
        try context.save()
      } catch {
        //
      }
      
      self.entry = ""
    }
  }
}
