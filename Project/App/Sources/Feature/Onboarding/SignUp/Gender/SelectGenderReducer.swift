//
//  SelectGenderReducer.swift
//  Flifin
//
//  Created by hyerin on 6/13/25.
//

import ComposableArchitecture

enum Gender {
  case male
  case female
  
  var title: String {
    switch self {
      case .male:
        return "남성"
      case .female:
        return "여성"
    }
  }
}

@Reducer
struct SelectGenderReducer {
  init() {}

  @ObservableState
  struct State: Equatable {
    var gender: Gender?
    var bottomButtonTitle: String
    var isBottomButtonDisabled: Bool

    init(
      gender: Gender? = nil,
      bottomButtonTitle: String = "다음",
      isBottomButtonDisabled: Bool = true
    ) {
      self.gender = gender
      self.bottomButtonTitle = bottomButtonTitle
      self.isBottomButtonDisabled = isBottomButtonDisabled
    }
  }

  enum Action {
    // View Action
    case genderButtonTapped(Gender)
    case bottomButtonTapped
    
    // Internal Action
    case genderSelected
    
    // Route Action
  }

  var body: some Reducer<State, Action> {
    Reduce { state, action in
      switch action {
        case .genderButtonTapped(let gender):
          state.gender = gender
          return .send(.genderSelected)
          
        case .bottomButtonTapped:
          return .none
          
        case .genderSelected:
          state.bottomButtonTitle = "금전운 확인하고 시작하기"
          state.isBottomButtonDisabled = false
          return .none
      }
    }
  }
}
