//
//  RootReducer.swift
//  Flifin
//
//  Created by Aiden.lee on 6/8/25.
//

import Foundation

import ComposableArchitecture

@Reducer
struct RootReducer {
  @Reducer
  enum Destination {
    case splash(SplashReducer)
    case onboarding(OnboardingReducer)
    case mainTab(MainTabReducer)
    case selectGender(SelectGenderReducer)
  }

  @ObservableState
  struct State {
    @Presents var destination: Destination.State?
  }

  enum Action {
    case destination(PresentationAction<Destination.Action>)
    case onAppear
  }

  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .destination(.presented(.splash(.delegate(.splashFinished)))):
        state.destination = .onboarding(OnboardingReducer.State())
        return .none
        
      case .destination(.presented(.onboarding(.delegate(.moveToMainTabView)))):
        state.destination = .mainTab(MainTabReducer.State())
        return .none
        
      case .destination(.presented(.onboarding(.delegate(.moveToSelectGenderView)))):
        state.destination = .selectGender(SelectGenderReducer.State())
        return .none

      case .destination(.presented(.mainTab(.myPageTab(.delegate(.moveToOnboarding))))):
        state.destination = .onboarding(OnboardingReducer.State())
        return .none

      case .destination:
        return .none

      case .onAppear:
        state.destination = .splash(SplashReducer.State())
        return .none
      }
    }
    .ifLet(\.$destination, action: \.destination)
  }
}
