//
//  MissionListReducer.swift
//  Flifin
//
//  Created by 김유빈 on 7/1/25.
//

import ComposableArchitecture

@Reducer
struct MissionListReducer {
  init() {}

  @ObservableState
  struct State: Equatable {
    var isTooltipVisible = false
  }

  enum Action {
    // View Action
    case tooltipTapped

    // Internal Action

    // Route Action
  }

  var body: some Reducer<State, Action> {
    Reduce { state, action in
      switch action {
      case .tooltipTapped:
        state.isTooltipVisible.toggle()
        return .none
      }
    }
  }
}
