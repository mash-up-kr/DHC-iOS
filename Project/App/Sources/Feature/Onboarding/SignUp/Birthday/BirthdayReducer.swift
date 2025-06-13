//
//  BirthdayReducer.swift
//  ProductName
//
//  Created by hyerin on 6/13/25.
//

import Foundation

import ComposableArchitecture

enum DateType {
  case lunar // 음력
  case solar // 양력
}

@Reducer
struct BirthdayReducer {
  init() {}

  @ObservableState
  struct State: Equatable {
    var dateType: DateType
    var birthday: Date

    init(
      dateType: DateType = .solar,
      birthday: Date = Date()
    ) {
      self.dateType = dateType
      self.birthday = birthday
    }
  }

  enum Action {
    // View Action
    case dateTypeButtonTapped(DateType)
    case birthdayChanged(Date)
    case nextButtonTapped
    case backButtonTapped
    
    // Internal Action
    
    // Route Action
  }

  var body: some Reducer<State, Action> {
    Reduce { state, action in
      switch action {
        case .dateTypeButtonTapped(let type):
          state.dateType = type
          return .none
          
        case .birthdayChanged(let birthday):
          state.birthday = birthday
          return .none
          
        case .nextButtonTapped:
          return .none
          
        case .backButtonTapped:
          return .none
      }
    }
  }
}
