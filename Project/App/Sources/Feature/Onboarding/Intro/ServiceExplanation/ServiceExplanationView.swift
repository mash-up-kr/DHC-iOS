//
//  ServiceExplanationView.swift
//  Flifin
//
//  Created by hyerin on 6/17/25.
//

import SwiftUI

import ComposableArchitecture

struct ServiceExplanationView: View {
  let store: StoreOf<ServiceExplanationReducer>
  
  init(store: StoreOf<ServiceExplanationReducer>) {
    self.store = store
  }
  
  var body: some View {
    VStack(spacing: 0) {
      IntroTitleView(
        style: .intro,
        title: "서비스명(우리 서비스)는\n이런식으로 작동해요"
      )
      .padding(.top, 24)
      .padding(.bottom, 120)
      
      infoView
      
      Spacer()
      
      CTAButton(
        size: .extraLarge,
        style: .secondary,
        title: "다음",
        action: {
          store.send(.nextButtonTapped)
        }
      )
      .padding(20)
    }
    .background(ColorResource.Background.main.color)
    .navigationBarBackButtonHidden()
  }
  
  var infoView: some View {
    VStack(spacing: 12) {
      ForEach(Array(zip(store.introInfoList.indices, store.introInfoList)), id: \.0) { index, info in
        IntroInfoView(index: index + 1, info: info)
      }
    }
    .padding(.vertical, 24)
    .padding(.horizontal, 20)
  }
}

#Preview {
  ServiceExplanationView(
    store: Store(
      initialState: .init(),
      reducer: ServiceExplanationReducer.init
    )
  )
}
