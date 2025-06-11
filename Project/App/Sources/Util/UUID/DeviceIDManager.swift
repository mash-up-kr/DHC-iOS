//
//  DeviceIDManager.swift
//  ProductName
//
//  Created by 김유빈 on 6/9/25.
//

import Foundation

import ComposableArchitecture

enum DeviceIDManager {
  static let deviceID = "install_uuid"

  @Dependency(\.keychainClient) static var keychain

  static func saveUUID(_ uuid: UUID) -> Bool {
    keychain.save(deviceID, uuid.uuidString)
  }

  static func loadUUID() -> UUID? {
    guard let uuidString = keychain.load(deviceID) else { return nil }
    return UUID(uuidString: uuidString)
  }

  static func deleteUUID() -> Bool {
    keychain.delete(deviceID)
  }
}
