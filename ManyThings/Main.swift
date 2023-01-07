//
//  App.swift
//  ManyThings
//
//  Created by De-Great Yartey on 07/01/2023.
//

import Foundation
import SwiftUI
import LaunchAtLogin

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
      
      Progress(category: activeTab)
      
      TodoItems(category: activeTab)
      
      Divider()
      
      CloseButton()
        .backgroundOnHover()
      
      Divider()
      
      Footer()
    }
    .padding(.all, 8)
    .onAppear {
      LaunchAtLogin.isEnabled = true
    }
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
