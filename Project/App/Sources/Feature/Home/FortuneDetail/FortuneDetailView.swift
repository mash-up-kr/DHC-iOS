//
//  FortuneDetailView.swift
//  ProductName
//
//  Created by 최혜린 on 6/22/25.
//

import SwiftUI

import ComposableArchitecture

struct FortuneDetailView: View {
  let store: StoreOf<FortuneDetailReducer>
  private let columns: [GridItem] = [GridItem(spacing: 12), GridItem()]
  @State private var bottomVStackHeight: CGFloat = 120
  
  init(store: StoreOf<FortuneDetailReducer>) {
    self.store = store
  }
  
  var body: some View {
    VStack(spacing: 0) {
      if store.type == .detail {
        DHCNavigationBar(
          type: .title("오늘의 금전운"),
          backButtonAction: {
            store.send(.backButtonTapped)
          }
        )
      }
      
      ScrollView {
        VStack(spacing: 24) {
          FortuneView(
            date: store.detailInfo.scoreInfo.date,
            score: store.detailInfo.scoreInfo.score,
            summary: store.detailInfo.scoreInfo.summary,
            cardBackgroundImageURL: store.detailInfo.cardInfo.backgroundImageURL,
            cardTitle: store.detailInfo.cardInfo.title,
            cardFortune: store.detailInfo.cardInfo.fortune
          )
          .padding(.top, 32)
          
          detailFortuneView
          
          tipView
            .padding(.bottom, store.type == .intro ? bottomVStackHeight : 53)
        }
      }
      .scrollIndicators(.hidden)
      .if(store.type == .intro) { view in
        view
          .radialGradientBackground(
            type: .backgroundGradient02,
            endRadiusMultiplier: 1.2,
            scaleEffectX: 1.8
          )
          .background(ColorResource.Background.main.color)
      }
    }
    .overlay(alignment: .bottom) {
      if store.type == .intro {
        VStack(spacing: 0) {
          BottomGradientView()
          
          CTAButton(
            size: .extraLarge,
            style: .secondary,
            title: "미션 확인하기",
            action: {
              store.send(.nextButtonTapped)
            }
          )
          .padding(20)
          .background(ColorResource.Background.main.color)
        }
        .overlay(ViewHeightGeometry())
      }
    }
    .onPreferenceChange(ViewHeightKey.self) { height in
      bottomVStackHeight = height
    }
    .if(store.type == .detail) { view in
      view
        .radialGradientBackground(
          type: .backgroundGradient02,
          endRadiusMultiplier: 1.2,
          scaleEffectX: 1.8
        )
        .background(ColorResource.Background.main.color)
    }
  }
  
  var detailFortuneView: some View {
    VStack(alignment: .leading, spacing: 16) {
      Text("금전운 상세보기")
        .textStyle(.h4_1)
        .foregroundStyle(ColorResource.Text.main.color)
      
      MessageCardView(
        title: "금전운",
        message: store.detailInfo.detailMessage
      )
    }
    .padding(.horizontal, 20.5)
  }
  
  var tipView: some View {
    VStack(alignment: .leading, spacing: 16) {
      Text("오늘의 꿀팁")
        .textStyle(.h4_1)
        .foregroundStyle(ColorResource.Text.main.color)
      
      LazyVGrid(
        columns: columns,
        spacing: 12,
        content: {
          ForEach(store.detailInfo.tipInfos, id: \.self) { tipInfo in
            TipCardView(
              imageURL: tipInfo.imageURL,
              title: tipInfo.title,
              content: tipInfo.content,
              contentColor: tipInfo.contentColor
            )
          }
        }
      )
    }
    .padding(.horizontal, 20)
  }
}

#Preview {
  FortuneDetailView(
    store: Store(
      initialState: .init(type: .intro),
      reducer: FortuneDetailReducer.init
    )
  )
}
