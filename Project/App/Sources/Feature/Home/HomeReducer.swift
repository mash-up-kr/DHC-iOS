//
//  HomeReducer.swift
//  Flifin
//
//  Created by Aiden.lee on 6/8/25.
//

import Foundation

import ComposableArchitecture

@Reducer
struct HomeReducer {
  @Dependency(\.homeClient) var homeClient

  @ObservableState
  struct State: Equatable {
    var missionList = MissionListReducer.State(
      longTermMission: HomeInfo.sample.longTermMission,
      todayDailyMissionList: HomeInfo.sample.todayDailyMissionList
    )
    var homeInfo: HomeInfo
  }

  enum Action {
    // View Actions
    case onAppear

    // Internal Actions
    case fetchHomeData
    case homeDataResponse(HomeInfo)
    case homeDataFailed(Error)
    case missionList(MissionListReducer.Action)

    // Navigation Actions
  }

  var body: some ReducerOf<Self> {
    Scope(state: \.missionList, action: \.missionList) {
      MissionListReducer()
    }

    Reduce { state, action in
      switch action {
      case .onAppear:
        return .send(.fetchHomeData)

      case .fetchHomeData:
        return .run { send in
          do {
            let homeInfo = try await homeClient.fetchHomeInfo()
            await send(.homeDataResponse(homeInfo))
          } catch {
            await send(.homeDataFailed(error))
          }
        }

      case .homeDataResponse(let homeInfo):
        state.homeInfo = homeInfo
        return .concatenate(
          .send(.missionList(.updateLongTermMission(homeInfo.longTermMission))),
          .send(.missionList(.updateDailyMissions(homeInfo.todayDailyMissionList)))
        )

      case .homeDataFailed:
        return .none

      case .missionList:
        return .none
      }
    }
  }
}
