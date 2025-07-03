//
//  FortuneView.swift
//  Flifin
//
//  Created by 최혜린 on 6/18/25.
//

import SwiftUI

struct FortuneView: View {
  private let date: String
  private let score: Int
  private let summary: String
  private let gradientType: LinearGradient.LinearType
  private let cardBackgroundImageURL: URL?
  private let cardTitle: String
  private let cardFortune: String
  private let needsGradientBackground: Bool
  
  init(
    date: String,
    score: Int,
    summary: String,
    gradientType: LinearGradient.LinearType,
    cardBackgroundImageURL: URL?,
    cardTitle: String,
    cardFortune: String,
    needsGradientBackground: Bool = false
  ) {
    self.date = date
    self.score = score
    self.summary = summary
    self.gradientType = gradientType
    self.cardBackgroundImageURL = cardBackgroundImageURL
    self.cardTitle = cardTitle
    self.cardFortune = cardFortune
    self.needsGradientBackground = needsGradientBackground
  }
  
  var body: some View {
    VStack(spacing: 20) {
      FortuneScoreView(
        date: date,
        score: score,
        summary: summary,
        gradientType: gradientType
      )
      
      FortuneCardFrontView(
        backgroundImageURL: cardBackgroundImageURL,
        title: cardTitle,
        fortune: cardFortune
      )
      .if(needsGradientBackground) { cardView in
        cardView
          .radialGradientBackground(
            type: .backgroundGradient01,
            endRadiusMultiplier: 0.4,
            scaleEffectX: 2.5,
            scaleEffectY: 1.6
          )
      }
      .padding(.bottom, 20)
    }
  }
}
