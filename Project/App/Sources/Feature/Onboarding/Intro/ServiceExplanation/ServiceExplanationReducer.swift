//
//  ServiceExplanationReducer.swift
//  Flifin
//
//  Created by hyerin on 6/17/25.
//

import ComposableArchitecture

@Reducer
struct ServiceExplanationReducer {
  init() {}

  @ObservableState
  struct State: Equatable {
    let introInfoList: [String] = [
      "오늘의 금전운 받기",
      "금전운에 따른 미션 수행",
      "수행한 미션을 토대로 소비습관 분석"
    ]

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
