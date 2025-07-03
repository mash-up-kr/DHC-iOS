//
//  FortuneLoadingView.swift
//  Flifin
//
//  Created by hyerin on 7/2/25.
//

import SwiftUI

import ComposableArchitecture

struct FortuneLoadingView: View {
  let store: StoreOf<FortuneLoadingReducer>
  
  init(store: StoreOf<FortuneLoadingReducer>) {
    self.store = store
  }
  
  var body: some View {
    mainView
    .overlay(alignment: .top) {
      VStack(spacing: 8) {
        BadgeView(
          text: store.todayDateString,
          textColor: ColorResource.Text.Body.primary.color,
          font: Typography.Body.body6
        )
        
        Text("오늘의 운세를 카드에 담고 있어요..")
          .foregroundStyle(ColorResource.Text.Body.primary.color)
          .textStyle(.h4)
      }
      .padding(.top, 84)
    }
    .onAppear {
      store.send(.onAppear)
    }
  }
  
  @ViewBuilder
  private var mainView: some View {
    if store.shouldPlayVideo {
      LoopingVideoPlayer(videoURL: Bundle.main.url(forResource: "fortuneLoading", withExtension: "mp4")!)
        .disabled(true)
        .ignoresSafeArea()
    } else {
      ImageResource.fortuneLoadingThumbnail.image
        .ignoresSafeArea()
    }
  }
}

#Preview {
  FortuneLoadingView(
    store: Store(
      initialState: .init(),
      reducer: FortuneLoadingReducer.init
    )
  )
}
