//
//  UserNotificationClient.swift
//  ProductName
//
//  Created by 김유빈 on 6/19/25.
//

import ComposableArchitecture

@DependencyClient
struct UserNotificationClient: Sendable {
  var requestAuthorization: () async throws -> Bool
}

extension UserNotificationClient: DependencyKey {
  static var liveValue: UserNotificationClient = {
    @Dependency(\.userNotificationService) var userNotificationService

    return UserNotificationClient(
      requestAuthorization: {
        let isNotificationAuthorized = try await userNotificationService.requestAuthorization()
        
        return isNotificationAuthorized
      }
    )
  }()

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
