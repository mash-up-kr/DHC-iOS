//
//  SelectCategoryReducer.swift
//  Flifin
//
//  Created by hyerin on 6/17/25.
//

import ComposableArchitecture

@Reducer
struct SelectCategoryReducer {
  init() {}

  @ObservableState
  struct State: Equatable {
    var categoryInfos: [CategoryInfo] = [] // TODO: 추후 API 연결 시 수정
    var selectedCategoryID: Set<Int> = []
    var isNextButtonDisabled: Bool {
      selectedCategoryID.count < 3
    }
    var nextButtonTitle: String {
      isNextButtonDisabled ? "다음" : "금전운 확인하고 시작하기"
    }

    init() {
    }
  }

  enum Action {
    // View Action
    case backButtonTapped
    case nextButtonTapped
    case categoryButtonTapped(categoryID: Int, isSelected: Bool)
    
    // Internal Action
    
    // Route Action
  }

  var body: some Reducer<State, Action> {
    Reduce { state, action in
      switch action {
        case .backButtonTapped:
          return .none
          
        case .nextButtonTapped:
          return .none
          
        case .categoryButtonTapped(let categoryID, let isSelected):
          if isSelected {
            state.selectedCategoryID.insert(categoryID)
          } else {
            state.selectedCategoryID.remove(categoryID)
          }
          
          return .none
      }
    }
  }
}
