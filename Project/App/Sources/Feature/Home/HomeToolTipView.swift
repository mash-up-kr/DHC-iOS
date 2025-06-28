//
//  HomeToolTipView.swift
//  Flifin
//
//  Created by 김유빈 on 6/29/25.
//

import SwiftUI

struct HomeToolTipView: View {
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
      .padding(10)
      .background(ColorResource.Neutral._500.color)
      .clipShape(RoundedRectangle(cornerRadius: 8))
  }
  
  private var textView: some View {
    Text(message)
      .textStyle(.body5)
      .multilineTextAlignment(.center)
      .foregroundStyle(ColorResource.Text.main.color)
      .padding(.horizontal, 2)
  }
  
  private var bottomArrowView: some View {
    BottomRoundedInvertedTriangle(cornerRadius: 1)
      .fill(ColorResource.Neutral._500.color)
      .frame(width: 12, height: 6)
  }
}

#Preview {
  HomeToolTipView(
    message: "좋은 금융 습관 형성을 위해\n2주간 매일 진행하는 미션이에요!"
  )
}

