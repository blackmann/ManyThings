//
//  Footer.swift
//  ManyThings
//
//  Created by De-Great Yartey on 07/01/2023.
//

import Foundation
import SwiftUI

struct Footer: View {
  
  var body: some View {
    VStack(alignment: .leading, spacing: 0) {
      Text("© ManyThings 2023")
      Text(try! AttributedString(markdown: "All rights reserved. Issue or ideas, tweet [@_yogr](https://twitter.com/_yogr)."))
    }
    .foregroundColor(.secondary.opacity(0.7))
  }
}
