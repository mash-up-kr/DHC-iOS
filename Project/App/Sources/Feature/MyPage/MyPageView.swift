//
//  MyPageView.swift
//  Flifin
//
//  Created by Aiden.lee on 6/8/25.
//

import SwiftUI

import ComposableArchitecture

struct MyPageView: View {
  @Bindable var store: StoreOf<MyPageReducer>

  var body: some View {
    ScrollView {
      LargeNavigationTitleView(title: "마이페이지")
        .unredacted()

      VStack(spacing: 0) {
        // 내 사주 정보
        VStack(spacing: 16) {
          FortuneInfoCardView(
            imageURL: store.myPageInfo.animalCard.cardImageURL,
            fortune: store.myPageInfo.animalCard.name
          )

          BirthdayInfoView(
            date: store.myPageInfo.birthDate.date,
            time: store.myPageInfo.birthDate.birthTime
          )
        }
        .frame(maxWidth: .infinity)
        .padding(20)
        .radialGradientBackground(
          type: .backgroundGradient01,
          endRadiusMultiplier: 0.4,
          scaleEffectX: 2.5
        )

        // 소비 카테고리
        VStack(alignment: .leading, spacing: 12) {
          Text("선택한 소비 카테고리")
            .textStyle(.body3)
            .foregroundColor(ColorResource.Neutral._50.color)
            .padding(.horizontal, 20)

          ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 8) {
              ForEach(store.myPageInfo.preferredMissionCategoryList, id: \.self) { item in
                CategoryCardView(
                  imageURL: item.imageURL,
                  title: item.displayName
                )
              }
            }
          }
          .contentMargins(.horizontal, 20)
        }
        .padding(.vertical, 24)

        Rectangle()
          .fill(ColorResource.Background.glassEffect.color)
          .frame(height: 7)

        // 설정
        VStack(alignment: .leading, spacing: 12) {
          Text("설정")
            .textStyle(.body3)
            .foregroundColor(ColorResource.Neutral._50.color)

          VStack {
            SettingListRowView(
              title: "앱 초기화",
              iconName: "icon/signOut",
              action: {
                store.send(.resetAppButtonTapped)
              }
            )
          }
          .padding(.horizontal, 16)
          .frame(maxWidth: .infinity)
          .background(ColorResource.Neutral._700.color)
          .cornerRadius(12)
        }
        .padding(.vertical, 24)
        .padding(.horizontal, 20)
      }
    }
    .onAppear {
      store.send(.onAppear)
    }
    .redacted(reason: store.isRedacted ? .placeholder : [])
    .resetAlert(
      item: $store.scope(state: \.appResetAlert, action: \.appResetAlert)
    )
    .background(ColorResource.Background.main.color)
  }
}
