//
//  ManyThingsApp.swift
//  ManyThings
//
//  Created by De-Great Yartey on 01/01/2023.
//

import SwiftUI

@main
struct ManyThingsApp: App {
  let persistenceController = PersistenceController.shared
  
  var body: some Scene {
    MenuBarExtra("Many Things", systemImage: "list.bullet.rectangle.portrait.fill") {
      Main()
        .environment(\.managedObjectContext, persistenceController.container.viewContext)
    }
    .menuBarExtraStyle(.window)
  }
}
