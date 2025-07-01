//
//  FortunePickExampleView.swift
//  Flifin
//
//  Created by hyerin on 6/17/25.
//

import SwiftUI

import ComposableArchitecture

struct FortunePickExampleView: View {
  let store: StoreOf<FortunePickExampleReducer>
  
  init(store: StoreOf<FortunePickExampleReducer>) {
    self.store = store
  }
  
  var body: some View {
    VStack(spacing: 0) {
      IntroTitleView(
        style: .intro,
        title: "먼저 금전운을 하나\n받아볼까요?"
      )
      .padding(.top, 24)
      
      if store.isCardFlipped {
        cardFlippedView
      } else {
        defaultView
      }
    }
    .frame(maxWidth: .infinity)
    .background(ColorResource.Background.main.color)
    .navigationBarBackButtonHidden()
  }
  
  var defaultView: some View {
    VStack(spacing: 86) {
      Text("오늘의 운세 카드를\n뒤집어보세요!")
        .textStyle(.h3)
        .foregroundStyle(ColorResource.Text.Body.primary.color)
        .multilineTextAlignment(.center)
      
      FlippableCard(
        frontContent: {
          FortuneCardView(
            backgroundImageURL: URL(string: "https://img.freepik.com/free-vector/dark-gradient-background-with-copy-space_53876-99548.jpg")!,
            title: "최고의 날",
            fortune: "네잎클로버"
          )
        },
        backContent: {
          FortuneCardView(
            backgroundImageURL: URL(string: "https://img.freepik.com/free-vector/dark-gradient-background-with-copy-space_53876-99548.jpg")!,
            title: "최고의 날",
            fortune: "네잎클로버"
          )
        },
        flipCompletion: {
          store.send(.cardFlipped)
        }
      )
      .rotationEffect(.degrees(-4))
      .radialGradientBackground(
        type: .backgroundGradient01,
        endRadiusMultiplier: 0.4,
        scaleEffectX: 2.5,
        scaleEffectY: 1.6
      )
      .overlay(alignment: .top) {
        OnboardingTooltipView(message: "Click!")
          .padding(.top, -12)
          .padding(.trailing, 10)
      }
    }
    .frame(maxHeight: .infinity)
  }
  
  var cardFlippedView: some View {
    VStack(spacing: 0) {
      FortuneView(
        date: "2025년 5월 20일",
        score: 35,
        summary: "마음이 들뜨는 날이에요,\n한템포 쉬어가요.",
        cardBackgroundImageURL: URL(string: "https://img.freepik.com/free-vector/dark-gradient-background-with-copy-space_53876-99548.jpg")!,
        cardTitle: "최고의 날",
        cardFortune: "네잎클로버",
        needsGradientBackground: true
      )
      .frame(maxHeight: .infinity)
      
      CTAButton(
        size: .extraLarge,
        style: .primary,
        title: "금전운 상세보기",
        action: {
          store.send(.nextButtonTapped)
        }
      )
      .padding(20)
    }
  }
}

#Preview {
  FortunePickExampleView(
    store: Store(
      initialState: .init(),
      reducer: FortunePickExampleReducer.init
    )
  )
}
