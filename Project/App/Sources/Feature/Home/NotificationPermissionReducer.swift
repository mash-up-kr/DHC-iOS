//
//  NotificationPermissionReducer.swift
//  ProductName
//
//  Created by 김유빈 on 6/17/25.
//

import UserNotifications

import ComposableArchitecture

@Reducer
struct NotificationPermissionReducer {
  @Dependency(\.userNotificationClient) var userNotificationClient

  @ObservableState
  struct State: Equatable {
    var isNotificationAuthorized: Bool?
  }

  enum Action {
    case allowButtonTapped
    case authorizationResponse(Bool)
    case authorizationFailed(Error)
  }

  var body: some Reducer<State, Action> {
    Reduce { state, action in
      switch action {
      case .allowButtonTapped:
        return .run { send in
          do {
            let isNotificationAuthorized = try await userNotificationClient.requestAuthorization()

            await send(.authorizationResponse(isNotificationAuthorized))
          } catch {
            await send(.authorizationFailed(error))
          }
        }

      case .authorizationResponse(let isNotificationAuthorized):
        state.isNotificationAuthorized = isNotificationAuthorized
        return .none

      case .authorizationFailed(let error):
        #if DEBUG
        print("Push Notification Authorization failed with error: \(error)")
        #endif
        return .none
      }
    }
  }
}
