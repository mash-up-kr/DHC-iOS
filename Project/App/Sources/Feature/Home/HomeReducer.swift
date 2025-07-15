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
      case loading
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
    var fortuneLoading: FortuneLoadingReducer.State?
    var isFirstLaunchOfToday: Bool
    
    // 폴링 관련 상태
    var isPolling = false
    
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
    case fetchFortuneDetail
    case fortuneDetailResponse(FortuneDetail)
    case fortuneDetailFailed(Error)
    case missionList(MissionListReducer.Action)
    case fortuneLoadingComplete(FortuneLoadingCompleteReducer.Action)
    case fortuneLoading(FortuneLoadingReducer.Action)
    
    // 폴링 관련 액션
    case startPolling
    case pollingTimeout
    case checkPollingStatus

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
          // 이미 폴링 중이거나 fortuneLoadingComplete가 있으면 API 호출하지 않음
          if state.isPolling || state.fortuneLoadingComplete != nil {
            return .none
          }
          
          // 첫 진입인 경우 loading 상태로 설정하고 fortuneDetail API 호출
          state.viewState = .loading
          return .send(.fetchFortuneDetail)
        } else {
          state.viewState = .home
          return .send(.fetchHomeData)
        }

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
        
      case .fetchFortuneDetail:
        let todayDate = formattedTodayDate()
        
        return .run { send in
          do {
            let fortuneDetail = try await homeAPIClient.fetchFortuneDetail(todayDate)
            await send(.fortuneDetailResponse(fortuneDetail))
          } catch {
            await send(.fortuneDetailFailed(error))
          }
        }
        
      case .fortuneDetailResponse(let fortuneDetail):
        // 폴링 중지
        state.isPolling = false
        
        #if DEBUG
        print("폴링 성공! FortuneLoadingCompleteView로 전환")
        #endif
        
        // FortuneLoadingCompleteView 표시
        state.fortuneLoadingComplete = .init(
          scoreInfo: .init(
            date: formatDate(from: fortuneDetail.scoreInfo.date),
            scoreString: fortuneDetail.scoreInfo.scoreString,
            score: fortuneDetail.scoreInfo.score,
            summary: fortuneDetail.scoreInfo.summary
          ),
          cardInfo: fortuneDetail.cardInfo
        )
        
        // firstLaunch 상태로 설정
        withAnimation(.easeInOut(duration: 0.5)) {
          state.viewState = .firstLaunch
        }
        return .none
        
      case .fortuneDetailFailed(let error):
        // needAPIRecall 에러인 경우에만 폴링 시작
        if let homeAPIClientError = error as? HomeAPIClientError,
           homeAPIClientError.code == .needAPIRecall {
          return .send(.startPolling)
        }
        return .none
        
      case .homeDataResponse(let homeInfo):
        state.homeInfo = homeInfo
        return .merge(
          .send(.missionList(.updateLongTermMission(homeInfo.longTermMission))),
          .send(.missionList(.updateDailyMissions(homeInfo.dailyMissionList)))
        )
        
      case .homeDataFailed:
        return .none
        
      case .startPolling:
        guard !state.isPolling else { return .none }
        
        state.isPolling = true
        
        // FortuneLoadingView 표시
        if state.fortuneLoading == nil {
          state.fortuneLoading = .init()
          state.viewState = .loading
        }
        
        #if DEBUG
        print("폴링 시작 - viewState: \(state.viewState)")
        #endif
        
        return .run { send in
          try await Task.sleep(for: .seconds(5))
          await send(.pollingTimeout)
        }
        
      case .pollingTimeout:
        guard state.isPolling else { return .none }
        
        #if DEBUG
        print("폴링 타임아웃 - 재시도 중...")
        #endif
        
        let todayDate = formattedTodayDate()
        
        return .run { send in
          do {
            let fortuneDetail = try await homeAPIClient.fetchFortuneDetail(todayDate)
            await send(.fortuneDetailResponse(fortuneDetail))
          } catch {
            // needAPIRecall 에러인 경우에만 계속 폴링
            if let homeAPIClientError = error as? HomeAPIClientError,
               homeAPIClientError.code == .needAPIRecall {
              #if DEBUG
              print("폴링 계속 - needAPIRecall 에러")
              #endif
              await send(.startPolling)
            }
          }
        }
        
      case .checkPollingStatus:
        // isFirstLaunchOfToday이고 폴링 중이지만 fortuneLoadingComplete가 없으면 폴링 재시작
        if state.isFirstLaunchOfToday && state.isPolling && state.fortuneLoadingComplete == nil {
          #if DEBUG
          print("폴링 상태 확인 - 폴링 재시작")
          #endif
          return .send(.startPolling)
        }
        return .none
        
      case .missionList:
        return .none
        
      case .fortuneLoading:
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
    .ifLet(\.fortuneLoading, action: \.fortuneLoading) {
      FortuneLoadingReducer()
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
