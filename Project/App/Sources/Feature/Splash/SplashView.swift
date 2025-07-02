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
    LottieView {
      await LottieAnimation.loadedFrom(url: .urlForResource(.splashLottie)!)
    } placeholder: {
      ImageResource.splashThumbnail.image
        .ignoresSafeArea()
    }
    .animationDidFinish { _ in
      _ = withAnimation {
        store.send(.delegate(.splashFinished))
      }
    }
    .playing()
    .ignoresSafeArea()
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
