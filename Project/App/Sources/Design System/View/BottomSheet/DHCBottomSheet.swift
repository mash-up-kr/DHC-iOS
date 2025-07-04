//
//  DHCBottomSheet.swift
//  ProductName
//
//  Created by 김유빈 on 6/16/25.
//

import SwiftUI

extension View {
  func adaptiveBottomSheet(
    isPresented: Binding<Bool>,
    cornerRadius: CGFloat = 32,
    backgroundColor: Color = ColorResource.Neutral._700.color,
    @ViewBuilder content: @escaping () -> some View
  ) -> some View {
    modifier(
      AdaptiveBottomSheetModifier(
        isPresented: isPresented,
        cornerRadius: cornerRadius,
        backgroundColor: backgroundColor,
        content: content
      )
    )
  }

  func measureHeight(_ height: Binding<CGFloat>) -> some View {
    self.modifier(AdaptableHeightModifier(currentHeight: height))
  }
}

private struct AdaptiveBottomSheetModifier<SheetContent: View>: ViewModifier {
  @Binding var isPresented: Bool
  let cornerRadius: CGFloat
  let backgroundColor: Color
  let content: () -> SheetContent

  @State private var contentHeight: CGFloat = 300

  func body(content: Content) -> some View {
    content
      .sheet(isPresented: $isPresented) {
        self.content()
          .measureHeight($contentHeight)
          .presentationDetents([.height(contentHeight)])
          .presentationCornerRadius(cornerRadius)
          .presentationBackground(backgroundColor)
          .presentationDragIndicator(.hidden)
      }
  }
}

struct AdaptableHeightPreferenceKey: PreferenceKey {
  static var defaultValue: CGFloat?

  static func reduce(value: inout CGFloat?, nextValue: () -> CGFloat?) {
    guard let nextValue = nextValue() else { return }
    value = nextValue
  }
}

struct AdaptableHeightModifier: ViewModifier {
  @Binding var currentHeight: CGFloat

  private var sizeView: some View {
    GeometryReader { geometry in
      Color.clear
        .preference(key: AdaptableHeightPreferenceKey.self, value: geometry.size.height)
    }
  }

  func body(content: Content) -> some View {
    content
      .background {
        sizeView
      }
      .onPreferenceChange(AdaptableHeightPreferenceKey.self) { height in
        if let height {
          currentHeight = height
        }
      }
  }
}
