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
    var homeTab = HomeReducer.State(homeInfo: .sample)
    var reportTab = ReportReducer.State(reportInfo: .sample, spendChart: nil)
    var myPageTab = MyPageReducer.State(myPageInfo: .sample)
    var selectedTab = TabKind.home
  }

  enum Action {
    case homeTab(HomeReducer.Action)
    case reportTab(ReportReducer.Action)
    case myPageTab(MyPageReducer.Action)
    case selectedTabChanged(TabKind)
  }

  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .homeTab:
        return .none
      case .reportTab:
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
    Scope(state: \.reportTab, action: \.reportTab) {
      ReportReducer()
    }
    Scope(state: \.myPageTab, action: \.myPageTab) {
      MyPageReducer()
    }
  }
}
