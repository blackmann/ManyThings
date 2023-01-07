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
  
  @AppStorage("activeTab") var activeTab = "now"
  @State var entry = ""

    var body: some Scene {
      MenuBarExtra("Many Things", systemImage: "list.bullet.rectangle.portrait.fill") {
        VStack(alignment: .leading) {
          Picker("", selection: $activeTab) {
            Text("Now")
              .tag("now")
            
            Text("Planned")
              .tag("planned")
            
            Text("Ideas")
              .tag("ideas")
          }
          .pickerStyle(.segmented)
          .labelsHidden()
          
          TextField("What to do", text: $entry)
            .textFieldStyle(.roundedBorder)
          
          ProgressView("Progress 3/10", value: 3, total: 10)
          
          VStack(alignment: .leading, spacing: 0) {
            
            
          }
          
          Divider()
        }.padding(.all, 8)
      }
      .menuBarExtraStyle(.window)
    }
}
