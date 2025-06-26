//
//  FortuneAnalyzingView.swift
//  ProductName
//
//  Created by hyerin on 6/17/25.
//

import SwiftUI

import ComposableArchitecture

struct FortuneAnalyzingView: View {
  let store: StoreOf<FortuneAnalyzingReducer>
  
  init(store: StoreOf<FortuneAnalyzingReducer>) {
    self.store = store
  }
  
  var body: some View {
    VStack(spacing: 0) {
      VStack(spacing: 40) {
        Text("금전운 분석중")
          .textStyle(.h1)
          .foregroundStyle(ColorResource.Text.main.color)
        
        ImageResource.Icon.info.image
          .resizable()
          .frame(width: 88, height: 88)
      }
      .padding(.horizontal, 20)
      .padding(.top, 48)
      .padding(.bottom, 24)
      
      Spacer()
    }
    .frame(maxWidth: .infinity)
    .padding(.top, 52)
    .background(ColorResource.Background.main.color)
  }
}

#Preview {
  FortuneAnalyzingView(
    store: Store(
      initialState: .init(),
      reducer: FortuneAnalyzingReducer.init
    )
  )
}
