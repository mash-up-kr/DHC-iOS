//
//  ContentView.swift
//  Flifin
//
//  Created by hyerin on 6/2/25.
//

import SwiftUI

import ComposableArchitecture

struct RootView: View {
  @Bindable var store: StoreOf<RootReducer>

  var body: some View {
    Group {
      switch store.destination {
      case .splash:
        if let store = store.scope(state: \.destination?.splash, action: \.destination.splash) {
          SplashView(store: store)
        }
        
      case .onboarding:
        if let store = store.scope(state: \.destination?.onboarding, action: \.destination.onboarding) {
          OnboardingView(store: store)
        }

      case .mainTab, .none:
        if let store = store.scope(state: \.destination?.mainTab, action: \.destination.mainTab) {
          MainTabView(store: store)
        }
        
      case .selectGender:
        if let store = store.scope(state: \.destination?.selectGender, action: \.destination.selectGender) {
          SelectGenderView(store: store)
        }
      }
    }
    .onAppear {
      store.send(.onAppear)
    }
  }
}

#Preview {
  RootView(
    store: Store(
      initialState: RootReducer.State(),
      reducer: RootReducer.init
    )
  )
}
