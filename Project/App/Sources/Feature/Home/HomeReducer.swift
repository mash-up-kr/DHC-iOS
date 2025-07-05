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
  @Dependency(\.homeAPIClient) var homeAPIClient

  @ObservableState
  struct State: Equatable {
    var path = StackState<Path.State>()
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
    case path(StackActionOf<Path>)
    case moveToFortuneDetail
  }
  
  @Reducer
  enum Path {
    case fortuneDetail(FortuneDetailReducer)
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
            let homeInfo = try await homeAPIClient.fetchHomeInfo()
            await send(.homeDataResponse(homeInfo))
          } catch {
            await send(.homeDataFailed(error))
          }
        }

      case .homeDataResponse(let homeInfo):
        state.homeInfo = homeInfo
        return .merge(
          .send(.missionList(.updateLongTermMission(homeInfo.longTermMission))),
          .send(.missionList(.updateDailyMissions(homeInfo.todayDailyMissionList)))
        )

      case .homeDataFailed:
        return .none

      case .missionList:
        return .none
        
      case .moveToFortuneDetail:
        state.path.append(.fortuneDetail(FortuneDetailReducer.State(type: .detail)))
        return .none
        
      case let .path(action):
        switch action {
        case let .element(id: id, action: .fortuneDetail(.backButtonTapped)):
          state.path.pop(from: id)
          return .none
          
        default:
          return .none
        }
      }
    }
    .forEach(\.path, action: \.path)
  }
}

extension HomeReducer.Path.State: Equatable {}
