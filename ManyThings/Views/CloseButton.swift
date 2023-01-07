//
//  CloseButton.swift
//  ManyThings
//
//  Created by De-Great Yartey on 07/01/2023.
//

import Foundation
import SwiftUI

struct CloseButton: View {
  
  var body: some View {
    Button(action: {
      NSApplication.shared.terminate(nil)
    }) {
      HStack {
        Label("Quit ManyThings", systemImage: "xmark")
        Spacer()
      }
    }
    .keyboardShortcut("Q")
    .buttonStyle(.plain)
  }
}
