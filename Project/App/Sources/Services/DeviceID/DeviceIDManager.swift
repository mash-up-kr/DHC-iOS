//
//  DeviceIDManager.swift
//  Flifin
//
//  Created by 김유빈 on 6/13/25.
//

import Foundation

import ComposableArchitecture

@DependencyClient
struct DeviceIDManager: Sendable {
  var generateDeviceID: () -> UUID = { UUID() }
  var saveDeviceID: (_ uuid: UUID) throws -> Void
  var loadDeviceID: () throws -> UUID
  var deleteDeviceID: () throws -> Void
}

extension DeviceIDManager: DependencyKey {
  static let liveValue: DeviceIDManager = {
    @Dependency(\.keychainClient) var keychainClient
    let key = "DeviceID"

    return DeviceIDManager(
      generateDeviceID: {
        UUID()
      },
      saveDeviceID: { uuid in
        try keychainClient.save(key, uuid.uuidString)
      },
      loadDeviceID: {
        let uuidString = try keychainClient.load(key)
        guard let uuid = UUID(uuidString: uuidString) else {
          throw KeychainError.loadFailed
        }
        return uuid
      },
      deleteDeviceID: {
        try keychainClient.delete(key)
      }
    )
  }()

  static var previewValue = Self()

  static var testValue = Self()
}

extension DependencyValues {
  var deviceIDManager: DeviceIDManager {
    get { self[DeviceIDManager.self] }
    set { self[DeviceIDManager.self] = newValue }
  }
}
