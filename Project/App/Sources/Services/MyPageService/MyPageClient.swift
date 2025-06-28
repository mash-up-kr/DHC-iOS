//
//  MyPageClient.swift
//  Flifin
//
//  Created by Aiden.lee on 6/29/25.
//

import Foundation

import ComposableArchitecture

@DependencyClient
struct MyPageClient {
  var fetchMyPageInfo: () async throws -> MyPageInfo
}

extension MyPageClient: DependencyKey {
  static let liveValue: Self = {
    let networkManager = NetworkManager()

    return MyPageClient(fetchMyPageInfo: {
      try await networkManager
        .request(MyPageAPI.myPage)
        .map(to: MyPageDTO.self)
        .toDomain()
    })
  }()

  static let previewValue = MyPageClient(
    fetchMyPageInfo: {
      .sample
    }
  )
  static let testValue = Self()
}

extension DependencyValues {
  var myPageClient: MyPageClient {
    get { self[MyPageClient.self] }
    set { self[MyPageClient.self] = newValue }
  }
}
