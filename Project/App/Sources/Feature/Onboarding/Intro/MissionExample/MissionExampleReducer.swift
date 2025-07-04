//
//  MissionExampleReducer.swift
//  Flifin
//
//  Created by 최혜린 on 6/29/25.
//

import Foundation

import ComposableArchitecture

@Reducer
struct MissionExampleReducer {
  @Dependency(\.dateFormatterCache) var dateFormatterCache
  
  init() {}

  @ObservableState
  struct State: Equatable {
    var missionList: MissionListReducer.State?
    
    init(missionList: MissionListReducer.State? = nil) {
      self.missionList = missionList
    }
  }

  enum Action {
    // View Action
    case nextButtonTapped
    case onAppear
    
    // Internal Action
    case missionList(MissionListReducer.Action)
    
    // Route Action
  }

  var body: some Reducer<State, Action> {
    Reduce { state, action in
      switch action {
      case .nextButtonTapped:
        return .none
        
      case .onAppear:
        let endDate = dateFormatterCache.formatter(for: "yyyy-MM-dd").string(from: Date().addDate(day: 12))
        let longTermMission = HomeInfo.Mission.onboardingLongTermMisson(endDate: endDate)
        state.missionList = .init(
          longTermMission: longTermMission,
          todayDailyMissionList: HomeInfo.Mission.onboardingDailyMissionList,
          isUserInteractionEnabled: false
        )
        return .none
        
      case .missionList:
        return .none
      }
    }
    .ifLet(\.missionList, action: \.missionList) {
      MissionListReducer()
    }
  }
}
