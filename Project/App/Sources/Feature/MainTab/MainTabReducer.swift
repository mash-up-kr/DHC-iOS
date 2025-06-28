//
//  MainTabReducer.swift
//  Flifin
//
//  Created by Aiden.lee on 6/8/25.
//

import Foundation

import ComposableArchitecture

@Reducer
struct MainTabReducer {
  @ObservableState
  struct State: Equatable {
    var homeTab = HomeReducer.State()
    var missionStatusTab = MissionStatusReducer.State()
    var myPageTab = MyPageReducer.State(myPageInfo: .sample)
    var selectedTab = TabKind.home
  }

  enum Action {
    case homeTab(HomeReducer.Action)
    case missionStatusTab(MissionStatusReducer.Action)
    case myPageTab(MyPageReducer.Action)
    case selectedTabChanged(TabKind)
  }

  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .homeTab:
        return .none
      case .missionStatusTab:
        return .none
      case .myPageTab:
        return .none
      case .selectedTabChanged(let tabKind):
        state.selectedTab = tabKind
        return .none
      }
    }

    Scope(state: \.homeTab, action: \.homeTab) {
      HomeReducer()
    }
    Scope(state: \.missionStatusTab, action: \.missionStatusTab) {
      MissionStatusReducer()
    }
    Scope(state: \.myPageTab, action: \.myPageTab) {
      MyPageReducer()
    }
  }
}
