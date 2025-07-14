//
//  FortuneView.swift
//  Flifin
//
//  Created by 최혜린 on 6/18/25.
//

import SwiftUI

struct FortuneView: View {
  private let date: String
  private let date: String?
  private let score: String
  private let summary: String
  private let gradientType: LinearGradient.LinearType
  private let cardBackgroundImageURL: URL?
  private let cardTitle: String
  private let cardFortune: String
  
  init(
    date: String?,
    score: String,
    summary: String,
    gradientType: LinearGradient.LinearType,
    cardBackgroundImageURL: URL?,
    cardTitle: String,
    cardFortune: String
  ) {
    self.date = date
    self.score = score
    self.summary = summary
    self.gradientType = gradientType
    self.cardBackgroundImageURL = cardBackgroundImageURL
    self.cardTitle = cardTitle
    self.cardFortune = cardFortune
  }
  
  var body: some View {
    VStack(spacing: 0) {
      FortuneScoreView(
        date: date,
        score: score,
        summary: summary,
        gradientType: gradientType
      )
      .padding(.bottom, 24)
      
      FortuneCardFrontView(
        backgroundImageURL: cardBackgroundImageURL,
        title: cardTitle,
        fortune: cardFortune
      )
      .padding(.top, 40)
      .padding(.bottom, 12)
      
      ImageResource.fortuneCardShadow.image
        .resizable()
        .frame(height: 32)
    }
  }
}
