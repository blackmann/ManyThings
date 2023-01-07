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
  
  @State var category = 0
  @State var entry = ""

    var body: some Scene {
      MenuBarExtra("Many Things", systemImage: "list.bullet.rectangle.portrait.fill") {
        VStack(alignment: .leading) {
          Picker("", selection: $category) {
            Text("Now")
            Text("Planned")
            Text("Ideas")
              
          }
          .pickerStyle(.segmented)
          .labelsHidden()
          
          TextField("What to do", text: $entry)
            .textFieldStyle(.roundedBorder)
          
          ProgressView("Progress 3/10", value: 3, total: 10)
          
          VStack(alignment: .leading, spacing: 0) {
            HStack {
              Image(systemName: "square")
              
              Text("Prepare for next week race")
            }
            .frame(maxWidth: .infinity)
            .backgroundOnHover()
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
            
            
            
            HStack {
              Image(systemName: "square")
              
              Text("Finish the book on computational thinking").frame(maxWidth: .infinity)
            }
            .frame(maxWidth: .infinity)
            .backgroundOnHover()
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
            
            
            
            HStack {
              Image(systemName: "multiply.square")
              
              Text("Call harumi")
              Spacer()
            }
            .frame(maxWidth: .infinity)
                        .foregroundColor(.secondary)
            .strikethrough()
            .backgroundOnHover()
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
          }
          
          Divider()
        }.padding(.all, 8)
      }
      .menuBarExtraStyle(.window)
    }
}
