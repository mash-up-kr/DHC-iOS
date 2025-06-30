//
//  SelectCategoryReducer.swift
//  Flifin
//
//  Created by hyerin on 6/17/25.
//

import Foundation

import ComposableArchitecture

@Reducer
struct SelectCategoryReducer {
  init() {}

  @ObservableState
  struct State: Equatable {
    let gender: Gender
    let calendarType: CalendarType
    let birthday: Date
    let birthTime: Date?
    var missionCategories: [MissionCategory] = []
    var selectedCategories: Set<String> = []
    var isNextButtonDisabled: Bool {
      selectedCategories.count < 3
    }

    init(
      gender: Gender,
      calendarType: CalendarType,
      birthday: Date,
      birthTime: Date?,
      missionCategories: [MissionCategory] = [],
      selectedCategories: Set<String> = []
    ) {
      self.gender = gender
      self.calendarType = calendarType
      self.birthday = birthday
      self.birthTime = birthTime
      self.missionCategories = missionCategories
      self.selectedCategories = selectedCategories
    }
  }
  
  @Dependency(\.signUpClient) var signUpClient

  enum Action {
    // View Action
    case onAppear
    case backButtonTapped
    case nextButtonTapped
    case categoryButtonTapped(categoryName: String, isSelected: Bool)
    
    // Internal Action
    case fetchMissionCategories([MissionCategory])
    
    // Route Action
  }

  var body: some Reducer<State, Action> {
    Reduce { state, action in
      switch action {
        case .onAppear:
          return .run { send in
            await send(.fetchMissionCategories(
              try await signUpClient.fetchMissionCategories()
            ))
          }
          
        case .backButtonTapped:
          return .none
          
        case .nextButtonTapped:
          return .none
          
        case .categoryButtonTapped(let categoryName, let isSelected):
          if isSelected {
            state.selectedCategories.insert(categoryName)
          } else {
            state.selectedCategories.remove(categoryName)
          }
          
          return .none
          
        case .fetchMissionCategories(let missionCategories):
          state.missionCategories = missionCategories
          return .none
      }
    }
  }
}
