//
//  MissionExampleView.swift
//  Flifin
//
//  Created by 최혜린 on 6/29/25.
//

import SwiftUI

import ComposableArchitecture

struct MissionExampleView: View {
  let store: StoreOf<MissionExampleReducer>
  @State private var bottomVStackHeight: CGFloat = 120
  
  init(store: StoreOf<MissionExampleReducer>) {
    self.store = store
  }
  
  var body: some View {
    VStack(alignment: .leading, spacing: 0) {
      IntroTitleView(
        style: .page,
        title: "금전운에 기반해서\n부여된 미션이에요",
        description: "미션을 수행하면서\n소비습관을 개선해보세요"
      )
      .padding(.top, 19)
      .padding(.bottom, 45)
      
      ScrollView {
        // TODO: 추후 미션 목록 추가
        EmptyView()
      }
      .padding(.bottom, bottomVStackHeight)
      
      Spacer()
    }
    .frame(maxWidth: .infinity, alignment: .leading)
    .overlay(alignment: .bottom) {
      VStack(spacing: 0) {
        BottomGradientView()
        
        CTAButton(
          size: .extraLarge,
          style: .secondary,
          title: "간편 개인정보 입력하기",
          action: {
            store.send(.nextButtonTapped)
          }
        )
        .padding(20)
        .background(ColorResource.Background.main.color)
      }
      .overlay(ViewHeightGeometry())
    }
    .onPreferenceChange(ViewHeightKey.self) { height in
      bottomVStackHeight = height
    }
    .navigationBarBackButtonHidden()
  }
}

#Preview {
  MissionExampleView(
    store: Store(
      initialState: .init(),
      reducer: MissionExampleReducer.init
    )
  )
}
