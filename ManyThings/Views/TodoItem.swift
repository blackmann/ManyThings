//
//  TodoItem.swift
//  ManyThings
//
//  Created by De-Great Yartey on 07/01/2023.
//

import Foundation
import SwiftUI

struct TodoItem: View {
  var body: some View {
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
}
