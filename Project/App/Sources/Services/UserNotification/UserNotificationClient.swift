//
//  UserNotificationClient.swift
//  Flifin
//
//  Created by 김유빈 on 6/19/25.
//

import UserNotifications

import ComposableArchitecture

@DependencyClient
struct UserNotificationClient: Sendable {
  var requestAuthorization: () async throws -> Bool
}

extension UserNotificationClient: DependencyKey {
  static var liveValue = UserNotificationClient(
    requestAuthorization: {
      let center = UNUserNotificationCenter.current()

      do {
        let isNotificationAuthorized = try await center.requestAuthorization(
          options: [.alert, .sound]
        )

        return isNotificationAuthorized
      } catch {
        throw error
      }
    }
  )

  static var previewValue: UserNotificationClient {
    UserNotificationClient()
  }

  static var testValue: UserNotificationClient {
    UserNotificationClient()
  }
}

extension DependencyValues {
  var userNotificationClient: UserNotificationClient {
    get { self[UserNotificationClient.self] }
    set { self[UserNotificationClient.self] = newValue }
  }
}
