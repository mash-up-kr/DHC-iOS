//
//  UUIDManager.swift
//  ProductName
//
//  Created by 김유빈 on 6/9/25.
//

import Foundation

import ComposableArchitecture

enum UUIDManager {
  static let uuidKey = "install_uuid"

  @Dependency(\.keychainClient) static var keychain

  static func saveUUID(_ uuid: UUID) -> Bool {
    keychain.save(uuidKey, uuid.uuidString)
  }

  static func loadUUID() -> UUID? {
    guard let uuidString = keychain.load(uuidKey) else { return nil }
    return UUID(uuidString: uuidString)
  }

  static func deleteUUID() -> Bool {
    keychain.delete(uuidKey)
  }
}
