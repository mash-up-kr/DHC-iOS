//
//  FortunePickExampleReducer.swift
//  Flifin
//
//  Created by hyerin on 6/17/25.
//

import ComposableArchitecture

@Reducer
struct FortunePickExampleReducer {
  init() {}

  @ObservableState
  struct State: Equatable {
    var isCardFlipped: Bool

    init(isCardFlipped: Bool = false) {
      self.isCardFlipped = isCardFlipped
    }
  }

  enum Action {
    // View Action
    case cardFlipped
    case nextButtonTapped
    
    // Internal Action
    
    // Route Action
  }

  var body: some Reducer<State, Action> {
    Reduce { state, action in
      switch action {
        case .cardFlipped:
          state.isCardFlipped = true
          return .none
        
        case .nextButtonTapped:
          return .none
      }
    }
  }
}
