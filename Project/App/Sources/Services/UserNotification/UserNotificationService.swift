//
//  UserNotificationService.swift
//  ProductName
//
//  Created by 김유빈 on 6/19/25.
//

import UserNotifications

import ComposableArchitecture

@DependencyClient
struct UserNotificationService: Sendable {
  var requestAuthorization: () async throws -> Bool
}

extension UserNotificationService: DependencyKey {
  static var liveValue = UserNotificationService(
    requestAuthorization: {
      let center = UNUserNotificationCenter.current()

      do {
        let isNotificationAuthorized = try await center.requestAuthorization(options: [.alert, .sound])

        if !isNotificationAuthorized {
          throw UserNotificationError.authorizationDenied
        }

        return isNotificationAuthorized
      } catch {
        throw UserNotificationError.unknownError(error)
      }
    }
  )

  static var previewValue: UserNotificationService {
    UserNotificationService()
  }

  static var testValue: UserNotificationService {
    UserNotificationService()
  }
}

extension DependencyValues {
  var userNotificationService: UserNotificationService {
    get { self[UserNotificationService.self] }
    set { self[UserNotificationService.self] = newValue }
  }
}
