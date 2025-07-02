//
//  SelectGenderReducer.swift
//  Flifin
//
//  Created by hyerin on 6/13/25.
//

import ComposableArchitecture

@Reducer
struct SelectGenderReducer {
  init() {}

  @ObservableState
  struct State: Equatable {
    var path = StackState<Path.State>()
    var gender: Gender?
    var isBottomButtonDisabled: Bool

    init(
      gender: Gender? = nil,
      isBottomButtonDisabled: Bool = true
    ) {
      self.gender = gender
      self.isBottomButtonDisabled = isBottomButtonDisabled
    }
  }

  enum Action {
    // View Action
    case genderButtonTapped(Gender)
    case nextButtonTapped
    
    // Internal Action
    case genderSelected
    
    // Route Action
    case path(StackActionOf<Path>)
    case moveToBirthdayInputView
    case delegate(Delegate)
    enum Delegate {
      case registerCompleted
    }
  }
  
  @Reducer
  enum Path {
    case birthdayInput(BirthdayInputReducer)
    case birthTimeInput(BirthTimeInputReducer)
    case selectCategory(SelectCategoryReducer)
  }

  var body: some Reducer<State, Action> {
    Reduce { state, action in
      switch action {
      case .genderButtonTapped(let gender):
        let pastGender = state.gender
        state.gender = gender
        
        if pastGender == nil {
          return .send(.genderSelected)
        } else {
          return .none
        }
        
      case .nextButtonTapped:
          return .send(.moveToBirthdayInputView)
          
        case .genderSelected:
          state.isBottomButtonDisabled = false
          return .none
          
        case .path(let action):
          switch action {
            case .element(id: _, action: .birthdayInput(.moveToBirthTimeInputView(let gender, let calendarType, let birthday))):
              state.path.append(.birthTimeInput(.init(gender: gender, calendarType: calendarType, birthday: birthday)))
              return .none
              
            case .element(id: _, action: .birthTimeInput(.moveToSelectCategoryView(let gender, let calendarType, let birthday, let birthTime))):
              state.path.append(.selectCategory(.init(gender: gender, calendarType: calendarType, birthday: birthday, birthTime: birthTime)))
              return .none
              
            case .element(id: _, action: .selectCategory(.delegate(.registerUserCompleted))):
              return .send(.delegate(.registerCompleted))
              
            case .element(let id, action: .birthdayInput(.backButtonTapped)):
              state.path.pop(from: id)
              return .none
              
            case .element(let id, action: .birthTimeInput(.backButtonTapped)):
              state.path.pop(from: id)
              return .none
              
            case .element(let id, action: .selectCategory(.backButtonTapped)):
              state.path.pop(from: id)
              return .none
              
            default:
              return .none
          }
          
        case .moveToBirthdayInputView:
          state.path.append(.birthdayInput(.init(gender: state.gender ?? .male)))
          return .none
          
        case .delegate:
          return .none
      }
    }
    .forEach(\.path, action: \.path)
  }
}

extension SelectGenderReducer.Path.State: Equatable {}
