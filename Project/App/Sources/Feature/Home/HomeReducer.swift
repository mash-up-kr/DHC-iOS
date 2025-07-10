//
//  HomeReducer.swift
//  Flifin
//
//  Created by Aiden.lee on 6/8/25.
//

import SwiftUI

import ComposableArchitecture

@Reducer
struct HomeReducer {
  @Dependency(\.homeAPIClient) var homeAPIClient
  @Dependency(\.dateFormatterCache) var dateFormatterCache

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
      todayDailyMissionList: HomeInfo.sample.dailyMissionList
    )
    var homeInfo: HomeInfo
    var presentBottomSheet = false
    var presentMissionDonePopup = false
    
    var fortuneLoadingComplete: FortuneLoadingCompleteReducer.State?
    var isFirstLaunchOfToday: Bool
    
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

    case presentBottomSheet(Bool)
    case confirmTodayMissionDoneButtonTapped
    case cancelTodayMissionDoneButtonTapped

    case popupConfirmButtonTapped
    case popupDismissButtonTapped

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
          withAnimation(.easeInOut(duration: 0.5)) {
            state.viewState = .firstLaunch
          }
        } else {
          state.viewState = .home
        }
        
        return .send(.fetchHomeData)

      case .presentBottomSheet(let isVisible):
        state.presentBottomSheet = isVisible
        return .none

      case .confirmTodayMissionDoneButtonTapped:
        state.presentBottomSheet = false
        state.presentMissionDonePopup = true

        let todayDate = formattedTodayDate()

        return .run { send in
          do {
            try await homeAPIClient.todayMissionDone(todayDate)
            await send(.fetchHomeData)
          } catch {
            #if DEBUG
            print("오늘 미션 완료 처리 실패")
            #endif
          }
        }

      case .cancelTodayMissionDoneButtonTapped:
        state.presentBottomSheet = false
        return .none

      case .popupConfirmButtonTapped:
        state.presentMissionDonePopup = false
        // TODO: 통계 탭으로 이동
        return .none

      case .popupDismissButtonTapped:
        state.presentMissionDonePopup = false
        return .none

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
          let dailyFortune = homeInfo.dailyFortune
          state.fortuneLoadingComplete = .init(
            scoreInfo: .init(
              date: formatDate(from: dailyFortune.date),
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
          
          withAnimation(.easeInOut(duration: 0.5)) {
            state.viewState = .firstLaunch
          }
          return .none
        } else {
          state.homeInfo = homeInfo
          return .merge(
            .send(.missionList(.updateLongTermMission(homeInfo.longTermMission))),
            .send(.missionList(.updateDailyMissions(homeInfo.dailyMissionList)))
          )
        }
        
      case .homeDataFailed:
        return .none
        
      case .missionList:
        return .none
        
      case .fortuneLoadingComplete(let action):
        switch action {
        case .delegate(.moveToHome):
          state.isFirstLaunchOfToday.toggle()
          withAnimation(.easeInOut(duration: 0.5)) {
            state.viewState = .home
          }
          return .none
        default:
          return .none
        }
        
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
  
  private func formatDate(from dateString: String) -> String {
    let date = dateFormatterCache.formatter(for: "yyyy-MM-dd").date(from: dateString) ?? Date()
    let formattedString = dateFormatterCache.formatter(for: "yyyy년 M월 d일").string(from: date)
    return formattedString
  }

  private func formattedTodayDate() -> String {
    let formatter = dateFormatterCache.formatter(for: "yyyy-MM-dd")
    return formatter.string(from: Date())
  }
}

extension HomeReducer.Path.State: Equatable {}
