//
//  NumberFactClient.swift
//  DHC-iOS
//
//  Created by hyerin on 5/27/25.
//

import Foundation

import ComposableArchitecture

@DependencyClient
struct NumberFactClient: Sendable {
  var fetch: @Sendable (Int) async throws -> String
}

extension NumberFactClient: DependencyKey {
  static var liveValue: NumberFactClient {
    return NumberFactClient(
      fetch: { number in
        let (data, _) = try await URLSession.shared.data(
          from: URL(string: "http://www.numbersapi.com/\(number)")!
        )
        return String(decoding: data, as: UTF8.self)
      }
    )
  }
  
  static var previewValue: NumberFactClient {
    return NumberFactClient(
      fetch: { number in
        return "프리뷰 value입니다 ^_^: \(number)"
      }
    )
  }
  
  static var testValue: NumberFactClient {
    return NumberFactClient()
  }
}

extension DependencyValues {
  var numberFactClient: NumberFactClient {
    get { self[NumberFactClient.self] }
    set { self[NumberFactClient.self] = newValue }
  }
}
