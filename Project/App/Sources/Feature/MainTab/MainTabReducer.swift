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
  @Dependency(\.launchManager) var launchManager
  
  @ObservableState
  struct State: Equatable {
    var homeTab: HomeReducer.State?
    var reportTab = ReportReducer.State(reportInfo: .sample, spendChart: nil)
    var myPageTab = MyPageReducer.State(myPageInfo: .sample)
    var selectedTab = TabKind.home
    
    init(homeTab: HomeReducer.State? = nil) {
      self.homeTab = homeTab
    }
  }

  enum Action {
    case onAppear
    
    case homeTab(HomeReducer.Action)
    case reportTab(ReportReducer.Action)
    case myPageTab(MyPageReducer.Action)
    case selectedTabChanged(TabKind)
  }

  var body: some ReducerOf<Self> {
    Scope(state: \.reportTab, action: \.reportTab) {
      ReportReducer()
    }
    Scope(state: \.myPageTab, action: \.myPageTab) {
      MyPageReducer()
    }

    Reduce { state, action in
      switch action {
      case .onAppear:
        let isFirstLaunch = launchManager.isFirstLaunchOfToday()
        state.homeTab = HomeReducer.State(homeInfo: .sample, isFirstLaunchOfToday: isFirstLaunch)
        return .none
        
      case .homeTab(let action):
        switch action {
        case .delegate(.moveToReportTab):
          state.selectedTab = .report
          return .none
        default:
          return .none
        }
      case .reportTab:
        return .none
      case .myPageTab:
        return .none
      case .selectedTabChanged(let tabKind):
        state.selectedTab = tabKind
        return .none
      }
    }
    .ifLet(\.homeTab, action: \.homeTab) {
      HomeReducer()
    }
  }
}
