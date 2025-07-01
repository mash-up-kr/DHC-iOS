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
  @Dependency(\.deviceIDManager) var deviceIDManager
  @Dependency(\.userManager) var userManager

  enum Action {
    // View Action
    case onAppear
    case backButtonTapped
    case nextButtonTapped
    case categoryButtonTapped(categoryName: String, isSelected: Bool)
    
    // Internal Action
    case fetchMissionCategories([MissionCategory])
    
    // Route Action
    case delegate(Delegate)
    enum Delegate {
      case registerUserCompleted
    }
  }

  var body: some Reducer<State, Action> {
    Reduce {
      state,
      action in
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
          return .run { [state] send in
            do {
              let userID = try await signUpClient.registerUser(
                deviceID: deviceIDManager.loadDeviceID().uuidString,
                gender: state.gender,
                birthday: state.birthday,
                calendarType: state.calendarType,
                birthTime: state.birthTime,
                missionCategoryList: Array(state.selectedCategories)
              )
              userManager.setUserID(userID)
              await send(.delegate(.registerUserCompleted))
            } catch {}
          }
          
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
          
        case .delegate:
          return .none
      }
    }
  }
}
