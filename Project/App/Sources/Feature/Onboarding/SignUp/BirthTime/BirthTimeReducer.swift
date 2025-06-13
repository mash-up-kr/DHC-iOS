//
//  BirthTimeReducer.swift
//  ProductName
//
//  Created by hyerin on 6/13/25.
//

import Foundation

import ComposableArchitecture

@Reducer
struct BirthTimeReducer {
  init() {}

  @ObservableState
  struct State: Equatable {
    var birthTime: Date
    var isNoIdeaButtonChecked: Bool

    init(
      birthTime: Date = Date(hour: 1, minute: 0),
      isNoIdeaButtonSelected: Bool = false
    ) {
      self.birthTime = birthTime
      self.isNoIdeaButtonChecked = isNoIdeaButtonSelected
    }
  }

  enum Action {
    // View Action
    case birthTimeChanged(Date)
    case noIdeaButtonTapped
    case nextButtonTapped
    case backButtonTapped
    
    // Internal Action
    
    // Route Action
  }

  var body: some Reducer<State, Action> {
    Reduce { state, action in
      switch action {
        case .birthTimeChanged(let birthTime):
          state.birthTime = birthTime
          return .none
          
        case .noIdeaButtonTapped:
          state.isNoIdeaButtonChecked.toggle()
          return .none
          
        case .nextButtonTapped:
          return .none
          
        case .backButtonTapped:
          return .none
      }
    }
  }
}
