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

  init() {}

  @ObservableState
  struct State: Equatable {
    var missionList: MissionListReducer.State
    
    init() {
      @Dependency(\.dateFormatterCache) var dateFormatterCache
      let endDate = dateFormatterCache.formatter(for: "yyyy-MM-dd")
        .string(from: Date().addDate(day: 12))
      let longTermMission = HomeInfo.Mission.onboardingLongTermMisson(endDate: endDate)
      self.missionList = .init(
        longTermMission: longTermMission,
        todayDailyMissionList: HomeInfo.Mission.onboardingDailyMissionList
      )
    }
  }

  enum Action {
    // View Action
    case nextButtonTapped

    // Internal Action
    
    // Route Action
  }

  var body: some Reducer<State, Action> {
    Reduce { state, action in
      switch action {
      case .nextButtonTapped:
        return .none
      }
    }
  }
}
