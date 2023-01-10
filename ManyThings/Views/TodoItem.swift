//
//  TodoItem.swift
//  ManyThings
//
//  Created by De-Great Yartey on 07/01/2023.
//

import Foundation
import SwiftUI

struct TodoItem: View {
  @Environment(\.managedObjectContext) var context
  
  @ObservedObject var item: Todo
  var dragMode: DragMode = .none
  
  var body: some View {
    VStack(spacing: 0) {
      if self.dragMode == .hoverUpper {
        PlaceIndicator()
      }
      
      HStack {
        Image(systemName: item.done ? "x.square" : "square")
          .fontWeight(.medium)
        
        Text(item.title!)
        Spacer()
      }
      .strikethrough(item.done)
      .frame(maxWidth: .infinity)
      .backgroundOnHover(enabled: dragMode == .none,
                         foregroundColor: item.done ? .secondary : .primary)
      .contextMenu {
        Button(role: .destructive, action: {
          let index = item.index
          context.delete(item)
          Indexer.shiftIndices(context, from: index)
        }) {
          Text("Delete")
        }
        
        if item.category != Category.now.rawValue {
          Button(role: .destructive, action: {
            moveTo(category: .now)
          }) {
            Text("Move to Now")
          }
        }
        
        if item.category != Category.planned.rawValue {
          Button(role: .destructive, action: {
            moveTo(category: .planned)
          }) {
            Text("Move to Planned")
          }
        }
        
        if item.category != Category.ideas.rawValue {
          Button(role: .destructive, action: {
            moveTo(category: .ideas)
          }) {
            Text("Move to Ideas")
          }
        }
      }
      
      if self.dragMode == .hoverLower {
        PlaceIndicator()
      }
    }
    .onTapGesture {
      item.setValue(!item.done, forKey: "done")
      do {
        try context.save()
      } catch {
        //
      }
    }
    
  }
  
  private func moveTo(category: Category) {
    self.item.category = category.rawValue
    do {
      try context.save()
    } catch {
      //
    }
  }
}

struct PlaceIndicator: View {
  
  var body: some View {
    Rectangle()
      .frame(height: 2)
      .frame(maxWidth: .infinity)
      .foregroundColor(.accentColor)
  }
}
