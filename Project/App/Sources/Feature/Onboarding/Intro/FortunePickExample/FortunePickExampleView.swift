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
      .padding(.bottom, 44)
      
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
    FortuneView(
      date: nil,
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
              backgroundImageURL: .urlForResource(.fortuneCardFrontDefaultView),
              title: "최고의 날",
              fortune: "네잎클로버"
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
  }
  
  var cardFlippedView: some View {
    VStack(spacing: 0) {
      FortuneView(
        date: nil,
        score: "85점",
        summary: "오늘 도착한 금전운이에요.\n함께 확인해볼까요?",
        gradientType: .text02,
        cardView: {
          FortuneCardFrontView(
            backgroundImageURL: .urlForResource(.fortuneCardFrontDefaultView),
            title: "최고의 날",
            fortune: "네잎클로버"
          )
        }
      )
      
      Spacer()
      
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
