//
//  UserManager.swift
//  Flifin
//
//  Created by Aiden.lee on 6/28/25.
//

import Foundation

import ComposableArchitecture

@DependencyClient
struct UserManager {
  var getUserID: () -> String?
  var setUserID: (String) -> Void
  var deleteUserID: () -> Void
}

extension UserManager: DependencyKey {
  static var liveValue: UserManager = {
    @ObservationIgnored
    @Shared(.appStorage("userID")) var userID: String?
    return UserManager(
      getUserID: {
        debugPrint("✅ getUserID: \(String(describing: userID))")
        return userID
      },
      setUserID: { newID in
        $userID.withLock { userID in
          userID = newID
        }
      },
      deleteUserID: {
        $userID.withLock { userID in
          userID = nil
        }
      }
    )
  }()

  static let previewValue = UserManager(
    getUserID: { "previewUserID" },
    setUserID: { _ in },
    deleteUserID: {}
  )

  static let testValue = Self()
}

extension DependencyValues {
  var userManager: UserManager {
    get { self[UserManager.self] }
    set { self[UserManager.self] = newValue }
  }
}
