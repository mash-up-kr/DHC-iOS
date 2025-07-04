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
    enum ViewState {
      case firstLaunch
      case home
    }
    
    var viewState: ViewState = .home
    
    var path = StackState<Path.State>()
    var missionList = MissionListReducer.State(
      longTermMission: HomeInfo.sample.longTermMission,
      todayDailyMissionList: HomeInfo.sample.todayDailyMissionList
    )
    var homeInfo: HomeInfo
    
    var fortuneLoadingComplete: FortuneLoadingCompleteReducer.State?
    let isFirstLaunchOfToday: Bool
    
    init(
      homeInfo: HomeInfo,
      fortuneLoadingComplete: FortuneLoadingCompleteReducer.State? = nil,
      isFirstLaunchOfToday: Bool
    ) {
      self.homeInfo = homeInfo
      self.fortuneLoadingComplete = fortuneLoadingComplete
      self.isFirstLaunchOfToday = isFirstLaunchOfToday
    }
  }

  enum Action {
    // View Actions
    case onAppear

    // Internal Actions
    case fetchHomeData
    case homeDataResponse(HomeInfo)
    case homeDataFailed(Error)
    case missionList(MissionListReducer.Action)
    case fortuneLoadingComplete(FortuneLoadingCompleteReducer.Action)

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
        if state.isFirstLaunchOfToday {
          state.viewState = .firstLaunch
        } else {
          state.viewState = .home
        }
        
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
        if state.isFirstLaunchOfToday {
          let dailyFortune = homeInfo.todayDailyFortune
          state.fortuneLoadingComplete = .init(
            scoreInfo: .init(
              date: dailyFortune.date,
              scoreString: "\(dailyFortune.score)점",
              score: dailyFortune.score,
              summary: dailyFortune.fortuneTitle
            ),
            cardInfo: .init(
              backgroundImageURL: .urlForResource(.fortuneCardFrontDefaultView),
              title: "최고의 날",
              fortune: "네잎클로버"
            )
          )
          
          state.viewState = .firstLaunch
          return .none
        } else {
          state.homeInfo = homeInfo
          return .merge(
            .send(.missionList(.updateLongTermMission(homeInfo.longTermMission))),
            .send(.missionList(.updateDailyMissions(homeInfo.todayDailyMissionList)))
          )
        }
        
      case .homeDataFailed:
        return .none
        
      case .missionList,
          .fortuneLoadingComplete:
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
    .ifLet(\.fortuneLoadingComplete, action: \.fortuneLoadingComplete) {
      FortuneLoadingCompleteReducer()
    }
  }
}

extension HomeReducer.Path.State: Equatable {}
