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
          title: "매일 카드를 넘기면,\n오늘의 금전운을 볼 수 있어요.",
          description: "금전운에 따라 당신만의 절약 미션이 도착해요."
        )
        .padding(.top, 24)
        
        Spacer()
        
        onboardingCTAButton
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
  
  private var onboardingCTAButton: some View {
    Button(
      action: {
        store.send(.nextButtonTapped)
      },
      label: {
        Text("다음")
          .textStyle(Typography.Head.h5)
          .foregroundStyle(ColorResource.Text.main.color)
          .padding(.vertical, 15)
          .frame(maxWidth: .infinity)
          .background {
            RoundedRectangle(cornerRadius: 8)
              .foregroundStyle(ColorResource.Neutral._700.color)
          }
      }
    )
    .padding(20)
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
