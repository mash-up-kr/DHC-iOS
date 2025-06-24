//
//  OnboardingView.swift
//  Flifin
//
//  Created by hyerin on 6/17/25.
//

import SwiftUI

import ComposableArchitecture

struct OnboardingView: View {
  let store: StoreOf<OnboardingReducer>
  
  init(store: StoreOf<OnboardingReducer>) {
    self.store = store
  }
  
  var body: some View {
    VStack(spacing: 0) {
      IntroTitleView(
        style: .intro,
        title: "매일매일 금전운 미션을 통해\n소비습관을 개선해보세요",
        description: "매일매일 금전운 미션을 통해\n소비습관을 개선해보세요"
      )
      .padding(.top, 24)
      
      Spacer()
      
      CTAButton(
        size: .extraLarge,
        style: .secondary,
        title: "금전운 확인하고 시작하기",
        action: {
          store.send(.nextButtonTapped)
        }
      )
      .padding(20)
    }
    .background(ColorResource.Background.main.color)
  }
}

#Preview {
  OnboardingView(
    store: Store(
      initialState: .init(),
      reducer: OnboardingReducer.init
    )
  )
}
