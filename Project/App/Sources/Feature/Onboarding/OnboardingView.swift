//
//  OnboardingView.swift
//  ProductName
//
//  Created by Aiden.lee on 6/8/25.
//

import SwiftUI

import ComposableArchitecture

struct OnboardingView: View {
  @Bindable var store: StoreOf<OnboardingReducer>

  var body: some View {
    VStack(spacing: 20.0) {
      Text("This is OnboardingView")
      Button("Move to MainTab") {
        store.send(.moveToMainTab)
      }
    }
  }
}
