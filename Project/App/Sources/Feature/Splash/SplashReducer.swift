//
//  SplashReducer.swift
//  Flifin
//
//  Created by hyerin on 7/2/25.
//

import ComposableArchitecture

@Reducer
struct SplashReducer {
  init() {}

  @ObservableState
  struct State: Equatable {

    init() {
    }
  }

  enum Action {
    // View Action
    
    // Internal Action
    
    // Route Action
    case delegate(Delegate)
    enum Delegate {
      case splashFinished
    }
  }

  var body: some Reducer<State, Action> {
    Reduce { state, action in
      switch action {
      case .delegate:
        return .none
      }
    }
  }
}
