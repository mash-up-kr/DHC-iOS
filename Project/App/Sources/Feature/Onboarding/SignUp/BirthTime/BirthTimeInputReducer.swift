//
//  BirthTimeInputReducer.swift
//  Flifin
//
//  Created by hyerin on 6/13/25.
//

import Foundation

import ComposableArchitecture

@Reducer
struct BirthTimeInputReducer {
  init() {}

  @ObservableState
  struct State: Equatable {
    let gender: Gender
    let calendarType: CalendarType
    let birthday: Date
    var birthTime: Date
    var isNoIdeaButtonChecked: Bool
    var selectedBirthTime: Date? {
      isNoIdeaButtonChecked ? nil : birthTime
    }

    init(
      gender: Gender,
      calendarType: CalendarType,
      birthday: Date,
      birthTime: Date = Date(hour: 1, minute: 0),
      isNoIdeaButtonSelected: Bool = false
    ) {
      self.gender = gender
      self.calendarType = calendarType
      self.birthday = birthday
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
    case moveToSelectCategoryView(Gender, CalendarType, Date, Date?)
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
          return .send(.moveToSelectCategoryView(state.gender, state.calendarType, state.birthday, state.selectedBirthTime))
          
        case .backButtonTapped:
          return .none
          
        case .moveToSelectCategoryView:
          return .none
      }
    }
  }
}
