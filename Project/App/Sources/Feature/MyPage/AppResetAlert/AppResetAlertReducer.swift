//
//  AppResetAlertReducer.swift
//  Flifin
//
//  Created by Aiden.lee on 6/29/25.
//

import ComposableArchitecture

@Reducer
struct AppResetAlertReducer {
  init() {}

  @ObservableState
  struct State: Equatable {
  }

  enum Action {
    // View Action
    case confirmButtonTapped
    case cancelButtonTapped

    // Internal Action

    // Route Action
  }

  var body: some Reducer<State, Action> {
    Reduce { state, action in
      switch action {
      case .confirmButtonTapped:
        print("초기화 버튼 탭")
        return .none
      case .cancelButtonTapped:
        print("취소 버튼 탭")
        return .none
      }
    }
  }
}
