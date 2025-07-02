//
//  SplashView.swift
//  Flifin
//
//  Created by hyerin on 7/2/25.
//

import SwiftUI

import ComposableArchitecture
import Lottie

struct SplashView: View {
  let store: StoreOf<SplashReducer>
  
  init(store: StoreOf<SplashReducer>) {
    self.store = store
  }
  
  var body: some View {
    LottieView(animation: .named("splash"))
      .playing()
      .ignoresSafeArea()
      .task {
        do {
          try await Task.sleep(for: .seconds(3))
          _ = withAnimation { @MainActor in
            store.send(.delegate(.splashFinished))
          }
        } catch {}
      }
  }
}

#Preview {
  SplashView(
    store: Store(
      initialState: .init(),
      reducer: SplashReducer.init
    )
  )
}
