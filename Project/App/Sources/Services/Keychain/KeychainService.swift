//
//  KeychainService.swift
//  ProductName
//
//  Created by 김유빈 on 6/9/25.
//

import Foundation
import Security

import ComposableArchitecture

@DependencyClient
struct KeychainService {
  var save: (_ key: String, _ value: String) throws -> Void
  var load: (_ key: String) throws -> String
  var delete: (_ key: String) throws -> Void
}

extension KeychainService: TestDependencyKey {
  static let previewValue = Self()

  static let testValue = Self()
}

extension DependencyValues {
  var keychainService: KeychainService {
    get { self[KeychainService.self] }
    set { self[KeychainService.self] = newValue }
  }
}

extension KeychainService: DependencyKey {
  static let liveValue = KeychainService(
    save: { key, value in
      guard let data = value.data(using: .utf8) else {
        throw KeychainError.stringEncodingFailed
      }

      let query: [String: Any] = [
        kSecClass as String: kSecClassGenericPassword,
        kSecAttrAccount as String: key,
        kSecValueData as String: data,
      ]

      SecItemDelete(query as CFDictionary)

      guard SecItemAdd(query as CFDictionary, nil) == errSecSuccess else {
        throw KeychainError.saveFailed
      }
    },
    load: { key in
      let query: [String: Any] = [
        kSecClass as String: kSecClassGenericPassword,
        kSecAttrAccount as String: key,
        kSecReturnData as String: true,
        kSecMatchLimit as String: kSecMatchLimitOne,
      ]

      var item: CFTypeRef?
      guard SecItemCopyMatching(query as CFDictionary, &item) == errSecSuccess,
            let data = item as? Data,
            let result = String(data: data, encoding: .utf8)
      else {
        throw KeychainError.loadFailed
      }

      return result
    },
    delete: { key in
      let query: [String: Any] = [
        kSecClass as String: kSecClassGenericPassword,
        kSecAttrAccount as String: key,
      ]

      let result = SecItemDelete(query as CFDictionary)
      guard result == errSecSuccess || result == errSecItemNotFound else {
        throw KeychainError.deleteFailed
      }
    }
  )
}
