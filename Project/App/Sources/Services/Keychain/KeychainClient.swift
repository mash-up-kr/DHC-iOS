//
//  KeychainClient.swift
//  DHC-iOS
//
//  Created by 김유빈 on 6/5/25.
//

import Foundation

import ComposableArchitecture

struct KeychainClient {
  var save: (_ key: String, _ value: String) -> Bool
  var load: (_ key: String) -> String?
  var delete: (_ key: String) -> Bool
}

extension KeychainClient: DependencyKey {
  static let liveValue = KeychainClient(
    save: { key, value in
      KeychainService.save(key: key, value: value)
    },
    load: { key in
      KeychainService.load(key: key)
    },
    delete: { key in
      KeychainService.delete(key: key)
    }
  )
}

extension DependencyValues {
  var keychain: KeychainClient {
    get { self[KeychainClient.self] }
    set { self[KeychainClient.self] = newValue }
  }
}
