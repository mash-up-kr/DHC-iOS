//
//  FortuneView.swift
//  ProductName
//
//  Created by 최혜린 on 6/18/25.
//

import SwiftUI

struct FortuneView: View {
  private let date: String
  private let score: Int
  private let summary: String
  private let cardBackgroundImageURL: URL
  private let cardTitle: String
  private let cardFortune: String
  private let isNeedGradientBackground: Bool
  
  init(
    date: String,
    score: Int,
    summary: String,
    cardBackgroundImageURL: URL,
    cardTitle: String,
    cardFortune: String,
    isNeedGradientBackground: Bool = false
  ) {
    self.date = date
    self.score = score
    self.summary = summary
    self.cardBackgroundImageURL = cardBackgroundImageURL
    self.cardTitle = cardTitle
    self.cardFortune = cardFortune
    self.isNeedGradientBackground = isNeedGradientBackground
  }
  
  var body: some View {
    VStack(spacing: 20) {
      FortuneScoreView(
        date: date,
        score: score,
        summary: summary
      )
      
      FortuneCardView(
        backgroundImageURL: cardBackgroundImageURL,
        title: cardTitle,
        fortune: cardFortune
      )
      .if(isNeedGradientBackground) { cardView in
        cardView.radialGradientBackground(
          color: ColorResource.Text.Highlights.primary.color.opacity(0.6),
          endRadiusMultiplier: 0.4,
          scaleEffectX: 2.2,
          scaleEffectY: 1.6
        )
      }
    }
  }
}

#Preview {
  FortuneView(
    date: "2025년 5월 20일",
    score: 35,
    summary: "마음이 들뜨는 날이에요,\n한템포 쉬어가요.",
    cardBackgroundImageURL: URL(string: "https://img.freepik.com/free-vector/dark-gradient-background-with-copy-space_53876-99548.jpg")!,
    cardTitle: "오늘의 운세 카드",
    cardFortune: "\'한 템포 쉬어가기\'"
  )
}
