//
//  ViewHeightKey.swift
//  Flifin
//
//  Created by hyerin on 6/25/25.
//

import SwiftUI

struct ViewHeightKey: PreferenceKey {
  static var defaultValue: CGFloat = .zero
  static func reduce(
    value: inout CGFloat,
    nextValue: () -> CGFloat
  ) {
    value = nextValue()
  }
}

struct ViewHeightGeometry: View {
  var body: some View {
    GeometryReader { geometry in
      Color.clear
        .preference(
          key: ViewHeightKey.self,
          value: geometry.size.height
        )
    }
  }
}
