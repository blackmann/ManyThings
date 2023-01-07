//
//  Tabs.swift
//  ManyThings
//
//  Created by De-Great Yartey on 07/01/2023.
//

import Foundation
import SwiftUI

struct Tabs: View {
  
  @Binding var activeTab: String
  
  var body: some View {
    Picker("", selection: $activeTab) {
      Text("Now")
        .tag(Category.now.rawValue)
      
      Text("Planned")
        .tag(Category.planned.rawValue)
      
      Text("Ideas")
        .tag(Category.ideas.rawValue)
    }
    .pickerStyle(.segmented)
    .labelsHidden()
  }
}

struct Tabs_Previews: PreviewProvider {
  static var previews: some View {
    Tabs(activeTab: .constant(Category.ideas.rawValue))
  }
}
