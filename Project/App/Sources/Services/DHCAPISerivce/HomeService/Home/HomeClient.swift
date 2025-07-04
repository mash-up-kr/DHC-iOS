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
  var fetchFortuneDetail: (_ date: String) async throws -> FortuneDetail
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
      fetchFortuneDetail: { date in
        let endPoint = HomeAPI.fortuneDetail(date: date)
        
        do {
          let response = try await networkManager
            .request(endPoint)
            .map(to: FortuneDetailDTO.self)
            .toDomain
          return response
        } catch {
          if let networkManageError = error as? NetworkManagerError,
             case .requestFailed(let error, let statusCode) = networkManageError {
            if statusCode == 404 {
              throw HomeClientError(code: .needAPIRecall)
            }
          }
          
          throw HomeClientError(code: .invalidResponse)
        }
      }
    )
  }()

  static let previewValue = HomeClient(
    fetchHomeInfo: { .sample },
    fetchFortuneDetail: { _ in
      .init(
        scoreInfo: .init(
          date: "",
          score: "",
          summary: ""
        ),
        cardInfo: .init(
          backgroundImageURL: .urlForResource(.fortuneCardFrontDefaultView),
          title: "",
          fortune: ""
        ),
        detailMessage: "",
        tipInfos: []
      )
    }
  )
  static let testValue = Self()
}

extension DependencyValues {
  var homeClient: HomeClient {
    get { self[HomeClient.self] }
    set { self[HomeClient.self] = newValue }
  }
}

public struct HomeClientError: Error {
  public var code: APIResponseError
  public var underlying: Error?

  public enum APIResponseError: Int {
    case needAPIRecall
    case invalidResponse
  }
}
