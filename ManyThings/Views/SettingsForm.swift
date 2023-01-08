//
//  SettingsForm.swift
//  ManyThings
//
//  Created by De-Great Yartey on 08/01/2023.
//

import Foundation
import SwiftUI
import LaunchAtLogin

struct SettingsForm: View {
  
  @AppStorage("menubar") var showInMenuBar = false
  
  var body: some View {
    TabView {
      Form {
        LaunchAtLogin.Toggle()
        
        Section {
          Toggle("Current item in menubar", isOn: $showInMenuBar)
        } footer: {
          Text("This will display the topmost undone 'now' item in the menu bar.")
            .foregroundColor(.secondary)
        }
      }.tabItem {
        Label("General", systemImage: "gear")
      }
    }
    .padding()
  }
}
