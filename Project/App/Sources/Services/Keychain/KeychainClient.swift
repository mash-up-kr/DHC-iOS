//
//  KeychainClient.swift
//  Flifin
//
//  Created by 김유빈 on 6/5/25.
//

import Foundation

import ComposableArchitecture

@DependencyClient
struct KeychainClient: Sendable {
  var save: (_ key: String, _ value: String) throws -> Void
  var load: (_ key: String) throws -> String
  var delete: (_ key: String) throws -> Void
}

extension KeychainClient: DependencyKey {
  static let liveValue: KeychainClient = {
    @Dependency(\.keychainService) var keychainService

    return KeychainClient(
      save: { key, value in
        try keychainService.save(key: key, value: value)
      },
      load: { key in
        try keychainService.load(key: key)
      },
      delete: { key in
        try keychainService.delete(key: key)
      }
    )
  }()

  static var previewValue = Self()

  static var testValue = Self()
}

extension DependencyValues {
  var keychainClient: KeychainClient {
    get { self[KeychainClient.self] }
    set { self[KeychainClient.self] = newValue }
  }
}
