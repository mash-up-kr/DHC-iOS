//
//  FortuneDetailReducer.swift
//  Flifin
//
//  Created by 최혜린 on 6/22/25.
//

import ComposableArchitecture

import SwiftUI

enum FortuneDetailType {
  case intro
  case detail
}

@Reducer
struct FortuneDetailReducer {
  init() {}

  @ObservableState
  struct State: Equatable {
    let type: FortuneDetailType
    var detailInfo = FortuneDetailInfo.introInfo

    init(type: FortuneDetailType) {
      self.type = type
    }
  }

  enum Action {
    // View Action
    case onAppear
    case nextButtonTapped
    case backButtonTapped
    
    // Internal Action
    
    // Route Action
  }

  var body: some Reducer<State, Action> {
    Reduce { state, action in
      switch action {
      case .onAppear:
        switch state.type {
        case .detail:
          break
        case .intro:
          state.detailInfo = .introInfo
        }
        return .none
        
      case .nextButtonTapped:
        return .none
        
      case .backButtonTapped:
        return .none
      }
    }
  }
}
