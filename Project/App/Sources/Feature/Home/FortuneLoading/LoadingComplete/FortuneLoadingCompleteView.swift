//
//  FortuneLoadingCompleteView.swift
//  Flifin
//
//  Created by 최혜린 on 7/2/25.
//

import SwiftUI

import ComposableArchitecture

struct FortuneLoadingCompleteView: View {
  let store: StoreOf<FortuneLoadingCompleteReducer>
  
  init(store: StoreOf<FortuneLoadingCompleteReducer>) {
    self.store = store
  }
  
  var body: some View {
    VStack(spacing: 0) {
      if store.isCardFlipped {
        cardFlippedView
      } else {
        defaultView
      }
    }
    .frame(maxWidth: .infinity)
    .radialGradientBackground(
      type: .backgroundGradient02,
      endRadiusMultiplier: 1.2,
      scaleEffectX: 1.8
    )
    .background(ColorResource.Background.main.color)
  }
  
  var defaultView: some View {
    FortuneView(
      date: store.scoreInfo.date,
      score: "?점",
      summary: "운세 카드를 뒤집고\n오늘의 금전운을 확인해보세요",
      gradientType: .text02,
      cardView: {
        FlippableCard(
          frontContent: {
            FortuneCardBackView(backgroundImageURL: .urlForResource(.fortuneCardBackView))
          },
          backContent: {
            FortuneCardFrontView(
              backgroundImageURL: store.cardInfo.backgroundImageURL,
              title: store.cardInfo.title,
              fortune: store.cardInfo.fortune
            )
          },
          flipCompletion: {
            _ = withAnimation {
              store.send(.cardFlipped)
            }
          }
        )
        .rotationEffect(.degrees(-4))
        .padding(.top, 20)
        .overlay(alignment: .top) {
          OnboardingTooltipView(message: "Flip!")
            .padding(.trailing, 10)
            .padding(.top, -40)
        }
      }
    )
    .frame(maxHeight: .infinity, alignment: .top)
    .padding(.top, 64)
  }
  
  var cardFlippedView: some View {
    FortuneView(
      date: store.scoreInfo.date,
      score: store.scoreInfo.scoreString,
      summary: store.scoreInfo.summary,
      gradientType: FortuneScore(score: store.scoreInfo.score).textGradient,
      cardView: {
        FortuneCardFrontView(
          backgroundImageURL: store.cardInfo.backgroundImageURL,
          title: store.cardInfo.title,
          fortune: store.cardInfo.fortune
        )
      }
    )
    .frame(maxHeight: .infinity, alignment: .top)
    .padding(.top, 64)
  }
}
