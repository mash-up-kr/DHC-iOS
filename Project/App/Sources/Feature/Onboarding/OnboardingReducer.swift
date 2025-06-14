//
//  OnboardingReducer.swift
//  ProductName
//
//  Created by Aiden.lee on 6/8/25.
//

import Foundation

import ComposableArchitecture

@Reducer
struct OnboardingReducer {
  @ObservableState
  struct State: Equatable {}

  enum Action {
    case moveToMainTab
  }

  var body: some ReducerOf<Self> {
    Reduce { _, action in
      switch action {
      case .moveToMainTab:
        .none
      }
    }
  }
}
