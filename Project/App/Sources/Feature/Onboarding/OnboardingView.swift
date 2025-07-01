//
//  OnboardingView.swift
//  Flifin
//
//  Created by hyerin on 6/17/25.
//

import SwiftUI

import ComposableArchitecture

struct OnboardingView: View {
  @Bindable var store: StoreOf<OnboardingReducer>
  
  init(store: StoreOf<OnboardingReducer>) {
    self.store = store
  }
  
  var body: some View {
    NavigationStack(
      path: $store.scope(state: \.path, action: \.path)
    ) {
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
          title: "다음",
          action: {
            store.send(.nextButtonTapped)
          }
        )
        .padding(20)
      }
      .background {
        VStack(spacing: 0) {
          Spacer()
          LoopingVideoPlayer(videoURL: Bundle.main.url(forResource: "onboardingVideo", withExtension: "mp4")!)
            .ignoresSafeArea()
            .disabled(true)
            .scaledToFill()
        }
      }
    } destination: { store in
      switch store.case {
      case .serviceExplanation(let store):
        ServiceExplanationView(store: store)
      case .fortunePickExample(let store):
        FortunePickExampleView(store: store)
      case .fortuneDetail(let store):
        FortuneDetailView(store: store)
      case .missionExample(let store):
        MissionExampleView(store: store)
      }
    }
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
