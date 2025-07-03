//
//  FortuneCardFrontView.swift
//  Flifin
//
//  Created by 최혜린 on 7/1/25.
//

import SwiftUI

struct FortuneCardFrontView: View {
  private let backgroundImageURL: URL?
  private let title: String
  private let fortune: String
  
  init(
    backgroundImageURL: URL?,
    title: String,
    fortune: String
  ) {
    self.backgroundImageURL = backgroundImageURL
    self.title = title
    self.fortune = fortune
  }
  
  var body: some View {
    FortuneCardView(backgroundImageURL: backgroundImageURL)
    .overlay {
      RoundedRectangle(cornerRadius: 12)
        .strokeBorder(LinearGradient(.cardBorder))
    }
    .overlay(alignment: .top) {
      VStack(spacing: 0) {
        Text(title)
          .textStyle(.h8)
          .foregroundStyle(LinearGradient(.text02))
        
        Text(fortune)
          .textStyle(.h6)
          .foregroundStyle(ColorResource.Text.Body.primary.color)
      }
      .padding(.top, 20)
    }
  }
}
