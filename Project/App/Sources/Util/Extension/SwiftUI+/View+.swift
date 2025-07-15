//
//  View+.swift
//  Flifin
//
//  Created by hyerin on 6/20/25.
//

import SwiftUI

extension View {
  @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
    if condition {
      transform(self)
    } else {
      self
    }
  }
}

extension View {
  func plainListRow() -> some View {
    self
      .listRowSeparator(.hidden)
      .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
      .listRowBackground(ColorResource.Background.main.color)
  }

  func plainListBackground() -> some View {
    self
      .listStyle(.plain)
      .scrollContentBackground(.hidden)
  }
}
