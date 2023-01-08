//
//  PreferencesButton.swift
//  ManyThings
//
//  Created by De-Great Yartey on 08/01/2023.
//

import Foundation
import SwiftUI

struct PreferencesButton: View {
  
  var body: some View {
    // TODO: DRY this
    Button(action: {
      NSApp.sendAction(Selector(("showSettingsWindow:")), to: nil, from: nil)
      NSApp.activate(ignoringOtherApps: true)
    }) {
      HStack {
        Label("Preferences…", systemImage: "gear")
        Spacer()
      }
    }
    .keyboardShortcut(",")
    .buttonStyle(.plain)
  }
}
