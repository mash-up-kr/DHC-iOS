//
//  SelectCategoryReducer.swift
//  ProductName
//
//  Created by hyerin on 6/17/25.
//

import ComposableArchitecture

@Reducer
struct SelectCategoryReducer {
  init() {}

  @ObservableState
  struct State: Equatable {
    var categoryInfos = CategoryInfo.mock // TODO: 추후 API 연결 시 수정
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
    case categoryButtonTapped(categoryId: Int)
    
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
          
        case .categoryButtonTapped(let categoryId):
          let isCategorySelected = state.selectedCategoryID.contains(categoryId)
          if isCategorySelected {
            state.selectedCategoryID.remove(categoryId)
          } else {
            state.selectedCategoryID.insert(categoryId)
          }
          
          return .none
      }
    }
  }
}
