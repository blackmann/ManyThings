//
//  View+Extensions.swift
//  ManyThings
//
//  Created by De-Great Yartey on 07/01/2023.
//

import Foundation
import SwiftUI

extension NSTextField {
  open override var focusRingType: NSFocusRingType {
    get { .none }
    set { }
  }
}

// Modified from: https://nilcoalescing.com/blog/ViewModifierForACustomHoverEffectInSwiftUI/
struct BackgroundOnHover: ViewModifier {
  @State private var isHovered = false
  
  func body(content: Content) -> some View {
    content
      .padding(.all, 4)
      .background(isHovered ? .accentColor : Color.clear)
      .clipShape(
        RoundedRectangle(
          cornerRadius: 4,
          style: .continuous
        )
      )
      .onHover { isHovered in
        withAnimation(.easeOut(duration: 0.1)) {
          self.isHovered = isHovered
        }
      }
  }
}

extension View {
  func backgroundOnHover() -> some View {
    self.modifier(BackgroundOnHover())
  }
}
