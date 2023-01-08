//
//  ManyThingsApp.swift
//  ManyThings
//
//  Created by De-Great Yartey on 01/01/2023.
//

import SwiftUI

@main
struct ManyThingsApp: App {
  private let persistenceController = PersistenceController.shared
  @State private  var currentTodo = ""
  
  @AppStorage("menubar") var showInMenuBar = false
  
  var body: some Scene {
    Settings {
      SettingsForm()
    }
    
    MenuBarExtra("ManyThings",
                 systemImage: "list.bullet.rectangle.portrait.fill",
                 isInserted: .constant(!showInMenuBar)) {
      Main(currentItem: $currentTodo)
        .environment(\.managedObjectContext, persistenceController.container.viewContext)
    }
    .menuBarExtraStyle(.window)
    
    MenuBarExtra("ManyThings", isInserted: .constant(showInMenuBar)) {
      Main(currentItem: $currentTodo)
        .environment(\.managedObjectContext, persistenceController.container.viewContext)
    }
    .menuBarExtraStyle(.window)
  }
}
