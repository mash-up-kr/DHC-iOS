//
//  FortuneScoreView.swift
//  Flifin
//
//  Created by 최혜린 on 6/18/25.
//

import SwiftUI

struct FortuneScoreView: View {
  private let date: String?
  private let score: String
  private let summary: String
  private let gradientType: LinearGradient.LinearType
  
  init(
    date: String?,
    score: String,
    summary: String,
    gradientType: LinearGradient.LinearType
  ) {
    self.date = date
    self.score = score
    self.summary = summary
    self.gradientType = gradientType
  }
  
  var body: some View {
    VStack(spacing: 12) {
      if let date {
        BadgeView(
          text: date,
          textColor: ColorResource.Text.Body.primary.color,
          font: Typography.Body.body6
        )
      }
      
      Text(score)
        .textStyle(.h0)
        .foregroundStyle(LinearGradient(gradientType))
      
      Text(summary)
        .textStyle(.body3)
        .foregroundStyle(ColorResource.Neutral._300.color)
        .multilineTextAlignment(.center)
    }
  }
}
