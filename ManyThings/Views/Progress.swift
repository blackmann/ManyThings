//
//  Progress.swift
//  ManyThings
//
//  Created by De-Great Yartey on 07/01/2023.
//

import Foundation
import SwiftUI

struct Progress: View {
  
  var body: some View {
    ProgressView("Progress 3/10", value: 3, total: 10)
  }
}
