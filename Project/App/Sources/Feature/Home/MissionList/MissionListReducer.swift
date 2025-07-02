//
//  MissionListReducer.swift
//  Flifin
//
//  Created by 김유빈 on 7/1/25.
//

import ComposableArchitecture

@Reducer
struct MissionListReducer {
  init() {}

  @ObservableState
  struct State: Equatable {
    var isTooltipVisible = false
    
    var longTermMission: HomeInfo.Mission
    var todayDailyMissionList: [HomeInfo.Mission] = []
    
    init(longTermMission: HomeInfo.Mission, todayDailyMissionList: [HomeInfo.Mission]) {
      self.longTermMission = longTermMission
      self.todayDailyMissionList = todayDailyMissionList
    }
  }

  enum Action {
    // View Action
    case tooltipTapped

    // Internal Action
    case updateLongTermMission(HomeInfo.Mission)
    case updateDailyMissions([HomeInfo.Mission])

    // Route Action
  }

  var body: some Reducer<State, Action> {
    Reduce { state, action in
      switch action {
      case .tooltipTapped:
        state.isTooltipVisible.toggle()
        return .none
        
      case .updateLongTermMission(let mission):
        state.longTermMission = mission
        return .none

      case .updateDailyMissions(let missions):
        state.todayDailyMissionList = missions
        return .none
      }
    }
  }
}
