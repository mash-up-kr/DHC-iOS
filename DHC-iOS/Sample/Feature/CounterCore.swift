//
//  CounterCore.swift
//  DHC-iOS
//
//  Created by hyerin on 5/27/25.
//

import ComposableArchitecture

@Reducer
struct CounterCore {
  init() {}

  @ObservableState
  struct State: Equatable {
    var count: Int
    var isLoadingFact: Bool
    var fact: String?
    
    init(
      count: Int = 0,
      isLoadingFact: Bool = false,
      fact: String? = nil
    ) {
      self.count = count
      self.isLoadingFact = isLoadingFact
      self.fact = fact
    }
  }

  enum Action {
    // View Action
    case decrementButtonTapped
    case incrementButtonTapped
    case getFactButtonTapped
    
    // Internal Action
    case fetchNumberFact(String?)
    
    // Route Action
  }
  
  // Dependency는 Action <-> Reducer 사이에 작성
  @Dependency(\.numberFactClient) var numberFactClient

  var body: some Reducer<State, Action> {
    Reduce { state, action in
      switch action {
        case .decrementButtonTapped:
          state.count -= 1
          state.fact = nil
          return .none
        case .incrementButtonTapped:
          state.count += 1
          state.fact = nil
          return .none
        case .getFactButtonTapped:
          state.fact = nil
          state.isLoadingFact = true
          return .run { [count = state.count] send in
            try await send(.fetchNumberFact(self.numberFactClient.fetch(count)))
          }
        case .fetchNumberFact(let numberFact):
          state.isLoadingFact = false
          state.fact = numberFact
          return .none
      }
    }
  }
}
