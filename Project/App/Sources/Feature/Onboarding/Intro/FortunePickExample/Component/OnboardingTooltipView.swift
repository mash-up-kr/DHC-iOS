//
//  OnboardingTooltipVIew.swift
//  Flifin
//
//  Created by hyerin on 6/20/25.
//

import SwiftUI

struct OnboardingTooltipView: View {
  private let message: String
  
  init(message: String) {
    self.message = message
  }
  
  var body: some View {
    VStack(spacing: 0) {
      contentView
      bottomArrowView
    }
  }
  
  private var contentView: some View {
    textView
      .padding(.vertical, 10)
      .padding(.leading, 10)
      .padding(.trailing, 12)
      .background(LinearGradient(.tooltip01))
      .clipShape(RoundedRectangle(cornerRadius: 8))
  }
  
  private var textView: some View {
    Text(message)
      .textStyle(.h7)
      .foregroundStyle(ColorResource.Text.Highlights.primary.color)
      .padding(.horizontal, 2)
  }
  
  private var bottomArrowView: some View {
    BottomRoundedInvertedTriangle(cornerRadius: 1)
      .fill(
        LinearGradient(
          .tooltip01,
          startPoint: .bottom,
          endPoint: .top
        )
      )
      .frame(width: 12, height: 6)
  }
}
