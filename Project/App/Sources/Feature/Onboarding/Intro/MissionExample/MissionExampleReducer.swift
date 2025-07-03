//
//  MissionExampleReducer.swift
//  Flifin
//
//  Created by 최혜린 on 6/29/25.
//

import ComposableArchitecture

@Reducer
struct MissionExampleReducer {
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
