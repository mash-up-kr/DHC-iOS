//
//  FortuneAnalyzingReducer.swift
//  Flifin
//
//  Created by hyerin on 6/17/25.
//

import ComposableArchitecture

@Reducer
struct FortuneAnalyzingReducer {
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
  }

  var body: some Reducer<State, Action> {
    Reduce { state, action in
      switch action {
      }
    }
  }
}
