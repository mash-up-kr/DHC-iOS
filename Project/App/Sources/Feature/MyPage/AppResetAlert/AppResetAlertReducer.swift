//
//  AppResetAlertReducer.swift
//  Flifin
//
//  Created by Aiden.lee on 6/29/25.
//

import ComposableArchitecture

@Reducer
struct AppResetAlertReducer {
  @Dependency(\.userManager) var userManager
  @Dependency(\.deviceIDManager) var deviceIDManager
  @Dependency(\.myPageClient) var myPageClient

  init() {}

  @ObservableState
  struct State: Equatable {
  }

  enum Action {
    // View Action
    case confirmButtonTapped
    case cancelButtonTapped

    // Route Action
    case delegate(Delegate)
    enum Delegate {
      case cancel
      case resetCompleted
    }
  }

  var body: some Reducer<State, Action> {
    Reduce { state, action in
      switch action {
      case .confirmButtonTapped:
        return .run { send in
          try await myPageClient.resetApp()
          userManager.deleteUserID()
          try? deviceIDManager.deleteDeviceID()
          await send(.delegate(.resetCompleted))
        }
      case .cancelButtonTapped:
        return .send(.delegate(.cancel))
      case .delegate:
        return .none
      }
    }
  }
}
