//
//  RootReducer.swift
//  ProductName
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
        case .destination(.presented(.onboarding(.nextButtonTapped))):
        state.destination = .mainTab(MainTabReducer.State())
        return .none

      case .destination:
        return .none

      case .onAppear:
        state.destination = .onboarding(OnboardingReducer.State())
        return .none
      }
    }
    .ifLet(\.$destination, action: \.destination)
  }
}
