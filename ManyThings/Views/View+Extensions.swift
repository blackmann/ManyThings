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

// Adapted from: https://nilcoalescing.com/blog/ViewModifierForACustomHoverEffectInSwiftUI/
struct BackgroundOnHover: ViewModifier {
  @State private var isHovered = false
  
  var foregroundColor: Color
  
  func body(content: Content) -> some View {
    content
      .padding(.all, 4)
      .background(isHovered ? .accentColor : Color.clear)
      .foregroundColor(isHovered ? .white : self.foregroundColor)
      .clipShape(
        RoundedRectangle(
          cornerRadius: 6,
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
  func backgroundOnHover(foregroundColor: Color = .primary) -> some View {
    self.modifier(BackgroundOnHover(foregroundColor: foregroundColor))
  }
  
  
  // https://stackoverflow.com/a/57685253/4803261
  @ViewBuilder
  func `if`<Content: View>(_ conditional: Bool, content: (Self) -> Content) -> some View {
    if conditional {
      content(self)
    } else {
      self
    }
  }
}

