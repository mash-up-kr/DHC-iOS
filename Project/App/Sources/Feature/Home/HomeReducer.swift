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
  @ObservableState
  struct State: Equatable {
    var missionList = MissionListReducer.State()
  }

  enum Action {
    case missionList(MissionListReducer.Action)
  }

  var body: some ReducerOf<Self> {
    Scope(state: \.missionList, action: \.missionList) {
      MissionListReducer()
    }

    Reduce { _, action in
      switch action {
      case .missionList:
        return .none
      }
    }
  }
}
