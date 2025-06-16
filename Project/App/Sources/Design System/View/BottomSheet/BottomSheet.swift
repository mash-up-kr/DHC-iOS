//
//  BottomSheet.swift
//  ProductName
//
//  Created by 김유빈 on 6/16/25.
//

import SwiftUI

enum Detents {
  case oneButton
  case twoButtons

  var height: CGFloat {
    switch self {
    case .oneButton:
      return 256
    case .twoButtons:
      return 264
    }
  }
}

extension View {
  @ViewBuilder
  func bottomSheet(
    isPresented: Binding<Bool>,
    detent: Detents,
    sheetCornerRadius: CGFloat = 32,
    @ViewBuilder content: @escaping () -> some View
  ) -> some View {
    self
      .sheet(isPresented: isPresented) {} content: {
        content()
          .presentationDetents([.height(detent.height)])
          .presentationCornerRadius(sheetCornerRadius)
          .presentationBackground(ColorResource.Neutral._700.color)
      }
  }
}
