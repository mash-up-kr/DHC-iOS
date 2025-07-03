//
//  FortuneLoadingReducer.swift
//  Flifin
//
//  Created by hyerin on 7/2/25.
//

import Foundation

import ComposableArchitecture

@Reducer
struct FortuneLoadingReducer {
  init() {}

  @Dependency(\.dateFormatterCache) var dateFormatterCache
  
  @ObservableState
  struct State: Equatable {
    var todayDateString: String
    var shouldPlayVideo = false

    init(
      todayDateString: String = "",
      shouldPlayVideo: Bool = false
    ) {
      self.todayDateString = todayDateString
      self.shouldPlayVideo = shouldPlayVideo
    }
  }

  enum Action {
    // View Action
    case onAppear
    
    // Internal Action
    
    // Route Action
  }

  var body: some Reducer<State, Action> {
    Reduce { state, action in
      switch action {
      case .onAppear:
        let dateString = dateFormatterCache.formatter(for: "yyyy년 M월 d일").string(from: Date())
        state.todayDateString = dateString
        state.shouldPlayVideo = true
        return .none
      }
    }
  }
}
