//
//  HomeClient.swift
//  Flifin
//
//  Created by 김유빈 on 7/2/25.
//

import Foundation

import ComposableArchitecture

@DependencyClient
struct HomeClient {
  var fetchHomeInfo: () async throws -> HomeInfo
  var todayMissionDone: (_ date: String) async throws -> Void
}

extension HomeClient: DependencyKey {
  static var liveValue: Self = {
    let networkManager = NetworkManager()

    return HomeClient(
      fetchHomeInfo: {
        try await networkManager
          .request(HomeAPI.home)
          .map(to: HomeDTO.self)
          .toDomain()
      },
      todayMissionDone: { date in
        _ = try await networkManager
          .request(
            HomeAPI.todayMissionDone(
              date: date
            )
          )
      }
    )
  }()

  static let previewValue = HomeClient(
    fetchHomeInfo: { .sample },
    todayMissionDone: { _ in }
  )
  static let testValue = Self()
}

extension DependencyValues {
  var homeClient: HomeClient {
    get { self[HomeClient.self] }
    set { self[HomeClient.self] = newValue }
  }
}
