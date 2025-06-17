//
//  FortuneScoreView.swift
//  ProductName
//
//  Created by 최혜린 on 6/18/25.
//

import SwiftUI

struct FortuneScoreView: View {
  private let date: String
  private let score: Int
  private let summary: String
  
  init(
    date: String,
    score: Int,
    summary: String
  ) {
    self.date = date
    self.score = score
    self.summary = summary
  }
  
  var body: some View {
    VStack(spacing: 12) {
      BadgeView(
        text: date,
        textColor: ColorResource.Text.Body.primary.color,
        font: Typography.Body.body6
      )
      
      Text("\(score)점")
        .textStyle(.h0)
        .foregroundStyle(LinearGradient(.text02))
      
      Text(summary)
        .textStyle(.body3)
        .foregroundStyle(ColorResource.Neutral._300.color)
        .multilineTextAlignment(.center)
    }
  }
}

#Preview {
  FortuneScoreView(
    date: "2025년 5월 20일",
    score: 35,
    summary: "마음이 들뜨는 날이에요,\n한템포 쉬어가요."
  )
}
