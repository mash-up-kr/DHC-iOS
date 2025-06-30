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
      case .destination(.presented(.onboarding(.delegate(.moveToMainTabView)))):
        state.destination = .mainTab(MainTabReducer.State())
        return .none
        
      case .destination(.presented(.onboarding(.delegate(.moveToSelectGenderView)))):
        state.destination = .selectGender(SelectGenderReducer.State())
        return .none

      case .destination:
        return .none

      case .onAppear:
        // TODO: 온보딩으로 갈지 메인탭으로 갈지 확인 후 이동해야함
        state.destination = .onboarding(OnboardingReducer.State())
        return .none
      }
    }
    .ifLet(\.$destination, action: \.destination)
  }
}
