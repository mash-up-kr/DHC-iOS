//
//  HomeAPIClient.swift
//  Flifin
//
//  Created by 김유빈 on 7/2/25.
//

import Foundation

import ComposableArchitecture

@DependencyClient
struct HomeAPIClient {
  var fetchHomeInfo: () async throws -> HomeInfo
  var todayMissionDone: (_ date: String) async throws -> Void
  var fetchFortuneDetail: (_ date: String) async throws -> FortuneDetail
  static var callCount = 0
}

extension HomeAPIClient: DependencyKey {
  static var liveValue: Self = {
    let networkManager = NetworkManager()

    return HomeAPIClient(
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
      },
      fetchFortuneDetail: { date in
        let endPoint = HomeAPI.fortuneDetail(date: date)
        // 테스트용: 처음 3번은 needAPIRecall 에러 발생
        callCount += 1
        
        #if DEBUG
        print("fetchFortuneDetail 호출 횟수: \(callCount)")
        #endif
        
        if callCount <= 10 {
          #if DEBUG
          print("테스트: needAPIRecall 에러 발생")
          #endif
          throw HomeAPIClientError(code: .needAPIRecall)
        } else {
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
                throw HomeAPIClientError(code: .needAPIRecall)
              }
            }
            
            throw HomeAPIClientError(code: .invalidResponse)
          }
        }
      }
    )
  }()

  static let previewValue = HomeAPIClient(
    fetchHomeInfo: { .sample },
    todayMissionDone: { _ in },
    fetchFortuneDetail: { _ in
      .init(
        scoreInfo: .init(
          date: "",
          scoreString: "",
          score: 0,
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
  var homeAPIClient: HomeAPIClient {
    get { self[HomeAPIClient.self] }
    set { self[HomeAPIClient.self] = newValue }
  }
}

public struct HomeAPIClientError: Error {
  public var code: APIResponseError
  public var underlying: Error?

  public enum APIResponseError: Int {
    case needAPIRecall
    case invalidResponse
  }
}
