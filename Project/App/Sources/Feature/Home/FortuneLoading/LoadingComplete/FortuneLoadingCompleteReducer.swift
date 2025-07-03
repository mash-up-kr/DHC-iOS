//
//  FortuneLoadingCompleteReducer.swift
//  Flifin
//
//  Created by 최혜린 on 7/2/25.
//

import ComposableArchitecture

@Reducer
struct FortuneLoadingCompleteReducer {
  init() {}

  @ObservableState
  struct State: Equatable {
    var isCardFlipped: Bool
    let scoreInfo: FortuneScoreInfo
    let cardInfo: FortuneCardInfo

    init(
      isCardFlipped: Bool = false,
      scoreInfo: FortuneScoreInfo,
      cardInfo: FortuneCardInfo
    ) {
      self.isCardFlipped = isCardFlipped
      self.scoreInfo = scoreInfo
      self.cardInfo = cardInfo
    }
  }

  enum Action {
    // View Action
    case cardFlipped
    
    // Internal Action
    
    // Route Action
    case delegate(Delegate)
    enum Delegate {
      case moveToHome
    }
  }

  var body: some Reducer<State, Action> {
    Reduce { state, action in
      switch action {
      case .cardFlipped:
        state.isCardFlipped = true
        return .run { send in
          do {
            try await Task.sleep(for: .seconds(1.5))
            await send(.delegate(.moveToHome))
          } catch {}
        }
        
      case .delegate:
        return .none
      }
    }
  }
}
