//
//  OnboardingReducer.swift
//  ProductName
//
//  Created by hyerin on 6/17/25.
//

import ComposableArchitecture

@Reducer
struct OnboardingReducer {
  init() {}

  @ObservableState
  struct State: Equatable {

    init() {
    }
  }

  enum Action {
    // View Action
    case nextButtonTapped
    
    // Internal Action
    
    // Route Action
  }

  var body: some Reducer<State, Action> {
    Reduce { state, action in
      switch action {
        case .nextButtonTapped:
          return .none
      }
    }
  }
}
