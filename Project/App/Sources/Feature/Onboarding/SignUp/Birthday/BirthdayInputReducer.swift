//
//  BirthdayInputReducer.swift
//  Flifin
//
//  Created by hyerin on 6/13/25.
//

import Foundation

import ComposableArchitecture

enum CalendarType {
  case lunar // 음력
  case solar // 양력
}

@Reducer
struct BirthdayInputReducer {
  init() {}

  @ObservableState
  struct State: Equatable {
    let gender: Gender
    var calendarType: CalendarType
    var birthday: Date

    init(
      gender: Gender,
      calendarType: CalendarType = .solar,
      birthday: Date = Date(year: 2000, month: 1, day: 1)
    ) {
      self.gender = gender
      self.calendarType = calendarType
      self.birthday = birthday
    }
  }

  enum Action {
    // View Action
    case calendarTypeButtonTapped(CalendarType)
    case birthdayChanged(Date)
    case nextButtonTapped
    case backButtonTapped
    
    // Internal Action
    
    // Route Action
    case moveToBirthTimeInputView(Gender, CalendarType, Date)
  }

  var body: some Reducer<State, Action> {
    Reduce { state, action in
      switch action {
        case .calendarTypeButtonTapped(let type):
          state.calendarType = type
          return .none
          
        case .birthdayChanged(let birthday):
          state.birthday = birthday
          return .none
          
        case .nextButtonTapped:
          return .send(.moveToBirthTimeInputView(state.gender, state.calendarType, state.birthday))
          
        case .backButtonTapped:
          return .none
        
      case .moveToBirthTimeInputView:
        return .none
      }
    }
  }
}
